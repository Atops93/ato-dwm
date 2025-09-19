# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /etc/profile
date
echo -n "Battery: "
cat /sys/class/power_supply/BAT0/capacity
echo -n "Status: "
cat /sys/class/power_supply/BAT0/status

alias lfs="chroot \"\$LFS\" /usr/bin/env -i \
    HOME=/atops \
    TERM=\"\$TERM\" \
    PS1=\"(lfs chroot) \\u@\\h:\\w\\\\\$ \" \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS=\"-j\$(nproc)\" \
    TESTSUITEFLAGS=\"-j\$(nproc)\" \
    /bin/bash --login"

#alias firefox='/sources/firefox/firefox'
#alias doas='sudo'
alias sudo='doas'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias todo='vim /home/$USER/to-do.txt'
#alias vi='vim'
alias atofetch='./git-repos/ato-fetch/ato-fetch.sh'
alias ls='ls -a --color=auto'
alias l='ls -la --color=auto'
alias ..='cd ..'
alias grep='grep --color=auto'
alias cl="clear"
alias gensync='sudo emaint -a sync'
alias update='doas emerge -avuDN --changed-use @world'
alias libvirt='doas rc-service libvirtd start'
PS1='\u@\h:\W# '
export PATH=$HOME/.local/bin:$PATH
export LFS=/mnt/lfs
#PS1="\u@\h \w \$ "
export PATH=$PATH:/home/atops/.spicetify

export XSESSION=openbox



RED="\[\033[0;31m\]"
WHITE="\[\033[0;37m\]"
RESET="\[\033[0m\]"

#PS1="${RED}\u:\[${WHITE}\][\$()-\$]${RESET}# "
