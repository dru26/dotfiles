# some more ls aliases
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls -F --color=auto'
alias lr='ls -t -1 --color=auto'

# update the dotfiles
alias dofiles-update=''
alias dofile-update='dofiles-update'
alias dofiles-update='dofiles-update'
alias dofile-='dofiles-update'

# browser
alias broswer="thorium-browser"

# diff
alias df="df -h"

# cmd lookup
alias find='history | grep'

# trash
rm() {
	cp -fr -t ~/Trash $1
	rm -fr $1
}
trash() {
	rm -fr ~/Trash
	mkdir ~/Trash
}

# clear
alias c='clear'

# navigation
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'

# colorize grep
alias grep='grep --color=auto'

# start calc with math support
alias bc='bc -l'

# create parent directories by default
alias mkdir='mkdir -pv'

# some helpful commands
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias ports='netstat -tulanp'
alias root='sudo -i'
alias keys='xmodmap -pke'

# power commands
alias reboot='sudo reboot now'
alias shutdown='sudo shutdown now'

# neovim is supreme
alias editor='neovim'
alias vi='editor'
alias vim='editor'
alias edit='editor'

# ip tables
alias ipt='sudo /sbin/iptables'

# update system
alias update='sudo aura -Syu; sudo aura -Ayu'
