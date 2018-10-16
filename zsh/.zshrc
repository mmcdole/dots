#
#  ███████╗███████╗██╗  ██╗██████╗  ██████╗
#  ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#    ███╔╝ ███████╗███████║██████╔╝██║
#   ███╔╝  ╚════██║██╔══██║██╔══██╗██║
#  ███████╗███████║██║  ██║██║  ██║╚██████╗
#  ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#


# Source Prezto.
if [[ -f "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Set vi mode
bindkey -v

# Setup FZF keybindings
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi

# Some aliases
alias sdn="sudo shutdown now"
alias p="sudo pacman"
alias SS="sudo systemctl"
alias v="vim"
alias sv="sudo vim"
alias r="ranger"
alias sr="sudo ranger"
alias ka="killall"
alias g="git"
alias mkd="mkdir -pv"


# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"

# Internet
alias yt="youtube-dl --add-metadata -ic" # Download video link
alias yta="yt -x -f bestaudio/best" # Download only audio

# Mud
alias vk="mosh flix tmux a"
alias vksay='ssh -t flix "tail -n0 -f /home/drakenot/viking/tells.log" | while read OUTPUT; do notify-send "VikingMUD" "$OUTPUT"; echo "$OUTPUT"; done'

# Flix
alias mflix="sshfs flix:/mnt/data /mnt/data -o reconnect -o dir_cache=yes -o compression=no
"
alias uflix="updatedb -l 0 -o ~/.flix.db -U /mnt/data/media"
