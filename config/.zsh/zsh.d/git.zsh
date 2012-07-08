compdef _git git git-apply git-checkout-index git-commit-tree git-hash-object git-index-pack git-init-db git-merge-index git-mktag git-pack-objects git-prune-packed git-read-tree git-unpack-objects git-update-index git-write-tree git-cat-file git-diff-index git-diff-files git-diff-stages git-diff-tree git-fsck-objects git-ls-files git-ls-tree git-merge-base git-name-rev git-rev-list git-show-index git-tar-tree git-unpack-file git-var git-verify-pack git-clone-pack git-fetch-pack git-http-fetch git-local-fetch git-peek-remote git-receive-pack git-send-pack git-ssh-fetch git-ssh-upload git-update-server-info git-upload-pack git-add git-am git-applymbox git-bisect git-branch git-checkout git-cherry-pick git-clone git-commit git-diff git-fetch git-format-patch git-grep git-log git-ls-remote git-merge git-mv git-octopus git-pull git-push git-rebase git-repack git-reset git-resolve git-revert git-shortlog git-show-branch git-status git-verify-tag git-whatchanged git-applypatch git-archimport git-convert-objects git-cvsimport git-lost-found git-merge-one-file git-prune git-relink git-svnimport git-symbolic-ref git-tag git-update-ref git-check-ref-format git-cherry git-count-objects git-daemon git-get-tar-commit-id git-mailinfo git-mailsplit git-patch-id git-request-pull git-send-email git-stripspace

# Commands not completed:
# git-sh-setup
# git-shell
# git-parse-remote 
# git-rev-parse 

# TODO: most commands need a valid git repository to run, so add a check for it
# so that we can make our handling a little bit cleaner (need to deal with
# GIT_DIR=... stuff as pre-command modifier)

# TODO: suggested zstyles:
#
# zstyle ':completion::*:git-{name-rev,add,rm}:*' ignore-line true

typeset -g nul_arg=

nul_arg='-z[use NUL termination on output]'

typeset -ga diff_args

# TODO: -s and --diff-filter are undocumented
diff_args=(
  '--diff-filter=-[filter to apply to diff]'
  '--find-copies-harder[try harder to find copies]'
  '--name-only[show only names of changed files]'
  '--name-status[show only names and status of changed files]'
  '--pickaxe-all[when -S finds a change, show all changes in that changeset]'
  '-B-[break complete rewrite changes into pairs of given size]: :_guard "[[\:digit\:]]#" size'
  '-C-[detect copies as well as renames with given score]: :_guard "[[\:digit\:]]#" size'
  '-l-[number of rename/copy targets to run]: :_guard "[[\:digit\:]]#" number'
  '-M-[detect renames with given score]: :_guard "[[\:digit\:]]#" size'
  '-O-[output patch in the order of glob-pattern lines in given file]:file:_files'
  '-p[generate diff in patch format]'
  '-R[do a reverse diff]'
  '-S-[look for differences that contain the given string]:string'
  '-s[do not produce any output]'
  '-u[synonym for -p]'
  $nul_arg
)

typeset -g pretty_arg=
pretty_arg='--pretty=-[pretty print commit messages]::pretty print:((raw\:"the raw commits"
                                                                     medium\:"most parts of the messages"
                                                                     short\:"few headers and only subject of messages"
                                                                     full\:"all parts of the commit messages"
                                                                     oneline\:"commit-ids and subject of messages"))'

typeset -g exec_arg=
exec_arg='--exec=-[specify path to git-upload-pack on remote side]:remote path'

typeset -ga fetch_args

fetch_args=(
  '-a[fetch all objects]'
  '-c[fetch commit objects]'
  '--recover[recover from a failed fetch]'
  '-t[fetch trees associated with commit objects]'
  '-v[show what is downloaded]'
  '-w[write out the given commit-id to the given file]:new file'
)

revlist_args=(
  '--all[show all commits from refs]' \
  '--bisect[show only the middlemost commit object]' \
  '(--sparse)--dense[this is the inverse of --sparse, and is also the default]' \
  '(--pretty)--header[show commit headers]' \
  '--objects[show object ids of objects referenced by the listed commits]' \
  '--max-age[maximum age of commits to output]: :_guard "[[\:digit\:]]#" number' \
  '--max-count[maximum number of commits to output]: :_guard "[[\:digit\:]]#" timestamp' \
  '(--topo-order)--merge-order[decompose into minimal and maximal epochs]' \
  '--min-age[minimum age of commits to output]: :_guard "[[\:digit\:]]#" timestamp' \
  '--parents[show parent commits]' \
  '(--header)'$pretty_arg \
  '(--dense)--sparse[when paths are given, output only commits that changes any of them]' \
  '(--merge-order)--topo-order[show commits in topological order]' \
  $show_breaks \
  '--unpacked[show only unpacked commits]'
)

typeset -ga merge_strategy

merge_strategy=(
  '(-s --strategy)'{-s,--strategy=}'[use given merge strategy]:strategy:(octopus recursive resolve stupid)')

typeset -ga force_ref_arg

force_ref_arg=('(-f --force)'{-f,--force}'[allow refs that are not ancestors to be updated]')

typeset -ga tags_fetch_arg

tags_fetch_arg=('(-t --tags)'{-t,--tags}'[fetch remote tags]')

