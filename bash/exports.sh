
# Prefer US English and use UTF-8
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# allow for more items in the history
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# ignore duplicates and commands that start with a space
export HISTCONTROL=ignoreboth

# commands to keep out of the history
export HISTIGNORE="cls:ls:cd:cd -:pwd:exit:date:* --help"

