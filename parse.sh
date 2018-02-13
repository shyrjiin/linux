#!/bin/bash

#this command prints out a unique list of open ports (service names) and sorts them from top to bottom (greatest at top)
cat text.txt | grep tcp | grep open | awk '{print $3}' | sort | uniq -c | sort -nr


#this command prints a list of IP address next to the service that was present
both=$(cat text.txt | egrep -B1 '[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}|tcp\s{1,}' | sed 's/search string //' | awk '{print $1,$3}' | sed 's/--//' | awk -F '/' '{print}' | grep -v PORT | sed 's/\// /' | awk '{print $1,$3}')

#this command prints a list of just ip addresses in the nmap report
ip=$(cat text.txt | awk '/search string/ { host=$NF } $2=="open" {print host}')

#this command prints just the services that were found on the nmap report
services=$(cat text.txt | awk '/search string/ { host=$NF } $2=="open" {print $1,$NF}')

#this command prints the port number for each service
port=$(cat text.txt | awk '/search string/ { host=$NF } $2=="open" {print $NF,$1}' | egrep -o "[0-9]{1,}")


#this command prints each IP address next to each service found on each

#cat text.txt | awk '/search string/ { host=$NF } $2=="open" {print host, $NF}'


#for loop that separates each service into the variable i, it then iterates through egrep grabbing the line below the fifth column (IP address) and the service name from #the for loop variable

for service in $services; do

    echo "========================================="
    echo "                 "$service
    echo "========================================="
    cat text.txt | egrep "(${service}$|([0-9]{3}\.){1,3}[0-9]{1,3}[0-9]{1,3})" | egrep -B1 "${service}$" | awk -F ' ' '{print $5}' | tr -s "\n"

done
