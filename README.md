# .dotfiles - Linux configuration files #

These are my Linux configuration files.  The intent is that this
repository be checked out into your home directory.  After that
installing the files is as simple as running `stow` for each
(non-.git) entry in the `.dotfiles` directory:

```console
$ stow --dotfiles $(find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -exec basename {} \;)
```

This is precisely what is done in the `deploy.sh` script.
