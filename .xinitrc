#!/bin/sh

feh --bg-fill ~/git-repos/ato-dwm/wallpapers/wallpaper.png &
exec dbus-launch --sh-syntax --exit-with-session dwm
