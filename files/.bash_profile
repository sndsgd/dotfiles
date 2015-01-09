# ~/.bash_profile: executed by bash for login shells.
# LOADS ALL OTHER BASH COMPONENTS!


# if it exists, add the user's private bin directory to the PATH
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# host OS (Darwin, Linux)
OS_NAME=$(uname)

# include additional files
for file in ~/.bash_{path,prompt,exports,aliases,functions,editor,extra}; do
   [ -r "$file" ] && source "$file"
done
unset file

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
   source /etc/bash_completion
fi

# stash the login timestamp & ip address
if [ -n "$SSH_CLIENT" ]; then
   echo $(date)" -- ${SSH_CLIENT%% *}" >> ~/.login_history
else
   date >> ~/.login_history
fi

