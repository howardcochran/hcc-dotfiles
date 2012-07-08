__ebo_command_list=(
    'bldtarget:set up a target directory'
    'build:build code'
    'check:sanity check the workspace to see if source & targets match'
    'fetch:fetch source'
    'getws:get a new fwb workspace'
    'help:get help for supported commands'
    'list:show info about URLs, units, targets, etc'
    'rmtarget:remove the given target'
    'rmtargets:remove all targets'
    'update:update the source to a specified revision'
    'ongoing:show ongoing build status'
    'version:show version info for ebo & lxkbb'
    'shell:launch a shell in a workdir'
    'linksrc:link in unit source from your local source dir'
    'hidelinks:hide any ebo-created source symlinks'
    'showlinks:show any previously-hidden source symlinks')

__compadd_targets()
{
    local targets
    targets=(gconfig/targets/*.target)

    for i in "${targets[@]}" ; do
        compadd -- $(echo $i | sed -e 's/gconfig\/targets\/\(.*\).target/\1/')
    done
}

__compadd_units()
{
    local units
    units=(`find units -maxdepth 3 -name "*.bb" -printf '%f '`)

    for i in "${units[@]}" ; do
        compadd -- $(echo $i | sed -e 's/\.bb//')
    done
}

_ebo() 
{
    local curcontext=$curcontext ret=1

    if [[ $words[1] == ebo ]]; then
        if (( CURRENT == 2 )); then
            _describe -t __ebo_command_list 'ebo command' __ebo_command_list && ret=0
        else
            shift words
            (( CURRENT-- ))
            curcontext="${curcontext%:*:*}:ebo-$words[1]:"
            _call_function ret _ebo_$words[1]
        fi
    else
        _call_function ret _$words[1]
    fi
}

_ebo_update()
{
    if (( CURRENT == 2 )); then
        local -a revs
        revs=(
            'DAILY:the daily snapshot'
            'HEAD:most recent revision'
            '<rev>:a specific revision')

        _describe -t revs 'ebo update revs' revs && ret=0
    elif (( CURRENT == 3 )); then
        __compadd_targets
    fi
}

_ebo_bldtarget() 
{
    __compadd_targets
}


_ebo_help() 
{
    local -a commands

    commands=(
        'URLs:show known fwb URLs'
        'units:show all known fwb units'
        'targets:show all build targets'
        'local-src:show all local source')

    _describe -t __ebo_command_list 'ebo help command' __ebo_command_list && ret=0
}

_ebo_list() 
{
    local -a commands

    commands=(
        'URLs:show known fwb URLs'
        'units:show all known fwb units'
        'targets:show all build targets'
        'local-src:show all local source')

    _describe -t commands 'ebo list command' commands && ret=0
}

_ebo_build() 
{
    if (( CURRENT == 2 )); then
        __compadd_units
    elif (( CURRENT == 3 )); then
        local targets
        targets=(compat/build/*)

        for i in "${targets[@]}" ; do
            compadd -- $(echo $i | sed -e 's/compat\/build\/\(.*\)-ix86.*/\1/')
        done
    fi
}

compdef _ebo ebo

