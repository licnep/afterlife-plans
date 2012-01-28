#!/bin/bash

echo "====================================================="
echo "INSTRUCTIONS:"
echo "====================================================="
echo "Substitute the default script in backend/last_act/pandoras_box/dont_run_me.sh with your own."
echo ""
echo "Is your custom script in place already (y/n)?"
read answer

if [ "$answer" != "y" ]
then
	exit
fi

#changing permissions
chmod a+rw backend/timestamp_last_on.txt
chmod a+x backend/last_act/encrypt_folder.sh
chmod a+x backend/last_act/decrypt_folder.sh
chmod a+x backend/last_act/pandoras_box/dont_run_me.sh



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

echo "====================================================="
echo "Configuration complete."
echo "For more options edit backend/afterlife.php"
echo "====================================================="

#encrypting the folder
echo "Encripting the folder..."
cd backend/last_act/
./encrypt_folder.sh pandoras_box "$password1" "$password1"
cd ../..

#save the password hash in afterlife.php
sed -i "s/PASSWORD=\".*\";/PASSWORD=\"$hash\";/g" backend/afterlife.php
echo "Password hash saved in backend/afterlife.php"

echo "====================================================="
echo "Installation succesfull!!!"
echo "====================================================="
echo "Now we suggest removing the folder /backend/last-act/pandoras_box"
