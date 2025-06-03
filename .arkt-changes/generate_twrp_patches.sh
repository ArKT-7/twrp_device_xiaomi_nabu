#!/bin/bash

MODIFIED_DIR=$(realpath ~/android/latest-twrp-arkt)
CLEAN_DIR=$(realpath ~/android/back-twrp-arkt-new)
PATCH_OUT=$(realpath ~/android/twrp_changes)

echo "[+] Backing up your TWRP edits from: $MODIFIED_DIR"
echo "[+] Comparing against clean reference at: $CLEAN_DIR"
echo "[+] Saving patches to: $PATCH_OUT"
echo

mkdir -p "$PATCH_OUT"

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

    TMP_PATCH=$(mktemp)
    diff -ruN "$REF" "$MOD" > "$TMP_PATCH"

    # Escape slashes for sed
    ESC_CLEAN_DIR=$(echo "$CLEAN_DIR" | sed 's|/|\\/|g')
    ESC_MODIFIED_DIR=$(echo "$MODIFIED_DIR" | sed 's|/|\\/|g')

    # Remove the full absolute path but keep leading slash in path
    sed -e "s|$ESC_CLEAN_DIR||g" -e "s|$ESC_MODIFIED_DIR||g" "$TMP_PATCH" | \
    sed -e 's|--- \([^/]\)|--- /\1|' -e 's|+++ \([^/]\)|+++ /\1|' > "$OUT"

    rm "$TMP_PATCH"

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
