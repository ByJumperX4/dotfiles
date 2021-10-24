#!/bin/sh
dunst &						 # Notifications daemon
nitrogen --restore &                             # Wallpaper
numlockx &                                       # Enable numlock
firewall-applet &                                # GNU/Linux Firewalld applet
nm-applet &                                      # For GNU/Linux NetworkManager
seapplet &                                       # SELinux alerts applet, if present
pasystray -N sink_default -N source_default &    # Sound applet with notifications when something is changed 
keepassxc &                                      # Password manager
matrixclient &                                   # Matrix client (chat platform)

# Set the date in the status bar
while true
do
    xsetroot -name "$(date +%H:%M:%S\ %d/%m/%Y)" &
    sleep 0.5
done
