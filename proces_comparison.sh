#!/bin/bash

while true; 
do
a=$(ps -elf | awk -F ' ' '{print $3, $4, $15}' | sort > ps_1.txt)
sleep 30

b=$(ps -elf | awk -F ' ' '{print $3, $4, $15}' | sort > ps_2.txt)

diff ps_1.txt ps_2.txt > ps_diff.txt

cat ps_diff.txt; done
