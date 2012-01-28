#!/bin/bash

#
# usage:
# decrypt_folder "folder" "password"
# 
# will decrypt the folder in a new folder called "temp_decrypted" and run the dont_run_me.sh script if present in the encrypted folder root
#

#we expect 3 arguments
if [ $# -ne 2 ]
then
	echo "Usage: `basename $0` {folder} {password}"
	exit $E_BADARGS
fi


#decrypt the archived folder
echo $2 | gpg --passphrase-fd 0 $1


#now we should have a temp_archive.tar, so we unzip it and run the run.sh
mkdir temp_decrypted
tar -xpf ./temp_archive.tar -C temp_decrypted/
rm ./temp_archive.tar
cd temp_decrypted
cd `ls` #cd to the only subfolder
./dont_run_me.sh
