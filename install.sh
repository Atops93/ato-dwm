#!/bin/bash

# Colors for output
red="\e[31m"
green="\e[32m"
reset="\e[0m"

sudo chmod 644 /etc/pacman.d/mirrorlist
sudo chown root:root /etc/pacman.d/mirrorlist

installYay() {
	if ! command -v yay &> /dev/null; then
		echo -e "${red}yay not installed!${reset} Installing now."
		cd; git clone https://aur.archlinux.org/yay.git || { echo -e "${red}Failed to clone yay repo.${reset}"; exit 1; }
		cd ~/yay || { echo -e "${red}Failed to cd into yay dir.${reset}"; exit 1; }
		makepkg -si --noconfirm --needed
		echo -e "${green}yay installed!${reset}"
	else
		echo -e "${green}yay is already installed.${reset}"
	fi
}

installPackages() {
	
	cd; yay -S --noconfirm ttf-jetbrains-mono-nerd xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libx11 libxft libxinerama xclip feh flameshot rofi brightnessctl picom alacritty make cmake
}

installDwm() {
	cd ~/git-repos/ato-dwm/dwm || { echo -e "${red}Failed to cd into dwm directory.${reset}"; exit 1; }
	sudo make clean install
}

moveConfigFiles() {
	cd ~/git-repos/ato-dwm/.config || { echo -e "${red}Failed to cd into .config directory.${reset}"; exit 1; }
	sudo mv rofi ~/.config
}

replaceXinitrc() {
	while true; do
		read -rp "Do you want to replace your current .xinitrc if you have one? (of course do 'y' if this is a fresh install.) (y/n): " replace
		case $replace in
			y|Y) 
				sudo mv ~/git-repos/ato-dwm/.xinitrc ~/
				break
				;;
			n|N) 
				echo "Skipping .xinitrc"
				break
				;;
			*) 
				echo "Invalid input, enter 'y' or 'n'."
				;;
		esac
	done
}

replacePicomConfig() {
	while true; do
		read -rp "Add picom.conf to /etc/xdg? Press 'y' if this is a fresh install. (y/n): " picominstall
		case $picominstall in
			y|Y)
				sudo mv ~/git-repos/ato-dwm/picom.conf /etc/xdg/
				echo "picom.conf was moved into /etc/xdg/"
				break
				;;
			n|N)
				echo "Skipping picom.conf"
				break
				;;
			*)
				echo "Invalid input, enter 'y' or 'n'."
				;;
		esac
	done
}

reduce-screen-tear-on-xorg-massivly() {
        while true; do
                read -rp "Move 20-intel.conf to /etc/X11/xorg.conf.d/ aka enable reduced screen tearing for xorg? (y/n): " reducescreentear
                case $reducescreentear in
                        y|Y)
                                sudo mv ~/git-repos/ato-dwm/20-intel.conf /etc/X11/xorg.conf.d/
                                break
                                ;;
                        n|N)
                                echo "Skippinging 20-intel.conf & making life harder to read due to tearing."
                                break
                                ;;
                        *)
                                echo "Invalid input, enter 'y' or 'n'."
                                ;;
                esac
        done
}

touchpad-for-laptops() {
        while true; do
                read -rp "Move 30-touchpad.conf to /etc/X11/xorg.conf.d/ aka enable touchpad for laptops? (y/n): " laptoptouchpad
                case $laptoptouchpad in
                        y|Y)
                                sudo mv ~/git-repos/ato-dwm/20-intel.conf /etc/X11/xorg.conf.d/
                                echo "Added 30-touchpad.conf to /etc/X11/xorg.conf.d/"
                                break
                                ;;
                        n|N)
                                echo "Skipping 30-touchpad.conf, I hope you are using a desktop or vm"
                                break
                                ;;
                        *)
                                echo "Invalid input, enter 'y' or 'n'."
                                ;;
                esac
        done
}

main() {
	installYay
	installPackages
	installDwm
	moveConfigFiles
	replaceXinitrc
	replacePicomConfig
	reduce-screen-tear-on-xorg-massivly
	touchpad-for-laptops
	echo "All good! Run 'startx' and it should launch dwm depending on your startx config."
	echo "If you pressed 'y' to replace/add my .xinitrc config, should work out of the box."
}

main
