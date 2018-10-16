if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

# Parse Options
while getopts ":a:p:h" o; do
  case "${o}" in
    h) echo -e -e "Optional arguments for custom use:\\n  -p: Dependencies and programs csv (local file or url)\\n  -a: A helper (must have pacman-like syntax)\\n  -h: Show this message" && exit ;;
    p) progs_file=${OPTARG} ;;
    a) aur_helper=${OPTARG} ;;
    *) echo -e "-$OPTARG is not a valid option." && exit ;;
  esac
done

# Defaults
[ -z ${progs_file+x} ] && progs_file="https://raw.githubusercontent.com/mmcdole/dots/master/progs.csv"
[ -z ${aur_helper+x} ] && aur_helper="yay"

# Functions
refresh_keys() {
  echo -e "Refreshing Arch keyring..."
  pacman --noconfirm -Sy archlinux-keyring &>/dev/null
}

main_install() { 
  echo -en "  [ ] [P] $1 ...\t"
  if pacman --noconfirm --needed -S "$1" &>/dev/null ; then
    echo -e "\r  [X]"
  else
    echo -e "\r  [\033[0;31mF\033[0m]"
  fi
}

aur_install() {
 echo -en "  [ ] [A] $1 ...\t"
 if grep "^$1$" <<< "$aur_installed" &>/dev/null || sudo -u $SUDO_USER $aur_helper -S --noconfirm "$1" &>/dev/null ; then
   echo -e "\r  [X]"
 else  
   echo -e "\r  [\033[0;31mF\033[0m]"
 fi
}

gitmake_install() {
  dir=$(mktemp -d)
  echo -en "  [ ] [G] $1 ...\t"
  git clone --depth 1 "$1" "$dir" &>/dev/null
  cd "$dir" || exit
  make &>/dev/null
  if make install &>/dev/null ; then 
    echo -e "\r  [X]"
  else
    echo -e "\r  [\033[0;31mF\033[0m]"
  fi
  cd /tmp ;
}

manual_install() { 
  [[ -f /usr/bin/$1 ]] || (
  echo -e "Manually installing \"$1\", an AUR helper..."
  cd /tmp
  rm -rf /tmp/"$1"*
  curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/"$1".tar.gz &&
  sudo -u $SUDO_USER tar -xvf "$1".tar.gz &>/dev/null &&
  cd "$1" &&
  sudo -u $SUDO_USER makepkg --noconfirm -si &>/dev/null
  cd /tmp) ;
}

installation_loop() {
  ([ -f "$progs_file" ] && cp "$progs_file" /tmp/progs.csv) || curl -Ls "$progs_file" > /tmp/progs.csv
  total=$(wc -l < /tmp/progs.csv)
  aur_installed=$(pacman -Qm | awk '{print $1}')
  echo -e "Installing programs..."
  while IFS=, read -r tag program comment; do
    n=$((n+1))
    case "$tag" in
      "P") main_install "$program" "$comment" ;;
      "A") aur_install "$program" "$comment" ;;
      "G") gitmake_install "$program" "$comment" ;;
    esac
  done < /tmp/progs.csv ;
}

refresh_keys

manual_install $aur_helper

installation_loop
