# Useful resource on what should/shouldn't go in each of [.zshrc, .zshenv, .zprofile]
# https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout

# NO ALIASES!

# Add things to PATH
PATH=$HOME/.local/bin:$HOME/bin:$PATH
source "$HOME/.cargo/env"
export PATH

# Other environment variables
export LANG=en_US.UTF-8 # set correct code page, very important
export DOTFILE_HOME=~/dotfiles