# TODO: either skip uninteresting commands or skip the description - the list
# is just too long
_git_commands () {
  local -a commands

  commands=(
    'add:add paths to the index'
    'annotate:show line-by-line file history'
    'am:apply patches from a mailbox (cooler than applymbox)'
    'apply:apply patch on a git index file and a work tree'
    'applymbox:apply patches from a mailbox'
    'applypatch:apply one patch extracted from an e-mail'
    'archimport:import an Arch repository into git'
    'bisect:find the change that introduced a bug'
    'blame:alias for annotate'
    'branch:create and show branches'
    'checkout:checkout and switch to a branch'
    'cherry-pick:cherry-pick the effect of an existing commit'
    'clone:clones a repository into a new directory'
    'commit:record changes to the repository'
    'cvsimport:import a CVS "repository" into a git repository'
    'diff:show changes between commits, commit and working tree, etc.'
    'fetch:download objects and a head from another repository'
    'format-patch:prepare patches for e-mail submission'
    'fsck-objects:verifies the connectivity and validity of the objects in the database'
    'grep:print lines matching a pattern'
    'log:shows commit logs'
    'lost-found:recovers lost references that luckily have not yet been pruned'
    'ls-files:information about files in the index/working directory'
    'mailinfo:extracts patch from a single e-mail message'
    'mailsplit:splits an mbox file into a list of files'
    'merge:grand unified merge driver'
    'mv:moves or renames a file, directory, or symlink'
    'prune:prunes all unreachable objects from the object database'
    'pull:fetch from and merge with a remote repository'
    'push:update remote refs along with associated objects'
    'rebase:rebases local commits to new upstream head'
    'repack:packs unpacked objects in a repository'
    'reset:resets current HEAD to the specified state'
    'revert:reverts an existing commit'
    'send-email:sends patch-e-mails out of "format-patch --mbox" output'
    'shortlog:summarizes git log output'
    "status:shows the working-tree's status"
    'svnimport:imports a SVN repository into git'
    'tag:creates a tag object signed with GPG'
    'whatchanged:shows commit-logs and differences they introduce')

  _describe -t commands 'git command' commands && ret=0
}

_git () {
    # TODO: this needs to be cleaned up and fixed
    local curcontext=$curcontext ret=1

    if [[ $words[1] == git ]]; then
      if (( CURRENT == 2 )); then
	_git_commands
      else
	shift words
	(( CURRENT-- ))
	curcontext="${curcontext%:*:*}:git-$words[1]:"
	_call_function ret _git-$words[1]
      fi
    else
      _call_function ret _$words[1]
    fi
}

_git-apply () {
  _arguments \
    $nul_arg \
    '*--apply[apply patches that would otherwise not be applied]' \
    '*--check[check if patches are applicable]' \
    '*--exclude=-[skip files matching specified pattern]:file pattern' \
    '*--index[make sure that the patch is applicable to the index]' \
    '*--index-info[output information about original version of a blob if available]' \
    '*--no-merge[do not use merge behavior]' \
    '*--numstat[same as --stat but in decimal notation and complete pathnames]' \
    '*--stat[output diffstat for the input]' \
    '*--summary[output summary of git-diff extended headers]' \
    '*:file:_files' && ret=0
}

_git-checkout-index () {
  _arguments -S \
    '(-a --all :)'{-a,--all}'[check out all files in the index]' \
    '(-f --force)'{-f,--force}'[force overwrite of existing files]' \
    '(-n --no-create)'{-n,--no-create}'[do not checkout new files]' \
    '(-q --quiet)'{-q,--quiet}'[do not complain about existing files or missing files]' \
    '(-u --index)'{-u,--index}'[update stat information in index]' \
    '--prefix=-[prefix to use when creating files]:directory:_directories' \
    '*:file:_files' && ret=0
}

_git-commit-tree () {
  if (( CURRENT == 2 )); then
    __git_trees && ret=0
  elif [[ $words[CURRENT-1] == -p ]]; then
    local expl
    _description commits expl 'parent commit'
    __git_objects $expl && ret=0
  else
    compadd - '-p'
  fi
}

_git-hash-object () {
  _arguments \
    '-t[the type of object to create]:object type:((blob\:"a blob of data"
                                                    commit\:"a tree with parent commits"
                                                    tag\:"a symbolic name for another object"
                                                    tree\:"a recursive tree of blobs"))' \
    '-w[write the object to the object database]' \
    ':file:_files' && ret=0
}

_git-index-pack () {
  _arguments \
    '-o[write generated pack index into specified file]' \
    ':pack file:_files -g "*.pack"' && ret=0
}

_git-init-db () {
  _arguments \
    '--template=-[directory to use as a template for the object database]:directory:_directories' && ret=0
}

_git-merge-index () {
  if (( CURRENT > 2 )) && [[ $words[CURRENT-1] != -[oq] ]]; then
    _arguments -S \
      '(:)-a[run merge against all files in the index that need merging]' \
      '*:index file:__git_files' && ret=0
  else
    typeset -a arguments

    (( CURRENT == 2 )) && arguments+='-o[skip failed merges]'
    (( CURRENT == 2 || CURRENT == 3 )) && arguments+='(-o)-q[do not complain about failed merges]'
    (( 2 <= CURRENT && CURRENT <= 4 )) && arguments+='*:merge program:_files -g "*(*)"'

    _arguments -S $arguments && ret=0
  fi
}

_git-mktag () {
  _message 'no arguments allowed; only accepts tags on standard input'
}

_git-pack-objects () {
  _arguments \
    '--depth=-[maximum delta depth]' \
    '--incremental[ignore objects that have already been packed]' \
    '--non-empty[only create a package if it contains at least one object]' \
    '--local[similar to --incremental, but only ignore unpacked non-local objects]' \
    '--window=-[number of objects to use per delta compression]' \
    '(:)--stdout[write the pack to standard output]' \
    ':base-name:_files' && ret=0
}

_git-prune-packed () {
  _arguments \
    '-n[only list the objects that would be removed]' && ret=0
}

