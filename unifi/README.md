# Unifi setup

Based on [Catching naughty devices](https://scotthelme.co.uk/catching-naughty-devices-on-my-home-network/)

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

- Type: LAN IN  # Traffic entering the LAN interface
- Description: Block DNS over TLS
- Rule applied: after
- Action: Drop
- IPv4 protocol: All
- Source: Network
- Network: <choose relevant network>
- Destination: Address/Port Group
- Port Group: <Create group with port 853>
- Enable logging: <up to you>

### Test

Make a `telnet` connection to [a DNS-over-TLS provider](https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Public+Resolvers) from the affected network:

```bash
# Should not succeed - blocked
telnet 9.9.9.9 853

# Should succeed - not blocked
telnet 9.9.9.9 443
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