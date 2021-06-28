xrdb -override ~/.Xresources
xset -dpms s off
xrandr --dpi 96
dbus-launch pipewire &
dbus-launch pipewire-media-session &
dbus-launch pipewire-pulse &
dbus-launch xmonad
#dbus-launch starttde
#startplasma-x11
