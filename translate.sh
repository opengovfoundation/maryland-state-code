#!/bin/sh

mkdir -p 5_translated
for file in `ls final`; do
	echo "translating $file"
	saxon -s:4_cleaner/$file -xsl:translate.xsl
done