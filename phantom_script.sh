#!/bin/bash

### Francisco J. - 17/05/2021 ####
### Phantom Tester script Version 5.3 ###

## Colors ##

GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
BLUE=$'\e[0;34m'
RED=$'\e[0;31m'
CYAN=$'\033[01;36m'
NC=$'\e[0m'
BOLD=$'\033[1m'
BLINKING=$'\x1b[5m'

echo "${CYAN}"
echo -e "${BLINKING}"
echo "       ************************************************************************************************* "
echo "        _____  _    _          _   _ _______ ____  __  __   _______ ______  _____ _______ ______ _____   "
echo "       |  __ \| |  | |   /\   | \ | |__   __/ __ \|  \/  | |__   __|  ____|/ ____|__   __|  ____|  __ \  "
echo "       | |__) | |__| |  /  \  |  \| |  | | | |  | | \  / |    | |  | |__  | (___    | |  | |__  | |__) | "
echo "       |  ___/|  __  | / /\ \ | .   |  | | | |  | | |\/| |    | |  |  __|  \___ \   | |  |  __| |  _  /  "
echo "       | |    | |  | |/ ____ \| |\  |  | | | |__| | |  | |    | |  | |____ ____) |  | |  | |____| | \ \  "
echo "       |_|    |_|  |_/_/    \_\_| \_|  |_|  \____/|_|  |_|    |_|  |______|_____/   |_|  |______|_|  \_\ "
echo ""
echo "       **************************************************************************************************${NC}"

echo "${GREEN}#================================================================================================================#"
echo "#                                                                                                                #"
echo "#   Author: Francisco J.                                                                                         #"
echo "#                                                                                                                #"
echo "#                                                                                                                #"
echo "#   Version: 5.3        May 17th, 2021                                                                           #"
echo "#                                                                                                                #"
echo "#   Description: The Phantom Tester Script assists you on testing new circuits connection                        #"
echo "#                This script usually will run in a Raspberry Pi but it can run into a laptop as well. Just       #"
echo "#                give to the Raspberry Pi or laptop internet connection with a modem 3g/4g and connect the       #"
echo "#                Raspberry Pi or laptop Ethernet interface into the new circuit. After running the script        #"
echo "#                it will ask you to setup the Raspberry Pi or laptop Ethernet IP interface, Mask, Gateway,       #"
echo "#                IPs to test the Ping, Traceroute and cURL commands and finally the Bandwidth of your new        #"
echo "#                circuit to test the IPERF command.                                                              #"
echo "#                                                                                                                #"
echo "#================================================================================================================#${NC}"

### Getting your network interface name ####

name_interface=`ip link | awk -F: '$0 !~ "lo|vir|wlp|wwp|wpp|wps|vlo|vbo|wlan|wlx|^[^0-9]"{print $2a;getline}' | sed 's/^[[:space:]]*//'`

### Pre-Step. Connect your Raspberry or laptop ethernet interface into the circuit ####

echo ""
echo -e "${YELLOW}---> PRE-STEPS <--- ${NC}\n"

OK1="y"

while [[ $OK1 != "yes" ]]; do

   read -p 'Is your Raspberry Pi or laptop ethernet interface connected into the circuit? If not, please connect it (Confirm with "yes"): ' OK1
   echo ""

done

OK1="N"

### Setting up your network interface ###

repeat="N"

