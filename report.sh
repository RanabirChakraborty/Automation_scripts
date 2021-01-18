#!/bin/bash
# ------------------------------------------------------------------------ #
# Script Name:   report.sh
# Description:   An interactive tool to check the deatils of your system.
# Written by:    Ranabir Chakraborty
# ------------------------------------------------------------------------ #
set -euo pipefail

function menuprincipal () {

flashed="\033[5;31;40m"
red="\033[31;40m"
none="\033[0m"

clear
readonly TIME=1
echo " "
echo "${0}"
echo " "
echo -e "${flashed}Hello,${USER}"${none}${red}" hope you are doing good! Let's interact with me."$none
echo "Choose an option below!
        1 - Verify desktop processor
	2 - Verify system kernel
	3 - Check report server related information
	4 - Operation system version
       	5 - Verify desktop memory
	6 - Last logged in users
	7 - Verify system IP
	8 - Checking a specified directory's size
	9 - Checking CPU temperature
	0 - Exit"
echo " "
echo -n "Chosen option: "
read opcao
case "${opcao}" in
	1)
		function processador () {
            CPU_INFO=$(cat /proc/cpuinfo | grep -i "^model name" | cut -d ":" -f2 | sed -n '1p')
			echo "CPU model: ${CPU_INFO}"
			sleep ${TIME}
		}
		processador
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	2)
		function kernel () {
			#RED HAT: cat /etc/redhat-release
            KERNEL_VERSION_UBUNTU=$(uname -r)
            KERNEL_VERSION_CENTOS=$(uname -r)
			if [ -f /etc/lsb-release ]
			then
				echo "kernel version: $KERNEL_VERSION_UBUNTU"
			else
				echo "kernel version: $KERNEL_VERSION_CENTOS"
			fi
		}
		kernel
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	3)
		function health () {
			echo "Today's date is:"
			date
			echo "uptime:"
			uptime
			echo "Currently connected:"
			w
			echo "--------------------"
			echo "Last logins:"
			last -a | head -3
			echo "--------------------"
			echo "Disk and memory usage:"
			df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}'
			free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}'
			echo "--------------------"
			echo "Utilization and most expensive processes:"
			top -b | head -3
			echo
			top -b | head -10 | tail -4
			echo "--------------------"
			echo "Open TCP ports:"
			nmap -p -T4 127.0.0.1
			echo "--------------------"
			echo "processes:"
			ps auxf --width=200
			echo "--------------------"
			echo "vmstat:"
			vmstat 1 5
		}
		health
		read -n 1 -p "<Enter> for main menu"
                menuprincipal
                ;;

	4)
		function sistema () {
			VERSION=`cat /etc/os-release | grep -i ^PRETTY`
			if [ -f /etc/os-release ]
			then
				echo "The system version: $VERSION"
			else
				echo "System not supported"
			fi
		}
		sistema
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;


	5)
		function memory () {
			MEMORY_FREE=`free -m  | grep ^Mem | tr -s ' ' | cut -d ' ' -f 4`
			#MEMORY_TOTAL=
			#MEMORY_USED=
			echo Verifying system memory...
			echo "Memory free is: $MEMORY_FREE"
		}
		memory
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	6)
		function serial () {
			TIME=3
			echo " "
			echo "Choose an option below for program's list!

			1 - Who is online ?
			2 - Who are the last logged in users
			4 - Back to menu"
			echo " "
			echo -n "Chosen option: "
			read alternative
			case "$alternative" in
				1) write_header " Who is online "
				   who -H
			           sleep $TIME
				   ;;
				2) write_header " List of last logged in users "
				   last
				   sleep $TIME
				   ;;
			esac
		}
		serial
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	7)
		function ip () {
			IP_SISTEMA=`hostname -I`
			echo IP is: $IP_SISTEMA
		}
		ip
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	8)
		function size () {
			echo -n "Enter your directory: "
                	read -r x
			echo -n "output a specified directory's size"
			sudo du -sh "$x"
		}
		size
		read -n 1 -p "<Enter> for main menu"
                menuprincipal
		;;

	9)
		function temperature () {
		TEMP_FILE=/sys/class/thermal/thermal_zone0/temp

		ORIGINAL_TEMP=$(cat $TEMP_FILE)
		TEMP_C=$((ORIGINAL_TEMP/1000))
		TEMP_F=$(($TEMP_C * 9/5 + 32))

		echo "show CPU temperature: $TEMP_F F"
		}
		temperature
		read -n 1 -p "<Enter> for main menu"
                menuprincipal
                ;;

	0)
	       echo Exiting the system...
       	       sleep $TIME
	       exit 0
	       ;;

	*)
		echo Invalid option, try again!
		;;
esac
}
menuprincipal
