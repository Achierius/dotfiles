# To profile slowdowns: load
#   zmodload zsh/zprof
# and then at the end of .zshrc
#   zprof
# Can also run `zsh -x` to get timings
# https://unix.stackexchange.com/questions/397135/change-of-directory-is-very-slow
# This is related somehow? Maybe I was debugging it idk PS4='+[%D{%T.%.}] %N:%i> '


###### Autoload setups ######
  # Autoload looks in FPATH -- defaults to ~/.zsh/functions ?
  # `zle -N` makes it a widget: necessary for keyboard bindings
  alias ald='autoload -Uz' # This alias can stay here

  # Fuzzy regex matcher
  ald zmv


###### Core settings ######
  # TODO see if there are otehrs I might want https://thevaluable.dev/zsh-install-configure-mouseless/
  setopt extendedglob flowcontrol
  # Autocorrection
  setopt correct hashlistall
  # Job control
  setopt autocontinue
  unsetopt notify bgnice
  # History
  HISTFILE=~/.zhistory
  HISTSIZE=10000000
  SAVEHIST=$HISTSIZE
  setopt histignorealldups sharehistory appendhistory histnostore histignorespace


##### Completions #####
  # tmuxp: at some point need to run
  # shtab --shell=zsh -u tmuxp.cli.create_parser | sudo tee /usr/local/share/zsh/site-functions/_TMUXP # `pip install shtab --user`
  ald compinit && compinit
  . $DOTFILE_HOME/submodules/fzf-tab/fzf-tab.plugin.zsh
  # TODO improve these colors (yoinked from https://www.reddit.com/r/zsh/comments/109rpd5/fzftab_colors_issue/)
  FZF_COLOR_CONFIG="16,fg:#88c0d0,bg:-1,hl:1,hl+:1,bg+:#5e81ac,fg+:-1:bold:underline,\
                  prompt:#5e81ac,pointer:#bf616a,gutter:-1,marker:#bf616a,spinner:3,info:3"
  FZF_BINDING_CONFIG="ctrl-l:accept,ctrl-h:toggle,right:accept,left:toggle"
  # May as well set normal FZF configuration here as well:
  export FZF_DEFAULT_OPTS="--color=\"$FZF_COLOR_CONFIG\" --bind=\"$FZF_BINDING_CONFIG\""

  # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default, so if not forced you would have to set stuff here
  # To make fzf-tab follow FZF_DEFAULT_OPTS you can add `use-fzf-default-opts yes` but that may break things:
  # see Aloxaf/fzf-tab#455
  #zstyle ':fzf-tab:*' use-fzf-default-opts yes
  zstyle ':fzf-tab:*' fzf-flags --color "$FZF_COLOR_CONFIG" --bind "$FZF_BINDING_CONFIG" 
  # preview directory's content with eza when completing cd
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
  # If I want to make them use a tmux popup:
  #zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
  # Rest are yoinked from https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file
  # disable sort when completing `git checkout`
  zstyle ':completion:*:git-checkout:*' sort false
  # set descriptions format to enable group support
  # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
  zstyle ':completion:*:descriptions' format '[%d]'
  # set list-colors to enable filename colorizing
  #zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
  zstyle ':completion:*' menu no
  # switch group using `<` and `>`
  zstyle ':fzf-tab:*' switch-group '<' '>'

  # Remember to run build-fzf-tab-module at some point to install the binary module

###### Load FZF keybinds #####
  # Load fzf keybinds + completion, with basic cross-platform compatability
  if command -v brew >/dev/null 2>&1; then
    # This handles the case where we have Homebrew installed but aren't
    # using it to package fzf
    FZF_HOMEBREW_PREFIX="$(brew --prefix fzf 2>/dev/null)"
    if [ -n "$FZF_HOMEBREW_PREFIX" ] && [ -d "$FZF_HOMEBREW_PREFIX/shell" ]; then
      FZF_BASE="$FZF_HOMEBREW_PREFIX"
    fi
  fi
  if [ -z "$FZF_BASE" ]; then
    if [ -d /usr/share/fzf ]; then
      # See /usr/share/doc/fzf/README.Fedora
      FZF_BASE="/usr/share/fzf"
    elif [ -d /usr/share/doc/fzf ]; then
      # Debian thing?
      FZF_BASE="/usr/share/doc/fzf"
    else
      echo ".zshrc: could not find FZF_BASE, is fzf installed?"
    fi
  fi
  [ -f "$FZF_BASE/shell/key-bindings.zsh" ] && source "$FZF_BASE/shell/key-bindings.zsh"
  # Often not available but we may as well try (though do I really want it? unclear)
  [ -f "$FZF_BASE/shell/completion.zsh" ] && source "$FZF_BASE/shell/completion.zsh"


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


####### Other files & extensions #######
  . ~/.aliasrc
  eval "$(direnv hook zsh)" # Depends on [direnv](https://direnv.net/docs/hook.html)

  # Per-directory history!!!
  . $DOTFILE_HOME/submodules/per-directory-history/per-directory-history.zsh


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
