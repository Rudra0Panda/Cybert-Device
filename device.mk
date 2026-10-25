#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service \
    fstab.mt6897

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# API levels
PRODUCT_SHIPPING_API_LEVEL := 35

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Rootdir
PRODUCT_PACKAGES += \
    aee_exp.sh \
    apanic_annotate.sh \
    apanic_copy.sh \
    apanic_mtk.sh \
    apanic_save.sh \
    hardware_revisions.sh \
    hardware_status.sh \
    init.insmod.sh \
    init.mmi.attest_model.sh \
    init.mmi.backup.trustlet.sh \
    init.mmi.block_perm.sh \
    init.mmi.boot.sh \
    init.mmi.cap.sh \
    init.mmi.clean_mbrain.sh \
    init.mmi.modem-rfs.sh \
    init.mmi.shutdown.sh \
    init.mmi.touch.sh \
    init.mmi.usb.sh \
    init.oem.fingerprint2.sh \
    init.oem.hw.sh \
    init.pstore_blk.sh \
    mot_rkp_csr_extraction.sh \
    pstore_annotate.sh \

PRODUCT_PACKAGES += \
    fstab.enableswap \
    factory_init.connectivity.common.rc \
    factory_init.connectivity.rc \
    factory_init.project.rc \
    factory_init.rc \
    init.aee.rc \
    init.cgroup.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init.mmi.backup.trustlet.rc \
    init.mmi.chipset.rc \
    init.mmi.overlay.rc \
    init.mmi.rc \
    init.mmi.tcmd.rc \
    init.mmi.usb.configfs.rc \
    init.modem.rc \
    init.mt6897.rc \
    init.mt6897.usb.rc \
    init.mtkgki.rc \
    init.project.rc \
    init.pstore.rc \
    init.sensor_2_0.rc \
    init.vendor.st21nfc.rc \
    init_conninfra.rc \
    meta_init.connectivity.common.rc \
    meta_init.connectivity.rc \
    meta_init.modem.rc \
    meta_init.project.rc \
    meta_init.rc \
    meta_init.vendor.rc \
    multi_init.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.enableswap:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.enableswap \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6897:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.mt6897

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/motorola/cybert/cybert-vendor.mk)
