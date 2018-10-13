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

export PATH="$HOME/bin:$PATH"
export EDITOR=vim;
export GOPATH="$HOME/go"
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git -l -g ""'
