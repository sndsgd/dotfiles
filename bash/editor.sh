
if [ "$OS_NAME" = "Darwin" ]; then
    if [ -e /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ]; then
        alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
        export GIT_EDITOR='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -w'
        export EDITOR='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -w'
    fi
fi
