#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
ISO_PATH="$DIST_DIR/tahoe-linux-amd64.iso"
RELEASE_DIR="$DIST_DIR/release"

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
out_iso="$RELEASE_DIR/tahoe-linux-amd64-${stamp}.iso"
cp -f "$ISO_PATH" "$out_iso"

(
  cd "$RELEASE_DIR"
  sha256sum "$(basename "$out_iso")" > "$(basename "$out_iso").sha256"
)

cat <<MSG
Release artifacts created:
- $out_iso
- $out_iso.sha256

To download from another machine on the same network:
1) cd $RELEASE_DIR
2) python3 -m http.server 8000
3) Open: http://<this-host-ip>:8000/

VMware-ready ISO path:
$out_iso
MSG
