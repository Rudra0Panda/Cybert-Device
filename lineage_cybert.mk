#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from cybert device
$(call inherit-product, device/motorola/cybert/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := cybert
PRODUCT_NAME := lineage_cybert
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola edge 60 pro
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="cybert_g_sys-user 17 A171VVM.36-23 132de release-keys" \
    BuildFingerprint=motorola/cybert_g_sys/cybert:17/A171VVM.36-23/132de:user/release-keys
