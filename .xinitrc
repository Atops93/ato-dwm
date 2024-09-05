#!/bin/sh
~/.screenlayout/main.sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#xrandr --output eDP-1 --mode 1366x768 --left-of HDMI-1 --output HDMI-1 --primary --mode 1920x1080 &
xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 1920x1080 &
feh ~/ato-dwm/clean-mountain.png --bg-scale --no-fehbg &
~/ato-dwm/sbar &
picom &
# exec icewm
exec dwm
