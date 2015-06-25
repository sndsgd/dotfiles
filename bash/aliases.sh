
# enable sudo in aliases
alias sudo='sudo '

# ssh agent
alias ssh-add='eval $(ssh-agent) && ssh-add'


if [ "$OS_NAME" = "Linux" ]; then
   COLOR_FLAG="--color=auto"

   # cd shortcuts
   [ -d "$HOME/git" ] && alias g="cd $HOME/git"

   # get the top 10 memory/cpu users
   alias mem10='ps auxf | sort -nr -k 4 | head -10'
   alias cpu10='ps auxf | sort -nr -k 4 | head -10'

   # daemon shortcuts
   alias d.nx='sudo service nginx'
   alias d.memc='sudo /etc/init.d/memcached'
   alias log.auth="cat /var/log/auth.log | grep -v 'pam_unix(cron:session)'"
elif [ "$OS_NAME" = "Darwin" ]; then
   COLOR_FLAG="-G"

   # cd shortcuts
   [ -d "$HOME/Documents/git" ] && alias g="cd $HOME/Documents/git"
   alias dl="cd ~/Downloads"

   alias showhf="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
   alias hidehf="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

   # audio volume
   alias mute="osascript -e 'set volume 0'"
   alias loud="osascript -e 'set volume 10'"

   # ip address info
   alias localip="ipconfig getifaddr en1"
   alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

   # kickstart
   # use 'kickstart -activate' to activate
   # use 'kickstart -deactivate' to deactivate
   alias kickstart='/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart'

   alias lockdown='open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app'
fi


# more cd shortcuts
alias h="cd ~"
alias t="cd /tmp"
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../../"
alias .5="cd ../../../../.."


# git 
if [ -e /usr/bin/git ]; then
   alias gst="git status"
   alias gci="git commit"
   alias gca="git commit --amend"
   alias gcm="git commit -m"
   alias gco="git checkout"
   alias glg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
   alias gbr="git branch"
   alias gr="git remote"
   alias gdf="git diff"
   alias ga="git add"
   alias gul="git pull"
   alias gph="git push"
fi

# closure compiler
if [ -f /usr/local/lib/google/closure/compiler.jar ]; then
   alias jscomp='java -jar /usr/local/lib/google/closure/compiler.jar'
fi


# clear the screen and buffer
alias cls='tput reset'

# list all set bash variables
alias setvars="( set -o posix ; set ) | less"

# globbing updates
alias eglob='shopt -s extglob'
alias egloboff='shopt -u extglob'
alias dglob='shopt -s dotglob'
alias dgloboff='shopt -u dotglob'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls
alias ls='ls '$COLOR_FLAG
alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -lA'
alias lah='ls -lAh'

# count files/directories/links
alias fcount='ls -l | grep "^-" | wc -l'
alias dcount='ls -l | grep "^d" | wc -l'
alias lcount='ls -l | grep "^l" | wc -l'

# list only files/directories/links
alias lsf="ls -l ${COLOR_FLAG} | grep ^-"
alias lsd="ls -l ${COLOR_FLAG} | grep ^d"
alias lsl="ls -l ${COLOR_FLAG} | grep ^l"

alias mkdir='mkdir -pv'

# ip addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

