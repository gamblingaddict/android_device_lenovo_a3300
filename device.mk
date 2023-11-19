# Init
PRODUCT_PACKAGES += \
    fstab.mt6582 \
    fstab.mt6582.ramdisk \
    ueventd.mt6582.rc

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,${DEVICE_PATH}/configs/init,$(TARGET_COPY_OUT_VENDOR)/etc/init) \

# Wifi
PRODUCT_PACKAGES += \
    libwifi-hal-mt66xx \
    lib_driver_cmd_mt66xx \
    6620_launcher

# Bluetooth
PRODUCT_PACKAGES += \
    libbt-vendor

# GPS
PRODUCT_PACKAGES += \
    gps.mt6582

# Brightness
PRODUCT_PACKAGES += \
    lights.mt6582

# Graphics
PRODUCT_PACKAGES += \
    hwcomposer.mt6582 \
    gralloc.mt6582 \
    memtrack.mt6582

# Seccomp
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,${DEVICE_PATH}/configs/seccomp,$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE		:= a3300
PRODUCT_BRAND		:= Lenovo
PRODUCT_MANUFACTURER	:= LENOVO
PRODUCT_MODEL		:= LenovoA3300-GV

# Set build fingerprint / ID / Prduct Name etc.
BUILD_FINGERPRINT= Lenovo/A3300-GV/A3300-GV:4.4.2/KOT49H/A3300GV_A442_01_48_150325_ROW:user/release-keys
PRODUCT_BUILD_PROP_OVERRIDES+= \
    PRODUCT_NAME=A3300-GV \
    TARGET_DEVICE=A3300-GV \
    PRIVATE_BUILD_DESC="huaqin82_tb_b2d_td-user LenovoA3300-GV A3300GV_A442_01_48_150325_ROW release-keys"
