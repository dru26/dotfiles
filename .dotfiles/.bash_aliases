# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -F'
alias lr='ls -t -1'

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
alias rm='mv --force -t ~/Trash'

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
alias reboot='sudo reboot -r now'
alias shutdown='sudo shutdown -r now'

# neovim is supreme
alias editor='neovim'
alias vi='editor'
alias vim='editor'
alias edit='editor'

# ip tables
alias ipt='sudo /sbin/iptables'

# update system
alias update='sudo aura -Syu; sudo aura -Ayu'
