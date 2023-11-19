#!/bin/bash

set -e

mkdir -p ../unencrypted/

for FILE in *.zip.gpg; do
	BASENAME=`basename $FILE`
	rm -f ../unencrypted/$BASENAME.zip
	echo $ASSET_DECRYPTION_KEY | gpg -o ../unencrypted/$BASENAME.zip --pinentry-mode loopback -v -d $FILE
	cd ../unencrypted/
	unzip -u $BASENAME.zip -d $BASENAME
	rm $BASENAME.zip
	cd ../encrypted/
done

