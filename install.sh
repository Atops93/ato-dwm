sudo pacman -S xorg-server xorg-xinit libx11 libxft libxinerama xclip feh flameshot rofi brightnessctl picom
cd dwm
sudo make clean install
cd ..
echo "Do you want to replace your current .xinitrc if you created it, with mine? (y/n)"
if [[y]] ; then
	sudo cp .xinitrc /home/$USER
continue

echo "Moving my picom.conf file to /etc/xdg replacing a configured picom? (y/n)"
if [[y]] ; then
	sudo pacman -S picom && sudo cp picom.conf /etc/xdg/
echo "All good to go, run startx & it should run"
