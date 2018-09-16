# Load Xresources config
xrdb -merge ~/.Xresources

# Create hybrid capslock key
xmodmap ~/.Xmodmap
xcape -e "Hyper_L=Escape"

systemctl --user import-environment DISPLAY XAUTHORITY

dbus-update-activation-environment --systemd \
  DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Launch i3
exec i3 
