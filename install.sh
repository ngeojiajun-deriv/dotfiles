#!/bin/sh

ls -a | grep -vE '^(\.){1,2}(git)?$' | xargs -I @ cp -r @ .. ;
# Patch
git config --global core.excludesFile ~/.gitignore;
