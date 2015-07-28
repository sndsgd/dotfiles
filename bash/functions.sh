
# create a data URL from a file
# @param string The path to the file to encode
function dataurl() {
   local MIME_TYPE=$(file -b --mime-type "$1")
   [ "$MIME_TYPE" == "text/*" ] && MIME_TYPE="${mimeType};charset=utf-8"
   echo "data:$MIME_TYPE;base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# make a directory and make it the current working directory
# @param string The directory path
function mcd() { 
   mkdir -pv $1 && cd $1
}


if [ "$OS_NAME" = "Darwin" ] && [ -e /usr/bin/vboxmanage ]; then
   # @param string vmname
   function startvm() {
      VBoxManage startvm $1 --type headless
   }

   # @param string vmname
   # @param string snapshot
   function restorevm() {
      VBoxManage snapshot $1 restore $2
   }

   # @param string vmname
   # @param string snapshot
   function rstartvm() {
      VBoxManage snapshot $1 restore $2
      VBoxManage startvm $1 --type headless
   }
fi


# if git is present, create a function for removing git tags
if [ -e /usr/bin/git ]; then
   function rmgittag() {
      git tag -d "$1"
      [ "$?" == "0" ] && git push origin ":refs/tags/$1"
   }
fi


