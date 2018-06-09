#!/bin/sh

p=$1
s=$(head -n 1 $p)
to=gcc-patches@gcc.gnu.org

tmp=$(mktemp)
cat <<EOF >$tmp
Hi,

Thanks,
- Tom

EOF

cat $p >> $tmp

mutt -s "$s" $to -i $tmp
rm $tmp
