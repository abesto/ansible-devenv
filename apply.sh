#!/bin/bash

set -euo pipefail
set +u; . virtualenv/bin/activate; set -u  # remove once lastpass lookup plugin is released
ansible-playbook -vv site.yml -i inventory --ask-become-pass "$@"
