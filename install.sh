sudo pacman -S libx11 libxft libxinerama
cd dwm
sudo make clean install
cd ..
echo "Do you want to replace the current .xinitrc if located with mine? (y/n)"
if [[y]] ; then
	sudo cp .xinitrc /home/$USER
continue

echo "Moving my picom.conf file to /etc/xdg replacing a configured picom? (y/n)"
if [[y]] ; then
	sudo pacman -S picom && sudo cp picom.conf /etc/xdg/
echo "All good to go, run startx & it should run"
