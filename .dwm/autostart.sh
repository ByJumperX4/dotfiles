#!/bin/sh
xrandr --dpi 96 &
xset s off &
xset -dpms &
while true; do xsetroot -name "$(date "+%H:%M:%S - %d/%m/%Y" && sleep 1)"; done &
albert & 
nitrogen --restore & 
pasystray &
dhcpcd-gtk &
element-desktop
