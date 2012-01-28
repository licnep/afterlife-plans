#!/bin/bash

echo "====================================================="
echo "INSTRUCTIONS:"
echo "====================================================="
echo "Setup your own personal pandoras_box folder"
echo "(follow the instructions in pandoras_box/instructions)"
echo "(For a first test run you can just use the default one)"
echo ""
echo "Is your pandoras_box folder ready (y/n)?"
read answer

if [ "$answer" != "y" ]
then
	exit
fi

#changing permissions
chmod a+rw backend/timestamp_last_on.txt
echo "-1" > backend/timestamp_last_on.txt #reset the timestamp
chmod a+x backend/encrypt_folder.sh
chmod a+x backend/decrypt_folder.sh
chmod a+w backend/
chmod a+x pandoras_box/modules/irc_message.sh
chmod a+x pandoras_box/modules/send_email.sh
chmod a+x pandoras_box/dont_run_me.sh

rm -rf decrypted
mkdir decrypted
chmod a+w decrypted/



echo "====================================================="
echo "CONFIGURATION:"
echo "====================================================="

password1="asd"
password2="fasd"

while [ "$password1" != "$password2" ]; do
	echo "Enter your password (1):"
	read password1
	echo "Repeat your password (2):"
	read password2
	if [ "$password1" != "$password2" ]
	then
		sleep 1
		echo "ERROR: The passwords don't match. Try again"
		sleep 1
	fi
done

#calculating the hash
hash=`php -r "echo md5('salt-is-for-pussies$password1');"`
echo "Password hash = $hash"

#save the password hash in afterlife.php
sed -i "s/PASSWORD=\".*\";/PASSWORD=\"$hash\";/g" backend/config.php
echo "Password hash saved in backend/config.php"

echo "Enter your email:"
read email

sed -i "s/__OWNER_EMAIL=\".*\";/__OWNER_EMAIL=\"$email\";/g" backend/config.php
echo "Email saved in backend/config.php"


echo "====================================================="
echo "Now open backend/config.php to refine the configuration"
echo "Have you edited backend/config.php to suit your needs (y/n)?"
read answer
if [ "$answer" != "y" ]
then
	exit
fi

#encrypting the folder
echo "Encripting the folder..."
cd backend/
./encrypt_folder.sh ../pandoras_box "$password1" "$password1"
cd ..

echo "====================================================="
echo "Installation succesfull!!!"
echo "====================================================="
echo "Now you can delete the pandoras_box folder"
echo "Be sure to configure the frontend as well."
