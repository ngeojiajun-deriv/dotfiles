#!/bin/sh

ls -a | grep -vE '^(\.){1,2}$' | xargs -I @ @ .. ;
