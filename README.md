# PiDNS

## Use

### Install [Pi-hole](https://pi-hole.net/)

```bash
curl --proto '=https' --tlsv1.2 -sSfL https://install.pi-hole.net | bash
```


### Enable WiFi (if you want)

```bash
sudo aptitude install network-manager
nmcli d wifi list
nmcli d wifi connect <wifi> password <password>
```

## Documentation

- [pi-hole.net](https://pi-hole.net/)


## Acknowledgements

- [@scotthelme](https://github.com/scotthelme): [DNS over HTTPS](https://scotthelme.co.uk/securing-dns-across-all-of-my-devices-with-pihole-dns-over-https-1-1-1-1/)
- [@scotthelme](https://github.com/scotthelme): [Catching naughty devices](https://scotthelme.co.uk/catching-naughty-devices-on-my-home-network/)
