#!/bin/bash

# Works as long as the last component is 
cwd=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

files_installed_in_homedir=(".bash_profile" ".bashrc" ".gitconfig" ".tmux.conf" ".vimrc" ".zprofile" ".zshenv" ".zshrc" ".aliasrc")
dirs_installed_in_config=("nvim")

for file in ${files_installed_in_homedir[@]}; do
	ln -si $cwd/$file ~/$file
done

for dir in ${dirs_installed_in_config[@]}; do
	ln -si $cwd/config/$dir/ -t ~/.config/
done
