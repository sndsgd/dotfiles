# Dotfiles

Loosely based on [Mathias Bynens'](https://github.com/mathiasbynens/dotfiles) dotfiles.

## Warning

Using this repo will clobber the following files if they exist on your system:

- `~/.bash_include`
- `~/.bash_logout`
- `~/.gitconfig`
- `~/.gitignore`


## Setup

Running the update script does the following:

- Concatenates the contents of the files in `bash` into `~/.bash_include`
- Copies files from `files` into your home directory
- Updates your `~/.bash_profile` to load `~/.bash_include` and `~/.bash_extra` if they exist


Copy and paste this command into your terminal to download this repo and perform updates:

```sh
REPO_URL=https://github.com/sndsgd/dotfiles/archive/master.tar.gz && \
curl -L -s -o /tmp/dotfiles.tgz $REPO_URL && \
tar -xvzf /tmp/dotfiles.tgz -C /tmp && \
rm /tmp/dotfiles.tgz && \
source /tmp/dotfiles-master/update.sh && \
rm -rf /tmp/dotfiles-master && \
unset REPO_URL
```


To configure yourself as the git author, update the following block with your name and email, and then copy and paste this command into your terminal:

```sh
cat << EOF >> "$HOME/.bash_extra"
# git credentials
git config --global user.name "Russell"
git config --global user.email "r@snds.gd"
EOF
```
