# MIUI Camera Vendor Integration

Experimental vendor-side integration for Xiaomi MIUI Camera on
Android-based custom ROMs.

## Contents

- Android build configuration
- Camera overlay and permission configuration
- SELinux policy
- Proprietary blob extraction scripts and manifest
- Camera compatibility shim source

Proprietary Xiaomi firmware binaries and APKs are not included
in this public repository.

## Integration

Place this repository at `vendor/xiaomi/camera`.

Add to the target device's product makefile:

    $(call inherit-product-if-exists, vendor/xiaomi/camera/miuicamera.mk)

Review device-specific properties, dependencies, SELinux rules,
and binary fixups before building.

## Blob extraction

Use `extract-files.sh` with a compatible firmware source and the
ROM's `extract-utils`. Review `proprietary-files.txt` first.

Do not commit or redistribute extracted firmware binaries unless
you have the necessary rights and permissions.

## Testing

Record the device, firmware version, Android version, build result,
and camera functionality before claiming compatibility.
