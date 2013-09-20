#!/bin/sh
for file in `ls final`; do
	echo "translating $file"
	saxon -s:final/$file -xsl:translate.xsl
done