# Init
PRODUCT_PACKAGES += \
    fstab.mt6582 \
    fstab.mt6582.ramdisk \
    ueventd.mt6582.rc

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,${DEVICE_PATH}/configs/init,$(TARGET_COPY_OUT_VENDOR)/etc/init) \

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0 \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder \
    libhwbinder.vendor

PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf \
    wificond \
    libwifi-hal-mt66xx \
    lib_driver_cmd_mt66xx \
    6620_launcher

# Tether
PRODUCT_PACKAGES += \
    android.hardware.tetheroffload.config@1.0 \
    android.hardware.tetheroffload.control@1.0

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    libbt-vendor

# GPS
PRODUCT_PACKAGES += \
    gps.mt6582

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service \
    lights.mt6582

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.composer@2.1-service \
    hwcomposer.mt6582 \
    gralloc.mt6582

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    memtrack.mt6582

# Seccomp
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,${DEVICE_PATH}/configs/seccomp,$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy)

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-impl \
    android.hardware.power@1.0-service \
    android.hardware.power.stats@1.0-service.mock

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

# ConfigStore
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic \
    com.android.future.usb.accessory \
    librs_jni

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
