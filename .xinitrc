#!/bin/sh
xrandr --output eDP-1 --off --output HDMI-1 --auto --primary &
sleep 3
xrandr --output HDMI-1 --mode 1920x1080 --rate 120 &
picom &
xset s off
xset -dpms
xset s noblank
xset r rate 250 50
#/usr/bin/pipewire &
#/usr/bin/pipewire-pulse &
#/usr/bin/wireplumber &
#feh --bg-fill ~/git-repos/ato-dwm/wallpapers/wallpaper.png &

#feh --bg-fill ~/git-repos/ato-dwm/wallpapers/wallhaven-6k229q_1920x1080.png &


exec dbus-launch --sh-syntax --exit-with-session starttde

#exec dbus-launch --sh-syntax --exit-with-session dwm

#exec dbus-launch --sh-syntax --exit-with-session sxwm

#exec dbus-launch --sh-syntax --exit-with-session ~/sowm/sowm

#exec dbus-launch --sh-syntax --exit-with-session ~/Downloads/aphelia/aphelia
