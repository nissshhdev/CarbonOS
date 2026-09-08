# CarbonOS Automated ISO Builder Container
FROM archlinux:base-devel

# Refresh keyring and install archiso and required build tools
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm archiso git dosfstools squashfs-tools libisoburn mtools lynx reflector && \
    pacman -Scc --noconfirm

# Set working directory
WORKDIR /build

# Copy archiso profile
COPY archiso-profile /build/archiso-profile
COPY build.sh /build/build.sh
RUN chmod +x /build/build.sh

# Default command to build ISO into /output directory
ENTRYPOINT ["/build/build.sh"]
