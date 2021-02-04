# Raspberry Pi Configuration Suggestions

## Useful Raspberry tools

```bash
# `pkg-config` and `libssl-dev` required by `cargo install starship`
sudo apt-get install aptitude build-essential jq libssl-dev net-tools network-manager nmap pkg-config ripgrep unzip zsh
```

## Starship

### [Nerd Font](https://www.nerdfonts.com/font-downloads)

Use [FiraCode](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip) as an example:

```bash
mkdir fonts
cd fonts  # or `pushd fonts`
curl -fLo FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip
# https://linuxconfig.org/how-to-install-fonts-on-ubuntu-20-04-focal-fossa-linux
mkdir -p "/home/$(whoami)/.local/share/fonts"
# https://unix.stackexchange.com/questions/56903/
ls | rg ttf | rg Mono | rg Fira | rg -v Windows | xargs -I{} mv {} "/home/$(whoami)/.local/share/fonts"
cd ..  # or `popd`
rm -r fonts
```

### Install starship

```bash
# No armhf target at https://github.com/starship/starship/tags as of yet
sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)
source $HOME/.cargo/env
cargo install starship
# Optionally, if starship is not found at login
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