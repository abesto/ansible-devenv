#!/bin/bash
# Applies a single role. Useful when making small changes, or developing a role.

set -euo pipefail

site="$1"; shift
role="$1"; shift

cat > "$role.yml" <<EOF
- hosts: localhost
  gather_subset:
    - "!all"
  roles:
    - $role
EOF
trap "rm -v $role.yml" EXIT

echo "Applying role $role. Playbook follows."
echo "******************"
cat "$role.yml"
echo "******************"
echo

cp "$site.email" "$role.email"
trap "rm -v $role.yml $role.email" EXIT

./apply.sh "$role" "$@"
