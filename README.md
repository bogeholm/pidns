# PiDNS

## Use

### Set up [Cloudflare DNS server](https://developers.cloudflare.com/1.1.1.1/dns-over-https/cloudflared-proxy) on [port 54](cloudflaredns.service.template)

```bash
git clone https://github.com/bogeholm/pidns.git && cd pidns
./download.sh
./install.sh
./test.sh
```


### Install [Pi-hole](https://pi-hole.net/)

```bash
bash <(curl -fL https://install.pi-hole.net)
```


### Enable WiFi (if you want)

```bash
sudo aptitude install network-manager
nmcli d wifi list
nmcli d wifi connect <wifi> password <password>
```

### Useful Raspberry tools

```bash
sudo apt-get install aptitude jq net-tools nmap mosh ripgrep
```


## Documentation

- [pi-hole.net](https://pi-hole.net/)


## Acknowledgements

- [@scotthelme](https://github.com/scotthelme): [DNS over HTTPS](https://scotthelme.co.uk/securing-dns-across-all-of-my-devices-with-pihole-dns-over-https-1-1-1-1/)
- [@scotthelme](https://github.com/scotthelme): [Catching naughty devices](https://scotthelme.co.uk/catching-naughty-devices-on-my-home-network/)
