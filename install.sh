#!/bin/sh

ls -a | grep -vE '^(\.){1,2}(git)?$' | xargs -I @ cp -r @ .. ;
