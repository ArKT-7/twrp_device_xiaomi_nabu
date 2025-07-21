# Modded TWRP for Xiaomi Pad 5 (Nabu)
## [Download Latest V4 Modded Recovery Here](https://github.com/ArKT-7/twrp_device_xiaomi_nabu/releases/tag/mod_normal)
---

## 🔁 Automated Builds via [GitHub Actions](https://github.com/ArKT-7/twrp_device_xiaomi_nabu/actions)

You can now build the recovery automatically using the pre-configured GitHub Actions [workflow](https://github.com/ArKT-7/twrp_device_xiaomi_nabu/actions/workflows/V4%20TWRP%20BUILDER.yml).

### ✅ How to Use:
1. Fork or clone this repository.
2. Go to the **[Actions](https://github.com/ArKT-7/twrp_device_xiaomi_nabu/actions)** tab on GitHub.
3. Select the workflow [(`V4-MODDED TWRP BUILD`)](https://github.com/ArKT-7/twrp_device_xiaomi_nabu/actions/workflows/V4%20TWRP%20BUILDER.yml) and run it.
4. Wait for the build to complete and download your recovery image from the artifacts.

> 💡 *No local setup needed!*

---

## 🔧 Manual Building Guide
## 😏 BTW, this is all happening on Arch...

### 🔧 **Prerequisites**

#### Make sure you’ve got the build environment set up:

```bash
sudo pacman -S base-devel git unzip bc python gcc clang lld lzop cpio perl android-tools android-udev
```

#### And install **repo** (if not already):

```bash
mkdir ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH
```

##### Add `export PATH=~/bin:$PATH` to your `~/.bashrc` or `~/.zshrc` if you want it permanent.

### 📁 **Initialize TWRP Source (AOSP + Minimal Manifest)**

#### Make a new directory and initialize the TWRP source:

```bash
mkdir -p ~/android/twrp && cd ~/android/twrp
```

#### **Important Note:**
##### The build process may take some time and approximately **60GB** of space will be required on the device.

#### ✅ **Step 1: Configure Git Identity**

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

##### Next, initialize the repo:

```bash
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
```

#### Then sync the repo:

```bash
repo sync -j$(nproc --all) --force-sync
```

#### 📦 **Step 2: Clone Your Modded Device Tree for Nabu**

##### Now, clone the TWRP mod device tree for the Xiaomi Pad 5 (Nabu) and kernel:

```bash
git clone https://github.com/ArKT-7/twrp_device_xiaomi_nabu.git -b mod-normal device/xiaomi/nabu
git clone --depth=1 https://github.com/Kfkcome/android_kernel_xiaomi_nabu.git -b 14.0 kernel/xiaomi/nabu
```

#### 🧩 **Step 3: Patch sources for Mod twrp**

```bash
patch -p1 < device/xiaomi/nabu/.arkt-changes/bootable-recovery.patch
patch -p1 < device/xiaomi/nabu/.arkt-changes/build-make.patch
bash device/xiaomi/nabu/.arkt-changes/deleted_files.sh  
```

#### 🚀 **Start Building**

```bash
source build/envsetup.sh
lunch twrp_nabu-eng
mka clean
mka bootimage -j$(nproc --all)
```

#### 📂 **Output**

##### When done, you’ll get your recovery image here:

```bash
out/target/product/nabu/boot.img
```

---

##### That's it! You've now set up a working Modded TWRP build specifically for the **Xiaomi Pad 5 (Nabu)**.

---




**Kernel Source** [https://github.com/Kfkcome/android_kernel_xiaomi_nabu](https://github.com/Kfkcome/android_kernel_xiaomi_nabu)

Special Thanks to [@SIDDK24](https://github.com/SIDDK24) and [@map220v](https://github.com/map220v)

