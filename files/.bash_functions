# ~/.bash_functions: functions to load on login


# create a data URL from a file
function dataurl() {
   local mimeType=$(file -b --mime-type "$1")
   if [[ $mimeType == text/* ]]; then
      mimeType="${mimeType};charset=utf-8"
   fi
   echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# make a directory and make it the current working directory
function mcd() { 
   mkdir -pv $1 && cd $1
}


if [ "$OS_NAME" = "Darwin" ]; then
   function startvm() {
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

