function complete-mls-target () {
	if [ ! -e bconfig ] ; then
	    return
	fi

	targets=( bconfig/*_dbg.target )
	for i in "${targets[@]}" ; do
	    compadd -- $(echo $i | sed -e 's/bconfig\/\(.*\).target/\1/')
	done
}

function _mh-commands () {
    local -a commands

    commands=(
	'populate:create a target directory appropriate to this workspace'
	'bldtarget:create a target and remake/rebuild flash'
	'makedotkernel:create a .kernel file appropriate to this workspace'
	'rebuild:rebuild units and their dependencies'
    )

    _describe -t commands 'mh command' commands && ret=0
}

_mh-bldtarget () {
    if (( CURRENT > 2 )); then
	return
    fi
    complete-mls-target
}

_mh-populate () {
    if (( CURRENT > 2 )); then
	return
    fi
    complete-mls-target
}

_mh-rebuild () {
    targets=( `find . -mindepth 2 -name "*.mak"` )
    for i in "${targets[@]}" ; do
	compadd -- $(basename $i | sed -e 's/.mak//')
    done
}

_mh () {
    if (( CURRENT == 2 )); then
	_mh-commands
    else
	shift words
	(( CURRENT-- ))
	curcontext="${curcontext%:*:*}:mh-$words[1]:"
	_call_function ret _mh-$words[1]
    fi
}

compdef _mh mls-helper
