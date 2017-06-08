#!/bin/bash

set -euo pipefail
set +u; . virtualenv/bin/activate; set -u  # remove once lastpass lookup plugin is released

site="$1"; shift

if ! lpass status; then
    lpass login <(cat $site)
fi

ansible-playbook -i inventory --ask-become-pass -v "$site.yml" "$@"
