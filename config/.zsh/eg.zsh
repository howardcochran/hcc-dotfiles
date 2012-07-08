compdef _eg eg

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
_eg_commands () {
  local -a commands

  commands=(
    'annotate:show line-by-line file history'
    'am:apply patches from a mailbox (cooler than applymbox)'
    'bisect:find the change that introduced a bug'
    'blame:alias for annotate'
    'branch:create and show branches'
    'cherry-pick:cherry-pick the effect of an existing commit'
    'clone:clones a repository into a new directory'
    'commit:record changes to the repository'
    'diff:show changes between commits, commit and working tree, etc.'
    'fetch:download objects and a head from another repository'
    'format-patch:prepare patches for e-mail submission'
    'grep:print lines matching a pattern'
    'log:shows commit logs'
    'merge:grand unified merge driver'
    'mv:moves or renames a file, directory, or symlink'
    'prune:prunes all unreachable objects from the object database'
    'pull:fetch from and merge with a remote repository'
    'push:update remote refs along with associated objects'
    'rebase:rebases local commits to new upstream head'
    'reset:resets current HEAD to the specified state'
    'revert:reverts an existing commit'
    'send-email:sends patch-e-mails out of "format-patch --mbox" output'
    'shortlog:summarizes git log output'
    "status:shows the working-tree's status"
    "stage:stage a file for commit"
    'tag:creates a tag object signed with GPG'
    'whatchanged:shows commit-logs and differences they introduce')

  _describe -t commands 'eg command' commands && ret=0
}

_eg () {
    # TODO: this needs to be cleaned up and fixed
    local curcontext=$curcontext ret=1

    if [[ $words[1] == eg ]]; then
      if (( CURRENT == 2 )); then
	_eg_commands
      else
	shift words
	(( CURRENT-- ))
	curcontext="${curcontext%:*:*}:eg-$words[1]:"
	_call_function ret _eg-$words[1]
      fi
    else
      _call_function ret _$words[1]
    fi
}

__eg-clone_or_fetch-pack () {
  _arguments \
    $exec_arg \
    ':remote repository:__git_remote_repository' \
    '*:head:__git_heads' && ret=0
}


_eg-rm () {
  _arguments \
    '--staged[do not remove the file from the filesytem]' \
    '*:index file:_files' && ret=0
}

