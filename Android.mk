LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),a3300)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
