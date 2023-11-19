#!/bin/bash

set -e

mkdir -p ../unencrypted/

for FILE in *.zip.gpg; do
	BASENAME=`basename $FILE`
	rm -f ../unencrypted/$BASENAME.zip
	gpg -o ../unencrypted/$BASENAME.zip --batch --no-tty --passphrase $ASSET_DECRYPTION_KEY -v -d $FILE
	cd ../unencrypted/
	unzip -u $BASENAME.zip -d $BASENAME
	rm $BASENAME.zip
	cd ../encrypted/
done

