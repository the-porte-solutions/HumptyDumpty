#!/bin/bash
# Author: Aleksandr Krasnov
# Contact: https://www.linkedin.com/in/alekkras
intro(){
mkdir txt
cd txt
echo "What is your target?"
echo " "
echo -n  "   "; read target
echo "$target"  > target.txt
cd ..	
}
show(){
echo " - - - - - - - - - - - - - - - - - - - - - - - "
echo "|      Here are some options to perform       |"
echo " - - - - - - - - - - - - - - - - - - - - - - - "
echo " "
echo "1) Testing ICMP:"
echo "hping3 will behave like a normal ping utility, sending ICMP-echo and receiving ICMP-reply"
echo " "
echo "2) Traceroute using ICMP:"
echo "hping3 will use ICMP packets increasing every time in 1 its TTL value"
echo " "
echo "3) Checking port:"
echo "hping3 will sned a SYN packet to a specified port"
echo " "
echo "4) Traceroute to a determined port: "
echo "hping3 uses traceroute to a specified port watching where your packet is blocked. Just add --traceroute to the command"
echo "5) ICMP mask request:"
echo "hping3 sends an ICMP address mask request"
echo " "
echo "6) FIN scan: "
echo "In a TCP connection the FIN flag is used to start the connection closing routine. If we don't receive a reply, the port is open."
echo " "
echo "7) ACK scan: "
echo "Check if host is alive (when ping is blocked)"
echo " "
echo "8) Xmas scan: "
echo "sets the sequence number to zero and set the URG+PSH+FIN flags in the packet."
echo " "
echo "9) Null scan: "
echo "sets the sequence number to zero and have no flags set in the packet."
echo " "
echo "10) DoS Land Attack"

echo "Whic one would you like to perform?"
}
ask(){

echo -n "   "; read a
if [[ $a == "1" ]]
then
	echo "ASFSAFASFSA"
    cd txt
    touch icmp.txt
    echo -n "hping3 -1 " > icmp.txt
    echo -n "$target" >> icmp.txt
    bash icmp.txt
    cd ..
    ask
elif [[ $a == "2" ]]
then
    cd txt
    touch tracert.txt
    echo -n "hping3 --traceroute -V -1 " > tracert.txt
    echo -n "$target" >> tracert.txt
    bash tracert.txt
    cd ..
    ask
elif [[ $a == "3" ]]
then
    cd txt
    touch check_port.txt
    echo -n "hping3 -V -S -p 80 -s 5050 " > check_port.txt
    echo -n "$target" >> check_port.txt
    bash check_port.txt
    cd ..
    ask
elif [[ $a == "4" ]]
then
	cd txt
    touch tracert_port.txt
    echo -n "hping3 --traceroute -V -S -p 80 -s 5050 " > tracert_port.txt
    echo -n "$target" >> tracert_port.txt
    bash tracert_port.txt
    cd ..
    ask
elif [[ $a == "5" ]]
then
	cd txt
	touch icmp_mask.txt
	echo -n "hping3 -c 1 -V -1 -C 17 " > icmp_mask.txt
	echo -n "$target" >> icmp_mask.txt
	bash icmp_mask.txt
	cd ..
	ask
elif [[ $a == "6" ]]
then 
	cd txt
	touch fin_scan.txt
	echo -n "hping3 -c 1 -V -p 80 -s 5050 -F " > fin_scan.txt
	echo -n "$target" >> fin_scan.txt
	bash fin_scan.txt
	cd ..
	ask
elif [[ $a == "7" ]]
then 
	cd txt
	touch ack_scan.txt
	echo -n "hping3 -c 1 -V -p 80 -s 5050 -A " > ack_scan.txt
	echo -n "$target" >> ack_scan.txt
	bash ack_scan.txt
	cd ..
	ask
elif [[ $a == "8" ]]
then 
	cd txt
	touch xmas_scan.txt
	echo -n "hping3 -c 1 -V -p 80 -s 5050 -M 0 -UPF " > xmas_scan.txt
	echo -n "$target" >> xmas_scan.txt
	bash xmas_scan.txt
	cd ..
	ask
elif [[ $a == "9" ]]
then
	cd txt
	touch null_scan.txt
	echo -n "hping3 -c 1 -V -p 80 -s 5050 -Y " > null_scan.txt
	echo -n "$target" >> null_scan.txt
	bash null_scan.txt
	cd ..
	ask
elif [[ $a == "10" ]]
then 
	cd txt
	touch dos.txt
	echo -n "hping3 -V -c 1000000 -d 120 -S -w 64 -p 445 -s 445 --flood --rand-source " > dos.txt
	echo -n "$target" >> dos.txt
	bash dos.txt
	cd ..
	ask
else
	echo "Something went wrong"
fi

}
main(){
	intro
	show
	ask
}
main