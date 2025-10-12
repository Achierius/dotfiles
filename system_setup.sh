#!/bin/sh

SYS_DIR="$HOME/Sys"

mkdir -p "$SYS_DIR"
mkdir -p "$SYS_DIR/builds"
mkdir -p "$HOME/Devel/"
mkdir -p "$HOME/Documents"

# Default package manager command (can be overridden via env)
: "${PACKAGE_MANAGER_CMD:=dnf install -y}"

# Package lists
PKGS_CORE="zsh git git-delta bat eza fzf vim neovim btop tree stow ripgrep rsync tmux fd-find direnv moreutils pv nnn jq xq yq jc jo miller gron"
PKGS_INFRA="restic pass wireguard-tools"
PKGS_MONITORING="cockpit vmstat iostat netstat sysstat vnstat lm_sensors glances lnav duf du-dust"
# Mostly from https://www.brendangregg.com/blog/2024-03-24/linux-crisis-tools.html
PKGS_DEBUG="procps-ng util-linux sysstat iproute numactl tcpdump kernel-tools perf bcc-tools bpftrace trace-cmd nicstat ethtool tiptop cpuid msr-tools"
PKGS_DESKTOP="flatpak firefox feh ncdu mpv ffmpeg sqlitebrowser wireshark openjdk rofi pandoc poppler-utils"
PKGS_DEVEL="hexedit hexyl xxd nasm gcc gcc-c++ uv hotspot speedscope perl make cmake meson valgrind hyperfine"

# List of packages to install
PACKAGES="$PKGS_CORE $PKGS_INFRA $PKGS_MONITORING $PKGS_DEBUG $PKGS_DEVEL $PKGS_DESKTOP"

# Keep track of failed packages
FAILED=""

echo "Using package manager: $PACKAGE_MANAGER_CMD"
echo "Installing packages..."

for pkg in $PACKAGES; do
    echo "Installing $pkg..."
    if $PACKAGE_MANAGER_CMD "$pkg"; then
        echo "✅ $pkg installed successfully"
    else
        echo "❌ Failed to install $pkg"
        FAILED="$FAILED $pkg"
    fi
done

if [ -n "$FAILED" ]; then
    echo
    echo "The following packages failed to install:"
    for f in $FAILED; do
        echo " - $f"
    done
    exit 1
else
    echo
    echo "All packages installed successfully!"
fi

#[ ! -d "$SYS_DIR/scripts" ] && git clone --recurse-submodules git@github.com:Achierius/scripts.git "$SYS_DIR/scripts"
[ ! -d "$SYS_DIR/nerd-fonts" ] && git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts "$SYS_DIR/nerd-fonts"
[ ! -d "$SYS_DIR/dotfiles" ] && git clone --recurse-submodules git@github.com:Achierius/dotfiles.git "$SYS_DIR/dotfiles"
