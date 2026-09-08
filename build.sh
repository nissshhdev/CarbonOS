#!/usr/bin/env bash
# CarbonOS ISO Build Script
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_DIR="${ARCHISO_PROFILE:-$SCRIPT_DIR/archiso-profile}"
OUTPUT_DIR="${OUTPUT_DIR:-$SCRIPT_DIR/output}"
WORK_DIR="/tmp/archiso-work"

echo "=========================================================="
echo "          CarbonOS ISO Build Automation Pipeline          "
echo "        IBM Carbon Design System Arch Linux Distro       "
echo "=========================================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "[!] Error: Building an Arch Linux ISO requires root privileges (for loop devices & chroot)."
    echo "[!] Please run with 'sudo ./build.sh' or use Docker ('docker compose up')."
    exit 1
fi

# Ensure pacman keyring is initialized
echo "[*] Initializing Pacman keyring..."
pacman-key --init 2>/dev/null || true
pacman-key --populate archlinux 2>/dev/null || true

# Ensure mkarchiso and grub exist
if ! command -v mkarchiso &>/dev/null; then
    echo "[*] mkarchiso not found. Installing 'archiso' package..."
    pacman -Syu --noconfirm archiso grub syslinux dosfstools squashfs-tools libisoburn mtools
fi

# Clean previous work directory
if [ -d "$WORK_DIR" ]; then
    echo "[*] Cleaning previous work directory ($WORK_DIR)..."
    rm -rf "$WORK_DIR"
fi

mkdir -p "$OUTPUT_DIR"
mkdir -p "$WORK_DIR"

# Ensure permissions are correct on scripts in profile
chmod +x "$PROFILE_DIR"/profiledef.sh 2>/dev/null || true
chmod +x "$PROFILE_DIR"/airootfs/usr/local/bin/* 2>/dev/null || true
chmod +x "$PROFILE_DIR"/airootfs/etc/skel/.local/bin/* 2>/dev/null || true

echo "[*] Building CarbonOS ISO from profile: $PROFILE_DIR"
echo "[*] Output directory: $OUTPUT_DIR"
echo "[*] Compiling SquashFS and packing ISO..."

mkarchiso -v -w "$WORK_DIR" -o "$OUTPUT_DIR" "$PROFILE_DIR"

echo "=========================================================="
echo " [✓] SUCCESS: CarbonOS ISO has been successfully created!"
echo " ISO location: $(ls -1 "$OUTPUT_DIR"/*.iso 2>/dev/null || echo "$OUTPUT_DIR")"
echo " You can now boot this ISO directly inside VirtualBox!"
echo "=========================================================="
