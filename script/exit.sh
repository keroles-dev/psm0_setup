#!/bin/sh

choice=$(echo -e "Shutdown\nReboot\nExit" | dmenu)

[ $choice = "Shutdown" ] && doas poweroff
[ $choice = "Reboot" ] && doas reboot
[ $choice = "Exit" ] && doas pkill dwm