_git-read-tree () {
  if (( CURRENT == 2 )); then
    _arguments \
      '--reset[perform a merge, not just a read, ignoring unmerged entries]' \
      '--trivial[only perform trivial merges]' \
      '-m[perform a merge, not just a read]' \
      ':tree-ish:__git_tree_ishs' && ret=0
  elif [[ $words[2] == (-m|--reset) ]]; then
    _arguments \
      '-i[update only the index; ignore changes in work tree]' \
      '-u[update the work tree after successful merge]' \
      '2:first tree-ish to be read/merged:__git_tree_ishs' \
      '3:second tree-ish to be read/merged:__git_tree_ishs' \
      '4:third tree-ish to be read/merged:__git_tree_ishs' && ret=0
  else
    _message 'no more arguments'
  fi
}

_git-unpack-objects () {
  _arguments \
    '-n[only list the objects that would be unpacked]' \
    '-q[run quietly]' && ret=0
}

_git-update-index () {
  local -a refreshables

  if (( $words[(I)--refresh] )); then
    refreshables=(
      '--ignore-missing[ignore missing files when refreshing the index]'
      '--unmerged[if unmerged changes exists, ignore them instead of exiting]'
      '-q[run quietly]')
  fi

  _arguments -S \
    $refreshables \
    '--add[add files not already in the index]' \
    '--cacheinfo[insert information directly into the cache]: :_guard "[0-7]#" "octal file mode": :_guard "[[\:xdigit\:]]#" "object id":file:_files' \
    '--chmod=-[set the execute permissions on the updated files]:permission:((-x\:executable +x\:"not executable"))' \
    '(--remove)--force-remove[remove files from both work tree and the index]' \
    '--index-info[read index information from stdin.]' \
    '--info-only[only insert files object-IDs into index]' \
    '--refresh[refresh the index]' \
    '(--force-remove)--remove[remove files that are in the index but are missing from the work tree]' \
    '--replace[replace files already in the index if necessary]' \
    '--stdin[read list of paths from standard input]' \
    '--verbose[report what is being added and removed from the index]' \
    '-z[paths are separated with NUL instead of LF for --stdin]' \
    '*:file:_files' && ret=0
}

_git-write-tree () {
  _arguments \
    '--missing-ok[ignore objects in the index that are missing in the object database]' && ret=0
}

_git-cat-file () {
  if (( CURRENT == 2 )); then
    _arguments \
      '-t[show the type of the given object]' \
      '-s[show the size of the given object]' \
      '*: :_values "object type" blob commit tag tree' && ret=0
  elif (( CURRENT == 3 )); then
    __git_objects && ret=0
  else
    _message 'no more arguments'
  fi
}

_git-diff-index () {
  _arguments -S \
    $diff_args \
    '--cached[do not consider the work tree at all]' \
    '-m[flag non-checked-out files as up-to-date]' \
    ':tree-ish:__git_tree_ishs' \
    '*:index file:__git_files' && ret=0
}

_git-diff-files () {
  _arguments \
    $diff_args \
    '-q[do not complain about nonexisting files]' \
    '*:file:_files' && ret=0
}

_git-diff-stages () {
  _arguments \
    $diff_args \
    ':stage 1:__git_stages' \
    ':stage 2:__git_stages' \
    '*:index file:__git_files' && ret=0
}

_git-diff-tree () {
  local curcontext=$curcontext state line
  typeset -A opt_args

  _arguments -S \
    $diff_args \
    $pretty_arg \
    '--no-commit-id[skip output of commit IDs]' \
    '--root[show diff against the empty tree]' \
    '--stdin[read commit and tree information from standard input]' \
    '-m[show merge commits]' \
    '-r[recurse into subdirectories]' \
    '(-r)-t[show tree entry itself as well as subtrees (implies -r)]' \
    '-v[show verbose headers]' \
    ':tree-ish:__git_tree_ishs' \
    '*::file:->files' && ret=0

  case $state in
    files)
      if (( $#line > 2 )); then
        # TODO: this is probably just stupid to do.
        # What'd be nice would be
        # common files:
        #   ...
        # original tree:
        #   ...
        # new tree:
        #   ...
        _alternative \
          "original tree:original tree:__git_tree_files $line[1]" \
          "new tree:new tree:__git_tree_files $line[2]" && ret=0
      else
        _alternative \
          ': :__git_tree_ishs' \
          ": :__git_tree_files $line[1]" && ret=0
      fi
      ;;
  esac
}

_git-fsck-objects () {
  _arguments -S \
    '--cache[consider objects recorded in the index as head nodes for reachability traces]' \
    '(--standalone)--full[check all object directories]' \
    '--root[show root nodes]' \
    '(--full)--standalone[check only the current object directory]' \
    '--strict[do strict checking]' \
    '--tags[show tags]' \
    '--unreachable[show objects that are unreferenced in the object database]' \
    '*:object:__git_objects' && ret=0
}

_git-ls-files () {
  _arguments -S \
    $nul_arg \
    '(-c --cached)'{-c,--cached}'[show cached files in the output]' \
    '(-d --deleted)'{-d,--deleted}'[show deleted files in the output]' \
    '(-i --ignored)'{-i,--ignored}'[show ignored files in the output]' \
    '(-k --killed)'{-k,--killed}'[show killed files in the output]' \
    '(-m --modified)'{-m,--modified}'[show modified files in the output]' \
    '(-o --others)'{-o,--others}'[show other files in the output]' \
    '(-s --stage)'{-s,--stage}'[show stage files in the output]' \
    '-t[identify each files status]' \
    '(-u --unmerged)'{-u,--unmerged}'[show unmerged files in the output]' \
    '*'{-x,--exclude=-}'[skip files matching given pattern]:file pattern' \
    '*'{-X,--exclude-from=-}'[skip files matching patterns in given file]:file:_files' \
    '*--exclude-per-directory=-[skip directories matching patterns in given file]:file:_files' \
    '*:index file:__git_files' && ret=0
}

_git-ls-tree () {
  local curcontext=$curcontext state line
  typeset -A opt_args

  _arguments \
    $nul_arg \
    '-d[do not show children of given tree]' \
    '-r[recurse into subdirectories]' \
    ':tree-ish:__git_tree_ishs' \
    '*:tree file:->files' && ret=0

  case $state in
    files)
      __git_tree_files $line[1] && ret=0
      ;;
  esac
}

