#!/bin/bash

# Colors for output
red="\e[31m"
green="\e[32m"
reset="\e[0m"

# Function to run commands as root
#asRoot() {
#	if [ "$EUID" -ne 0 ]; then
#		sudo "$@"
#	else
#		"$@"
#	fi
#}

installYay() {
	if ! command -v yay &> /dev/null; then
		echo -e "${red}yay not installed!${reset} Installing now."
		#asRoot pacman -S --needed git
		sudo pacman -S --noconfirm --needed git base-devel
		git clone https://aur.archlinux.org/yay.git || { echo -e "${red}Failed to clone yay repository.${reset}"; exit 1; }
		cd yay || { echo -e "${red}Failed to cd into the yay directory.${reset}"; exit 1; }
		makepkg -si --noconfirm --needed
		echo -e "${green}yay installed!${reset}"
	else
		echo -e "${green}yay is already installed.${reset}"
	fi
}

installPackages() {
	yay -S --noconfirm ttf-jetbrains-mono-nerd xorg-server xorg-xinit xorg-xsetroot \
	libx11 libxft libxinerama xclip feh flameshot rofi brightnessctl picom alacritty xrandr \
	make cmake
}

installDwm() {
	cd dwm || { echo -e "${red}Failed to cd into the dwm directory.${reset}"; exit 1; }
	sudo make clean install
}

moveConfigFiles() {
	cd ~/src/ato-dwm/.config || { echo -e "${red}Failed to cd into the .config directory.${reset}"; exit 1; }
	mv rofi ~/.config
}

replaceXinitrc() {
	while true; do
		read -rp "Do you want to replace your current .xinitrc with mine, unless this is a clean install? (y/n): " replace
		case $replace in
			y|Y) 
				cp .xinitrc ~/
				echo "Done"
				break
				;;
			n|N) 
				echo "Skipping .xinitrc replacement."
				break
				;;
			*) 
				echo "Invalid input, please enter 'y' or 'n'."
				;;
		esac
	done
}

replacePicomConfig() {
	while true; do
		read -rp "Move/add picom.conf to /etc/xdg? Press 'y' if this is a fresh install. (y/n): " picominstall
		case $picominstall in
			y|Y)
				sudo cp picom.conf /etc/xdg/
				echo "picom.conf replaced or added."
				break
				;;
			n|N)
				echo "Skipping picom.conf change. (aka default)"
				break
				;;
			*)
				echo "Invalid input, please enter 'y' or 'n'."
				;;
		esac
	done
}

reduce-screen-tear-on-xorg-massivly() {
        while true; do
                read -rp "Move 20-intel.conf aka no screen tearing file to /etc/X11/xorg.conf.d/? (y/n): " reducescreentear
                case $reducescreentear in
                        y|Y)
                                sudo cp 20-intel.conf /etc/X11/xorg.conf.d/
                                echo "Added reduced screentearing aka vsync to /etc/X11/xorg.conf.d/"
                                break
                                ;;
                        n|N)
                                echo "Skippinging 20-intel.conf & making life harder to read due to tearing."
                                break
                                ;;
                        *)
                                echo "Invalid input, please enter 'y' or 'n'."
                                ;;
                esac
        done
}

touchpad-for-laptops() {
        while true; do
                read -rp "Move 30-touchpad.conf to /etc/X11/xorg.conf.d/ aka enable touchpad for laptops? (y/n): " laptoptouchpad
                case $laptoptouchpad in
                        y|Y)
                                sudo cp 20-intel.conf /etc/X11/xorg.conf.d/
                                echo "Added 30-touchpad.conf to /etc/X11/xorg.conf.d/"
                                break
                                ;;
                        n|N)
                                echo "Skipping 30-touchpad.conf, I hope you are using a desktop or vm"
                                break
                                ;;
                        *)
                                echo "Invalid input, please enter 'y' or 'n'."
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
	echo "If you pressed 'y' to replace/add my .xinitrc config, it should work out of the box."
}

main
