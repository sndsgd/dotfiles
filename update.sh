#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FORCE_CLOBBER=$([ "$1" == "--force" ] && echo "yes" || echo "no")

# @param string The path to the file to retrieve the md5 sum for
get_file_md5() {
    local OS=$(uname)

    if [ "$OS" == "Darwin" ]; then
        md5 -q $1
        return $?
    fi

    md5sum $1 | awk '{ print $1 }'
    return $?
}

# @param string The source path
# @param string The destination path
verify_overwrite() {
    local SOURCE_PATH=$1
    local DEST_PATH=$2
    local CMD=$([ $(uname) == "Darwin" ] && echo "md5" || echo "md5sum")

    [ $FORCE_CLOBBER == "yes" ] && return 0
    [ ! -f $DEST_PATH ] && return 0
    [ $(get_file_md5 $SOURCE_PATH) == $(get_file_md5 $DEST_PATH) ] && return 0

    read -p "clobber $DEST_PATH? [y/n] " CONFIRM
    [ $CONFIRM == "y" ] && return 0

    return 1
}

# if ~/.bash_profile doesn't exist, create it
if [ ! -f "$HOME/.bash_profile" ]; then
    printf "#!/bin/bash\n\n" >> "$HOME/.bash_profile"
fi

# source `~/.bash_include` and `~/.bash_extra` from within `~/.bash_profile`
for INCLUDE_FILE in {"",".bash_extra"}; do
    INSERT_LINE='[ -f "$HOME/'$INCLUDE_FILE'" ] && source "$HOME/'$INCLUDE_FILE'"'
    if ! grep -Fxq "$INSERT_LINE" "$HOME/.bash_profile"; then
        echo "$INSERT_LINE" >> "$HOME/.bash_profile"
    fi
done

FILES_DIR="$DIR/files"
LEN=${#FILES_DIR}+1
for SOURCE_PATH in $(find $FILES_DIR -type f -not -path $FILES_DIR); do
    REL_PATH=${SOURCE_PATH:$LEN}
    DEST_PATH="$HOME/$REL_PATH"

    verify_overwrite $SOURCE_PATH $DEST_PATH
    if [ $? -eq 0 ]; then
        echo "updating $REL_PATH"
        rsync --quiet --perms $SOURCE_PATH $DEST_PATH
    else
        echo "skipping $REL_PATH"
    fi

done
