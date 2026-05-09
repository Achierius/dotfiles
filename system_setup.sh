#!/bin/sh

# Default package manager command (can be overridden via env)
: "${PACKAGE_MANAGER_CMD:=sudo dnf install -y}"

SYS_DIR="$HOME/Sys"

mkdir -p "$SYS_DIR"
mkdir -p "$SYS_DIR/builds"
mkdir -p "$HOME/Devel/"
mkdir -p "$HOME/Documents"

##### First, install languages #####
# Install ghc if not already installed
command -v ghc >/dev/null && echo "✅ $(ghc --version)" || {
  read -r -p "GHC not found. Install via GHCup? [Y/n] " a
  [[ ${a:-Y} =~ ^[Yy]$ ]] && curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh || echo "Skipped."
}
# Install cargo if not already installed
command -v cargo >/dev/null && echo "✅ $(cargo --version)" || {
  read -r -p "Cargo not found. Install Rust and Cargo? [Y/n] " a
  [[ ${a:-Y} =~ ^[Yy]$ ]] && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || echo "Skipped."
}
# Install OCaml if not already installed
command -v ocamlc >/dev/null && echo "✅ OCaml $(ocamlc -version)" || {
  read -r -p "OCaml not found. Install via OPAM? [Y/n] " a
  [[ ${a:-Y} =~ ^[Yy]$ ]] && curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh | sh &&  opam init || echo "Skipped."
}
# Install go if not already installed
if command -v go >/dev/null; then
  echo "✅ $(go version)"
else
  read -r -p "Go not found. Install from go.dev tarball? [Y/n] " a
  if [[ ${a:-Y} =~ ^[Yy]$ ]]; then
    echo "Visit https://go.dev/dl/ to pick your version (e.g. go1.22.3.linux-amd64.tar.gz)"
    read -r -p "Enter version filename (just the tarball name): " v
    curl -LO "https://go.dev/dl/${v}" || { echo "Download failed."; return 1 2>/dev/null || true; }
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "${v}"
    echo "✅ Go installed. Add /usr/local/go/bin to your PATH if not already."
  else
    echo "Skipped Go installation."
  fi
fi

#### For now we just install lang-provided packages here #####
cargo install atuin

##### Then, install dnf packages #####
# Package lists
PKGS_CORE="zsh git git-delta bat eza fzf vim neovim btop tree stow ripgrep rsync tmux fd-find direnv moreutils pv nnn jq xq yq jc jo miller gron notify-send"
PKGS_INFRA="restic pass wireguard-tools"
PKGS_MONITORING="cockpit vmstat iostat netstat sysstat vnstat lm_sensors glances lnav duf du-dust"
# Mostly from https://www.brendangregg.com/blog/2024-03-24/linux-crisis-tools.html
PKGS_DEBUG="procps-ng util-linux sysstat iproute numactl tcpdump kernel-tools perf bcc-tools bpftrace trace-cmd nicstat ethtool tiptop cpuid msr-tools"
# For openjdk, can also pin (e.g. java-25-openjdk) but then need to bump periodically: `dnf search openjdk` to find
# grim, slurp, wl-copy are for grimshot
PKGS_DESKTOP="flatpak firefox feh ncdu mpv ffmpeg-free sqlitebrowser wireshark java-latest-openjdk rofi-wayland pandoc poppler-utils grim slurp wl-copy"
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

##### Finally, ensure core system scripts &c #####

#[ ! -d "$SYS_DIR/scripts" ] && git clone --recurse-submodules git@github.com:Achierius/scripts.git "$SYS_DIR/scripts"
[ ! -d "$SYS_DIR/nerd-fonts" ] && git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts "$SYS_DIR/nerd-fonts"
[ ! -d "$SYS_DIR/dotfiles" ] && git clone --recurse-submodules git@github.com:Achierius/dotfiles.git "$SYS_DIR/dotfiles"
