##### DEBUG ######
# Does this shit even work man
# export XKB_LOG_LEVEL=2
# export XKB_LOG_FILE=$HOME/xkb.log

###### SSH ######
  # Setup SSH Agent (No systemd :[) # TODO move this to systemd?
  SSH_ENV="$HOME/.ssh/agent-environment"

  function start_agent {
      echo "Initialising new SSH agent..."
      /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
      echo succeeded
      chmod 600 "${SSH_ENV}"
      . "${SSH_ENV}" > /dev/null
      # Example: add other keys
      # /usr/bin/ssh-add ~/.ssh/other-keys/me-rivos-2;
  }

  # Source SSH settings, if applicable
  if [ -f "${SSH_ENV}" ]; then
      . "${SSH_ENV}" > /dev/null
      #ps ${SSH_AGENT_PID} doesn't work under cywgin
      ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
          start_agent;
      }
  else
      start_agent;
  fi

###### Keyboard/Interface Settings ######
  # TODO should this be in .zprofile?
  # Map Shift+Space to '_' on graphical environments
  # xmodmap -e 'keycode 65 = space underscore' # Requires x11-xserver-utils
  # Map Shift+Space to '_' in the console
  # TODO # Requires console-data

  # Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='vim'
  fi


####### PATH changes ######
  # Add things to PATH that are too heavy to add in .zshenv
  # E.g. ones where I need to do conditional logic or launch subprocesses
  # Mostly this is just the ones which may or may not exist on different systems
  # and tend not to change much after that point, like .local/bin

  # set PATH so it includes user-bins if they exist
  if [ -d "$HOME/bin" ] ; then
      PATH="$HOME/bin:$PATH"
  fi
  if [ -d "$HOME/.local/bin" ] ; then
      PATH="$HOME/.local/bin:$PATH"
  fi

  # Language-specific binary install paths
  if [ -d "/usr/local/go/bin" ] ; then
    PATH=$PATH:"/usr/local/go/bin"     # Go
  fi
  if [ -d $HOME/.ghcup ] ; then
    . "$HOME/.ghcup/env"          # Haskell (Cabal, via ghcup)
  fi
  if [ -d "$HOME/.cargo" ] ; then
    export CARGO_HOME="$HOME/.cargo"   # Rust
    . "$HOME/.cargo/env"          # Rust
  fi
  if [ -d "$HOME/Library/Python/3.9/bin" ] ; then
    PATH=$PATH:"$HOME/Library/Python/3.9/bin" # macOS issue: pip installed binaries aren't on the path by default for whartever reason
  fi

  export PATH
