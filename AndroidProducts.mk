#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_beryl.mk \
    $(LOCAL_DIR)/fox_beryl.mk

COMMON_LUNCH_CHOICES := \
    twrp_beryl-ap2a-userdebug \
    twrp_beryl-ap2a-eng \
    fox_beryl-ap2a-userdebug \
    fox_beryl-ap2a-eng \
    twrp_beryl-userdebug \
    twrp_beryl-eng \
    fox_beryl-userdebug \
    fox_beryl-eng
