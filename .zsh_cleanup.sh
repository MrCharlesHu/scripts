#!/bin/sh
vim .zsh_history << EOF
:%s/^/\=line('.').' '
:sort! /\d\+\s:\s\d\+:0;/
:g/^\d\+\s:\s\d\+:0;\(.*\)\n^\d\+\s:\s\d\+:0;\1\n^\d\+\s:\s\d\+:0;\1/d
:sort n
:%s/^\d\+\s//
:wq
EOF
