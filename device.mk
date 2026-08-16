#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/beryl

# Configure Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Virtual A/B OTA configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression_with_xor.mk)

# Enable developer GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Configure generic_ramdidk.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Hidl Service
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION  := false

# API
PRODUCT_SHIPPING_API_LEVEL := 34
PRODUCT_TARGET_VNDK_VERSION := 34
BOARD_SHIPPING_API_LEVEL := 34
SHIPPING_API_LEVEL := 34

BOARD_ROOT_EXTRA_SYMLINKS += \
    /vendor/firmware:/vendor/odm/firmware

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/mtk_plpath_utils \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# Boot
PRODUCT_PACKAGES += \
    android.hardware.boot-V1-ndk \
    android.hardware.boot@1.0 \
    android.hardware.boot@1.1 \
    android.hardware.boot@1.2 \
    android.hardware.boot@1.2-impl \
    libmtk_bsg

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload \
    checkpoint_gc

PRODUCT_PACKAGES += \
    vold.recovery \
    vold_prepare_subdirs.recovery \
    wait_for_keymaster.recovery

# Fastboot
PRODUCT_PACKAGES += \
    android.hardware.fastboot-V1-ndk \
    android.hardware.fastboot@1.0 \
    android.hardware.fastboot@1.1 \
    fastbootd

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint \
    android.hardware.security.secureclock \
    android.hardware.security.sharedsecret

PRODUCT_PACKAGES += \
    e2fsck.vendor_ramdisk \
    fsck.f2fs.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    tune2fs.vendor_ramdisk

PRODUCT_PACKAGES += \
    fstab.mt6855.vendor_ramdisk

# Keystore2
PRODUCT_PACKAGES += \
    android.system.keystore2

# Drm
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4

# Additional Target Libraries
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.keymaster@4.1 \
    android.hardware.keymaster-V4-ndk.so \
    android.hardware.graphics.common@1.0 \
    libion \
    libxml2 \
    android.hardware.boot@1.0 \
    android.hardware.boot@1.1 \
    android.hardware.boot-V1-ndk

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.gatekeeper-V1-ndk.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libc++.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.1.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.graphics.common@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot@1.1.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot-V1-ndk.so \

# Copy first-stage fstabs to vendor_ramdisk — required by first-stage init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/first_stage_ramdisk/fstab.mt6855:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.mt6855 \
    $(LOCAL_PATH)/recovery/root/first_stage_ramdisk/fstab.emmc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.emmc

# Copy stock vendor_ramdisk essentials to ramdisk00 — sepolicy, context files, snapuserd, init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor_ramdisk/first_stage_ramdisk/system/bin/snapuserd:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/bin/snapuserd \
    $(LOCAL_PATH)/vendor_ramdisk/system/bin/mtk_plpath_utils:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/mtk_plpath_utils \
    $(LOCAL_PATH)/vendor_ramdisk/system/bin/init:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system/bin/init \
    $(LOCAL_PATH)/vendor_ramdisk/init:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init \
    $(LOCAL_PATH)/vendor_ramdisk/init.recovery.hardware.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.recovery.hardware.rc \
    $(LOCAL_PATH)/vendor_ramdisk/sepolicy:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/sepolicy \
    $(LOCAL_PATH)/vendor_ramdisk/prop.default:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/prop.default \
    $(LOCAL_PATH)/vendor_ramdisk/plat_file_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/plat_file_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/plat_property_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/plat_property_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/plat_service_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/plat_service_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/vendor_file_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor_file_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/vendor_property_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor_property_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/vendor_service_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor_service_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/system_ext_file_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system_ext_file_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/system_ext_property_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system_ext_property_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/system_ext_service_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system_ext_service_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/odm_file_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/odm_file_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/odm_property_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/odm_property_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/product_file_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/product_file_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/product_property_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/product_property_contexts \
    $(LOCAL_PATH)/vendor_ramdisk/product_service_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/product_service_contexts

# Copy all system/ to vendor_ramdisk — boot service, health HAL, config
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root/system,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system)

# Copy root-level RC files to vendor_ramdisk — imported by init during normal + recovery boot
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt6855.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.recovery.mt6855.rc \
    $(LOCAL_PATH)/recovery/root/tee-supplicant.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/tee-supplicant.rc \
    $(LOCAL_PATH)/recovery/root/miteelog.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/miteelog.rc
