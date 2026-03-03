#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[1/3] Building Novara ISO..."
./build/build-iso.sh

echo "[2/3] Packaging release artifact..."
./build/release-iso.sh

echo "[3/3] Done. To download Novara ISO over browser:"
echo "  cd dist/release && python3 -m http.server 8000"
