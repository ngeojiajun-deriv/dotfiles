#!/bin/bash
read -p 'Path to ignore:' path;
echo $path >> .gitignore;
cat .gitignore;
