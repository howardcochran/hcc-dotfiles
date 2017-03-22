# Singleton ssh-agent:
#
# Connect every new interactive shell owned by the current user
# on this machine with the same ssh-agent, starting it if needed.

# If we are runnning under ssh with agent forwarding, abort (do nothing)
is_ssh_agent_forwarded() {
	local ssh_pid=${SSH_AUTH_SOCK/#*\/ssh-*agent./}
	[[ "$ssh_pid" =~ ^[0-9]\+$ ]] && [[ $(</proc/$ssh_pid/cmdline) = sshd* ]]
}
is_ssh_agent_forwarded && return 0


# Stash away the original, in case user wants to restore it.
if [ -n "$SSH_AUTH_SOCK" -a -z "$ORIG_SSH_AUTH_SOCK" ] ; then
	ORIG_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
fi

unset SSH_AGENT_LAUNCHER  # Typically this was "upstart"
eval $($HOME/bin/single-ssh-agent)
