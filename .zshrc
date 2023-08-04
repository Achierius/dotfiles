setopt histignorealldups sharehistory extendedglob

# To profile: load
#   zmodload zsh/zprof
# and then at the end of .zshrc
#   zprof

# Path modifications
export ZSH="$HOME/.oh-my-zsh"
PATH="$PATH:/rivos/llvm/bin/"
export RUSTUP_HOME=/rivos/rustup
export CARGO_HOME=/rivos/cargo
source "$CARGO_HOME/env"

# https://zsh.sourceforge.io/Doc/Release/Parameters.html
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E\nmax rss\t%MKB'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="Soliah" #"robbyrussell"
# debug slowdowns: https://unix.stackexchange.com/questions/397135/change-of-directory-is-very-slow
# PS4='+[%D{%T.%.}] %N:%i> ' zsh -x

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Prepare env-vars for the (fzf) zsh plugin
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
export FZF_BASE=/usr/bin/fzf
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_COMPLETION_TRIGGER=';;' # vs. default **

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# https://github.com/unixorn/awesome-zsh-plugins#plugins
plugins=( git fzf shellfirm z zsh-syntax-highlighting zsh-autosuggestions )
# Enabled:
#   - git: obvious
#   - fzf: completion
#   - shellfirm: warn when I try to do dumb things
#   - z: jump around magically, https://github.com/agkozak/zsh-z
#   - zsh-syntax-highlighting: it just looks nice
#   - zsh-autosuggestions: autosuggestions based on history; !Still need to configure!
# Disabled:
#   - zsh-vi-mode: couldn't get the hang of it, was slowing down startup

# required for compat b/w zsh-vi-mode and fzf: https://github.com/jeffreytse/zsh-vi-mode/issues/24
export ZVM_INIT_MODE=sourcing

# Don't "load only from secure directories", just load from everywhere
# Reduces startup time by like half, esp. since we avoid trawling NFS
export ZSH_DISABLE_COMPFIX=1

# Don't autoupdate: make sure to run omz update
# Also for performance reasons
export DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh

# Sourcing the following (key-bindings, completion) was recc'd by: "apt-cache-show fzf"
source /usr/share/doc/fzf/examples/key-bindings.zsh 
source /usr/share/doc/fzf/examples/completion.zsh

####### User configuration #######

# Disable global history sharing
unsetopt share_history

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8 
export LANG="$LC_ALL"
#export LC_CTYPE=en_US.UTF-8
#export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

####### Compilation flags #######
# export ARCHFLAGS="-arch x86_64"

####### Personal additions from here on out #######

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

# Map Shift+Space to '_' on graphical environments
#xmodmap -e 'keycode 65 = space underscore' # Requires x11-xserver-utils
# Map Shift+Space to '_' in the console
# TODO # Requires console-data

# Keybinds for zsh-autosuggestions
#bindkey '^ ' autosuggest-accept # Binds to ctrl-space
bindkey '^[[Z' autosuggest-accept # Binds to shift-tab

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ohmyzsh="mate ~/.oh-my-zsh"
alias tmux="tmux -u"
alias git-watch="watch -c -t -n3 git --no-optional-locks -c color.status=always status"
alias git-logwatch="watch -c -t -n5 git --no-optional-locks -c color.ui=always log --decorate --oneline"
alias -g up='popd'
alias gmake="make"

# LS aliases
# Maybe change colors someday https://the.exa.website/docs/colour-themes
alias l='exa --icons'
alias la='exa --icons -a'
alias lx='exa --icons -x'
alias lax='exa --icons -a -x'

# Git aliases from https://hackernoon.com/lesser-known-git-commands-151a1918a60
git config --global alias.please 'push --force-with-lease'
git config --global alias.tackon 'commit --amend --no-edit' # was "commend"
git config --global alias.stsh 'stash --keep-index'
git config --global alias.staash 'stash --include-untracked'
git config --global alias.staaash 'stash --all'
git config --global alias.qstat 'status --short --branch' # was "shorty"/"st"
git config --global alias.grog 'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
git config --global alias.count-lines "! git log --author=\"\$1\" --pretty=tformat: --numstat | awk '{ add += \$1; subs += \$2; loc += \$1 - \$2 } END { printf \"added lines: %s, removed lines: %s, total lines: %s\n\", add, subs, loc }' #"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/bin/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/bin/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/bin/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/bin/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