_eg-am () {
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

_eg-bisect () {
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
    _describe -t command "eg-bisect commands" bisect_cmds && ret=0
  else
    case $words[2] in
      (bad)
        _arguments \
          '2:revision:__eg_commits' && ret=0
        ;;
      (good)
        _arguments \
          '*:revision:__eg_commits' && ret=0
        ;;
      (replay)
        _arguments \
          '2:file:_files' && ret=0
        ;;
      (reset)
        _arguments \
          '2:branch:__eg_heads' && ret=0
        ;;
      (*)
        _nothing
        ;;
    esac
  fi
}

_eg-branch () {
  _arguments \
    '(-D)-d[delete a branch, which must be fully merged]' \
    '(-d)-D[delete a branch]' \
    '(-s)-s[switch to branch]' \
    ':branch-name:__git_commits2' \
    ':base branch:__git_revisions' && ret=0
}

_eg-cherry-pick () {
  _arguments \
    '(-n --no-commit)'{-n,--no-commit}'[do not make the actually commit]' \
    '(-r --replay)'{-r,--replay}'[use the original commit message intact]' \
    ':commit:__git_revisions' && ret=0
}

_eg-clone () {
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

_eg-commit () {
  _arguments -S \
    '(-a --all)'{-a,--all}'[update all paths in the index file]' \
    '(-d --dirty)'{-d,--dirty}'[commit staged changes]' \
    '(-b --bypass-unknown)'{-b,--bypass-unknown}'[dont check for unknown files]' \
    '(-s --signoff)'{-s,--signoff}'[add Signed-off-by line at the end of the commit message]' \
    '(-v --verify -n --no-verify)'{-v,--verify}'[look for suspicious lines the commit introduces]' \
    '(-n --no-verify -v --verify)'{-n,--no-verify}'[do not look for suspicious lines the commit introduces]' \
    '*:file:_files' \
    - '(message)' \
      '(-c -C --reedit-message --reuse-message)'{-c,--reedit-message=}'[use existing commit object and edit log message]:commit id:__git_commits' \
      '(-c -C --reedit-message --reuse-message)'{-C,--reuse-message=}'[use existing commit object with same log message]:commit id:__git_commits' \
      '(-F --file)'{-F,--file=}'[read commit message from given file]:file:_files' \
      '(-m --message)'{-m,--message=}'[use the given message as the commit message]:message' && ret=0
}

# TODO: __git_files should be __git_tree_files (do like in git-diff-tree and
# such)
_eg-diff () {
  _arguments \
    $diff_args \
    '(--unstaged --staged)--staged[show staged changes]' \
    '(--unstaged --staged)--unstaged[show unstaged changes]' \
    '::original revision:__git_revisions' \
    '*:index file:_files' && ret=0
}

_eg-fetch () {
  _arguments \
    '(-a --append)'{-a,--append}'[append fetched refs instead of overwriting]' \
    $force_ref_arg \
    $tags_fetch_arg \
    '(-u --update-head-ok)'{-u,--update-head-ok}'[allow updates of current branch head]' \
    ':repository:__git_any_repositories' \
    '*:refspec:__git_ref_specs' && ret=0
}

# TODO: should support R1..R2 syntax
_eg-format-patch () {
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
_eg-grep () {
  service=grep _grep
  ret=0
}

# TODO: this isn't strictly right, but close enough
_eg-log () {
  _arguments \
    $diff_args \
    $revlist_args \
    ':commit id:__git_commits2' \
    '*:file:_files' && ret=0
}

_eg-merge () {
  _arguments \
    '(-n --no-summary)'{-n,--no-summary}'[do not show diffstat at end of merge]' \
    $merge_strategy \
    ':merge message' \
    ':head:__git_revisions' \
    '*:remote:__git_revisions' && ret=0
}

_eg-mv () {
  _arguments \
    '-f[force renaming/moving even if targets exist]' \
    '-k[skip move/renames that would lead to errors]' \
    '-n[only show what would happen]' \
    '*:index file:__git_files' && ret=0
}

_eg-pull () {
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

_eg-push () {
  _arguments \
    $force_ref_arg \
    '--all[fetch all refs]' \
    ':repository:__git_any_repositories' \
    '*:refspec:__git_ref_specs' && ret=0
}

_eg-rebase () {
  _arguments \
    ':upstream branch:__git_revisions' \
    '::working branch:__git_revisions' && ret=0
}

_eg-reset () {
  _arguments \
    '(--working-copy)--no-unstaging[do not touch the index file nor the working tree]' \
    '(--no-unstaging)--working-copy[match the working copy and index to the given tree]' \
    ':commit-ish:__git_revisions' && ret=0
}

_eg-revert () {
  _arguments \
    '(--commit)--no-commit[do not commit the reversion]' \
    '(--no-commit)--commit[commit the reversion]' \
    '(--since)--in[revert the changes in the given commit]' \
    '(--in)--since[revert the changes since the given commit]' \
    '::commit:__git_revisions' \
    '*:index file:_files' && ret=0
}

_eg-shortlog () {
  _nothing
}

_eg-status () {
  _nothing
}

_eg-stage () {
  _arguments \
    '-n[do not actually add files; only show which ones would be added]' \
    '-v[show files as they are added]' \
    '*:file:_files -g "*(^e:__git_is_indexed:)"' && ret=0
}

_eg-switch () {
  _arguments \
    ':commit id:__git_commits2' \
}
# TODO: first argument right?
# TODO: document options once they are in man
# key-id for -u could perhaps be completed from _gpg somehow
_eg-tag () {
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

_eg-send-email () {
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
