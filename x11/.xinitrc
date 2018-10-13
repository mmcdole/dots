# Load Xresources config
xrdb -merge ~/.Xresources

# Start dbus
dbus-update-activation-environment --systemd --all
#
#systemctl --user import-environment DISPLAY XAUTHORITY
#dbus-update-activation-environment --systemd \
#  DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Launch i3
exec i3
