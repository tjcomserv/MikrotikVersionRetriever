# Mikrotik Version Retriever
A script to get the latest Mikrotik version

Usage: GetMikrotikLatest.sh [-s | -d | -l | -t]
  -s: Returns the latest Stable release
  -d: Returns the latest Development release
  -l: Returns the latest Long-term release
  -t: Returns the latest Testing release

Example:
```
wget "https://github.com/tjcomserv/MikrotikVersionRetriever/raw/refs/heads/main/GetMikrotikLatest.sh" -q && bash ./GetMikrotikLatest.sh -s
```

Output:

7.19.1
