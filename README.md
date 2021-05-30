# Monitoring Scripts

## Pre requisites

- [figlet](https://github.com/cmatsuoka/figlet)
- [curl](https://github.com/curl/curl)
- [jq](https://github.com/stedolan/jq)
- [anew](https://github.com/tomnomnom/anew)
- [subfinder](https://github.com/projectdiscovery/subfinder)
- [chaos](https://github.com/projectdiscovery/chaos-client)
- [gau](https://github.com/lc/gau)
- [dalfox](https://github.com/hahwul/dalfox)
- [notify](https://github.com/projectDiscovery/notify)

running app
```
make run
```

or

```
chmod +x ./monitoring.sh && ./monitoring.sh
```

## Steps

### Subdomains Finder

```
Will search by domain and write tmp/subdomains.txt

0 - crt.sh                                                         
1 - subfinder                                                      
2 - chaos                                                          
3 - hacktrails                                                     

99 - search by xss                                                 
100 - enable notify                                                

Choose your service: 1
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
