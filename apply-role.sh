#!/bin/bash
# Applies a single role. Useful when making small changes, or developing a role.

set -euo pipefail

site="$1"; shift
role="$1"; shift

echo "Applying role $role with site $site."

./apply.sh single_role "$site" --extra-vars "role_to_run=${role} site=${site}" "$@"
