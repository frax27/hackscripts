#! /bin/bash
# This script is designed to find systems with a certain port open.
# This is the exact script from Chapter 8 of Linux Basics for Hackers by OccupyTheWeb
echo "Enter the starting IP address to scan... :"
read FIRSTIP
echo "Enter the last octet of the last IP :"
read LastOctetIP
echo "Enter the port number you want to scan for :"
read port
nmap -sT $FIRSTIP-$LastOctetIP -p $port >/dev/null -oG Alohascan
cat Alohascan | grep open > Alohascan2
cat Alohascan2
