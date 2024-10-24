#!/bin/sh
~/.screenlayout/main.sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#xrandr --output eDP-1 --mode 1366x768 --left-of HDMI-1 --output HDMI-1 --primary --mode 1920x1080 &

#xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 1920x1080 &
feh ~/src/ato-dwm/clean-mountain.png --bg-scale --no-fehbg &
~/src/ato-dwm/sbar &
picom &
xset r rate 200 30 &
# exec icewm
exec dwm
