# Monitoring Scripts

## Pre requisites

- [figlet](https://github.com/cmatsuoka/figlet)
- [curl](https://github.com/curl/curl)
- [jq](https://github.com/stedolan/jq)
- [anew](https://github.com/tomnomnom/anew)
- [assetfinder](https://github.com/tomnomnom/assetfinder)
- [subfinder](https://github.com/projectdiscovery/subfinder)
- [chaos](https://github.com/projectdiscovery/chaos-client)
- [github search](https://github.com/gwen001/github-search)
- [gau](https://github.com/lc/gau)
- [dalfox](https://github.com/hahwul/dalfox)
- [notify](https://github.com/projectDiscovery/notify)

running app
```
make run
```

or

```
chmod +x ./src/*.sh && ./src/monitoring.sh
```

## Steps

### Subdomains Finder

```
 __  __             _ _             _             
|  \/  | ___  _ __ (_) |_ ___  _ __(_)_ __   __ _ 
| |\/| |/ _ \| '_ \| | __/ _ \| '__| | '_ \ / _` |
| |  | | (_) | | | | | || (_) | |  | | | | | (_| |
|_|  |_|\___/|_| |_|_|\__\___/|_|  |_|_| |_|\__, |
                                            |___/ 

Will search by domain and write tmp/subdomains.txt

0 - crt.sh 
1 - subfinder
2 - chaos
3 - hacktrails
4 - assetfinder
5 - github search
6 - amass

99 - search by xss
100 - enable notify

Choose your service: 
```

> if you enable notify you need to configure previously the bot

### Search by XSS (you must have the file `tmp/subdomains.txt`)

```
__  ______ ____  
\ \/ / ___/ ___| 
 \  /\___ \___ \ 
 /  \ ___) |__) |
/_/\_\____/____/ 
                 
searching by XSS in: live-iad.twitch.tv
searching by XSS in: www.lion.rc.twitch.tv
searching by XSS in: live-rio.twitch.tv
searching by XSS in: schwaben-redirector.cp2.rc.twitch.tv
searching by XSS in: android.tv.twitch.tv
searching by XSS in: dev-extensions.sings.twitch.tv
searching by XSS in: production.helix-origin.twitch.tv
```
