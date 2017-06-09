#!/bin/bash
# Applies a single role. Useful when making small changes, or developing a role.

set -euo pipefail
set +u; . virtualenv/bin/activate; set -u  # remove once lastpass lookup plugin is released

site="$1"; shift
role="$1"; shift

if ! lpass status; then
    lpass login "$(cat "$site".email)"
fi

trap "rm -v $role.yml" EXIT
cat > "$role.yml" <<EOF
- hosts: localhost
  gather_subset:
    - "!all"
  roles:
    - $role
EOF

echo "Applying role $role. Playbook follows."
echo "******************"
cat "$role.yml"
echo "******************"
echo

ansible-playbook -i inventory --ask-become-pass -v "$role.yml" "$@"