_git-merge-base () {
  _arguments \
    '(-a --all)'{-a,--all}'[show all common ancestors]' \
    ':commit 1:__git_commits' \
    ':commit 2:__git_commits' && ret=0
}

_git-name-rev () {
  _arguments -S \
    '--tags[only use tags to name the commits]' \
    '(--stdin :)--all[list all commits reachable from all refs]' \
    '(--all :)--stdin[read from stdin and append revision-name]' \
    '(--stdin --all)*:commit-ish:__git_revisions' && ret=0
}

# TODO: --no-merges undocumented
_git-rev-list () {
  if (( $words[(I)--] && $words[(I)--] != CURRENT )); then
    _arguments \
      '*:index file:__git_files' && ret=0
  else
    local show_breaks

    (( $words[(I)--merge-order] )) && show_breaks='--show-breaks[show commit prefixes]'
    _arguments -S \
      $revlist_args \
      '*:commit id:__git_commits2' && ret=0
  fi
}

_git-show-index () {
  _message 'no arguments allowed; accepts index file on standard input'
}

_git-tar-tree () {
  _arguments \
    ':tree-ish:__git_tree_ishs' \
    ':base-name:_files' && ret=0
}

_git-unpack-file () {
  _arguments \
    ':blob id:__git_blobs' && ret=0
}

_git-var () {
  _arguments \
    '(:)-l[show logical variables]' \
    '(-):variable:((GIT_AUTHOR_IDENT\:"name and email of the author" \
                    GIT_COMMITTER_IDENT\:"name and email of committer"))' && ret=0
}

_git-verify-pack () {
  _arguments -S \
    '-v[show objects contained in pack]' \
    '*:index file:_files -g "*.idx"' && ret=0
}
 
__git-clone_or_fetch-pack () {
  _arguments \
    $exec_arg \
    ':remote repository:__git_remote_repository' \
    '*:head:__git_heads' && ret=0
}

_git-clone-pack () {
  __git-clone_or_fetch-pack
}

_git-fetch-pack () {
  __git-clone_or_fetch-pack
}

# TODO: __git_commits appropriate here?  Probably not, as this should be a
# remote commit, but perhaps good enough?
__git-http_or_ssh-fetch () {
  _arguments \
    $fetch_args \
    ':commit id:__git_commits' \
    ':URL:_urls' && ret=0
}

_git-http-fetch () {
  __git-http_or_ssh-fetch
}

_git-local-fetch () {
  _arguments \
    $fetch_args \
    '-l[hard-link objects]' \
    '-n[do not copy objects]' \
    '-s[sym-link objects]' \
    ':commit id:__git_commits' \
    ':directory:_directories' && ret=0
}

_git-peek-remote () {
  _arguments \
    $exec_arg \
    ':remote repository:__git_remote_repository' && ret=0
}

_git-receive-pack () {
  _arguments \
    ':directory:_directories' && ret=0
}

_git-send-pack () {
  _arguments \
    $exec_arg \
    '--all[update all refs that exist locally]' \
    '--force[update remote orphaned refs]' \
    ':remote repository:__git_remote_repository' \
    '*:remote refs' && ret=0
}

# TODO: git-shell, but that's only invoked by other git commands.

_git-ssh-fetch () {
  __git-http_or_ssh-fetch
}

_git-ssh-upload () {
  __git-http_or_ssh-fetch
}

_git-update-server-info () {
  _arguments \
    '(-f --force)'{-f,--force}'[update the info files from scratch]'
}

_git-upload-pack () {
  _arguments \
    ':directory:_directories' && ret=0
}

_git-add () {
  _arguments \
    '-n[do not actually add files; only show which ones would be added]' \
    '-v[show files as they are added]' \
    '*:file:_files -g "*(^e:__git_is_indexed:)"' && ret=0
}

_git-am () {
  _arguments \
    '--3way[use 3-way merge if patch does not apply cleanly]' \
    '--dotest=-[use given directory as working area instead of .dotest]:directory:_directories' \
    '--interactive[apply patches interactively]' \
    '--keep[do not modify Subject: header]' \
    '--signoff[add Signed-off-by: line to the commit message]' \
    '--skip[skip the current patch]' \
    '--utf8[encode commit information in UTF-8]' \
    '*:mbox file:_files' && ret=0
}

_git-applymbox () {
  _arguments \
    '-k[do not modify Subject: header]' \
    '-m[apply patches with git-apply and fail if patch is unclean]' \
    '-q[apply patches interactively]' \
    '-u[encode commit information in UTF-8]' \
    '(1)-c[restart command after fixing an unclean patch]:patch:_files -g ".dotest/0*"' \
    ':mbox file:_files' \
    '::signoff file:__git_signoff_file' && ret=0
}

