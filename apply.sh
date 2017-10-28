#!/bin/bash

set -euo pipefail

site="$1"; shift
if [ $# -gt 0 ]; then
    email_file="$1"; shift
else
    email_file="$site"
fi

if ! lpass status; then
    lpass login "$(cat "$email_file.email")"
fi

ansible-playbook -i inventory --limit="$site" --ask-become-pass -v "site.yml" "$@"
