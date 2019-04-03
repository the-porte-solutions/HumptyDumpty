#!/bin/bash
# Maintainer: Aleksandr Krasnov
# https://www.linkedin.com/in/alekkras

ask()
{
echo "What is your target?"
echo ""
echo -n "${grn} > > > ${end}   " ; read target
echo "$target" > target.txt #use  >> if you would like to append instead of overwriting
}

basic_scan()
{
    touch basic_scan.txt
    echo -n "nmap -sS -sU -T4 -A -v -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53 --script \"default or (discovery and safe)\" -iL target.txt" > basic_scan.txt
    bash basic_scan.txt
}
main()
{
ask
basic_scan
}
main
