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
        vendor/lib/hw/hwcomposer.mt6582.so)
            sed -i 's|_ZN7android6Thread3runEPKcij|_ZN7android6Bhread3runEPKcij|g' "${2}"
            "${PATCHELF}" --add-needed "libshim_utils.so" "${2}"
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
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/configs/helpers/setup-makefiles.sh"
