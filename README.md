# Tahoe Linux ISO Builder

This repository builds a **VMware-ready Linux ISO** that mimics a macOS Tahoe-inspired desktop with liquid glass styling while staying lightweight.

## Goals this project targets

- macOS Tahoe-like visual flavor (glass panels, blur, translucency, smooth dock workflow)
- Runs comfortably on **4 vCPU / 6 GB RAM**
- Installation footprint target: **15–20 GB** (and comfortably under 30 GB)
- Designed for a **40 GB VM disk** in VMware Workstation Pro
- Outputs a bootable ISO suitable for VM installation

## Base stack

- Debian 12 (Bookworm) live-build
- XFCE desktop (lighter than GNOME/KDE for 6 GB RAM)
- Compositor + theme stack tuned for “liquid glass” style:
  - `picom` blur/transparency
  - `plank` dock
  - `kvantum` + custom Tahoe palette
  - Papirus icons + modern fonts

## Build host requirements

Use Debian/Ubuntu host with at least 40 GB free storage:

```bash
sudo apt update
sudo apt install -y live-build debootstrap xorriso squashfs-tools wget rsync dosfstools mtools
```

## Build the ISO

```bash
./build/build-iso.sh
```

The output ISO is written to:

- `dist/tahoe-linux-amd64.iso`

## Recommended VMware VM profile

- Guest type: Linux / Debian 12.x 64-bit
- CPU: 4 cores
- RAM: 6144 MB
- Disk: 40 GB (thin provisioned okay)
- Firmware: UEFI
- 3D acceleration: enabled

## Runtime tuning included

- `zram-tools` enabled to improve responsiveness on 6 GB systems
- `earlyoom` configured to prevent UI lockups under pressure
- XFCE session autostarts dock + compositor
- Trimmed package selection to keep install size low

## Notes

- This is an original Linux desktop theme/configuration inspired by macOS Tahoe aesthetics.
- It does **not** include Apple assets or proprietary binaries.
