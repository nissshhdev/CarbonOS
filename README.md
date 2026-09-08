# 🔷 CarbonOS — IBM Carbon Design System Arch Linux Distribution

<div align="center">

```
   ____           _                    ___  ____  
  / ___|__ _ _ __| |__   ___  _ __    / _ \/ ___| 
 | |   / _` | '__| '_ \ / _ \| '_ \  | | | \___ \ 
 | |__| (_| | |  | |_) | (_) | | | | | |_| |___) |
  \____\__,_|_|  |_.__/ \___/|_| |_|  \___/|____/ 
```

**An elegant, performance-oriented Arch Linux distribution crafted with the IBM Carbon Design System.**

[![Build ISO](https://github.com/carbon-os/carbonos/actions/workflows/build-iso.yml/badge.svg)](.github/workflows/build-iso.yml)
[![Design System](https://img.shields.io/badge/Design-IBM%20Carbon-0f62fe)](https://carbondesignsystem.com)
[![Typography](https://img.shields.io/badge/Font-IBM%20Plex-black)](https://www.ibm.com/plex/)
[![Target](https://img.shields.io/badge/VM-VirtualBox%20Ready-green)]()

</div>

---

## 🌟 Key Features

- **IBM Carbon Design System Aesthetics**:
  - Main accent color: **IBM Blue 60 (`#0f62fe`)**, IBM Cyan, Carbon Gray 100 (`#161616`), and Gray 10 (`#f4f4f4`).
  - Strict Carbon geometric typography, focus rings, buttons, inputs, and layout grids.
- **"Drawer" Applications Menu**:
  - The traditional application launcher is renamed to **"Drawer"** with custom Carbon grid icon, category navigation, and quick search.
- **Seamless Dark & Light Mode**:
  - Instant one-click toggle button on the top panel or via terminal command `carbon-toggle-theme`.
  - Dynamically switches GTK 3/4 themes, window borders, terminal colors, and desktop wallpapers.
- **Modern Terminal Experience**:
  - Shell: **`zsh`** with custom IBM Carbon prompt, syntax highlighting, completions, and autosuggestions.
  - Font: **IBM Plex Mono** configured across all terminal emulators (Alacritty & XFCE Terminal).
  - Built-in **Fastfetch** system information display featuring the CarbonOS ASCII logo.
- **VirtualBox Out-of-the-Box**:
  - Pre-installed `virtualbox-guest-utils` for automatic screen resolution resizing, bidirectional clipboard sharing, seamless mouse integration, and shared folders.
- **Universal Bootloader Support**:
  - Dual boot support: **UEFI (GRUB)** with custom Carbon Blue styling and **BIOS (Syslinux)**.

---

## 📂 Project Structure

```
CarbonOS/
├── archiso-profile/              # Arch Linux archiso build profile
│   ├── profiledef.sh             # ISO metadata, image options, file permissions
│   ├── packages.x86_64           # Package manifest (base, xfce4, zsh, ibm-plex, v-box)
│   ├── pacman.conf               # Arch mirrors & package manager settings
│   ├── grub/                     # UEFI Bootloader configuration
│   ├── syslinux/                 # BIOS Bootloader configuration
│   └── airootfs/                 # Root filesystem overlay
│       ├── etc/
│       │   ├── skel/             # Default user configurations (.zshrc, xfce4, alacritty)
│       │   ├── lightdm/          # Display manager configuration (Drawer / IBM Blue)
│       │   └── systemd/          # Live autologin and vboxservice systemd units
│       └── usr/
│           ├── local/bin/        # carbon-toggle-theme, carbon-welcome, carbon-init
│           ├── share/themes/     # Carbon-Dark and Carbon-Light GTK themes
│           └── share/backgrounds/# High-res IBM Carbon wallpapers
├── .github/workflows/
│   └── build-iso.yml             # Cloud CI pipeline to build bootable ISO on push
├── Dockerfile                    # Containerized Archiso environment
├── docker-compose.yml            # 1-command Docker build
├── build.sh                      # Local build script for Arch / Linux / WSL2
├── build-iso.ps1                 # Windows PowerShell build helper
└── preview/                      # Interactive browser simulator for CarbonOS Desktop
```

---

## 🚀 How to Build the Bootable ISO

### Option 1: On Windows (using Docker Desktop)
Run the PowerShell helper script in this directory:
```powershell
.\build-iso.ps1
```
*Or using Docker Compose directly:*
```powershell
docker compose run --rm carbonos-builder
```
The generated bootable ISO will be saved in the `output/` directory as `CarbonOS-x86_64.iso`.

---

### Option 2: On Linux / WSL2 (Native Arch or Docker)
Make sure you are in an environment with root privileges:
```bash
sudo ./build.sh
```

---

### Option 3: GitHub Actions (Automated Cloud Build)
1. Push this folder to a GitHub repository.
2. Navigate to **Actions** -> **Build CarbonOS Bootable ISO**.
3. Download the generated `CarbonOS-x86_64-ISO` artifact directly from the release page!

---

## 🖥️ VirtualBox Setup Guide

To run CarbonOS in VirtualBox:

1. **Create New VM**:
   - **Name**: `CarbonOS`
   - **Type**: `Linux`
   - **Version**: `Arch Linux (64-bit)`
2. **Hardware Configuration**:
   - **Base Memory (RAM)**: `2048 MB` minimum (`4096 MB` recommended).
   - **Processors**: `2` or more CPUs.
3. **Display Configuration**:
   - **Video Memory**: Set to `128 MB`.
   - **Graphics Controller**: `VMSVGA` (enables automatic resizing).
   - **Enable 3D Acceleration**: Check box.
4. **Storage**:
   - Under Storage Devices, attach `CarbonOS-x86_64.iso` to the Optical Drive.
5. **Start Virtual Machine**:
   - The ISO will boot automatically into the CarbonOS Live Desktop with autologin.

---

## 🔑 Live Environment Credentials

| Account | Username | Password | Privileges |
| :--- | :--- | :--- | :--- |
| **Live User** | `carbon` | `carbon` | Sudo (NOPASSWD) |
| **Root** | `root` | `root` | System Administrator |

---

## 💡 Quick Tips & Shortcuts

- **Open Drawer Menu**: Click **Drawer** on the top-left panel or press `Alt + F1`.
- **Toggle Dark / Light Theme**: Click the theme toggle icon on the top panel or execute:
  ```zsh
  toggle-theme
  ```
- **Install to Hard Disk**: Click the **Install CarbonOS** shortcut on the desktop or run:
  ```zsh
  sudo archinstall
  ```
- **Open Carbon Terminal**: `Super + Enter` or click the terminal icon.
- **Preview Desktop Environment**: Open [preview/index.html](file:///c:/Users/AMIT%20KUMAR/OneDrive/Desktop/CarbonOS/preview/index.html) in any web browser.
