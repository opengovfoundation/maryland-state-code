<?php
$unconvertedEntity = array(
	'&percnt;',
	'&numsp;',
	'&lowbar;',
	'&ndash;',
	'&#x2013;'
);
$convertedChar = array(
	'%',
	' ',
	'_',
	'-',
	'-'
);

$filename = $argv[1];
$xml = file_get_contents($filename);
$xml = html_entity_decode($xml);
$xml = htmlspecialchars_decode($xml, ENT_HTML5);
$xml = str_replace($unconvertedEntity, $convertedChar, $xml);
$xml = str_replace('&', '&amp;', $xml);

file_put_contents('1_stripped/'.$filename, $xml);
