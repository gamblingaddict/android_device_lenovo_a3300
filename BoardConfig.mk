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
