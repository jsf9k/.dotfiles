#!/bin/bash

find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -exec stow {} \;
