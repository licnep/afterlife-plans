#!/bin/bash

#
# usage:
# irc_message.sh "network" "channel" "message"
# 
#

config=/tmp/ircbot

echo "NICK pingbot" > $config # what nick
echo "USER pingbot +iw pingbot :$0" >> $config 
echo "JOIN $2" >> $config # what channel

tail -f $config | telnet $1 6667 | while true; do # what network

echo "PRIVMSG $2 :$3" >> $config # what to say.
sleep 20 # number of seconds to wait before saying it again

done

rm $config
