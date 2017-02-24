#!/bin/bash

set -euo pipefail
set +u; . virtualenv/bin/activate; set -u

ansible-playbook site.yml -i inventory --ask-become-pass "$@"
