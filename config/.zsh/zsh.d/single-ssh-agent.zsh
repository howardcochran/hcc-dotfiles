# Singleton ssh-agent:
#
# Connect every new interactive shell owned by the current user
# on this machine with the same ssh-agent, starting it if needed.

# Stash away the original, in case user wants to restore it.
# E.g. Useful if user is logging in via ssh with ssh-agent-forwarding.
# TODO: Can we detect an ssh with agent-forwarding login and
#       just do nothing in that case?
if [ -n "$SSH_AUTH_SOCK" -a -z "$ORIG_SSH_AUTH_SOCK" ] ; then
	ORIG_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
fi

unset SSH_AGENT_LAUNCHER  # Typically this was "upstart"
eval $($HOME/bin/single-ssh-agent)

