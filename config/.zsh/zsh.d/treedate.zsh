
# List all the files in the given directory tree(s), sorted by
# modification date. Oldest to newest, because having the most
# recent files at the end of the output us usually more convenient,
# especially when not piped through a pager.
function treedate() {
	find "$@" -type f -printf "%T@ %u %g %Cc %k %p\n"| sort -n
}

