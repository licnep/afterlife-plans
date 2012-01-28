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
echo "-1" > backend/timestamp_last_on.txt #reset the timestamp
chmod a+x backend/last_act/encrypt_folder.sh
chmod a+x backend/last_act/decrypt_folder.sh
chmod a+x backend/last_act/modules/irc_message.sh
chmod a+x backend/last_act/modules/send_email.sh
chmod a+x backend/last_act/pandoras_box/dont_run_me.sh
chmod a+w backend/last_act/



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
echo "(MANDATORY)"
echo "Have you edited backend/config.php to suit your needs (y/n)?"
read answer
if [ "$answer" != "y" ]
then
	exit
fi

#encrypting the folder
echo "Encripting the folder..."
cd backend/last_act/
./encrypt_folder.sh pandoras_box "$password1" "$password1"
cd ../..

echo "====================================================="
echo "Installation succesfull!!!"
echo "====================================================="
echo "Now you can remove the folder /backend/last-act/pandoras_box"
echo "Be sure to configure the frontend as well."
