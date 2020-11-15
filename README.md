### config items ###

| dir  | description |
| ------------- | ------------- |
| bin | system automation scripts  |
| dunst | notification daemon|
| git | global git config and aliases  |
| i3 | i3 tiling window manager  |
| ncspot | cli spotify client | 
| newsboat | rss reader|
| picom | minimal composite manager  |
| polybar | system bar  |
| ranger | file browser|
| rofi | launcher  |
| vim | best text editor  |
| wallpaper | sick wallpapers  |
| x11 | x windows config|
| zsh | zshell settings and config  |

### install ###

the `dots` repo is cloned to `$HOME` and each item is installed using [gnu stow](http://www.gnu.org/software/stow/).  

```bash
cd ~/dotfiles
stow bin
stow picom
stow git
stow i3
...
```

each directory that has been stowed has its contents linked to the `$HOME` directory while still being centrally located in my `$HOME/dotfiles` git repo.
