#!/bin/sh
dunst &						 # Notifications daemon
nitrogen --restore &                             # Wallpaper
numlockx &                                       # Enable numlock
firewall-applet &                                # GNU/Linux Firewalld applet
nm-applet &                                      # For GNU/Linux NetworkManager
freenet start &                                  # Start Freenet
seapplet &                                       # SELinux alerts applet, if present
pasystray -N sink_default -N source_default &    # Sound applet with notifications when something is changed 
keepassxc &                                      # Password manager
matrixclient &                                   # Matrix client (chat platform)

# Set the date in the status bar
while true ;do
    xsetroot -name "$(date +%H:%M:%S\ %d/%m/%Y)" &
    sleep 0.5
done &

# If it's december, january or february, run xsnow

case "$(date +%m)" in
    12|1|01|2|02)
	#xsnow -nomenu &
	echo xsnow disable
	
	;;
esac

xrandr --output DVI-D-1 --mode 1920x1080 --pos 0x0 --rotate left --output DP-1 --primary --mode 2560x1440 --pos 1080x240 --rotate normal --output DP-2 --mode 1360x768 --pos 3640x912 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1400x1680 --rotate normal --output DP-3 --off
