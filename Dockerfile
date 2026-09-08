# CarbonOS Automated ISO Builder Container
FROM archlinux:base-devel

# Refresh keyring, initialize pacman keys, and install archiso + grub + build tools
RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm archiso grub syslinux dosfstools squashfs-tools libisoburn mtools lynx reflector edk2-ovmf && \
    pacman -Scc --noconfirm

# Set working directory
WORKDIR /build

# Copy archiso profile
COPY archiso-profile /build/archiso-profile
COPY build.sh /build/build.sh
RUN chmod +x /build/build.sh

# Default command to build ISO into /output directory
ENTRYPOINT ["/build/build.sh"]
