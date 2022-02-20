#!/bin/sh
dunst &						 # Notifications daemon
nitrogen --restore &                             # Wallpaper
numlockx &                                       # Enable numlock
firewall-applet &                                # GNU/Linux Firewalld applet
nm-applet &                                      # For GNU/Linux NetworkManager
freenet start &                                  # Start Freenet
seapplet &                                       # SELinux alerts applet, if present
pasystray -N sink_default -N source_default &    # Sound applet with notifications when something is changed 
dbus-launch keepassxc &                          # Password manager
dbus-launch matrixclient --hidden &                       # Matrix client (chat platform)

# Set the date in the status bar
while true ;do
    xsetroot -name "$(date +%H:%M:%S\ %d/%m/%Y)" &
    sleep 0.5
done &

# If it's december, january or february, run xsnow

case "$(date +%m)" in
    12|1|01|2|02)
	xsnow -nomenu &	
	;;
esac
