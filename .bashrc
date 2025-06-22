# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /etc/profile
date
echo -n "Battery: "
cat /sys/class/power_supply/BAT0/capacity
echo -n "Status: "
cat /sys/class/power_supply/BAT0/status

alias lfs='doas /usr/sbin/chroot /mnt/lfs /usr/bin/env -i HOME=/root TERM="$TERM" PS1="\u:\w\\\\$ "
PATH=/usr/bin:/usr/sbin /bin/bash --login'

alias grub-update='doas grub-mkconfig -o /boot/grub/grub.cfg'
alias todo='vim ~/to-do.txt'
alias vi='vim'
alias atofetch='./git-repos/ato-fetch/ato-fetch.sh'
alias ls='ls -a --color=auto'
alias l='ls -la --color=auto'
alias ..='cd ..'
alias grep='grep --color=auto'
alias cl="clear"
alias gensync='doas emaint -a sync'
alias update='doas emerge -avuDN @world'
PS1='\u@\h:\W# '
export PATH=$HOME/.local/bin:$PATH
export LFS=/mnt/lfs
#PS1="\u@\h \w \$ "
alias sudo='doas'
source "$HOME/.cargo/env"
