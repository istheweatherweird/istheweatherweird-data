#!/bin/bash
echo 'YEAR,MAX,MIN'
zcat `find www -type f -not -empty | sort` | cut --output-delimiter=, -c 15-22,103-108,111-116 | tr -d ' ' | sed -n "s/^\([[:digit:]]\{4\}\)$1/\1/p"
