#!/bin/sh
for file in `ls final`; do
	echo "translating $file"
	java -Xmx4096m -jar /usr/local/Cellar/saxon/9.5.0.2/libexec/saxon9he.jar -s:final/$file -xsl:translate.xsl
done