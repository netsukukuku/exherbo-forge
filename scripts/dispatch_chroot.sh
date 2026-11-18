#!/bin/bash
set -uo pipefail


[[ $EXECUTED_IN_CHROOT != "true" ]] \
	&& { echo "This script must not be executed directly!" >&2; exit 1; }

# Source the systems profile
source /etc/profile

# Paludis and the tools it spawns must be able to read what root creates. A restrictive umask
# breaks that, so use the normal system umask. Secrets are chmod'ed explicitly.
umask 0022

# Export variables (used to determine processor count by some applications)
export NPROC="$(nproc || echo 2)"
export NPROC_ONE="$((NPROC + 1))"

# Unset critical variables
unset key

# Execute the requested command
exec "$@"
