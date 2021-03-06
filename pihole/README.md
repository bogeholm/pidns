# Install [Pi-hole](https://pi-hole.net/)

```bash
curl --proto '=https' --tlsv1.2 -sSfL https://install.pi-hole.net | bash
```

## Pihole whitelists and blacklists

## DNS over HTTPS
Blacklists - add in the admin UI
- https://raw.githubusercontent.com/Sekhan/TheGreatWall/master/TheGreatWall.txt
- https://raw.githubusercontent.com/oneoffdallas/dohservers/master/list.txt

## Whitelist
See [`whitelist.txt`](whitelist.txt). Add to the Pi from the terminal:
```bash
rg -v '^#' whitelist.txt | xargs -I {} pihole -w {}
```

Check `/etc/pihole/whitelist.txt` and confirm the domains were added.

## Update gravity
After updating white- or blacklists, run `pihole -g`

## Check status of specific domain
```bash
pihole -q <domain>
```

# Documentation
- https://docs.pi-hole.net/guides/whitelist-blacklist/
- https://discourse.pi-hole.net/t/what-files-does-pi-hole-use/1684
- https://discourse.pi-hole.net/t/doh-dns-over-https-ip-block-list-s/30393
