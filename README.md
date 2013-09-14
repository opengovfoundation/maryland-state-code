maryland-state-code
===================

Parsing the Maryland State Code to be used in the StateDecoded

The XML files in the root directory are the original files.

To parse the files into the StateDecoded format:

1.  `./clean.sh`
	- This will create files in the following directories:
		- stripped ( files with html entities decoded )
		- formatted ( files formatted with xmllint for readability )
		- clean ( files have had the article code added to the root article id attribute and unicode characters have been converted to ascii for readability purposes )
2.  `./translate.sh`
	- This will run saxon to translate each file in the `clean` directory using `translate.xsl`
	- *Note:* This uses the full path to the saxon .jar file.  You should update this path to meet your environment.