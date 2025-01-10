# Useful resource on what should/shouldn't go in each of [.zshrc, .zshenv, .zprofile]
# https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# NO ALIASES!

####### PATH changes #######
# If doing so would require logic logic that would slow down startup,
# do it in .zprofile instead
  PATH="$HOME/Sys/builds/j-language/bin:$PATH"
  export PATH

####### Compilation flags #######
  # export ARCHFLAGS="-arch x86_64"
  # TODO remove this it's probably causing problems
  # But ig I should make an alias which sets it so I can use it when needed
  export CPLUS_INCLUDE_PATH='/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11'  # Lets me use clangd lsp on one-off files w/o compile_commands.json 

####### Set other envvars ######
  # Other environment variables
  export LANG=en_US.UTF-8 # set correct code page, very important
  export DOTFILE_HOME=~/dotfiles
  #export MANPATH="/usr/local/man:$MANPATH" # TODO is this necessary?
