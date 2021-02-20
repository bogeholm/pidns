# Unifi setup

Based on [Catching naughty devices](https://scotthelme.co.uk/catching-naughty-devices-on-my-home-network/)

## Rule numbering

> _The custom rules created in the `config.gateway.json` cannot have duplicate rule numbers with the existing rules in the USG, or there will be a provisioning loop. It is recommended to put custom rules before the existing ruleset, as the lower number will win between two matching rules._ ([source](https://help.ui.com/hc/en-us/articles/215458888-UniFi-USG-Advanced-Configuration-Using-config-gateway-json))

The rules we create in [`config.gateway.json`](config.gateway.json) will start at `2000`, since rules created in the UI start at `3000`.

## Location of `config.gateway.json` 

### On Cloud Key, Gen 2

1. The `config.gateway.json` goes to `<unifi_base>/data/sites/<site_ID>` ([link](https://help.ui.com/hc/en-us/articles/215458888-UniFi-USG-Advanced-Configuration-Using-config-gateway-json))

2. On Cloud Key, `<unifi_base>` is `/usr/lib/unifi` ([link](https://help.ui.com/hc/en-us/articles/115004872967))

3. `<site_ID>` is the site name seen in the controller URL in a browser ([link]())
```html
https://127.0.0.1:8443/manage/site/<site_ID>/dashboard
```

So on a vanilla setup, that would be

```bash
/usr/lib/unifi/data/sites/default/config.gateway.json
```

### Ownership 

The `config.gateway.json` must have `unifi:unifi` as owner

#### To check

```bash
ls -l
```

#### To change

```bash
chown unifi:unifi config.gateway.json
```

## DNS over TLS

- https://community.ui.com/questions/Block-outgoing-traffic-I-dont-understand-/7008e42e-7b4f-4896-ad1c-24731ae9e05d
- https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Clients#DNSPrivacyClients-Commandlineclients
- https://www.knot-resolver.cz/download/
- https://launchpad.net/ubuntu/bionic/+package/knot-dnsutils

### Create blocking rule

```yaml
- Type: LAN IN  # Traffic entering the LAN interface
- Description: Block DNS over TLS
- Rule applied: Before
- Action: Drop
- IPv4 protocol: All
- Source: Network
- Network: <choose relevant network>
- Destination: Address/Port Group
- Port Group: <Create group with port 853>
- Enable logging: <up to you>
```

### Test

Make a `telnet` connection to [a DNS-over-TLS provider](https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Public+Resolvers) from the affected network:

```bash
# Should not succeed - blocked
telnet 9.9.9.9 853

# Should succeed - not blocked
telnet 9.9.9.9 443
```

If you enabled logging when you set up the rule, you should see a log entry:
```bash
# SSH into the USG
tail -f /var/log/messages

Feb  4 21:59:05 USG-Pro-4One kernel: [LAN_IN-4000-D]IN=eth0 OUT=eth2 MAC=<snip> SRC=192.168.3.52 DST=9.9.9.9 LEN=64 TOS=0x00 PREC=0x00 TTL=63 ID=0 DF PROTO=TCP SPT=50970 DPT=853 WINDOW=65535 RES=0x00 SYN URGP=0 
```

# Documentation

## Unifi

- The [`config.gateway.json` file](https://help.ui.com/hc/en-us/articles/215458888-UniFi-Advanced-USG-Configuration)
- [Location of `config.gateway.json`](https://help.ui.com/hc/en-us/articles/115004872967)
- https://help.ui.com/hc/en-us/articles/115010254227-UniFi-USG-Firewall-How-to-Disable-InterVLAN-Routing
- https://community.ui.com/questions/How-to-force-user-to-reconnect-after-changing-static-local-ip/333b5ad5-24f6-4f1d-b43c-dfefb6e5129c


## Other

- https://gist.github.com/troyfontaine/a0a0098d6a8c333e5316ebf16db1c425
- https://forum.netgate.com/topic/139457/transparently-intercept-and-redirect-dns-traffic-to-an-internal-dns/4
- https://raw.githubusercontent.com/Sekhan/TheGreatWall/master/TheGreatWall.txt
- https://www.reddit.com/r/Ubiquiti/comments/ii3lan/unifi_pihole_doing_it_right_with_usg/
- https://fauxzen.com/force-all-dns-traffic-to-pi-hole/