#!/usr/bin/env bash
# CarbonOS archiso profile definition

iso_name="CarbonOS"
iso_label="CARBON_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="CarbonOS Project <https://github.com/carbon-os>"
iso_application="CarbonOS Live/Rescue/Install CD (IBM Carbon Design System)"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
build_modes=('iso')
bootmodes=(
    'bios.syslinux.mbr'
    'bios.syslinux.eltorito'
    'uefi-ia32.grub.esp'
    'uefi-x64.grub.esp'
    'uefi-ia32.grub.eltorito'
    'uefi-x64.grub.eltorito'
)
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '15')
file_permissions=(
    ["/etc/shadow"]="0:0:400"
    ["/etc/gshadow"]="0:0:400"
    ["/etc/sudoers.d"]="0:0:750"
    ["/root"]="0:0:750"
    ["/root/.automated_script.sh"]="0:0:755"
    ["/usr/local/bin/carbon-toggle-theme"]="0:0:755"
    ["/usr/local/bin/carbon-welcome"]="0:0:755"
    ["/usr/local/bin/carbon-init"]="0:0:755"
    ["/etc/skel/.local/bin/carbon-toggle-theme"]="0:0:755"
    ["/etc/skel/.local/bin/carbon-welcome"]="0:0:755"
)
