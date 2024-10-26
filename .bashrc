# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias sudonvim='sudo XDG_CONFIG_HOME=/home/atops/.config nvim'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias todo='vim ~/to-do.txt'
alias vi='vim'
alias atofetch='./github-projects/ato-fetch/ato-fetch.sh'
alias ls='ls -a --color=auto'
alias l='ls -la --color=auto'
alias ..='cd ..'
alias grep='grep --color=auto'
PS1='\u@\h:\W# '
#PS1="\u@\h \w \$ "
