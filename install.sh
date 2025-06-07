#!/bin/bash

set -euo pipefail

# Works as long as the last component is 
cwd=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

files_installed_in_homedir=(".bash_profile" ".bashrc" ".gitconfig" ".tmux.conf" ".vimrc" ".zprofile" ".zshenv" ".zshrc" ".aliasrc")
dirs_installed_in_config=("nvim" "sway" "swaylock" "foot" "rofi" "tmuxp" "nix" "waybar")

install_symlink() {
  src="$1"
  dest="$2"

  if [ -L "$dest" ]; then
    if [ "$(realpath -- "$(readlink "$dest")")" == "$(realpath -- "$src")" ]; then
      return
    else
      echo "info: $dest currently points to $(readlink "$dest")"
    fi
  elif [ -e "$dest" ]; then
    echo "warning: $dest is not a symlink!"
  fi

  ln -si "$src" -T "$dest"
}

# Create whatever directories we'll need first
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.vim/autoload"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.tmux/plugins"
mkdir -p "$HOME/Pictures/Desktop Backgrounds/"

# Default desktop background
if [ ! -e "$HOME/Pictures/Desktop Backgrounds/current" ]; then
  ln -s "$cwd/images/McDonald-Lake.jpg" "$HOME/Pictures/Desktop Backgrounds/current"
fi

# Special setup for TPM
if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  if command -v git &> /dev/null; then
    git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
  else
    echo "error: git is not installed, skipping tpm installation" >&2
  fi
fi

# Then install all the symlinks
for file in ${files_installed_in_homedir[@]}; do
	install_symlink "$cwd/$file" "$HOME/$file"
done
for dir in ${dirs_installed_in_config[@]}; do
	install_symlink "$cwd/config/$dir" "$HOME/.config/$dir"
done

# Special setup for vim-plug
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
  if command -v curl &> /dev/null; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    echo "info: installed vim-plug for vim, but you must still run :PlugInstall inside vim"
  else
    echo "error: curl is not installed, skipping vim-plug installation for vim" >&2
  fi
fi
if [ ! -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
  if command -v curl &> /dev/null; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo "info: installed vim-plug for neovim, but you must still run :PlugInstall inside nvim"
  else
    echo "error: curl is not installed, skipping vim-plug installation for nvim" >&2
  fi
fi
