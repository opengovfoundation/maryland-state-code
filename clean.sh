#!/bin/sh
mkdir -p 1_stripped
for file in `ls *.xml`; do
	php ./convert.php $file
done

mkdir -p 2_formatted
for file in `ls 1_stripped`; do
	xmllint -format "1_stripped/$file" -output "2_formatted/$file"
done

mkdir -p 3_clean
for file in `ls 2_formatted`; do
	sed '/^<!DOCTYPE.*$/d' "2_formatted/$file" > "3_clean/$file"
done

mkdir -p 4_cleaner
for file in `ls clean`; do
	art=`echo $file | sed 's/\..*//'`
	sed -E "s/<article id=\"([^\"]+)\"(\/)?>/<article id=\"$art\"\2>/" "3_clean/$file" > "4_cleaner/$file"
	sed -i.bak 's/&#x2013;/-/g' "final/$file"
	sed -i.bak 's/&#x2014;/-/g' "final/$file"
	sed -i.bak 's/&#x201C;/"/g' "final/$file"
	sed -i.bak 's/&#x201D;/"/g' "final/$file"
	sed -i.bak 's/&#xA7;/§/g' "final/$file"
	sed -i.bak "s/&#x2018;/'/g" "final/$file"
	sed -i.bak "s/&#x2019;/'/g" "final/$file"
	sed -i.bak "s/&#x2002;/ /g" "final/$file"
	sed -i.bak "s/&#x2003;/ /g" "final/$file"
	sed -i.bak "s/&#x2026;/\.\.\./g" "final/$file"
	sed -i.bak "s/&#xB0;/º/g" "final/$file"
	sed -i.bak "s/&#xB5;/µ/g" "final/$file"
	sed -i.bak "s/&#x2022;/•/g" "final/$file"
	sed -i.bak "s/--amp--ndash;/-/g" "final/$file"
	rm final/*.bak
done