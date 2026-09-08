#!/usr/bin/env bash
# CarbonOS One-Command Live Setup & Installer
# Converts any standard Arch Linux live ISO or installation into CarbonOS (IBM Carbon Edition)
set -e

echo "=========================================================="
echo "          CarbonOS Live Environment Installer             "
echo "        IBM Carbon Design System Arch Linux Distro        "
echo "=========================================================="

# 1. Update Pacman Keys & Mirrors
echo "[1/6] Updating package database..."
pacman -Sy --noconfirm archlinux-keyring
pacman -S --noconfirm reflector
reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist 2>/dev/null || true

# 2. Install IBM Plex Fonts & Core Desktop Packages
echo "[2/6] Installing IBM Plex Fonts, XFCE4, LightDM & Core Apps..."
pacman -S --noconfirm \
    ttf-ibm-plex noto-fonts-emoji \
    xorg-server xorg-xinit xorg-xrandr \
    xfce4 xfce4-goodies xfce4-whiskermenu-plugin xfce4-pulseaudio-plugin \
    lightdm lightdm-gtk-greeter \
    zsh zsh-syntax-highlighting zsh-autosuggestions \
    alacritty fastfetch \
    firefox mousepad thunar file-roller \
    virtualbox-guest-utils xf86-video-vmware mesa

# 3. Create Live User 'carbon'
echo "[3/6] Setting up live user 'carbon'..."
if ! id "carbon" &>/dev/null; then
    useradd -m -g users -G wheel,audio,video,storage,optical,network,power,input -s /bin/zsh carbon
fi
echo "carbon:carbon" | chpasswd
echo "root:root" | chpasswd

# Enable Sudo for Wheel
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/99-carbon
chmod 0440 /etc/sudoers.d/99-carbon

# 4. Deploy IBM Carbon System Themes & Assets
echo "[4/6] Installing IBM Carbon Design System Themes & Assets..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -d "$SCRIPT_DIR/archiso-profile/airootfs" ]; then
    cp -r "$SCRIPT_DIR/archiso-profile/airootfs/usr" /
    cp -r "$SCRIPT_DIR/archiso-profile/airootfs/etc/skel/." /home/carbon/
else
    # Fallback default Carbon styling if run standalone
    mkdir -p /home/carbon/.config/xfce4/xfconf/xfce-perchannel-xml
fi

chown -R carbon:users /home/carbon
chmod +x /usr/local/bin/carbon-* 2>/dev/null || true
chmod +x /home/carbon/.local/bin/* 2>/dev/null || true

# 5. Configure LightDM Autologin for Carbon User
echo "[5/6] Configuring LightDM Display Manager..."
mkdir -p /etc/lightdm/lightdm.conf.d
cat <<EOF > /etc/lightdm/lightdm.conf.d/autologin.conf
[Seat:*]
autologin-user=carbon
autologin-user-timeout=0
user-session=xfce
greeter-session=lightdm-gtk-greeter
EOF

# 6. Enable Services & Launch Desktop
echo "[6/6] Enabling System Services (VirtualBox Guest, NetworkManager, LightDM)..."
systemctl enable vboxservice.service 2>/dev/null || true
systemctl enable NetworkManager.service 2>/dev/null || true
systemctl enable lightdm.service

echo "=========================================================="
echo " [✓] CarbonOS has been successfully configured!"
echo " Starting display manager..."
echo "=========================================================="
systemctl start lightdm.service || systemctl restart lightdm.service
