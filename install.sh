sudo pacman -S xorg-server xorg-xinit libx11 libxft libxinerama xclip feh flameshot rofi brightnessctl picom alacritty
cd dwm; sudo make clean install
cd ~/ato-dwm; mv alacritty rofi ~/.config
until [ "$replace" = "y"] || [ "$replace" = "n" ]; do
echo -n "Do you want to replace your current .xinitrc if you created it, with mine? (y/n)"
read -r replace
done

if [ "$replace" = "y"] ; then
	sudo cp .xinitrc /home/$USER
fi

until [ "$picominstall" = "y" ] || [ "$picominstall" = "n" ]; do
echo -n "Moving my picom.conf file to /etc/xdg replacing a configured picom? (y/n)"
read -r picominstall
done
if [ "$picominstall" = "y" ]; then
	cp picom.conf /etc/xdg/
else
	sudo cp picom.conf /etc/xdg/
fi
echo "All good! Run startx & it should run"
