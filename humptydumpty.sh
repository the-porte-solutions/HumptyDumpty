#!/bin/bash
# Welcome to the Humpty Dumpty
# Author: Aleksandr Krasnov
# Contact: https://www.linkedin.com/in/alekkras
# Define colors for pretty output
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
# Ask the user for the target
# The webserver would be the target
intro()
{
echo "What is your target?"
echo ""
echo -n "${grn} > > > ${end}   " ; read target
echo "$target" > target.txt #use  >> if you would like to append instead of overwriting
}

ack()
{
touch ack.txt
echo -n "nmap -PN -sA -vv -n -p1-65535 -T4 -oN mapACKScan.txt -iL target.txt" > ack.txt
bash ack.txt
}

tcp_connect()
{
touch tcp_connect.txt
echo -n "nmap -PN -sT -vv -n -p1-65535 -T4 -oN mapTCPConnect.txt -iL target.txt" > tcp_connect.txt
bash tcp_connect.txt
}

syn()
{
touch syn.txt
echo -n "nmap -PN -sS -f -vv -n -p1-65535 -T4 -max-rtt-timeout 15 -oN mapSYNScan.txt -iL target.txt" > syn.txt
bash syn.txt
}

version_detection()
{
echo "For the Version Detection scan we would need to perform probing."
echo "To detect the actual service running on the open port that was found, you have to run"
echo "${grn}nmap -PN -sV -vv -n -p${end}${red}OPEN PORTS${end}${grn} -oN mapServiceDetection.txt -iL target.txt"
echo "This is something that you would need to perform manually, just copy paste the command and put the open ports discovered"
}

udp_tcp()
{
touch udp_tcp.txt
echo -n "nmap -vv -sU -p1-65535 -n -r -T4 -oN mapIPCopInternal.txt -iL target.txt" > udp_tcp.txt
bash udp_tcp.txt
}

service_detection()
{
echo "Do you have time for the full scan? (y/n)"
echo ""
echo -n "${grn} > > >  ${end}    " ; read sd
if [[ $sd == "Y" || $sd == "y" ]]; then
	touch service_detection.txt
	echo -n "nmap -vv -p1-65535 -sV -oN mapIPCopIntUDPServDet.txt -iL target.txt" > service_detection.txt
	bash service_detection.txt
elif [[ $sd == "N" || $sd == "n" ]]; then
	echo "You would need to perform it manually, just copy paste the command below and put the open ports discovered"
	echo "${grn}nmap -vv -p${end}${red}OPEN PORTS${end}${grn} -sV -oN mapIPCopIntUDPServDet.txt -iL target.txt${end}"
else
	echo "I am not sure what you want"
	service_detection
fi
}


main()
{
	echo "Would you like to ${grn}start${end}? (y/n)"
	echo ""
	echo -n "${grn} > > > ${end}    "; read start
	if [[ $start == "Y" || $start == "y" ]]; then
		echo "Welcome to the Humpty Dumpty!"
		cat art/humptydumpty.txt
		echo "Let's find the target!!!"
		intro
		echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
		echo "In order to perform the firewall testing in the right order, I recommend following the following pathway:"
		echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
		echo ""
		echo " ${blu}Perform ACK scan${end}"
		echo ""
		echo " ${blu}Perform TCP connect scan${end}"
		echo ""
		echo " ${blu}Perform SYN scan${end}"
		echo ""
		echo " ${blu}Perform Version Detection and Probing${end}"
		echo ""
		echo " ${blu}Firewall testing: UDP and TCP Connect Scans${end}"
		echo ""
		echo " ${blu}Service Detection scan${end}"
		echo ""
		echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
		echo ""
		echo "Would you like to go via ${cyn}recommended path (R)${end} or would you like to do it by ${mag}yourself(Y)${end}?"
		echo ""
		echo "Pick ${cyn}R${end} or ${mag}Y${end}"
		echo -n "${grn}>>>${end} "; read choice
		if [[ $choice == "R" || $choice == "r" ]]; then
			ack
			tcp_connect
			syn
			udp_tcp
			service_detection
			version_detection
		elif [[ $choice == "Y" || $choice == "y" ]]; then
			echo "Here are some options for you"
		    echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
			echo "In order to perform the firewall testing in the right order, I recommend following the following pathway:"
		    echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
			echo "1) Perform ${red}ACK${end} scan"
			echo ""
			echo "2) Perform ${red}TCP connect${end} scan"
			echo ""
			echo "3) Perform ${red}SYN${end} scan"
			echo ""
			echo "4) Perform ${red}Version Detection and Probing${end}"
			echo ""
			echo "5) Firewall testing: ${red}UDP and TCP Connect${end} Scans"
			echo ""
			echo "6) ${red}Service Detection${end} scan"	
			echo ""
			echo "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
			echo "Which one would you like to do?"
			echo ""
			echo -n "${grn} > > > ${end}   " ; read ch
			if [[ $ch == "1" ]]; then
				ack
				main
			elif [[ $ch == "2" ]]; then
				tcp_connect
				main
			elif [[ $ch == "3" ]]; then
				syn
			elif [[ $ch == "4" ]]; then
				version_detection
			elif [[ $ch == "5" ]]; then
				udp_tcp
			elif [[ $ch == "6" ]]; then
				service_detection
			else
				echo "I am not sure what you want"
				exit
			fi
		else 
			echo "I am not sure what you want"
			exit
		fi
	elif [[ $start == "N" || $start == "n" ]]; then
		cowsay -f ghostbusters Bye, you will never find joy in firewall intrusion || echo "${red}Bye, you will never find a real joy in firewall intrusion${end}"
	else
		exit
fi
}
main