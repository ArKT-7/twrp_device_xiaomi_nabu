# TWRP/ Modded TWRP for WOA Build Guide for Xiaomi Pad 5 (Nabu)

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
##### The build process may take some time and approximately **30GB** of space will be required on the device.

#### ✅ **Step 1: Configure Git Identity**

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

##### For example:

```bash
git config --global user.name "arkt"
git config --global user.email "arkt@archlinux.local"
```

##### Next, initialize the repo:

```bash
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
```

#### Then sync the repo:

```bash
repo sync -c --no-clone-bundle --no-tags -j4
```

#### 📦 **Clone Your Device Tree for Nabu**

##### Now, clone the TWRP device tree for the Xiaomi Pad 5 (Nabu) from the appropriate repository:

```bash
git clone https://github.com/ArKT-7/twrp_device_xiaomi_nabu.git device/xiaomi/nabu
git clone https://github.com/Kfkcome/android_kernel_xiaomi_nabu.git kernel/xiaomi/nabu
```

#### 📂 **Output**

##### When done, you’ll get your recovery image here:

```bash
out/target/product/nabu/boot.img
```

---

##### That's it! You've now set up a working TWRP build specifically for the **Xiaomi Pad 5 (Nabu)**.

---




**Kernel Source** [https://github.com/Kfkcome/android_kernel_xiaomi_nabu](https://github.com/Kfkcome/android_kernel_xiaomi_nabu)

Special Thanks to [@SIDDK24](https://github.com/SIDDK24) and [@map220v](https://github.com/map220v)

