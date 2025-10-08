#!/bin/bash

MODIFIED_DIR=$(realpath ~/android/twrp-nabu)
CLEAN_DIR=$(realpath ~/android/backup-twrp)
PATCH_OUT=$(realpath ~/android/twrp-nabu/device/xiaomi/nabu/.arkt-changes)
DELETE_SCRIPT="$PATCH_OUT/deleted_files.sh"

echo "[+] Backing up your TWRP edits from: $MODIFIED_DIR"
echo "[+] Comparing against clean reference at: $CLEAN_DIR"
echo "[+] Saving patches to: $PATCH_OUT"
echo

mkdir -p "$PATCH_OUT"
echo "#!/bin/bash" > "$DELETE_SCRIPT"
chmod +x "$DELETE_SCRIPT"

folders=(
  bootable/recovery
  system/core
  vendor/twrp
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
    diff -ruN --exclude='.git' "$REF" "$MOD" > "$TMP_PATCH"

    # Escape slashes for sed
    ESC_CLEAN_DIR=$(echo "$CLEAN_DIR" | sed 's|/|\\/|g')
    ESC_MODIFIED_DIR=$(echo "$MODIFIED_DIR" | sed 's|/|\\/|g')

    # Clean absolute paths
    sed -e "s|$ESC_CLEAN_DIR||g" -e "s|$ESC_MODIFIED_DIR||g" "$TMP_PATCH" | \
    sed -e 's|--- \([^/]\)|--- /\1|' -e 's|+++ \([^/]\)|+++ /\1|' > "$OUT"

    rm "$TMP_PATCH"

    if [ ! -s "$OUT" ]; then
      rm "$OUT"
      echo "    No changes found. Skipped."
    else
      echo "    Saved: $OUT"
    fi

    # Deleted files (skip .git too)
    while IFS= read -r line; do
      dir_part=$(echo "$line" | sed "s|Only in $REF/||" | cut -d':' -f1)
      file_part=$(echo "$line" | cut -d':' -f2- | sed 's|^ ||')
      fullpath="$folder/$dir_part/$file_part"
      if [[ "$fullpath" == *".git/"* || "$fullpath" == *"/.git" || "$fullpath" == *"/.gitignore" ]]; then
        continue
      fi
      echo "rm -f \"$fullpath\"" >> "$DELETE_SCRIPT"
      echo "    Scheduled for deletion: $fullpath"
    done < <(diff -rq --exclude='.git' "$REF" "$MOD" | grep "^Only in $REF")

  else
    echo "[!] Skipping $folder — not found in one of the trees"
  fi
done

echo
echo "Done! You can re-apply patches with: patch -p1 < patchfile.patch"
echo "Then run: bash deleted_files.sh  # to remove any deleted files"
