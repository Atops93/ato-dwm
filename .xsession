#!/bin/sh
#xrandr --output eDP-1 --off --output HDMI-1 --auto --primary &
#sleep 3
#xrandr --output HDMI-1 --mode 1920x1080 --rate 120 &
#xrandr --output HDMI-1 --mode  1280x720 --rate 60 &
#xsetroot -mod 16 16 -bg '#1c1c1c' -fg '#a8a8a8' &
picom --opacity-rule "90:class_g = 'XTerm'" &
xset s off
xset -dpms
xset s noblank
xset r rate 250 50
xset b off
#/usr/bin/pipewire &
#/usr/bin/pipewire-pulse &
#/usr/bin/wireplumber &
#feh --bg-fill ~/git-repos/dotfiles/wallpapers/wallpaper.png &

#polybar &

#feh --bg-fill ~/git-repos/dotfiles/wallpapers/wallhaven-6k229q_1920x1080.png &
feh --bg-fill /home/atops/git-repos/dotfiles/wallpapers/openbsd-wall1.png

#exec dbus-launch --sh-syntax --exit-with-session starttde

#exec dbus-launch --sh-syntax --exit-with-session dwm
exec dwm

#exec dbus-launch --sh-syntax --exit-with-session sxwm

#exec dbus-launch --sh-syntax --exit-with-session ~/git-repos/sowm/sowm

#exec dbus-launch --sh-syntax --exit-with-session ~/Downloads/aphelia/aphelia
