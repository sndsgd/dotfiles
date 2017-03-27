#!/bin/bash

DOTFILE=".bash_include"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMP_FILE="$DIR/temp.sh"
BASH_FILES_DIR="$DIR/bash"
BASH_INCLUDE_LINE='[ -f "$HOME/'$DOTFILE'" ] && source "$HOME/'$DOTFILE'"'
BASH_EXTRA_LINE='[ -f "$HOME/.bash_extra" ] && source "$HOME/.bash_extra"'


[ -f "$TMP_FILE" ] && rm "$TMP_FILE"


sndsgd_section_header() {
    local COMMENT="# $1 "
    local X=78
    local LEN=$(expr $X - ${#COMMENT})
    COMMENT+=$(printf "#%.0s" $(seq 1 $LEN))"\n"
    COMMENT+=$(printf "#%.0s" $(seq 1 $X))"\n"
    echo -e "$COMMENT"
}

sndsgd_include_file() {
    local NAME=$1
    local FILE="$BASH_FILES_DIR/$NAME.sh"
    if [ -r "$FILE" ]; then
        sndsgd_section_header "$NAME" >> $TMP_FILE
        cat "$FILE" >> $TMP_FILE
        printf "\n\n\n" >> $TMP_FILE
    else
        echo "$NAME (skipped)"
    fi
}

# copy the contents from a bunch of files into a single include file
echo "creating ~/$DOTFILE..."
for INCLUDE_NAME in {init,path,exports,php,go,prompt,aliases,functions,editor}; do
    sndsgd_include_file "$INCLUDE_NAME"
done
mv $TMP_FILE "$HOME/$DOTFILE"

# if ~/.bash_profile doesn't exist, create it
if [ ! -f "$HOME/.bash_profile" ]; then
    echo "creating ~/.bash_profile..."
    printf "#!/bin/bash\n\n" >> "$HOME/.bash_profile"
else
    echo "updating ~/.bash_profile..."
fi

# source `~/.bash_include` and `~/.bash_extra` from within `~/.bash_profile`
for INSERT_LINE in {"$BASH_INCLUDE_LINE","$BASH_EXTRA_LINE"}; do
    if ! grep -Fxq "$INSERT_LINE" "$HOME/.bash_profile"; then
        echo "$INSERT_LINE" >> "$HOME/.bash_profile"
    fi
done

# copy all files within the files directory into the home directory
echo "copying files..."
rsync --exclude ".DS_Store" --archive --quiet "$DIR/files/." "$HOME"

# cleanup: unset all variables
unset DOTFILE
unset DIR
unset TMP_FILE
unset BASH_FILES_DIR
unset INCLUDE_NAME
unset BASH_INCLUDE_LINE
unset BASH_EXTRA_LINE
unset INSERT_LINE
unset sndsgd_include_file
unset sndsgd_section_header
