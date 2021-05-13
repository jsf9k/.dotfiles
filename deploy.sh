#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

for d in $(find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -exec basename {} \;)
do
    stow --dotfiles "$d"
done
