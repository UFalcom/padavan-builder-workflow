#!/usr/bin/env bash
set -euo pipefail

BUSYBOX_DIR="padavan-ng/trunk/user/busybox/busybox-1.37.0"
PATCH_FILE="patches/busybox-1.37.0-fix-can-compat.patch"

if [[ -d "$BUSYBOX_DIR" && -f "$PATCH_FILE" ]]; then
  echo "Applying BusyBox CAN compatibility patch"
  git -C "$BUSYBOX_DIR" init || true
  git -C "$BUSYBOX_DIR" add -A
  git -C "$BUSYBOX_DIR" commit -m "prepatch: baseline" || true
  git -C "$BUSYBOX_DIR" apply --index "../../$PATCH_FILE" || {
    echo "Patch failed to apply; aborting"
    exit 1
  }
else
  echo "BusyBox dir or patch file not found; skipping patch"
fi
