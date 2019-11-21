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

# If we are running under tmx with agent forwarding, abort
is_tmx_agent_forwarded() {
	[[ "$SSH_AUTH_SOCK" =~ tmx_.*_auth_sock ]]
}
is_tmx_agent_forwarded && return 0

# Stash away the original, in case user wants to restore it.
if [ -n "$SSH_AUTH_SOCK" -a -z "$ORIG_SSH_AUTH_SOCK" ] ; then
	ORIG_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
fi

unset SSH_AGENT_LAUNCHER  # Typically this was "upstart"
eval $($HOME/bin/single-ssh-agent)
