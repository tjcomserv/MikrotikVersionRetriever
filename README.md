# Mikrotik Version Retriever
A script to get the latest Mikrotik version

Usage: GetMikrotikLatest.sh [-s | -d | -l | -t]\
  -s: Returns the latest Stable release\
  -d: Returns the latest Development release\
  -l: Returns the latest Long-term release\
  -t: Returns the latest Testing release\

Example:
```
wget -q "https://github.com/tjcomserv/MikrotikVersionRetriever/raw/refs/heads/main/GetMikrotikLatest.sh" -O GetMikrotikLatest.sh && bash ./GetMikrotikLatest.sh -s
```

Output:\
7.19.1

To download the latest stable main package for x86 as a oneliner you could use:

```
ver=$(wget -q https://github.com/tjcomserv/MikrotikVersionRetriever/raw/refs/heads/main/GetMikrotikLatest.sh -O GetMikrotikLatest.sh && bash GetMikrotikLatest.sh -s) && wget https://download.mikrotik.com/routeros/$ver/routeros-$ver.npk -O routeros-$ver.npk
```
