#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="$ROOT_DIR/.live-build"
DIST_DIR="$ROOT_DIR/dist"
ISO_NAME="novara-linux-amd64.iso"
ROOT_FRIENDLY_ISO="$ROOT_DIR/Novara Intel-amd x64.iso"
PROJECT_SNAPSHOT_DIR="$ROOT_DIR/build/config/includes.chroot/opt/novara-project"

mkdir -p "$WORK_DIR" "$DIST_DIR"

required_cmds=(lb rsync)
for cmd in "${required_cmds[@]}"; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing required command: $cmd"
    echo "Install build deps: sudo apt install -y live-build rsync"
    exit 1
  fi
done

# Include a copy of project files in ISO so users can inspect customizations in-system.
rm -rf "$PROJECT_SNAPSHOT_DIR"
mkdir -p "$PROJECT_SNAPSHOT_DIR"
rsync -a \
  --exclude '.git' \
  --exclude '.live-build' \
  --exclude 'dist' \
  --exclude '__pycache__' \
  --exclude 'build/config/includes.chroot/opt/novara-project' \
  "$ROOT_DIR/" "$PROJECT_SNAPSHOT_DIR/"

pushd "$WORK_DIR" >/dev/null

rm -rf config auto local chroot binary cache .build

lb config \
  --architecture amd64 \
  --distribution bookworm \
  --debian-installer live \
  --archive-areas "main contrib non-free non-free-firmware" \
  --bootappend-live "boot=live components quiet splash" \
  --image-name novara-linux \
  --iso-application "Novara Linux" \
  --iso-publisher "Novara Project" \
  --linux-flavours amd64 \
  --binary-images iso-hybrid

rsync -a "$ROOT_DIR/build/config/" ./config/

sudo lb build

if [[ ! -f novara-linux-amd64.hybrid.iso ]]; then
  echo "Build completed but expected ISO not found."
  exit 1
fi

cp -f novara-linux-amd64.hybrid.iso "$DIST_DIR/$ISO_NAME"
cp -f novara-linux-amd64.hybrid.iso "$ROOT_FRIENDLY_ISO"

popd >/dev/null

echo "ISO ready: $DIST_DIR/$ISO_NAME"
echo "Direct ISO in repo root: $ROOT_FRIENDLY_ISO"
