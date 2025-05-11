#!/bin/bash

MODIFIED_DIR=~/android/latest-twrp-arkt
CLEAN_DIR=~/android/back-twrp-arkt-new
PATCH_OUT=~/android/twrp_changes

echo "[+] Backing up your TWRP edits from: $MODIFIED_DIR"
echo "[+] Comparing against clean reference at: $CLEAN_DIR"
echo "[+] Saving patches to: $PATCH_OUT"
echo

mkdir -p "$PATCH_OUT"

# list of common TWRP-modified dirs
folders=(
  bootable/recovery
  system/core
  vendor/twrp
  device/xiaomi/nabu
  external/libziparchive
  build/make
)

for folder in "${folders[@]}"; do
  MOD="$MODIFIED_DIR/$folder"
  REF="$CLEAN_DIR/$folder"
  OUT="$PATCH_OUT/$(echo "$folder" | sed 's|/|-|g').patch"

  if [ -d "$MOD" ] && [ -d "$REF" ]; then
    echo "[*] Generating patch for: $folder"
    diff -ruN "$REF" "$MOD" > "$OUT"

    if [ ! -s "$OUT" ]; then
      rm "$OUT"
      echo "    No changes found. Skipped."
    else
      echo "    Saved: $OUT"
    fi
  else
    echo "[!] Skipping $folder — not found in one of the trees"
  fi
done

echo
echo "Done! You can re-apply any patch with: patch -p1 < patchfile.patch"
