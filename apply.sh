#!/bin/bash

ansible-playbook site.yml -i inventory --ask-become-pass
