# Dotfiles


## Setup

Run `update.sh`. It will copy the contents of `files/` into your home directory,
prompting before overwriting along the way.

```sh
./update.sh
```


### Copy Pasta

:warning:   This command block is here exclusively for my use. DO NOT RUN THESE IF YOU ARE NOT ME.

```sh
curl -L -s -o /tmp/dotfiles.tgz https://github.com/sndsgd/dotfiles/archive/master.tar.gz && \
tar -xzf /tmp/dotfiles.tgz -C /tmp && \
rm /tmp/dotfiles.tgz && \
source /tmp/dotfiles-master/update.sh --force && \
rm -rf /tmp/dotfiles-master && \
git config --global user.name "Russell"  && \
git config --global user.email "r@snds.gd"
```

### Todo

- Allow for os blacklists to prevent files being copied
