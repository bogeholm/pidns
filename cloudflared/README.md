# Set up [Cloudflare DNS server](https://developers.cloudflare.com/1.1.1.1/dns-over-https/cloudflared-proxy) on [port 54](cloudflaredns.service.template)

```bash
git clone https://github.com/bogeholm/pidns.git && cd pidns/cloudflared
sudo ./download.sh  # sudo required to move binary to /usr/local/bin
sudo ./install.sh   # sudo required to write to /etc/systemd/system/cloudflaredns.service
sudo reboot
# Get a beer or coffee
./test.sh
```