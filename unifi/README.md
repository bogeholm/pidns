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
/usr/lib/unifi/data/sites/config.gateway.json
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

## Documentation

### Unifi

- The [`config.gateway.json` file](https://help.ui.com/hc/en-us/articles/215458888-UniFi-Advanced-USG-Configuration)
- [Location of `config.gateway.json`](https://help.ui.com/hc/en-us/articles/115004872967)

### Other

- https://gist.github.com/troyfontaine/a0a0098d6a8c333e5316ebf16db1c425
- https://forum.netgate.com/topic/139457/transparently-intercept-and-redirect-dns-traffic-to-an-internal-dns/4