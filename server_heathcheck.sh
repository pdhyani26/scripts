#!/bin/bash

	#Author: Prashant Dhyani

	#Purpose: To monitor the CPU usage

	Date=$(date +%d'|'%m'|'%Y)
	Host=`hostname`
	
	cpu=`top -bn1 | grep Cpu | awk 'BEGIN {FS=" "} {printf("%.2f\n",100-$8)}'`
	MemFree=`top -bn1 | grep 'Mem :' | awk 'BEGIN {FS=" "}{printf("%.2f\n",$6/1024)}'` 
	MemPercent=`top -bn1 | grep 'Mem :' | awk 'BEGIN {FS=" "}{printf("%.2f\n",($8/$4)*100)}'` 
	SwapFree=`top -bn1 | grep 'Swap:' | awk 'BEGIN {FS=" "}{printf("%.2f\n",$5/1024)}'` ##Swap free 
	SwapPercent=`top -bn1 | grep 'Swap:' | awk 'BEGIN {FS=" "}{printf("%.2f\n",($7/$3)*100)}'`
	
	echo -e "\e[36mDate : \e[0m" $Date
	echo -e "\e[31m***************************\e[0m"$Host"\e[31m*********************************\e[0m"
	printf %"s\n"
	echo -e "\e[31m-----------------------------------------------------------------------------------------\e[0m"
	printf "%-18s |%-18s |%-18s |%-18s |%-18s\n" CPU_Utilization Memory_Available Memory_Utilization Swap_Memory_Available Swap_Utilization
	echo -e "\e[31m-----------------------------------------------------------------------------------------\e[0m"
	printf "%18s |%-18s |%-18s |%-18s |%-18s\n" "$cpu"% "$MemFree"GB  "$MemPercent"%  "$SwapFree"GB  "$SwapPercent"%
