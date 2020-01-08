#
#  ███████╗███████╗██╗  ██╗███████╗███╗   ██╗██╗   ██╗
#  ╚══███╔╝██╔════╝██║  ██║██╔════╝████╗  ██║██║   ██║
#    ███╔╝ ███████╗███████║█████╗  ██╔██╗ ██║██║   ██║
#   ███╔╝  ╚════██║██╔══██║██╔══╝  ██║╚██╗██║╚██╗ ██╔╝
#  ███████╗███████║██║  ██║███████╗██║ ╚████║ ╚████╔╝
#  ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝  ╚═══╝
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Read any secret env variables
source "${ZDOTDIR:-$HOME}/.zsecrets"

export PATH="$HOME/bin:$HOME/.cargo/bin:$PATH"
export EDITOR="vim"
export VISUAL="$EDITOR"
export TERMINAL="xst"
export READER="zathura"
export BROWSER="linkhandler"
export TRUEBROWSER="google-chrome-stable"

export GOPATH="$HOME/go"
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git --ignore .cache -l -g ""'
