#!/bin/bash

subsjs() {
  figlet Subsjs

  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      cat tmp/subdomains.txt | subsjs | anew js.txt | notify --silent
      cat tmp/subdomains.txt | gau | subsjs | anew js.txt | notify --silent
    else
      cat tmp/subdomains.txt | subsjs | anew js.txt
      cat tmp/subdomains.txt | gau | subsjs | anew js.txt
    fi
    sleep 3600
  done
}

wayback() {
  figlet Waybackurls

  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      cat tmp/subdomains.txt | waybackurls | grep -E "\.js(?:onp?)?$" | anew js.txt | notify --silent
    else
      cat tmp/subdomains.txt | waybackurls | grep -E "\.js(?:onp?)?$" | anew js.txt
    fi
    sleep 3600
  done
}

gu() {
  figlet Gau

  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      cat tmp/subdomains.txt | gau | grep -E "\.js(?:onp?)?$" | anew js.txt | notify --silent
    else
      cat tmp/subdomains.txt | gau | grep -E "\.js(?:onp?)?$" | anew js.txt
    fi
    sleep 3600
  done
}

#### END FUNCTIONS ####

figlet JS Enumeration

notify_enabled=$NOTIFY

echo "
Will search by domain and write tmp/js.txt

0 - Subsjs
1 - Waybackurls
2 - Gau

99 - search by subdomains
100 - enable notify
"

read -p 'Choose your service: ' service

case $service in
  '0' | 0)
    subjs
    ;;
  '1' | 1)
    wayback
    ;;
  '2' | 2)
    gu
    ;;
  '99' | 99)
    ./src/monitoring.sh
    ;;
  '100' | 100)
    echo "run this: export NOTIFY=true"
    ;;
esac
