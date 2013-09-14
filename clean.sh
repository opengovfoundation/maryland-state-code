#!/bin/sh
for file in `ls *.xml`; do
	php ./convert.php $file
done

for file in `ls stripped`; do
	xmllint -format "stripped/$file" -output "formatted/$file"
done

for file in `ls formatted`; do
	sed '/^<!DOCTYPE.*$/d' "formatted/$file" > "clean/$file"
done

for file in `ls clean`; do
	art=`echo $file | sed 's/\..*//'`
	sed "s/<article id=".*">/<article id=\"$art\">/" "clean/$file" > "final/$file"
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