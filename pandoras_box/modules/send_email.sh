#!/bin/bash
#
# usage: 
# send_email.sh "to" "subject" "from" "message"
#


php -r "mail('$1','$2','$4','From: $3');"
