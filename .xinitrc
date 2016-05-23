# Setup my monitors
/home/sfrasier/bin/setup_monitors

# Merge in my X resources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Screensaver
#xscreensaver --no-splash &

# Set the cursor icon
xsetroot -cursor_name left_ptr &

# Set background image
sh ~/.fehbg &

# Ignore the touchpad unless I have stopped typing for 3 seconds
#syndaemon -d -k -i 3.0 &

# Turn off the touchpad
synclient TouchpadOff=1

# Turn on numlock
numlockx

# Start ratpoison
exec ratpoison
