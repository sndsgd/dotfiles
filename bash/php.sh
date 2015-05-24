
if [ "$OS_NAME" == "Darwin" ]; then
   which brew >/dev/null 2>&1
   if [ $? -eq 0 ]; then
      for BREW_PHP_VERSION in {php54,php55,php56,php7}; do
         BREW_PHP_DIR=$(brew --prefix "$BREW_PHP_VERSION" 2> /dev/null)
         [ $? -eq 0 ] && alias "$BREW_PHP_VERSION=$BREW_PHP_DIR/bin/php"
      done
   fi

   unset BREW_PHP_VERSION
   unset BREW_PHP_DIR
fi

# add the composer vendor bin directory to the PATH if it exists
[ -d "$HOME/.composer/vendor/bin" ] && PATH="$HOME/.composer/vendor/bin:$PATH"

