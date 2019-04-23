#!/usr/bin/env bash
set -e

echo "### executing $0"

echo -e "\n------------------- fix $HOME/xstartup -----------------------"

if [ -f $HOME/.vnc/xstartup ] ; then 
	sed -ie 's/vncserver -kill $DISPLAY//' $HOME/.vnc/xstartup
else
	echo "ERROR: $HOME/.vnc/xstartup is missing, I cannot fix it."
	exit 1
fi