_git-bisect () {
  local bisect_cmds

  bisect_cmds=(
    bad:"mark current or given revision as bad"
    good:"mark current or given revision as good"
    log:"show the log of the current bisection"
    next:"find next bisection to test and check it out"
    replay:"replay a bisection log"
    reset:"finish bisection search and return to the given branch (or master)"
    start:"reset bisection state and start a new bisection"
    visualize:"show the remaining revisions in gitk"
  )

  if (( CURRENT == 2 )); then
    _describe -t command "git-bisect commands" bisect_cmds && ret=0
  else
    case $words[2] in
      (bad)
        _arguments \
          '2:revision:__git_commits' && ret=0
        ;;
      (good)
        _arguments \
          '*:revision:__git_commits' && ret=0
        ;;
      (replay)
        _arguments \
          '2:file:_files' && ret=0
        ;;
      (reset)
        _arguments \
          '2:branch:__git_heads' && ret=0
        ;;
      (*)
        _nothing
        ;;
    esac
  fi
}

_git-branch () {
  _arguments \
    '(-D)-d[delete a branch, which must be fully merged]' \
    '(-d)-D[delete a branch]' \
    ':branch-name' \
    ':base branch:__git_revisions' && ret=0
}

_git-checkout () {
  _arguments \
    '-f[force a complete re-read]' \
    '-b[create a new branch based at given branch]:branch-name' \
    ':branch:__git_revisions' \
    '*:file:_files' && ret=0
}

_git-cherry-pick () {
  _arguments \
    '(-n --no-commit)'{-n,--no-commit}'[do not make the actually commit]' \
    '(-r --replay)'{-r,--replay}'[use the original commit message intact]' \
    ':commit:__git_revisions' && ret=0
}

_git-clone () {
  local -a shared

  if (( $words[(I)(-l|--local)] )); then
    shared=('(-s --shared)'{-s,--shared}'[share the objects with the source repository]')
  fi

  _arguments \
    '(-l --local)'{-l,--local}'[perform a local cloning of a repository]' \
    $shared
    '(-q --quiet)'{-q,--quiet}'[operate quietly]' \
    '-n[do not checkout HEAD after clone is complete]' \
    '(-u --upload-pack)'{-u,--uploadpack}'[specify path to git-upload-pack on remote side]:remote path' \
    ':repository:__git_any_repositories' \
    ':directory:_directories' && ret=0
}

_git-commit () {
  _arguments -S \
    '(-a --all)'{-a,--all}'[update all paths in the index file]' \
    '(-s --signoff)'{-s,--signoff}'[add Signed-off-by line at the end of the commit message]' \
    '(-v --verify -n --no-verify)'{-v,--verify}'[look for suspicious lines the commit introduces]' \
    '(-n --no-verify -v --verify)'{-n,--no-verify}'[do not look for suspicious lines the commit introduces]' \
    '(-e --edit)'{-e,--edit}'[edit the commit message before committing]' \
    '*:file:_files' \
    - '(message)' \
      '(-c -C --reedit-message --reuse-message)'{-c,--reedit-message=}'[use existing commit object and edit log message]:commit id:__git_commits' \
      '(-c -C --reedit-message --reuse-message)'{-C,--reuse-message=}'[use existing commit object with same log message]:commit id:__git_commits' \
      '(-F --file)'{-F,--file=}'[read commit message from given file]:file:_files' \
      '(-m --message)'{-m,--message=}'[use the given message as the commit message]:message' && ret=0
}

# TODO: __git_files should be __git_tree_files (do like in git-diff-tree and
# such)
_git-diff () {
  _arguments \
    $diff_args \
    '::original revision:__git_revisions' \
    '*:index file:_files' && ret=0
}

_git-fetch () {
  _arguments \
    '(-a --append)'{-a,--append}'[append fetched refs instead of overwriting]' \
    $force_ref_arg \
    $tags_fetch_arg \
    '(-u --update-head-ok)'{-u,--update-head-ok}'[allow updates of current branch head]' \
    ':repository:__git_any_repositories' \
    '*:refspec:__git_ref_specs' && ret=0
}

# TODO: should support R1..R2 syntax
_git-format-patch () {
  _arguments \
    '(-a --author)'{-a,--author}'[output From: header for your own commits as well]' \
    '(-d --date)'{-d,--date}'[output Date: header for your own commits as well]' \
    '(-h --help)'{-h,--help}'[display usage information]' \
    '(-k --keep-subject)'{-k,--keep-subject}'[do not strip/add \[PATCH\] from the first line of the commit message]' \
    '(-m --mbox)'{-m,--mbox}'[use true mbox formatted output]' \
    '(-n --numbered)'{-n,--numbered}'[name output in \[PATCH n/m\] format]' \
    '(-o --output-directory --stdout)'{-o,--output-directory}'[store resulting files in given directory]:directory:_directories' \
    '(-o --output-directory --mbox)--stdout[output the generated mbox on standard output (implies --mbox)]' \
    ':their revision:__git_revisions' \
    '::my revision:__git_revisions' && ret=0
}

# TODO: something better
_git-grep () {
  service=grep _grep
  ret=0
}

# TODO: this isn't strictly right, but close enough
_git-log () {
  _arguments \
    $revlist_args \
    ':commit id:__git_commits2' \
    '*:file:_files' && ret=0
}

# TODO: repository needs fixing
_git-ls-remote () {
  _arguments \
    '(-h --heads)'{-h,--heads}'[show only refs under refs/heads]' \
    '(-t --tags)'{-t,--tags}'[show only refs under refs/tags]' \
    ':repository:__git_any_repositories' \
    '*: :__git_references' && ret=0
}

_git-merge () {
  _arguments \
    '(-n --no-summary)'{-n,--no-summary}'[do not show diffstat at end of merge]' \
    $merge_strategy \
    ':merge message' \
    ':head:__git_revisions' \
    '*:remote:__git_revisions' && ret=0
}

