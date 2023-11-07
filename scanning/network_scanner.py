import scapy.all as scapy
import re
import subprocess

ip_add_range = re.compile('^(?:[0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]*$')
ip_inputed = ''

while True:
    ip_inputed = input('IP address range (ex: 192.168.1.0/24): ')
    if (ip_add_range.search(ip_inputed)):
        print(f'{ip_inputed} is valid')
        break


print('---------------------------------------------------------------------------------------------------------')
arp_result = scapy.arping(ip_inputed)
print('---------------------------------------------------------------------------------------------------------')

nmap_ip_input = input('Choose IP address to scan on nmap: ')
print(subprocess.call(['nmap', nmap_ip_input]))