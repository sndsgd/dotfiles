# dotfiles

Loosely based on [Mathias Bynens'](https://github.com/mathiasbynens/dotfiles) dotfiles.



## Install

Copy and paste the following into your terminal and hit enter

```sh
inject_dotfiles() {
   local CURRENT_DIR=$(pwd)
   local URL=https://github.com/sndsgd/dotfiles/archive/master.tar.gz
   curl -L -s -o /tmp/dotfiles.tgz $URL
   tar -xvzf /tmp/dotfiles.tgz -C /tmp
   rm /tmp/dotfiles.tgz
   source /tmp/dotfiles-master/update.sh --local
   rm -rf /tmp/dotfiles-master
}
inject_dotfiles && \
unset inject_dotfiles
```

