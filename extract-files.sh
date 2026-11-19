#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=a3300
VENDOR=lenovo

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function patch_bytes() { # file offset_hex expected_hex new_hex
  [ "$(xxd -p -c $((${#3}/2)) -s $(($2)) -l $((${#3}/2)) "$1")" = "$3" ] || { echo "MISMATCH $1 @$2"; return 1; }
  printf "$(echo "$4" | sed 's/../\\x&/g')" | dd of="$1" bs=1 seek=$(($2)) conv=notrunc 2>/dev/null
}

function blob_fixup() {
    case "${1}" in
        vendor/bin/ccci_fsd)
            sed -i 's|etc/firmware|vendor/firmw|g' "${2}"
            ;;
        vendor/bin/ccci_mdinit)
            sed -i 's|etc/firmware|vendor/firmw|g' "${2}"
            ;;
        vendor/bin/mdlogger)
            sed -i 's|etc/firmware|vendor/firmw|g' "${2}"
            ;;
        vendor/lib/libMali.so)
            sed -i 's|system/lib/egl|vendor/lib/egl|g' "${2}"
            "${PATCHELF}" --add-needed "libshim_cutils.so" "${2}"
            ;;
        vendor/lib/libMtkOmxCore.so)
            sed -i 's|system/etc|vendor/etc|g' "${2}"
            ;;
        vendor/lib/hw/audio.primary.mt6582.so)
            # Realign audio_hw_device slots with the Android 11 audio HAL layout:
            # create/release patch, get_audio_port, set_audio_port_config shift +4,
            # and the MTK store at 0x98 is dropped so it can't clobber set_audio_port_config.
            patch_bytes "${2}" 0x3d98c 881084e5 8c1084e5
            patch_bytes "${2}" 0x3d990 8c6084e5 906084e5
            patch_bytes "${2}" 0x3d994 903084e5 943084e5
            patch_bytes "${2}" 0x3d998 94b084e5 98b084e5
            patch_bytes "${2}" 0x3d99c 98a084e5 0000a0e1
            sed -i 's|_ZN7android6Thread3runEPKcij|_ZN7android6Bhread3runEPKcij|g' "${2}"
            ;;
        vendor/lib/libvcodecdrv.so)
            # width MB count: (w >> 4) - 1  ->  (w - 1) >> 4
            patch_bytes "${2}" 0x6dda 0a09 4a1e
            patch_bytes "${2}" 0x6dde 501e 1009
            # crop flag: bottom pad = (-h) & 15, branch to cave if zero
            patch_bytes "${2}" 0x6e54 00f10f0c2cf00f0ebeeb000a47d0 c0f1000a1af00f0a00bf00f0eb80
            # right crop offset: call cave returning ((-w) & 15) >> 1
            patch_bytes "${2}" 0x6e94 00204946 00f0c9f8
            # caves in the dead sprintf loop
            patch_bytes "${2}" 0x7024 \
                0df11409dbf80060dff83ca0cbf810403446fa44dbf81020a11b914207d214f8012b4846 \
                cbf8104013e04946d8f80c004042c0f342007047d8f80cc01cf00f0f7ff40faffff755bf
            # driver bitstream dump
            patch_bytes "${2}" 124501 \
                2f2f6d6e742f2f7364636172642f2f656e635f64756d70253038642e6832363400 \
                2f646174612f6c6f63616c2f746d702f656e63253038642e683236340000000000
            ;;
        vendor/lib/libMtkOmxVenc.so)
            # align destination width to 16
            patch_bytes "${2}" 0x9892 cdf80880 01f092f8
            patch_bytes "${2}" 0xa9ba 2de9f04f89b0d0f8143241f66462 08f10f0828f00f08cdf808807047
            # C: make the MDP source region 608 wide (the aligned width) so source and destination match 1:1
            patch_bytes "${2}" 0x90d8 949f959d 01f077fc
            patch_bytes "${2}" 0xa9ca 18520193019ea5f1040a8058 949f0f3727f00f07959d7047
            # post-MDP YUV dump
            patch_bytes "${2}" 62449 \
                2f7364636172642f696e70757461635f25645f25645f25645f25642e79757600 \
                2f646174612f6c6f63616c2f746d702f25645f25645f25645f25642e79757600
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/configs/helpers/setup-makefiles.sh"
