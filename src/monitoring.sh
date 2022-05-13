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
      chaos -d $domain -silent | anew tmp/subdomains.txt | notify -silent
    else
      chaos -d $domain -silent | anew tmp/subdomains.txt
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

githubSearch() {
  figlet Github Search

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      python3 /opt/github-search/github-subdomains.py -t GITHUB_TOKEN -d $domain | anew tmp/subdomains.txt | notify -silent
    else
      python3 /opt/github-search/github-subdomains.py -t GITHUB_TOKEN -d $domain | anew tmp/subdomains.txt
    fi
    sleep 3600
  done
}

mass() {
  figlet Amass

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "true" ]
    then
      amass enum -d $domain | anew tmp/subdomains.txt | notify -silent
    else
      amass enum -d $domain | anew tmp/subdomains.txt
    fi
    sleep 3600
  done
}

validateUrls() {
  figlet HTTPX

  file="tmp/subdomains_unresolved.txt"
  mv tmp/subdomains.txt $file

  if [ "$notify_enabled" == "true" ]
  then
    cat $file | httpx -silent | anew tmp/subdomains.txt | notify -silent
  else
    cat $file | httpx -silent | anew tmp/subdomains.txt
  fi

  rm -rf $file
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
4 - assetfinder (subs-only)
5 - github search
6 - amass

97 - validate URLS
98 - search by javascripts
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
  '5' | 5)
    githubSearch
    ;;
  '6' | 6)
    mass
    ;;
  '97' | 97)
    validateUrls
    ;;
  '98' | 98)
    ./src/search_javascripts.sh
    ;;
  '99' | 99)
    ./src/search_xss.sh
    ;;
  '100' | 100)
    echo "run this: export NOTIFY=true"
    ;;
esac
