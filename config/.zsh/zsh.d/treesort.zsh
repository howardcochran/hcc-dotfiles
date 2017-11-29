# Internal function to short a full tree of files with the find format
# string (and thus the sort criteria) parameterized.
function __treesort() {
	set -x
	local fmt="$1"
	shift
	local reverse_arg=
	if [ x"$1" = x'-r' ] ; then
		reverse_arg="$1"
		shift
	fi
	find "$@" -type f -printf "${fmt}"| sort -n $reverse_arg
}

# List all the files in the given directory tree(s), sorted by
# modification date. Default oldest to newest, because having the most
# recent files at the end of the output us usually more convenient,
# especially when not piped through a pager.
# Use -r to reverse the order (must be first arg)
function treedate() {
	__treesort "%T@ %u %g %Cc %k %p\n" "$@"
}

# List all the files in the given directory tree(s), sorted by
# size. Default smallest to largest, because having the largest
# files at the end of the output us usually more convenient,
# especially when not piped through a pager.
# Use -r to reverse the order (must be first arg)
function treesize() {
	__treesort "%s %u %g %Cc %k %p\n" "$@"
}

compdef _find treedate treesize
