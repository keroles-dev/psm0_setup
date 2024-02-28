#!/bin/sh

uid=$(id -u)
gid=$(id -g)

usbdev=$(ls -l /sys/dev/block/ | awk -F"/" '($7~"usb" && $15~"sd") {print "/dev/"$15}')

if [ $usbdev ]
then
	selected=$( \
		lsblk -rno size,name,mountpoint $usbdev | \
		awk '($1!~"M" && $1!~"K") {printf "%s%8s%12s\n", $2, $1, $3}' | \
		dmenu -l S -i -p "Usb Drivers: " | awk '{print $1}' \
	)

	if grep -qs $selected /proc/mounts
	then
		sync
		doas unmount /dev/$selected
		grep -qs /mnt/$selected /proc/mounts || doas rm -rf /mnt/$selected
	else
		[ ! -d /mnt/$selected ] && doas mkdir /mnt/$selected
		doas mount -o uid=$uid,gid=$gid /dev/$selected /mnt/$selected
	fi
else
	echo "No drivers connected" | dmenu -i -p "USB Drivers: "
	exit
fi	
