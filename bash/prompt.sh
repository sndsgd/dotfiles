
prompt_git_branch() {
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then
        # Get the short symbolic ref.
        # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
        local BRANCH="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
            git rev-parse --short HEAD 2> /dev/null)"

        echo -e "$BRANCH "
    fi
}

PS1=""

[ -n "$SSH_CLIENT" ] && PS1+="\[\e[1;7m\] ssh \[\e[0m\]"

# hostname
[ "$OS_NAME" == "Darwin" ] && PS1+="\[\e[1;30;46m\] " || PS1+="\[\e[1;30;42m\] "
PS1+="\h \[\e[0m\] "

# working directory and newline
PS1+="\[\e[2m\]\w\n\[\e[0m\]"

# git branch
PS1+="\[\e[92m\]\$(prompt_git_branch)\[\e[0m\]"

# prompt
PS1+="\\$ "
export PS1

# PS2
PS2="\[\e[0m\]↳ "
export PS2

# update the osx terminal tab title to the current directory
# @see http://akrabat.com/setting-os-xs-terminal-tab-to-the-current-directory
if [ "$OS_NAME" == "Darwin" ]; then
    function set_tab_title() {
        echo -n -e "\033]0;${PWD##*/}\007"
    }
    PROMPT_COMMAND="set_tab_title ; $PROMPT_COMMAND"
fi
