#!/system/bin/sh
#remove VINTF fragments from vendor_boot that TWRP did not ship, its old libvintf can't parse them
LIST=/ramdisk-files.txt
[ -s "$LIST" ] || exit 0
for f in /system/etc/vintf/manifest/*.xml; do
  grep -qxF "${f#/}" "$LIST" || rm -f "$f"
done