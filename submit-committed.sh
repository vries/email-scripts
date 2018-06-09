#!/bin/sh

p=$1
s=$(head -n 1 $p)
to=gcc-patches@gcc.gnu.org

if echo "$s" | grep -q '^\[.*\]'; then
    tags=$(echo "$s" \
		  | sed 's/^\[//;s/\].*//')
    s=$(echo "$s" \
	       | sed 's/.*\][ ]*//')
    tags="$tags, commited"
else
    tags="committed"
fi
s="[$tags] $s"

set -x
mutt -s "$s" $to -i $p
