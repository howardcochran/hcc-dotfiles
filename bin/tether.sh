#!/bin/bash

# Invert the exit status of a command. There is probably a more elegant
# way to achieve this result.
function invert() { 
    if [ "$?" -eq 0 ] ; then 
	return 1
    else
	return 0
    fi
}

case $1 in
    ""|-c)
	# Set up a Bluetooth PAN connection to my phone
	echo Connecting
	pand --connect 00:21:BA:6B:CA:4E -n

	# Wait for pand to get connection established
	while ( pand -l |grep '^bnep0' ; invert ) ; do
	    echo Waiting...
	    sleep 1
	done
	ifup bnep0
	;;
    -d)
	# Bring down the Bluetooth PAN connection
	echo Disconnecting
	ifdown bnep0
	pand -K
	;;
esac
