#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APK_DIR="$ROOT/proprietary/system/priv-app/MiuiCamera"
APK="$APK_DIR/MiuiCamera.apk"
shopt -s nullglob
PARTS=("$APK".part[0-9][0-9])

if [ "${#PARTS[@]}" -eq 0 ]; then
    echo "ERROR: No split APK chunks found in $APK_DIR" >&2
    exit 1
fi

if ! command -v unzip >/dev/null 2>&1; then
    echo "ERROR: unzip is required to validate the assembled APK" >&2
    exit 1
fi

if [ -e "$APK" ]; then
    echo "ERROR: $APK already exists; refusing to overwrite it" >&2
    exit 1
fi

TMP="$(mktemp "$APK_DIR/.MiuiCamera.apk.XXXXXX")"
trap 'rm -f "$TMP"' EXIT

cat "${PARTS[@]}" > "$TMP"
unzip -tq "$TMP"

mv "$TMP" "$APK"
trap - EXIT

echo "Assembled and validated: $APK"
echo "Source chunks were preserved."
