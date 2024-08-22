#!/bin/sh
~/.screenlayout/main.sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

feh ~/ato-dwm/clean-mountain.png --bg-scale --no-fehbg &
~/ato-dwm/dwmbar/bar.sh &
picom &
exec dwm
