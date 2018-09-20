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

# fzf completion / keybinding
source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh

# custom path
export PATH="$HOME/bin:$PATH"

# antibody
source <(antibody init)
antibody bundle < ~/.zsh_plugins

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
