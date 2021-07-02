#!/bin/bash

subsjs() {
  figlet Subsjs

  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      cat tmp/subdomains.txt | subjs | anew tmp/js.txt | notify -silent
      cat tmp/subdomains.txt | gau | subsjs | anew tmp/js.txt | notify -silent
    else
      cat tmp/subdomains.txt | subjs | anew tmp/js.txt
      cat tmp/subdomains.txt | gau | subsjs | anew tmp/js.txt
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
      cat tmp/subdomains.txt | waybackurls | grep -E "\.js(?:onp?)?$" | anew tmp/js.txt | notify -silent
    else
      cat tmp/subdomains.txt | waybackurls | grep -E "\.js(?:onp?)?$" | anew tmp/js.txt
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
      cat tmp/subdomains.txt | gau | grep -E "\.js(?:onp?)?$" | anew tmp/js.txt | notify -silent
    else
      cat tmp/subdomains.txt | gau | grep -E "\.js(?:onp?)?$" | anew tmp/js.txt
    fi
    sleep 3600
  done
}

validateJavascripts() {
  figlet anti-burl

  file="tmp/javascripts_unresolved.txt"
  mv tmp/js.txt $file

  if [ "$notify_enabled" == "true" ]
  then
    cat $file | anti-burl | awk '{print $4}' | anew tmp/js.txt | notify -silent
  else
    cat $file | anti-burl | awk '{print $4}' | anew tmp/js.txt
  fi

  rm -rf $file
}

#### END FUNCTIONS ####

figlet JS Enumeration

notify_enabled=$NOTIFY

echo "
Will search by domain and write tmp/js.txt

0 - Subsjs
1 - Waybackurls
2 - Gau

97 - validate javascripts
98 - collect info from javascripts
99 - search by subdomains
100 - enable notify
"

read -p 'Choose your service: ' service

case $service in
  '0' | 0)
    subsjs
    ;;
  '1' | 1)
    wayback
    ;;
  '2' | 2)
    gu
    ;;
  '97' | 97)
    validateJavascripts
    ;;
  '98' | 98)
    collectorJavascript
    ;;
  '99' | 99)
    ./src/monitoring.sh
    ;;
  '100' | 100)
    echo "run this: export NOTIFY=true"
    ;;
esac
