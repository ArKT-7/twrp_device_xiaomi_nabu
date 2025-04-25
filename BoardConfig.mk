#
# Copyright (C) 2021 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# ==================================================
# == Build System Fixes ==
# ==================================================
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# ==================================================
# == Architecture ==
# ==================================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a76
TARGET_SUPPORTS_64_BIT_APPS := true
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# ==================================================
# == APEX (disable for TWRP-only) ==
# ==================================================
DEXPREOPT_GENERATE_APEX_IMAGE := true

# ==================================================
# == Device Assert ==
# ==================================================
TARGET_OTA_ASSERT_DEVICE := nabu

# ==================================================
# == Bootloader / Platform ==
# ==================================================
PRODUCT_PLATFORM := msmnile
TARGET_BOOTLOADER_BOARD_NAME := msmnile
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# ==================================================
# SoC/GPU Flags
# ==================================================
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := msmnile
TARGET_BOARD_PLATFORM_GPU := qcom-adreno640
QCOM_BOARD_PLATFORMS += msmnile

# ==================================================
# == Kernel (Prebuilt) ==
# ==================================================
TARGET_KERNEL_CONFIG := prebuilt.config
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtbs
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_SECOND_OFFSET := 0x00000000
BOARD_RAMDISK_OFFSET := 0x01000000

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)

# ==================================================
# == Kernel Command Line ==
# ==================================================
BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/1d84000.ufshc
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3
BOARD_KERNEL_CMDLINE += androidboot.memcg=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += buildvariant=userdebug
BOARD_KERNEL_CMDLINE += earlycon=msm_geni_serial,0x880000
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem,nosocket
BOARD_KERNEL_CMDLINE += swiotlb=2048
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += pcie_ports=compat
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += androidboot.fastboot=1
BOARD_KERNEL_CMDLINE += video=vfb:640x400,bpp=32,memsize=3072000

# ==================================================
# == Android Verified Boot (AVB) ==
# ==================================================
BOARD_AVB_ENABLE := true
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# ==================================================
# == Partition Layout ==
# ==================================================
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 66060288
#BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 33554432

BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system product system_ext odm vendor
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
BOARD_SUPPRESS_SECURE_ERASE := true

# ==================================================
# == Filesystem Types ==
# ==================================================
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

BOARD_USES_PRODUCTIMAGE := true
BOARD_USES_SYSTEM_EXTIMAGE := true
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_ODM := odm

# ==================================================
# == Recovery Settings ==
# ==================================================
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# ==================================================
# == A/B & Virtual A/B Support ==
# ==================================================
AB_OTA_UPDATER := true
ENABLE_VIRTUAL_AB := true
TARGET_IS_VAB := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    mi_ext \
    product \
    system \
    system_ext \
    vendor \
    vendor_boot \
    vbmeta \
    vbmeta_system

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# ==================================================
# == Encryption / Decryption (FBE) Support ==
# ==================================================
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