_git-mv () {
  _arguments \
    '-f[force renaming/moving even if targets exist]' \
    '-k[skip move/renames that would lead to errors]' \
    '-n[only show what would happen]' \
    '*:index file:__git_files' && ret=0
}

_git-octupus () {
  _nothing
}

_git-pull () {
  _arguments \
    $merge_strategy \
    $force_ref_arg \
    $tags_fetch_arg \
    '(-a --append)'{-a,--append}'[append ref-names and object-names to .git/FETCH_HEAD]' \
    '--no-commit[do not commit the merge]' \
    '(-n --no-summary)'{-n,--no-summary}'[do not show diffstate at end of merge]' \
    '(-u,--update-head-ok)'{-u,--update-head-ok}'[allow updating of head to current branch]' \
    ':repository:__git_any_repositories' \
    '*:refspec:__git_ref_specs' && ret=0
}

_git-push () {
  _arguments \
    $force_ref_arg \
    '--all[fetch all refs]' \
    ':repository:__git_any_repositories' \
    '*:refspec:__git_ref_specs' && ret=0
}

_git-rebase () {
  _arguments \
    ':upstream branch:__git_revisions' \
    '::working branch:__git_revisions' && ret=0
}

_git-repack () {
  _arguments \
    '-a[pack all objects into a single pack]' \
    '-d[remove redundant packs after packing]' \
    '-l[ignore unpacked non-local objects]' \
    '-n[do not update server information]' && ret=0
}

_git-reset () {
  _arguments \
    '(        --soft --hard)--mixed[like --soft but report what has not been updated (default)]' \
    '(--mixed        --hard)--soft[do not touch the index file nor the working tree]' \
    '(--mixed --soft       )--hard[match the working tree and index to the given tree]' \
    ':commit-ish:__git_revisions' && ret=0
}

_git-resolve () {
  _arguments \
    ':current commit:__git_revisions' \
    ':merged commit:__git_revisions' \
    ':commit message'
}

_git-revert () {
  _arguments \
    '(-n --no-commit)'{-n,--no-commit}'[do not commit the reversion]'
    '(-r --replay)'{-r,--replay}'[use the original commit message intact]' \
    ':commit:__git_revisions' && ret=0
}

_git-shortlog () {
  _nothing
}

_git-show-branch () {
  _arguments \
    '--all[show all refs under $GIT_DIR/refs]' \
    '--heads[show all refs under $GIT_DIR/refs/heads]' \
    '--independent[show only the reference that can not be reached from any of the other]' \
    '--list[do not display any commit ancestry]' \
    '--merge-base[act like "git-merge-base -a" but with two heads]' \
    '--more=-[go given number of commit beyond common ancestor (no ancestry if negative)]:number' \
    '--no-name[do not show naming strings for each commit]' \
    '--sha1-name[name commits with unique prefix of object names]' \
    '--topo-order[show commits in topological order]' \
    '--tags[show all refs under $GIT_DIR/refs/tags]' \
    '*:reference:__git_revisions' && ret=0
}

_git-status () {
  _nothing
}

_git-verify-tag () {
  _arguments \
    ':tag:__git_tag_ids' && ret=0
}

# TODO: this should be a combination of git-rev-list and git-diff-tree
_git-whatchanged () {
}

_git-applypatch () {
  _arguments \
    ':message file:_files' \
    ':patch file:_files' \
    ':info file:_files' \
    '::signoff file:_files' && ret=0
}

# TODO: archive/branch can use _arch_archives perhaps?
_git-archimport () {
  _arguments \
    '-h[display usage information]' \
    '-v[produce verbose output]' \
    '-T[create a tag for every commit]' \
    '-t[use given directory as temporary directory]:directory:_directories' \
    ':archive/branch' \
    '::archive/branch'
}

_git-convert-objects () {
  _arguments \
    ':object:__git_objects'
}

# TODO: _cvs_root for -d would be nice
_git-cvsimport () {
  _arguments \
    '-C[specify the git repository to import into]:directory:_directories' \
    '-d[specify the root of the CVS archive]:cvsroot' \
    '-h[display usage information]' \
    '-i[do not perform a checkout after importing]' \
    '-k[remove keywords from source files in the CVS archive]' \
    '-u[convert underscores in tag and branch names to dots]' \
    '-M[attempt to detect merges based on the commit message with custom pattern]:pattern' \
    '-m[attempt to detect merges based on the commit message]' \
    '-o[specify the branch into which you wish to import]:branch' \
    '-p[specify additionaly options for cvsps]:cvsps-options' \
    '-s[substitute the "/" character in branch names with given substitution]:substitute' \
    '-v[produce verbose output]' \
    '-z[specify timestamp fuzz factor to cvsps]:fuzz-factor' \
    ':cvsmodule' && ret=0
}

# TODO: documentation is weird
_git-lost-found () {
  _message "awaiting better documentation before proceeding..."
}

# TODO: something better
_git-merge-one-file () {
  _message "you probably should not be issuing this command"
}

_git-prune () {
  _arguments -S \
    '-n[do not remove anything; just report what would have been removed]' && ret=0
}

_git-relink () {
  _arguments \
    '--safe[stop if two objects with the same hash exist but have different sizes]' \
    '*:directory:_directories' && ret=0
}

