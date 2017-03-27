
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

if [ "$OS_NAME" == "Darwin" ] && [ -e /usr/bin/vboxmanage ]; then

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
    function restartvm() {
        VBoxManage snapshot $1 restore $2
        VBoxManage startvm $1 --type headless
    }
fi

if [ -e /usr/bin/git ]; then

    # checkout a git branch
    # @param string The partial of full branch name to checkout
    function gcof() {
        if [ -z "$1" ]; then
            echo "you need to enter at least a partial branch name"
            return 1
        fi

        local BRANCHES=$(git branch | grep $1 | sed -e s/\\*//g | xargs)
        local COUNT=$(echo "$BRANCHES" | wc -w | xargs)

        if [ $COUNT == 1 ]; then
            git checkout "$BRANCHES"
            return 0
        elif [ $COUNT == 0 ]; then
            echo "no branches found"
            return 1
        fi

        local BRANCH=""
        echo "found $COUNT branches"
        for BRANCH in $BRANCHES
        do
            echo "- $BRANCH"
        done
        return 1
    }

    # remove a tag from both local and remote repos
    # @param string The git tag to remove
    function gitremovetag() {
        git tag -d "$1"
        [ "$?" == "0" ] && git push origin ":refs/tags/$1"
    }

    # recursively find modified git repos
    function gitmod() {
        local REPO=""
        local DIR=""
        local CHANGED=0
        for REPO in $(find . -type d -name ".git"); do
            DIR=$(dirname "$REPO")
            cd "$DIR"
            git status -s | grep -v '??' &> /dev/null && {
                echo -ne "$DIR\n"
                let CHANGED=${CHANGED}+1
            }
            cd - &> /dev/null
        done
        echo -ne "---\nfound $CHANGED repos with modifications\n"
    }

    # replace the current git config with another
    # @param string The name of the user to become
    function gituser() {
        local USER="$1"
        local GITCONFIG="$HOME/.gitconfig"
        local FILE="$GITCONFIG-$USER"
        if [ ! -f "$FILE" ]; then
            echo "no git config for '$USER'"
            return 1
        fi
        cp "$FILE" "$GITCONFIG"
        if [ "$?" != 0 ]; then
            echo "failed to copy git config for $USER"
            return 1
        fi
        echo "now using $USER's gitconfig"
    }
fi
