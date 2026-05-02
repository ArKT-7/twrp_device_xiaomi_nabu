#
# Copyright 2018 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# ========== Release Info ==========
PRODUCT_RELEASE_NAME := nabu
DEVICE_PATH := device/xiaomi/nabu

# ========== Base AOSP Configurations ==========
# Includes basic 64-bit and AOSP structure
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# ========== TWRP Common Config ==========
# Includes standard TWRP features and logic
$(call inherit-product, vendor/twrp/config/common.mk)

# ========== Device-specific Configuration ==========
# Points to device.mk that configures partitions, flags, etc
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# ========== Device Identifiers ==========
# These must be after all inheritances
PRODUCT_DEVICE := nabu
PRODUCT_NAME := twrp_nabu
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Xiaomi Pad 5
PRODUCT_MANUFACTURER := Xiaomi
