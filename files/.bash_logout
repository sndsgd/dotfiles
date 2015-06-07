#!/bin/bash

# clear the screen
[ "$SHLVL" = 1 ] && [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
[ -x /usr/bin/clear ] && /usr/bin/clear

# clear the tab title
printf "\e]0;\a"
