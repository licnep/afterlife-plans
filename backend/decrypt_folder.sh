#!/bin/bash

#
# usage:
# decrypt_folder "password"
# 
# will decrypt the folder in the "decrypted" folder
#

#we expect 1 argument
if [ $# -ne 1 ]
then
	echo "Usage: `basename $0` {password}"
	exit $E_BADARGS
fi


#decrypt the archived folder
echo $1 | gpg --batch --no-tty --passphrase-fd 0 ./temp_archive.tar.gpg


#now we should have a temp_archive.tar, so we unzip it and run the run.sh
rm -rf ../decrypted/*
cd ../decrypted
tar -xpf ../backend/temp_archive.tar
rm ../backend/temp_archive.tar
