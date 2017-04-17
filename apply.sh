#!/bin/bash

set -euo pipefail
set +u; . virtualenv/bin/activate; set -u  # remove once lastpass lookup plugin is released

if ! lpass status; then
    lpass login zoltan.nagy@prezi.com
fi

ansible-playbook -v site.yml -i inventory --ask-become-pass "$@"
