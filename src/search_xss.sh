#!/bin/bash

dalfo() {
  figlet Dalfox

  file='tmp/subdomains.txt'
  while :
  do
    while read -r subdomain
    do
      echo "searching by XSS in: $subdomain"
      if [ "$notify_enabled" == "true" ]
      then
        gau -subs $subdomain | dalfox pipe --silence --skip-bav | anew tmp/xss | notify -silent
      else
        gau -subs $subdomain | dalfox pipe --silence --skip-bav | anew tmp/xss
      fi
    done < $file
    sleep 3600
  done
}

kxs() {
  figlet KXSS

  file='tmp/subdomains.txt'
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      cat tmp/subdomains.txt | waybackurls | kxss | anew tmp/kxss | notify -silent
      cat tmp/kxss | awk '{print $2}' | anew xss
    else
      cat tmp/subdomains.txt | waybackurls | kxss | anew tmp/kxss
      cat tmp/kxss | awk '{print $2}' | anew xss
    fi
    sleep 3600
  done
}

gf_xss() {
  figlet GF

  file='tmp/subdomains.txt'
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      cat tmp/subdomains.txt | waybackurls | gf xss | anew tmp/xss | notify -silent
    else
      cat tmp/subdomains.txt | waybackurls | gf xss | anew tmp/xss
    fi
    sleep 3600
  done
}

#### END FUNCTIONS ####

figlet XSS

notify_enabled=$NOTIFY

echo "
Will search by domain and write tmp/js.txt

0 - Dalfox 
1 - Kxss 
2 - GF 

99 - search by subdomains
100 - enable notify
"

read -p 'Choose your service: ' service

case $service in
  '0' | 0)
    dalfo
    ;;
  '1' | 1)
    kxs
    ;;
  '2' | 2)
    gf_xss
    ;;
  '99' | 99)
    ./src/monitoring.sh
    ;;
  '100' | 100)
    echo "run this: export NOTIFY=true"
    ;;
esac
