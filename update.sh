#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$1" != "--local" ] && [ "$1" != "-l" ]; then
   echo "updating to latest version..."
   git --git-dir="$DIR/.git" --work-tree="$DIR" pull
fi

echo "copying files..."
rsync --exclude ".DS_Store" --archive --quiet "$DIR/files/." ~


link_ssh_config() {
   local sshdir="$HOME/.ssh"
   local destpath="$sshdir/config"
   local sourcepath="$1"
   if [ ! -f "$destpath" ] && [ -f "$sourcepath" ]; then
      echo "creating link to ssh config in $sourcepath"
      if [ ! -d "$sshdir" ]; then
         mkdir -pv "$sshdir"
      fi
      ln -s "$sourcepath" "$destpath"
      chmod 600 "$destpath"
   fi
}


echo "updating bash environment..."
source ~/.bash_profile

OS_NAME=$(uname)
if [ "$OS_NAME" = "Darwin" ]; then
   link_ssh_config "$HOME/Dropbox/Documents/ssh/config"
fi
