#!/bin/zsh

function waitfor {
    if [ $# -ne 1 ] ; then print "Usage: waitfor identifier" ; return 1 ; fi
    mkdir -p /tmp/$USER-waitfor
    local wait_file="/tmp/$USER-waitfor/wait-$1.pid"
    if [ -e "$wait_file" ] ; then
	print "Wait file already exists: $wait_file"
	return 1
    fi

    sleep 1000000 &
    local pid=$!
    echo $pid > "$wait_file"
    wait $pid

    # Read result from file. If not found, make result be 1
    result=$(cat ${wait_file}.result)
    [ $? -eq 0 ] || result=1

    \rm -f "$wait_file" "${wait_file}.result"
    return $result
}
