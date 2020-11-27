# PiDNS

## PiHole
- [pihole.net](https://pi-hole.net/)

### Install
```bash
bash <(curl -fL https://install.pi-hole.net)
```

### Enable WiFi (if you want)
```bash
sudo aptitude install network-manager
nmcli d wifi list
nmcli d wifi connect <wifi> password <password>
```

## Credits / references
- [Scott Helme](https://scotthelme.co.uk/securing-dns-across-all-of-my-devices-with-pihole-dns-over-https-1-1-1-1/)
