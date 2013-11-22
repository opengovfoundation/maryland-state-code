#!/bin/sh

rm -R 1_stripped
mkdir -p 1_stripped
for file in `ls *.xml`; do
	php ./convert.php $file
done

rm -R 2_formatted
mkdir -p 2_formatted
for file in `ls 1_stripped`; do
	xmllint -format "1_stripped/$file" -output "2_formatted/$file"
done

rm -R 3_clean
mkdir -p 3_clean
for file in `ls 2_formatted`; do
	sed '/^<!DOCTYPE.*$/d' "2_formatted/$file" > "3_clean/$file"
done

rm -R 4_cleaner
mkdir -p 4_cleaner
for file in `ls 3_clean`; do
	art=`echo $file | sed 's/\..*$//'`
	sed -E "s/<article id=\"([^\"]+)\"(\/)?>/<article id=\"$art\"\2>/" "3_clean/$file" > "4_cleaner/$file"
	sed -i.bak 's/&#x2013;/-/g'      "4_cleaner/$file"
	sed -i.bak 's/&#x2014;/-/g'      "4_cleaner/$file"
	sed -i.bak 's/&#x201C;/"/g'      "4_cleaner//$file"
	sed -i.bak 's/&#x201D;/"/g'      "4_cleaner//$file"
	sed -i.bak 's/&#xA7;/§/g'        "4_cleaner//$file"
	sed -i.bak "s/&#x2018;/'/g"      "4_cleaner//$file"
	sed -i.bak "s/&#x2019;/'/g"      "4_cleaner//$file"
	sed -i.bak "s/&#x2002;/ /g"      "4_cleaner//$file"
	sed -i.bak "s/&#x2003;/ /g"      "4_cleaner//$file"
	sed -i.bak "s/&#x2026;/\.\.\./g" "4_cleaner//$file"
	sed -i.bak "s/&#xB0;/º/g"        "4_cleaner//$file"
	sed -i.bak "s/&#xB5;/µ/g"        "4_cleaner//$file"
	sed -i.bak "s/&#x2022;/•/g"      "4_cleaner//$file"
	sed -i.bak "s/--amp--ndash;/-/g" "4_cleaner//$file"
	rm 4_cleaner/*.bak
done
