#! bin/bash
# Created By: Hacker 27

# Checks to see if the script is run as root
if [[ "${UID}" -ne 0 ]]; then
    echo 'Please run with sudo or as root.' >&2
    exit 1
fi

# Select the drive to burn
lsblk && echo "Please enter the name of the usb drive to flash. :"
read DRIVE

#Unmounts and format's the drive
umount /dev/$DRIVE* && mkfs.vfat -I /dev/sdb

# Select the file to burn to the drive
echo "Please enter the name or path of the ISO image to flash. :"
read ISO

#Starts Burning the image to the flash drive
dd bs=4M if=$ISO of=/dev/$DRIVE status=progress 