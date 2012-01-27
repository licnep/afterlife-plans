#!/bin/bash

#
# usage:
# encrypt_folder "folder" "password" "password"
# 
# the encrypted folder is saved as "temp_archive.tar.gpg"
# 
# you can later decrypt the folder with: decrypt_folder "folder" "password"
# which will also automatically run the dont_run_me.sh script you put inside the folder (if there is one)
#

#we expect 3 arguments
if [ $# -ne 3 ]
then
	echo "Usage: `basename $0` {folder} {password} {repeat password}"
	exit $E_BADARGS
fi

#check that passwords match or leave
if [ "$2" != "$3" ] 
then
	echo "ERROR: passwords don't match!!"
	exit
fi

#archive the folder
tar -cf temp_archive.tar $1


#crypt the archived folder
echo $2 | gpg --passphrase-fd 0 -c temp_archive.tar

#delete the temp archive
rm temp_archive.tar
