### config items ###

```
bin               -> system automation scripts  
dunst           -> notification daemon
compton     -> minimal composite manager  
git                -> global git config and aliases  
i3                  -> i3 tiling window manager  
polybar        -> system bar  
rofi                -> launcher  
vim               -> best text editor  
wallpaper    -> sick wallpapers  
x11               -> x windows config  
zsh                -> zshell settings and config  
```

### install ###

the `dots` repo is cloned to `$HOME` and each item is installed using [gnu stow](http://www.gnu.org/software/stow/).  

```bash
cd ~/dotfiles
stow bin
stow compton
stow git
stow i3
...
```

each directory that has been stowed has its contents linked to the `$HOME` directory while still being centrally located in my `$HOME/dotfiles` git repo.
