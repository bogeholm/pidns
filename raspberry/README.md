# Raspberry Pi Configuration Suggestions

Instructions below are tested on my [Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/) running [Ubuntu Server 20.04.2 LTS](https://ubuntu.com/download/raspberry-pi). They'll likely work on [Raspberry Pi OS](https://www.raspberrypi.org/software/) as well.

## Useful Raspberry tools

```bash
# `pkg-config` and `libssl-dev` required by `cargo install starship` below
sudo apt-get install aptitude build-essential jq libssl-dev net-tools network-manager nmap pkg-config ripgrep unzip zsh
```

## Enabling WiFi (if necessary)

```bash
sudo aptitude install network-manager
nmcli d wifi list
nmcli d wifi connect <wifi> password <password>
```

## Starship

### [Nerd Font](https://www.nerdfonts.com/font-downloads)

Use [FiraCode](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip) as an example:

```bash
mkdir fonts
pushd fonts

curl -fLo FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip

unzip FiraCode.zip

# https://linuxconfig.org/how-to-install-fonts-on-ubuntu-20-04-focal-fossa-linux
mkdir -p "/home/$(whoami)/.local/share/fonts"

# https://unix.stackexchange.com/questions/56903/
ls | rg ttf | rg Mono | rg Fira | rg -v Windows | xargs -I{} mv {} "/home/$(whoami)/.local/share/fonts"

popd
rm -r fonts
```

### Install starship

```bash
# No armhf target at https://github.com/starship/starship/tags as of yet
sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)
source $HOME/.cargo/env
cargo install starship

# If starship is not found at login:
sudo mv /home/ubuntu/.cargo/bin/starship /usr/local/bin/starship
```

### Starship config

1. Edit [`~/.bashrc`](https://starship.rs/)

```bash
# ~/.bashrc
eval "$(starship init bash)"
```

2. Create `config.toml`
```bash
mkdir -p ~/.config && touch ~/.config/starship.toml
```

3. Edit `config.toml`

```bash
# ~/.config/starship.toml
# https://starship.rs/config/#prompt
add_newline = false

[character]                            # The name of the module we are configuring is "character"
success_symbol = "[❯❯](bold blue)"     # The "success_symbol" segment is being set to "❯❯" with the color "bold blur"

# Disable the package module, hiding it from the prompt completely
[package]
disabled = true
```

### Miniconda Python

```bash
curl --proto '=https' --tlsv1.2 -sSf -o miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-armv7l.sh

# Compare with https://repo.anaconda.com/miniconda/
md5sum miniconda3.sh

# Do not use sudo
bash miniconda3.sh

# 0) Use cheat code 'Enter' + 'Space'
# 1) Type 'yes'
# 2) Install in /home/ubuntu/miniconda3 (default)

# If not done by installer, add the following to ~/.bashrc
export PATH="/home/ubuntu/miniconda3/bin:$PATH"
```