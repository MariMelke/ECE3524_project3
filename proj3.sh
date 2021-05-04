#!/bin/sh

main_menu(){
	echo -e "`date`\n------------------------------------\nMain Menu\n-------------------------------------"
	echo -e "1. Operating system info\n2. Host name and DNS info\n3. Network info\n4. Who is online\n5. Last logged in users"
	echo -e "6. My IP address\n7. My disk usage\n8. My home file-tree\n9. Free space\n10. Exit!"
	echo -n "Enter your choice [ 1 - 9 ]: "
	read choice

	if [ $choice == 1 ]
	then
		echo -e "--------------------------------------------------------------------\nSystem information"
		echo "--------------------------------------------------------------------"
		echo "Operating system: Linux"
		cd /home
		/usr/bin/lsb_release -a
	elif [ $choice == 2 ]
	then
		echo -e "---------------------------------------------------------------------\nHostname and DNS information"
		echo "--------------------------------------------------------------------"
		echo "Hostname : `hostname`"
		echo "DNS domain name : `hostname -d`"
		echo "Fully qualified domain name : `hostname -f`"
		echo "Network address (IP) : `hostname -i | awk '{ print $2}'`"
		cd /home
		echo -n "DNS name server (DNS IP) : " 
		grep "^nameserver" /etc/resolv.conf
	elif [ $choice == 3 ]
	then
		echo -e "---------------------------------------------------------------------\nNetwork information"
		echo "--------------------------------------------------------------------"
		cd /home
		echo -n "Total network interfaces found : "
		ls -A /sys/class/net | wc -l
		echo "*** IP Adresses Information ***"
		ip addr show
		echo "***********************"
		echo "*** Network routing ***"
		echo "***********************"
		netstat -r 
		echo "*************************************"
		echo "*** INterface traffic information ***"
		echo "*************************************"
		netstat -i
	elif [ $choice == 4 ]
		then
		echo -e "---------------------------------------------------------------------\nWho is online"
		echo "--------------------------------------------------------------------"
		echo "Name      TTY            DATE         COMMENT"
		who
	elif [ $choice == 5 ]
	then
		echo -e "----------------------------------------------------------------------\nList of last logged in users"
		echo "--------------------------------------------------------------------"
		last | grep -v "^reboot"
	elif [ $choice == 6 ]
	then
		echo -e "----------------------------------------------------------------------\nPublic IP information"
		echo "--------------------------------------------------------------------"
		hostname -I
	elif [ $choice == 7 ]
	then
		echo -e "-----------------------------------------------------------------------\nDisk usage information"
		echo "--------------------------------------------------------------------"
		df -hl | awk '{ print $5 " " $6 }'
	elif [ $choice == 8 ]
	then
		source ./proj1.sh filetree.html
	elif [ $choice == 9 ]
	then
		echo "There is no command for the ninth option."
	elif [ $choice == 10 ]
	then
		exit 1
	else
		echo "Please choose a number between the range of 1-10."
	fi
}

main_menu

while (read -p "Press enter to continue")
do
	main_menu
done


