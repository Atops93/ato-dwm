# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /etc/profile
date
alias sudovim='sudo XDG_CONFIG_HOME=/home/atops/.config vim'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias todo='vim ~/to-do.txt'
alias vi='vim'
alias atofetch='./git-repos/ato-fetch/ato-fetch.sh'
alias ls='ls -a --color=auto'
alias l='ls -la --color=auto'
alias ..='cd ..'
alias grep='grep --color=auto'
alias cl="clear"
PS1='\u@\h:\W# '
export PATH=$HOME/.local/bin:$PATH
#PS1="\u@\h \w \$ "