# TODO: import stuff from _svn
_git-svnimport () {
  _arguments \
    '-b[specify the name of the SVN branches directory]:directory:_directories' \
    '-C[specify the git repository to import into]:directory:_directories' \
    '-D[use direct HTTP-requests if possible]:path' \
    '-d[use direct HTTP-requests if possible for logs only]:path' \
    '-h[display usage information]' \
    '-i[do not perform a checkout after importing]' \
    '-l[limit the number of SVN changesets to pull]: :_guard "[[\:digit\:]]#" number' \
    '-o[specify the branch into which you wish to import]:branch' \
    '-M[attempt to detect merges based on the commit message with custom pattern]:pattern' \
    '-m[attempt to detect merges based on the commit message]' \
    '-s[specify the change number to start importing from:start-revision' \
    '-t[specify the name of the SVN trunk]:trunk:_directories' \
    '-T[specify the name of the SVN tags directory]:directory:_directories' \
    '-v[produce verbose output]' \
    ':svn-repositry-url:_urls' \
    '::directory:_directories' && ret=0
}

# TODO: how do we complete argument 1?
# TODO: argument 2 should be __git_heads, but with full path
_git-symbolic-ref () {
  _arguments \
    ':symbolic reference' \
    ':reference' && ret=0
}

# TODO: first argument right?
# TODO: document options once they are in man
# key-id for -u could perhaps be completed from _gpg somehow
_git-tag () {
  local message=

  if (( $words[(I)-[asu]] )); then
    message='-m[specify tag message]'
  fi

  _arguments \
    $message \
    ':tag-name:__git_tags' \
    '::head:__git_revisions' \
    - '(creation)' \
      '-a[annotate]' \
      '-f[create a new tag even if one with the same name already exists]' \
      '-s[annotate and sign]' \
      '-u[annotate and sign with given key-id]:key-id' \
    - '(deletion)' \
      '-d[delete]:tag:__git_tags' && ret=0
}

_git-update-ref () {
  _arguments \
    ':symbolic reference:__git_revisions' \
    ':new reference:__git_revisions' \
    '::old reference:__git_revisions' && ret=0
}

_git-check-ref-format () {
  _arguments \
    ':reference:__git_revisions' && ret=0
}


_git-cherry () {
  _arguments \
    '-v[be verbose]' \
    ':upstream:__git_revisions' \
    '::head:__git_revisions' && ret=0
}

_git-count-objects () {
  _nothing
}

# TODO: do better than _directory?  The directory needs to be a git-repository,
# so one could check for a required file in the given directory.
_git-daemon () {
  _arguments -S \
    '--export-all[allow pulling from all repositories without verification]' \
    '(--port)--inetd[run server as an inetd service]' \
    '--init-timeout=-[specify timeout between connection and request]' \
    '--port=-[specify port to listen to]' \
    '--syslog[log to syslog instead of stderr]' \
    '--timeout=-[specify timeout for sub-requests]' \
    '--verbose[log details about incoming connections and requested files]' \
    '*:repository:_directory' && ret=0
}

_git-get-tar-commit-id () {
  _message 'no arguments allowed; accepts tar-file on standard input'
}

_git-mailinfo () {
  _arguments \
    '-k[do not strip/add \[PATCH\] from the first line of the commit message]' \
    '-u[encode commit information in UTF-8]' \
    ':message file:_files' \
    ':patch file:_files' && ret=0
}

_git-mailsplit () {
  _arguments \
    '-d-[specify number of leading zeros]: :_guard "[[\:digit\:]]#" "precision' \
    ':mbox file/directory:_files' \
    '::directory:_directories' && ret=0
}

_git-patch-id () {
  _message 'no arguments allowed; accepts patch on standard input'
}

_git-request-pull () {
  _arguments \
    ':start commit:__git_revisions' \
    ':url:_urls' \
    ':end commit:__git_revisions'
}

# TODO: do we want this?
#_git-rev-parse () {
#}

_git-send-email () {
  _arguments \
    '(--no-chain-reply-to)--chain-reply-to[each email will be sent as a reply to the previous one sent]' \
    '(--chain-reply-to)--no-chain-reply-to[all emails after the first will be sent as replies to the first one]' \
    '--compose[use $EDITOR to edit an introductory message for the patch series]' \
    '--from[specify the sender of the emails]' \
    '--in-reply-to[specify the contents of the first In-Reply-To header]' \
    '--smtp-server[specify the outgoing smtp server]:smtp server:_hosts' \
    '--subject[specify the initial subject of the email thread]' \
    '--to[specify the primary recipient of the emails]'
    ':file:_files' && ret=0
}

_git-stripspace () {
  _message 'no arguments allowed; accepts input file on standard input'
}

_git_ps1 () {
  local d="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -z "$d" ]; then
    exit 0
  fi

  if [ -e "$d/.dotest-merge" -o -e "$d/../.dotest" ]; then
    printf " (%s)" "REBASING"
    exit 0
  fi

  if pwd -P | grep "^/bonus/scratch" >& /dev/null ; then
      if git update-index --refresh 2> /dev/null | grep "needs merge" > /dev/null; then
	printf " (%s)" "MERGING"
	exit 0
      fi
  fi

  local b="$(git symbolic-ref HEAD 2>/dev/null)"
  if [ -n "$b" ]; then
    printf " (%s)" "${b##refs/heads/}"
  else
    printf " (%s)" "DETACHED"
  fi
}

# ---

__git_guard () {
  typeset -A opts

  zparseopts -K -D -A opts M: J: V: 1 2 n F: X:

  [[ "$PREFIX$SUFFIX" != $~1 ]] && return 1

  if (( $+opts[-X] )); then
    _message -r $opts[-X]
  else
    _message -e $2
  fi

  [[ -n "$PREFIX$SUFFIX" ]]
}

__git_objects () {
  __git_guard $* "[[:xdigit:]]#" "object"
}

__git_trees () {
  __git_guard $* "[[:xdigit:]]#" "tree"
}

__git_tree_ishs () {
  __git_guard $* "[[:xdigit:]]#" "tree-ish"
}

__git_blobs () {
  _git_guard $* "[[:xdigit:]]#" 'blob id'
}

