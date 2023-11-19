DEVICE_PATH := device/lenovo/a3300

# Platform
TARGET_BOARD_PLATFORM := mt6582

# Bootloader
TARGET_NO_BOOTLOADER		:= true
TARGET_BOOTLOADER_BOARD_NAME	:= A3300-GV

# Architecture
TARGET_ARCH			:= arm
TARGET_ARCH_VARIANT		:= armv7-a-neon
TARGET_ARCH_VARIANT_CPU		:= cortex-a7
TARGET_CPU_ABI			:= armeabi-v7a
TARGET_CPU_ABI2			:= armeabi
TARGET_CPU_VARIANT		:= generic
TARGET_CPU_VARIANT_RUNTIME	:= cortex-a7
TARGET_CPU_MEMCPY_OPT_DISABLE	:= true

# Filesystem
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE   := ext4
TARGET_COPY_OUT_VENDOR		     := vendor
TARGET_USERIMAGES_USE_EXT4	     := true
BOARD_BOOTIMAGE_PARTITION_SIZE	     := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE   := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE     := 1283457024
BOARD_USERDATAIMAGE_PARTITION_SIZE   := 968884224
BOARD_VENDORIMAGE_PARTITION_SIZE     := 132120576
BOARD_FLASH_BLOCK_SIZE		     := 131072

# No cache hack
BOARD_CACHEIMAGE_PARTITION_SIZE     := 132120576
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE   := ext4

# Configs
TARGET_RECOVERY_FSTAB		:= $(DEVICE_PATH)/configs/fstab.$(TARGET_BOARD_PLATFORM)

# Kernel config
TARGET_KERNEL_CONFIG := lineage_a3300_defconfig
TARGET_KERNEL_SOURCE := kernel/lenovo/a3300-again
BOARD_KERNEL_IMAGE_NAME := zImage

# Boot image config
BOARD_MKBOOTIMG_ARGS := \
    --board $(TARGET_BOARD_PLATFORM) \
    --base 0x10000000 \
    --pagesize 2048 \
    --kernel_offset 0x00008000 \
    --ramdisk_offset 0x01000000 \
    --tags_offset 0x00000100

# Wifi
BOARD_WLAN_DEVICE		 := MediaTek
WPA_SUPPLICANT_VERSION		 := VER_0_8_X
BOARD_HOSTAPD_DRIVER		 := NL80211
BOARD_HOSTAPD_PRIVATE_LIB	 := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER	 := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM	 := /dev/wmtWifi
WIFI_DRIVER_FW_PATH_AP		 := AP
WIFI_DRIVER_FW_PATH_STA		 := STA
WIFI_DRIVER_FW_PATH_P2P		 := P2P
WIFI_DRIVER_STATE_CTRL_PARAM	 := /dev/wmtWifi
WIFI_DRIVER_STATE_ON		 := 1
WIFI_DRIVER_STATE_OFF		 := 0
