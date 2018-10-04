#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR

# aliases
#alias vksay='ssh -t flix "tail -n0 -f /home/drakenot/viking/tells.log" | espeak > /dev/null 2>&1'
alias vksay='ssh -t flix "tail -n0 -f /home/drakenot/viking/tells.log" | while read OUTPUT; do notify-send "VikingMUD" "$OUTPUT"; done'

# fzf completion / keybinding
source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh

# custom path
export PATH="$HOME/bin:$PATH"

export GOPATH="$HOME/go"

# antibody
source <(antibody init)
antibody bundle < ~/.zsh_plugins

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
