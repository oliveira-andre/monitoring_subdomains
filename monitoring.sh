#!/bin/bash

#### FUNCTIONS ####

crt() {
  figlet CRT

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      curl -s "https://crt.sh/?q=%.$domain&output=json" | jq -r '.[].name_value' | sed 's/\*//g' | anew tmp/subdomains.txt | notify -silent
    else
      curl -s "https://crt.sh/?q=%.$domain&output=json" | jq -r '.[].name_value' | sed 's/\*//g' | anew tmp/subdomains.txt
    fi
    sleep 3600
  done
}

sbfinder() {
  figlet Subfinder

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      subfinder -d $domain -silent | anew tmp/subdomains.txt | notify -silent
    else
      subfinder -d $domain -silent | anew tmp/subdomains.txt
    fi
    sleep 3600
  done
}

caos() {
  figlet Chaos

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      chaos -d $domain -silent -o tmp/subdomains.txt | notify -silent
    else
      chaos -d $domain -silent -o tmp/subdomains.txt
    fi
    sleep 3600
  done
}

hcktrails() {
  figlet Hacktrails

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      echo $domain | hacktrails subdomains | anew tmp/subdomains.txt | notify -silent
    else
      echo $domain | hacktrails subdomains | anew tmp/subdomains.txt
    fi
    sleep 3600
  done
}

ssetfinder() {
  figlet Assetfinder

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      assetfinder -subs-only $domain | anew tmp/subdomains.txt | notify -silent
    else
      assetfinder -subs-only $domain | anew tmp/subdomains.txt
    fi
    sleep 3600
  done
}

search_by_xss() {
  figlet XSS

  file='tmp/subdomains.txt'
  while :
  do
    while read -r subdomain
    do
      echo "searching by XSS in: $subdomain"
      if [ "$notify_enabled" == "true" ]
      then
        gau -subs $subdomain | dalfox pipe --silence --skip-bav | notify -silent
      else
        gau -subs $subdomain | dalfox pipe --silence --skip-bav
      fi
    done < $file
    sleep 3600
  done
}

#### END FUNCTIONS ####

figlet Monitoring

notify_enabled=$NOTIFY

echo "
Will search by domain and write tmp/subdomains.txt

0 - crt.sh 
1 - subfinder
2 - chaos
3 - hacktrails
4 - assetfinder

99 - search by xss
100 - enable notify
"

read -p 'Choose your service: ' service

case $service in
  '0' | 0)
    crt
    ;;
  '1' | 1)
    sbfinder
    ;;
  '2' | 2)
    caos
    ;;
  '3' | 3)
    hcktrails
    ;;
  '4' | 4)
    ssetfinder
    ;;
  '99' | 99)
    search_by_xss
    ;;
  '100' | 100)
    echo "run this: export NOTIFY=true"
    ;;
esac
