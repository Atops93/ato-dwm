#!/bin/sh
xrandr --output HDMI-1 --mode 1920x1080 --rate 120 &
picom &
#xrandr --output eDP-1 --off --output HDMI-1 --auto --primary &
xset s off
xset -dpms
xset s noblank
xset r rate 250 50
pipewire &
pipewire-pulse &
wireplumber &
feh --bg-fill ~/git-repos/ato-dwm/wallpapers/wallpaper.png &
exec dbus-launch --sh-syntax --exit-with-session dwm
