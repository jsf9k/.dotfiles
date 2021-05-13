#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

stow --dotfiles $(find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -exec basename {} \;)
