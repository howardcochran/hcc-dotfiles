
# Do a find, pruning any directory tree called tmp. This is useful
# for finding stuff in a bitbake / Yocto workspaces, while skipping build
# output, which would be slow to search. e.g. build output is typically found
# in poky/build/tmp within a poky workspace.
# For convenience, we include -iname, so the first argument should be a
# filename pattern trying to find, but since we use "$@", you can append other
# find conditionals, e.g.:
# findnotmp "recipes" -type d
# The -print on the end of this command, somewhat counter-intuitively,
# suppresses the print of the pruned directory names.
function findnotmp () {
    find . -path '*/tmp' -prune -o -iname "$@" -print
}

# Not 100% accurate since directory has already been given, but works well
# enough to complete options after typing -
compdef _find findnotmp
