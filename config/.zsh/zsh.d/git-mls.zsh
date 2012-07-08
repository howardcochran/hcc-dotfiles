
_git-mls-commands () {
    local -a commands

    commands=(
	'branch:fetch a new MLS branch'
	'clone:clone a new repository'
	'fetch:retrive new revisions'
	'metadata:update git-mls metadata'
	'push:upload local revisions'
	'relreq:create a release request branch'
	'url:show the git url for a given repo'
	"version:print git-mls's version"
    )

    _describe -t commands 'git-mls command' commands && ret=0
}

_git-mls-repos () {
    codelines=( `git-mls helper` )
    compadd - "${codelines[@]}"
}

_git-mls-branches () {
    codelines=( `git-mls helper branches` )
    compadd - "${codelines[@]}"
}

_git-mls-local-branches () {
    branches=( `git-mls branch | gawk '/\w+\s+/{print $1}'` )
    compadd - "${branches[@]}"
}

_git-mls-branch () {
    _arguments \
	'-d[delete a branch]:local branch:_git-mls-local-branches' \
	'*:codeline:_git-mls-branches' && ret=0
}

_git-mls-clone () {
    _arguments \
	'*:codeline:_git-mls-repos' && ret=0
}

_git-mls () {
    if (( CURRENT == 2 )); then
	_git-mls-commands
    else
	shift words
	(( CURRENT-- ))
	curcontext="${curcontext%:*:*}:git-mls-$words[1]:"
	_call_function ret _git-mls-$words[1]
    fi
}

compdef _git-mls git-mls
