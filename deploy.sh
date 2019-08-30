#!/bin/bash

for d in $(find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -exec basename {} \;)
do
    stow "$d"
done
