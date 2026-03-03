#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
ISO_PATH="$DIST_DIR/novara-linux-amd64.iso"
RELEASE_DIR="$DIST_DIR/release"
FRIENDLY_ISO_NAME="Novara Intel-amd x64.iso"
FRIENDLY_ROOT_ISO="$ROOT_DIR/$FRIENDLY_ISO_NAME"

mkdir -p "$DIST_DIR" "$RELEASE_DIR"

if [[ ! -f "$ISO_PATH" ]]; then
  echo "ISO not found at $ISO_PATH"
  echo "Running build first..."
  "$ROOT_DIR/build/build-iso.sh"
fi

if [[ ! -f "$ISO_PATH" ]]; then
  echo "ERROR: ISO build did not produce $ISO_PATH"
  exit 1
fi

stamp="$(date +%Y%m%d-%H%M%S)"
out_iso="$RELEASE_DIR/novara-linux-amd64-${stamp}.iso"
stable_iso="$RELEASE_DIR/novara-linux-amd64.iso"
friendly_release_iso="$RELEASE_DIR/$FRIENDLY_ISO_NAME"
cp -f "$ISO_PATH" "$out_iso"
cp -f "$ISO_PATH" "$stable_iso"
cp -f "$ISO_PATH" "$friendly_release_iso"
cp -f "$ISO_PATH" "$FRIENDLY_ROOT_ISO"

(
  cd "$RELEASE_DIR"
  sha256sum "$(basename "$out_iso")" > "$(basename "$out_iso").sha256"
  sha256sum "$(basename "$stable_iso")" > "$(basename "$stable_iso").sha256"
  sha256sum "$(basename "$friendly_release_iso")" > "$(basename "$friendly_release_iso").sha256"
)
sha256sum "$FRIENDLY_ROOT_ISO" > "$FRIENDLY_ROOT_ISO.sha256"

cat <<MSG
Release artifacts created:
- $out_iso
- $out_iso.sha256
- $stable_iso
- $stable_iso.sha256
- $friendly_release_iso
- $friendly_release_iso.sha256
- $FRIENDLY_ROOT_ISO
- $FRIENDLY_ROOT_ISO.sha256

To download from another machine on the same network:
1) cd "$ROOT_DIR"
2) python3 -m http.server 8000
3) Open: http://<this-host-ip>:8000/

Direct repo-root ISO filename:
$FRIENDLY_ISO_NAME
MSG
