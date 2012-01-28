#!/bin/bash

#
# usage:
# irc_message.sh "network" "channel" "message" "nick"
# 
#

config=/tmp/ircbot

echo "NICK $4" > $config # what nick
echo "USER $4 +iw $4 :$0" >> $config 
echo "JOIN $2" >> $config # what channel

cat $config

tail -f $config | telnet $1 6667 | for i in {1..3}
do
	echo "PRIVMSG $2 :$3" >> $config # what to say.
	sleep 6 # number of seconds to wait before saying it again
	if [ "$i" -eq "3" ]
	then
		echo "quit" >> $config #close the telnet client
		pkill -9 -P $$ tail #kill tail otherwise it keeps running forever and the script never exits
	fi
done

rm $config
