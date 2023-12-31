DEVICE_PATH := device/lenovo/a3300

# Platform
TARGET_BOARD_PLATFORM			:= mt6582

# Bootloader
TARGET_NO_BOOTLOADER			:= true
TARGET_BOOTLOADER_BOARD_NAME		:= A3300-GV

# Architecture
TARGET_ARCH				:= arm
TARGET_ARCH_VARIANT			:= armv7-a-neon
TARGET_ARCH_VARIANT_CPU			:= cortex-a7
TARGET_CPU_ABI				:= armeabi-v7a
TARGET_CPU_ABI2				:= armeabi
TARGET_CPU_VARIANT			:= generic
TARGET_CPU_VARIANT_RUNTIME		:= cortex-a7
TARGET_CPU_MEMCPY_OPT_DISABLE		:= true

# Filesystem
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE	:= ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE	:= ext4
TARGET_COPY_OUT_VENDOR			:= vendor
TARGET_USERIMAGES_USE_EXT4		:= true
BOARD_BOOTIMAGE_PARTITION_SIZE		:= 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE	:= 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE	:= 1283457024
BOARD_USERDATAIMAGE_PARTITION_SIZE	:= 968884224
BOARD_VENDORIMAGE_PARTITION_SIZE	:= 132120576
BOARD_FLASH_BLOCK_SIZE			:= 131072
BOARD_ROOT_EXTRA_FOLDERS		:= protect_f protect_s
TARGET_FS_CONFIG_GEN			:= $(DEVICE_PATH)/configs/config.fs

# No cache hack
BOARD_CACHEIMAGE_PARTITION_SIZE		:= 132120576
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE	:= ext4

# Reduce space taken by the journal
BOARD_SYSTEMIMAGE_JOURNAL_SIZE		:= 0

# Build system
WITHOUT_CHECK_API			:= true

# Binder
TARGET_USES_64_BIT_BINDER		:= true

# HIDL
DEVICE_MANIFEST_FILE			:= $(DEVICE_PATH)/configs/manifest.xml

# Fstab
TARGET_RECOVERY_FSTAB			:= $(DEVICE_PATH)/configs/fstab.$(TARGET_BOARD_PLATFORM)

# OTA
TARGET_OTA_ASSERT_DEVICE		:= A3300-GV,A3300-HV,a3300
TARGET_RELEASETOOLS_EXTENSIONS		:= $(DEVICE_PATH)/configs

# Props
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED	:= true
TARGET_VENDOR_PROP			:= $(DEVICE_PATH)/configs/vendor.prop

# Kernel config
TARGET_KERNEL_CLANG_COMPILE		:= false
TARGET_KERNEL_CONFIG			:= lineage_a3300_defconfig
TARGET_KERNEL_SOURCE			:= kernel/lenovo/a3300-again
BOARD_KERNEL_IMAGE_NAME			:= zImage

# Boot image config
BOARD_CUSTOM_BOOTIMG_MK			:= $(DEVICE_PATH)/configs/bootimg.mk
BOARD_MKBOOTIMG_ARGS := \
    --board $(TARGET_BOARD_PLATFORM) \
    --base 0x10000000 \
    --pagesize 2048 \
    --kernel_offset 0x00008000 \
    --ramdisk_offset 0x01000000 \
    --tags_offset 0x00000100

# Legacy blobs
TARGET_PROCESS_SDK_VERSION_OVERRIDE	+= /system/bin/mediaserver=22

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH		:= /sys/devices/platform/mt_usb/musb-hdrc.0.auto/gadget/lun%d/file

# Malloc
MALLOC_SVELTE				:= true

# Fonts
EXCLUDE_SERIF_FONTS			:= true
SMALLER_FONT_FOOTPRINT			:= true
USE_REDUCED_CJK_FONT_WEIGHTS		:= true

# SELinux
SEPOLICY_VERS				:= 30
SELINUX_IGNORE_NEVERALLOWS		:= true
BOARD_SEPOLICY_DIRS			+= $(DEVICE_PATH)/configs/sepolicy/public
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS	+= $(DEVICE_PATH)/configs/sepolicy/private

# Memfd
TARGET_HAS_MEMFD_BACKPORT		:= true

# Display
TARGET_SCREEN_DENSITY			:= 160

# Dexpreopt
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true

# RIL
BOARD_PROVIDES_RILD			:= true
BOARD_PROVIDES_LIBRIL			:= true
ENABLE_VENDOR_RIL_SERVICE := true
SIM_COUNT := 1

# Wifi
BOARD_WLAN_DEVICE			:= MediaTek
WPA_SUPPLICANT_VERSION			:= VER_0_8_X
BOARD_HOSTAPD_DRIVER			:= NL80211
BOARD_HOSTAPD_PRIVATE_LIB		:= lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER		:= NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB	:= lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM		:= /dev/wmtWifi
WIFI_DRIVER_FW_PATH_AP			:= AP
WIFI_DRIVER_FW_PATH_STA			:= STA
WIFI_DRIVER_FW_PATH_P2P			:= P2P
WIFI_DRIVER_STATE_CTRL_PARAM		:= /dev/wmtWifi
WIFI_DRIVER_STATE_ON			:= 1
WIFI_DRIVER_STATE_OFF			:= 0
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
