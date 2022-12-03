#!/bin/sh
set -eu
set pipefail

tmpsums=`mktemp`
exec 3>"$tmpsums"
exec 4<"$tmpsums"
rm "$tmpsums"

accum=0 part1= part2=

while read line ; do
	: $(( accum += line ))
	if [ "$line" = "" ]; then
		echo "$accum" >&3
		accum=0
	fi
done

while read line ; do
	: ${part1:=$line}
	: $(( part2 += line ))
done <<-EOF
$( sort -nr <&4 | head -3 )
EOF

echo "part 1: $part1"
echo "part 2: $part2"
