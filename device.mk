DEVICE_PATH := device/lenovo/a3300
VENDOR_PATH := vendor/lenovo/a3300

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Firmware
$(call inherit-product, $(VENDOR_PATH)/vendor.mk)

# Dalvik/HWUI
$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)

# Device characteristics
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_SHIPPING_API_LEVEL := 21

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal mdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Boot Animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_BOOTANIMATION_MULTITHREAD_DECODE := true
TARGET_SCREEN_WIDTH := 1024
TARGET_SCREEN_HEIGHT := 600

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

PRODUCT_DEXPREOPT_SPEED_APPS += SystemUI

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Always preopt extracted APKs to prevent extracting out of the APK for gms
# modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# Dedupe VNDK libraries with identical core variants.
TARGET_VNDK_USE_CORE_VARIANT := true

# Disable Scudo outside of eng builds to save RAM.
PRODUCT_DISABLE_SCUDO := true

# Disable dex2oat debug
USE_DEX2OAT_DEBUG := false

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/configs/overlay

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    $(DEVICE_PATH)/libs \
    $(VENDOR_PATH)/proprietary \

# Permissions/features
PERM_PATH := frameworks/native/data/etc
PERM_DEST := $(TARGET_COPY_OUT_VENDOR)/etc/permissions

PRODUCT_COPY_FILES += \
    $(PERM_PATH)/android.hardware.bluetooth_le.xml:$(PERM_DEST)/android.hardware.bluetooth_le.xml \
    $(PERM_PATH)/android.hardware.location.gps.xml:$(PERM_DEST)/android.hardware.location.gps.xml \
    $(PERM_PATH)/android.hardware.touchscreen.multitouch.distinct.xml:$(PERM_DEST)/android.hardware.touchscreen.multitouch.distinct.xml \
    $(PERM_PATH)/android.hardware.touchscreen.multitouch.jazzhand.xml:$(PERM_DEST)/android.hardware.touchscreen.multitouch.jazzhand.xml \
    $(PERM_PATH)/android.hardware.touchscreen.multitouch.xml:$(PERM_DEST)/android.hardware.touchscreen.multitouch.xml \
    $(PERM_PATH)/android.hardware.touchscreen.xml:$(PERM_DEST)/android.hardware.touchscreen.xml \
    $(PERM_PATH)/android.hardware.usb.accessory.xml:$(PERM_DEST)/android.hardware.usb.accessory.xml \
    $(PERM_PATH)/android.hardware.usb.host.xml:$(PERM_DEST)/android.hardware.usb.host.xml \
    $(PERM_PATH)/android.hardware.wifi.direct.xml:$(PERM_DEST)/android.hardware.wifi.direct.xml \
    $(PERM_PATH)/android.hardware.wifi.xml:$(PERM_DEST)/android.hardware.wifi.xml \
    $(PERM_PATH)/handheld_core_hardware.xml:$(PERM_DEST)/handheld_core_hardware.xml \

# Chopping block
PRODUCT_COPY_FILES += \
    $(PERM_PATH)/android.hardware.sensor.light.xml:$(PERM_DEST)/android.hardware.sensor.light.xml \
    $(PERM_PATH)/android.hardware.sensor.proximity.xml:$(PERM_DEST)/android.hardware.sensor.proximity.xml \
    $(PERM_PATH)/android.hardware.telephony.gsm.xml:$(PERM_DEST)/android.hardware.telephony.gsm.xml \
    $(PERM_PATH)/android.hardware.camera.xml:$(PERM_DEST)/android.hardware.camera.xml \

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
    libhwbinder \

PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-service

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
    wificond \
    libwifi-hal-mt66xx \
    lib_driver_cmd_mt66xx \
    6620_launcher \
    wmt_loader

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,${DEVICE_PATH}/configs/wifi,$(TARGET_COPY_OUT_VENDOR)/etc/wifi)

# Tether
PRODUCT_PACKAGES += \
    android.hardware.tetheroffload.config@1.0 \
    android.hardware.tetheroffload.control@1.0

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    libbt-vendor

# Nvram
PRODUCT_PACKAGES += \
    nvram_daemon

# Input
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,${DEVICE_PATH}/configs/kl,$(TARGET_COPY_OUT_VENDOR)/usr/keylayout) \

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl \
    sensors.wrapper \
    sensors.mt6582

PRODUCT_COPY_FILES += \
     $(DEVICE_PATH)/configs/_hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/_hals.conf

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl \
    mnld \
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

# OpenGL
PRODUCT_PACKAGES += \
    libMali \
    libEGL_mali \
    libGLESv1_CM_mali \
    libGLESv2_mali \
    libshim_cutils

PRODUCT_COPY_FILES += \
     $(DEVICE_PATH)/configs/egl.cfg:$(TARGET_COPY_OUT_VENDOR)/lib/egl/egl.cfg

# OMX
PRODUCT_PACKAGES += \
    android.hardware.media.omx@1.0 \
    libMtkOmxCore \
    libMtkOmxVdec \
    libMtkOmxVenc \
    libstagefrighthw

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/configs/media,$(TARGET_COPY_OUT_VENDOR)/etc) \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video_le.xml

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

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    audio.usb.default \
    audio.r_submix.default \
    libaudio-resampler \
    tinymix \
    audio.primary.mt6582

POLICY_PATH := frameworks/av/services/audiopolicy/config
POLICY_DEST := $(TARGET_COPY_OUT_VENDOR)/etc/

PRODUCT_COPY_FILES += \
    $(POLICY_PATH)/a2dp_audio_policy_configuration.xml:$(POLICY_DEST)/a2dp_audio_policy_configuration.xml \
    $(POLICY_PATH)/audio_policy_volumes.xml:$(POLICY_DEST)/audio_policy_volumes.xml \
    $(POLICY_PATH)/default_volume_tables.xml:$(POLICY_DEST)/default_volume_tables.xml \
    $(POLICY_PATH)/r_submix_audio_policy_configuration.xml:$(POLICY_DEST)/r_submix_audio_policy_configuration.xml \
    $(POLICY_PATH)/usb_audio_policy_configuration.xml:$(POLICY_DEST)/usb_audio_policy_configuration.xml \

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
