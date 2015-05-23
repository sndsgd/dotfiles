#!/bin/bash

OS_NAME=$(uname)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


create_git_dir() {
   if [ ! -d "$1" ]; then
      echo "creating git directory in '$1'"
      mkdir -pv "$1"
   fi
}

link_ssh_config() {
   local DEST_PATH="$HOME/.ssh/config"
   local SOURCE_PATH="$1"
   if [ ! -f "$DEST_PATH" ] && [ -f "$SOURCE_PATH" ]; then
      echo "creating link to ssh config in $SOURCE_PATH"
      ln -s "$SOURCE_PATH" "$DEST_PATH"
      chmod 600 "$DEST_PATH"
   fi
}


# setup tasks ###############################################################
#############################################################################

OS_NAME=$(uname)

[ ! -d "$HOME/.ssh" ] && mkdir -pv "$HOME/.ssh"

if [ "$OS_NAME" = "Darwin" ]; then
   create_git_dir "$HOME/Documents/git"
   link_ssh_config "$HOME/Dropbox/Documents/ssh/config"
elif [ "$OS_NAME" = "Linux" ]; then
   create_git_dir "$HOME/git"
fi


# copy files into $HOME #####################################################
#############################################################################

echo "copying files..."
rsync --exclude ".DS_Store" --archive --quiet "$DIR/files/." "$HOME"


# cleanup ###################################################################
#############################################################################

unset OS_NAME
unset DIR
unset create_git_dir
unset link_ssh_config
