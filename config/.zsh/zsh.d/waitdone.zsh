#!/bin/zsh

function waitdone {
    local wait_result=$?
    if [ $# -ne 1 ] ; then print "Usage: waitdone identifier" ; return 1 ; fi
    local wait_file="/tmp/$USER-waitfor/wait-$1.pid"
    if [ ! -e "$wait_file" ] ; then
	print "No one waiting on $1"
	return 1
    fi

    local pid=$(cat "$wait_file")
    if [ $? -eq 0 ] ; then
	print $wait_result > ${wait_file}.result
	kill -USR1 $pid
    fi
}
