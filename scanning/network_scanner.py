import scapy.all as scapy
import re

ip_add_range = re.compile('^(?:[0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]*$')
ip_inputed = ''

while True:
    ip_inputed = input('IP address range: ')
    if (ip_add_range.search(ip_inputed)):
        print(f'{ip_inputed} is valid')
        break


print('---------------------------------------------------------------------------------------------------------')
arp_result = scapy.arping(ip_inputed)
print('---------------------------------------------------------------------------------------------------------')