__git_stages () {
  __git_guard $* "[[:digit:]]#" 'stage'
}

__git_files () {
  local expl files

  files=("${(@f)$(git-ls-files 2>/dev/null)}")
  if (( $? == 0 )); then
    _wanted files expl 'index file' _multi_parts $@ - / files
  else
    _message 'not a git repository'
  fi
}

__git_tree_files () {
  local expl tree_files

  tree_files=(${"${(@f)$(git-ls-tree -r $@[-1] 2>/dev/null)}"#*$'\t'})
  if (( $? == 0 )); then
    _wanted files expl 'tree file' _multi_parts $@[1,-2] - / tree_files
  else
    _message 'not a git repository'
  fi
}

# TODO: deal with things that __git_heads and __git_tags has in common (i.e.,
# if both exists, they need to be completed to heads/x and tags/x.
__git_commits () {
  _alternative \
    'heads::__git_heads' \
    'tags::__git_tags'
}

# TODO: deal with prefixes and suffixes listed in git-rev-parse
__git_revisions () {
  __git_commits $*
}

__git_commits2 () {
  compset -P '\\\^'
  __git_commits
}

# FIXME: these should be imported from _ssh
# TODO: this should take -/ to only get directories
_remote_files () {
  # There should be coloring based on all the different ls -F classifiers.
  local expl rempat remfiles remdispf remdispd args suf ret=1

  if zstyle -T ":completion:${curcontext}:files" remote-access; then
    zparseopts -D -E -a args p: 1 2 4 6 F:
    if [[ -z $QIPREFIX ]]
    then rempat="${PREFIX%%[^./][^/]#}\*"
    else rempat="${(q)PREFIX%%[^./][^/]#}\*"
    fi
    remfiles=(${(M)${(f)"$(_call_program files ssh $args -a -x ${IPREFIX%:} ls -d1FL "$rempat" 2>/dev/null)"}%%[^/]#(|/)})
    compset -P '*/'
    compset -S '/*' || suf='remote file'

#    remdispf=(${remfiles:#*/})
    remdispd=(${(M)remfiles:#*/})

    _tags files
    while _tags; do
      while _next_label files expl ${suf:-remote directory}; do
#        [[ -n $suf ]] && compadd "$@" "$expl[@]" -d remdispf \
#	    ${(q)remdispf%[*=@|]} && ret=0 
	compadd ${suf:+-S/} "$@" "$expl[@]" -d remdispd \
	    ${(q)remdispd%/} && ret=0
      done
      (( ret )) || return 0
    done
    return ret
  else
    _message -e remote-files 'remote file'
  fi
}

__git_remote_repository () {
  local service

  service= _ssh

  if compset -P '*:'; then
    _remote_files
  else
    _alternative \
      'directories::_directories' \
      'hosts:host:_ssh_hosts -S:'
  fi
}

# should also be $GIT_DIR/remotes/origin
__git_any_repositories () {
  _alternative \
    'files::_files' \
    'remote repositories::__git_remote_repository'
}

__git_ref_specs () {
  if compset -P '*:'; then
    __git_heads
  else
    compset -P '+'
    if compset -S ':*'; then
      __git_heads
    else
      __git_heads -S ':'
    fi
  fi
}

__git_signoff_file () {
  _alternative \
    'signoffs:signoff:(yes true me please)' \
    'files:signoff file:_files'
}

__git_tag_ids () {
}

__git_heads_or_tags () {
  local expl
  typeset -a refs opts
  typeset -A ours

  zparseopts -K -D -a opts S: M: J: V: 1 2 n F: X: P:=ours T:=ours

  (( $+ours[-P] )) || ours[-P]=./.

  refs=(${${"${(@f)$(git ls-remote --$ours[-T] $ours[-P] 2>/dev/null)}"#*$'\t'}#refs/$ours[-T]/})
  if (( $? == 0 )); then
    _wanted $ours[-T] expl $ours[-T] compadd $opts - $refs
  else
    _message 'not a git repository'
  fi
}

__git_heads () {
  __git_heads_or_tags $* -T heads && ret=0
}

__git_tags () {
  __git_heads_or_tags $* -T tags && ret=0
}

# TODO: depending on what options are on the command-line already, complete
# only tags or heads
# TODO: perhaps caching is unnecessary.  usually won’t contain that much data
# TODO: perhaps provide alternative here for both heads and tags (and use
# __git_heads and __git_tags)
# TODO: instead of "./.", we should be looking in the repository specified as
# an argument to the command (but default to "./." I suppose (why not "."?))
__git_references () {
#  _alternative \
#    'heads::__git_heads' \
#    'tags::__git_tags' && ret=0
  local expl

  # TODO: deal with GIT_DIR
  if [[ $_git_refs_cache_pwd != $PWD ]]; then
    _git_refs_cache=(${${"${(@f)$(git ls-remote ./. 2>/dev/null)}"#*$'\t'}#refs/(heads|tags)/})
    _git_refs_cache_pwd=$PWD
  fi

  if (( $? == 0 )); then
    _wanted references expl 'references' compadd - $_git_refs_cache
  else
    _message 'not a git repository'
  fi
}

__git_local_references () {
  local expl

  if [[ $_git_local_refs_cache_pwd != $PWD ]]; then
    _git_local_refs_cache=(${${"${(@f)$(git ls-remote ./. 2>/dev/null)}"#*$'\t'}#refs/})
    _git_local_refs_cache_pwd=$PWD
  fi

  if (( $? == 0 )); then
    _wanted references expl 'references' compadd - $_git_local_refs_cache
  else
    _message 'not a git repository'
  fi
}

# ---

__git_is_indexed () {
  [[ -n $(git ls-files $REPLY) ]]
}
