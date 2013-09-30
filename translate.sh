#!/bin/sh

mkdir -p 5_translated
for file in `ls 4_cleaner`; do
	echo "translating $file"
	saxon -s:4_cleaner/$file -xsl:translate.xsl
done