while [[ $repeat = 'N' || $repeat = 'n' ]]; do

  OK1="N"

  echo ""
  echo "${YELLOW}---> STEP 1 <---${NC}"
  echo ""

 ## IP ##

  while [[ $OK1 = 'N' ]]; do

    read -p 'Please type the IP for the Ethernet interface: ' IP
    echo ""

    if [[ "$IP" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then

       OK1="Y"

    else

       echo -e "${RED} The IP is not in correct format ${NC} \n"
       OK1="N"

    fi

  done

OK1="N"

 ## MASK ##

  while [[ $OK1 = 'N' ]]; do

    read -p 'Please type the Mask for the Ethernet interface: ' Mask
    echo ""

    if [[ "$Mask" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then

       OK1="Y"

    else

       echo -e "${RED} The Mask is not in correct format ${NC} \n"
       OK1="N"

    fi

  done

OK1="N"


  ## GATEWAY ##


  while [[ $OK1 = 'N' ]]; do

   read -p 'Please type the Gateway (Next Hop) to setup the static route: ' Gateway
   echo ""

   if [[ "$Gateway" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then

      OK1="Y"

   else

      echo -e "${RED} The Gateway is not in correct format ${NC} \n"
      OK1="N"

   fi

  done

OK1="N"

## IP to test the PING ##

  while [[ $OK1 = 'N' ]]; do

   read -p 'Please type the IP to test the PING (e.g 8.8.8.8): ' v_ping
   echo ""

   if [[ "$v_ping" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then

      OK1="Y"

   else

      echo -e "${RED} The IP to test the PING is not in correct format ${NC} \n"
      OK1="N"

   fi

  done

OK1="N"


## IP for the traceroute ##

  while [[ $OK1 = 'N' ]]; do

   read -p 'Please type the IP to test the TRACEROUTE (e.g 8.8.4.4): ' v_traceroute
   echo ""

   if [[ "$v_traceroute" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then

      OK1="Y"

   else

      echo -e "${RED} The IP to test the TRACEROUTE is not in correct format ${NC} \n"
      OK1="N"

   fi

  done

OK1="N"

## IP to test the cURL ##

  while [[ $OK1 = 'N' ]]; do

   read -p 'Please type the IP to test the cURL (e.g 74.125.193.94): ' v_curl
   echo ""

   if [[ "$v_curl" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then

      OK1="Y"

   else

      echo -e "${RED} The IP to test the cURL is not in correct format ${NC} \n"
      OK1="N"

   fi

  done

  read -p 'Please type the Circuit Bandwidth ( 100/200/300/400/500 MB ): ' CircuitBW

  echo ""
  echo -e "${GREEN} Interface IP: $IP ${NC} \n"
  echo -e "${GREEN} Interface Mask: $Mask ${NC} \n"
  echo -e "${GREEN} Gateway to configure the static route: $Gateway ${NC} \n"
  echo -e "${GREEN} IP for Ping test: $v_ping ${NC} \n"
  echo -e "${GREEN} IP for Traceroute test: $v_traceroute ${NC} \n"
  echo -e "${GREEN} IP for cURL test e.g 74.125.193.94: $v_curl ${NC} \n" 
  echo -e "${GREEN} Circuit Bandwidth: $CircuitBW ${NC} \n"

  read -p 'Is the data that you have specified correct? Enter y/n ' repeat
  echo ""


done



echo -e "The data that you have introduced is correct !!!\n" 

echo "${YELLOW}---> STEP 2 <---${NC}"
echo ""

echo -e "${YELLOW}Setting up your ethernet interface . . . ${NC} \n"

ifconfig $name_interface $IP netmask $Mask
route add $v_ping gw $Gateway dev $name_interface
route add $v_curl gw $Gateway dev $name_interface
route add $v_traceroute gw $Gateway dev $name_interface
route add 216.218.207.42 gw $Gateway dev $name_interface
echo ""

echo "This is your current Ethernet interface configuration:"
echo "${GREEN}"
ip a | grep -i $name_interface
echo "${NC}"

echo "This is your current ROUTING TABLE:"
echo "${GREEN}"
route -n
echo "${NC}"

echo "${YELLOW}---> STEP 3 <---${NC}"
echo ""
echo -e "Testing $name_interface connectivity CURL/PING/TRACEROUTE \n"

echo "*** cURL TO $v_curl ***"
echo ""

variable=`curl -Is $v_curl --connect-timeout 20 | head -1 | awk '{print $2}'`

echo -e "HTTP response: ${GREEN} $variable ${NC} \n"

if [[ $variable = "301"  ]]; then
  v_failed_1="0"
  echo "${GREEN}[ OK ] CURL IS GETTING A CORRECT HTTPS RESPONSE !!! [ OK ] ${NC}"
  echo ""
else
  v_failed_1="1"
  echo "${RED}[ FAILED ] CURL IS NOT GETTING A CORRECT HTTPS RESPONSE [ FAILED ] ${NC}"
  echo ""
fi

echo "*** PING TO $v_ping ***"

echo "${BLUE}"
ping -c 5 $v_ping
value_ping=$(echo "$?")
echo "${NC}"

if [[ $value_ping -ne "1" ]]; then
  v_failed_2="0"
  echo "${GREEN}[ OK ] PING WAS SUCCESSFUL !!! [ OK ] ${NC}"
  echo ""
else
  v_failed_2="1"
  echo "${RED}[ FAILED ] PING WAS NOT SUCCESSFUL [ FAILED ] ${NC}"
  echo ""
fi

echo ""

echo "*** TRACEROUTE TO $v_traceroute ***"

echo "${BLUE}"
traceroute $v_traceroute
echo "${NC}"

echo "*** LINK INFO ***"

echo "${BLUE}"
ethtool $name_interface
echo "${NC}"

echo "*** Interface RX/TX statistics***"
echo "${BLUE}"
timeout 10 ifstat
echo "${NC}"

echo "*** BANDWIDTH $name_interface ***"
echo -e "${BLUE}"
iperf -c iperf.he.net -l 1300 -u -b ${CircuitBW}m -i 1 -w 4m
echo "${NC}"

echo -e "${YELLOW}---> STEP 4 <---${NC} \n"
echo "${YELLOW}Restoring your routing table . . . ${NC}"

route del $v_ping gw $Gateway dev $name_interface
route del $v_curl gw $Gateway dev $name_interface
route del $v_traceroute gw $Gateway dev $name_interface
route del 216.218.207.42 gw $Gateway dev $name_interface

echo "${BLUE}"
route -n
echo "${NC}"

if [[ $v_failed_1 = "0" ]] && [[ $v_failed_2 = "0" ]]; then

    echo "${GREEN}"
    read -p 'Ping and cURL are successful. Would you like to redirect all the traffic to the Ethernet interface for troubleshooting? (type y/n): ' v_ts
    echo "${NC}"

    if [[ $v_ts = "y" ]]; then

       route del default
       route add default gw $Gateway $name_interface

       echo ""
       echo "${YELLOW}All the traffic is going to be redirected to the interface $name_interface using the gateway $Gateway ${NC}"

       echo "${BLUE}"
       route -n
       echo "${NC}"

    fi

else

      echo "${RED}"
      echo "Ping or cURL failed. Please check your new circuit connection !!!"
      echo "${NC}"

fi

echo "${YELLOW}    THE PHANTOM TESTER HAS FINISHED ITS EXECUTION! THANKS FOR USING!${NC}"
echo ""
