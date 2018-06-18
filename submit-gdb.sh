#!/bin/sh

p=$1
s=$(head -n 1 $p)
to=gdb-patches@sourceware.org

patch=$(mktemp)
rationale=$(mktemp)

awk '/^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/,0' \
    $p \
    > $patch

awk '
BEGIN { p = 1; }
/^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ { p = 0; }
// { if (p) { print $0}; }
' $p \
    | tail -n +2 \
	   > $rationale

tmp=$(mktemp)

cat <<EOF >$tmp
Hi,

EOF

cat $rationale >> $tmp

cat <<EOF >>$tmp

OK for trunk?

Thanks,
- Tom

EOF

echo $s >> $tmp
echo >> $tmp

cat $patch >> $tmp

mutt -s "[PATCH]$s" $to -i $tmp
rm $tmp $rationale $patch
