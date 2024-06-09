# To profile slowdowns: load
#   zmodload zsh/zprof
# and then at the end of .zshrc
#   zprof

# To debug slowdowns: https://unix.stackexchange.com/questions/397135/change-of-directory-is-very-slow
# PS4='+[%D{%T.%.}] %N:%i> ' zsh -x

###### Core settings ######
  setopt histignorealldups sharehistory extendedglob

  # https://zsh.sourceforge.io/Doc/Release/Parameters.html
  TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E\nmax rss\t%MKB'

  # FZF - See /usr/share/doc/fzf/README.Fedora
  source /usr/share/fzf/shell/key-bindings.zsh 

  # I don't really know if this is necessary or wise
  export LANG=en_US.UTF-8 
  export LANG="$LC_ALL"
  #export LC_CTYPE=en_US.UTF-8
  #export LC_ALL=en_US.UTF-8

  # Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='vim'
  fi

  # TODO should this be in .zprofile?
  # Map Shift+Space to '_' on graphical environments
  #xmodmap -e 'keycode 65 = space underscore' # Requires x11-xserver-utils
  # Map Shift+Space to '_' in the console
  # TODO # Requires console-data

####### Make prompt pretty #######
  # Terminal prompt -- got tired of the oh-my-zsh defaults
  # https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
  # Color chart: https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html %F{51}?
  # General prompt code docs: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
  # I used to use %# to see if I was sudo, don't use it that often
  export PROMPT='%F{blue}%n%f %F{245}in%f %B%F{blue}%~%f%b %(?.%F{blue}√.%F{yellow}?%?)%f %B%F{red}⁊ᶜ%f%b '

  # Version control addons
  # https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
  # https://unix.stackexchange.com/questions/193659/in-which-situations-are-ps2-ps3-ps4-used-as-the-prompt
  autoload -Uz vcs_info
  precmd_vcs_info() { vcs_info }
  setopt prompt_subst
  zstyle ':vcs_info:git:*' formats '%F{red}(%b)%f %F{blue}%*%f' # %T is 24-hour time, %* is that w/ seconds
  zstyle ':vcs_info:git:*' actionformats '%F{red}%a (%20.20b)%f %F{blue}%*%f'
  zstyle ':vcs_info:*' enable git
  RPS1=\$vcs_info_msg_0_
  precmd_functions+=( precmd_vcs_info )

####### Compilation flags #######
  # export ARCHFLAGS="-arch x86_64"
  # TODO remove this it's probably causing problems
  # But ig I should make an alias which sets it so I can use it when needed
  export CPLUS_INCLUDE_PATH='/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11'  # Lets me use clangd lsp on one-off files w/o compile_commands.json 

####### Aliases #######
  # TODO move these to another file
  alias ohmyzsh="mate ~/.oh-my-zsh"
  alias tmux="tmux -u"
  alias git-watch="watch -c -t -n3 git --no-optional-locks -c color.status=always status"
  alias git-logwatch="watch -c -t -n5 git --no-optional-locks -c color.ui=always log --decorate --oneline"
  alias -g up='popd'
  alias gmake="make"

  # LS aliases
  # Maybe change colors someday https://the.exa.website/docs/colour-themes
  alias l='eza --icons always'
  alias ll='eza --icons always -l'
  alias la='eza --icons always -a'
  alias lla='eza --icons always -la'

  # Git aliases from https://hackernoon.com/lesser-known-git-commands-151a1918a60
  git config --global alias.please 'push --force-with-lease'
  git config --global alias.tackon 'commit --amend --no-edit' # was "commend"
  git config --global alias.stsh 'stash --keep-index'
  git config --global alias.staash 'stash --include-untracked'
  git config --global alias.staaash 'stash --all'
  git config --global alias.qstat 'status --short --branch' # was "shorty"/"st"
  git config --global alias.grog 'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
  git config --global alias.count-lines "! git log --author=\"\$1\" --pretty=tformat: --numstat | awk '{ add += \$1; subs += \$2; loc += \$1 - \$2 } END { printf \"added lines: %s, removed lines: %s, total lines: %s\n\", add, subs, loc }' #"
  git config --global alias.rbc 'rebase --continue'

####### Old oh-my-zsh configurations #######
  # Prepare env-vars for the (fzf) zsh plugin
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
  #export FZF_BASE=/usr/bin/fzf
  #export FZF_DEFAULT_COMMAND='rg --files'
  #export FZF_COMPLETION_TRIGGER=';;' # vs. default **

  # Prepare env-vars for zsh-vim-mode
  # I don't know if these actually need to be set up ahead of time
  #export MODE_CURSOR_VIINS="#ebcb8b blinking bar" # Nord Aurora yellow
  #export MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #bf616a" # Nord Aurora red
  #export MODE_CURSOR_VICMD="#88c0d0 block" # Nord Frost cyan, since it's the default mode it doesn't need attention
  #export MODE_CURSOR_SEARCH="#b48ead steady underline" # Nord Aurora purple
  #export MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
  #export MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #ebcb8b" # Nord Aurora yellow

  # TODO re-enable some of these plugins
  #   - z https://github.com/agkozak/zsh-z?tab=readme-ov-file#installation
  #   - zsh-syntax-highlighting
  #   - fzf?
  #   - zsh-vim-mode?
  #      "Ordering": https://github.com/agkozak/zsh-z?tab=readme-ov-file#installation

  # Do I still need this now that I'm using zsh-vim-mode instead?
  # (was?) required for compat b/w zsh-vi-mode and fzf: https://github.com/jeffreytse/zsh-vi-mode/issues/24
  #export ZVM_INIT_MODE=sourcing

  # Is this oh-my-zsh only?
  # Don't "load only from secure directories", just load from everywhere
  # Reduces startup time by like half, esp. since we avoid trawling NFS

  # Keybinds for zsh-autosuggestions
  #bindkey '^ ' autosuggest-accept # Binds to ctrl-space
  #bindkey '^[[Z' autosuggest-accept # Binds to shift-tab
