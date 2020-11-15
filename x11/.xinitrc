# Load Xresources config
xrdb -merge ~/.Xresources

# Load custom keyboard mappings
xmomap .xmodmap

# Set key repeat delay to 125ms and rate to 25
xset r rate 200 25


systemctl --user import-environment DISPLAY XAUTHORITY

# Start dbus
dbus-update-activation-environment --systemd \
  DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Setup default terminal
export TERMINAL="xst"

# Launch i3
exec i3
