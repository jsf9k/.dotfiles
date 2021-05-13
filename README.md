# .dotfiles - Linux configuration files #

These are my Linux configuration files.  The intent is that this
repository be checked out into your home directory.  After that
installing the files is as simple as running `stow` for each
(non-.git) entry in the `.dotfiles` directory:

```console
for d in $(find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -exec basename {} \;)
do
    stow --dotfiles "$d"
done
```

This is precisely what is done in the `deploy.sh` script.
