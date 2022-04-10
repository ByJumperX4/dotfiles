#!/bin/sh
dunst &						 # Notifications daemon
nitrogen --restore &                             # Wallpaper
numlockx &                                       # Enable numlock
seapplet &                                       # SELinux alerts applet, if present
pasystray -N sink_default -N source_default &    # Sound applet with notifications when something is changed 
dbus-launch keepassxc &                          # Password manager
dbus-launch matrixclient &                       # My favourite matrix client (IM protocol)
xmullvad &                                       # Mullvad VPN GUI app

# Set the date in the status bar
watch -n1 'xsetroot -name "$(date +%H:%M:%S\ %d/%m/%Y)"' &>/dev/null &

# If it's december, january or february, run xsnow

case "$(date +%m)" in
    12|1|01|2|02)
	xsnow -nomenu &	
	;;
esac
