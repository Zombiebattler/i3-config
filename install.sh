#!/bin/bash
# URL'S
ZSH_CONFIG_URL="https://raw.githubusercontent.com/Zombiebattler/linux-customization/refs/heads/main/configs/zshrc"

# Software
sudo pacman -Syu --noconfirm
sudo pacman -S cowsay zsh feh picom kitty mtr curl ttf-droid nerd-fonts rofi --noconfirm
sudo pacman -S --needed base-devel git --noconfirm

# yay
rm -rf "$HOME/yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf "$HOME/yay"
yay -S i3lock-color --noconfirm

# oh-my-zsh + plugins & config >
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"

[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
curl -fsSL "$ZSH_CONFIG_URL" -o "$HOME/.zshrc"

# Zielverzeichnisse erstellen
mkdir -p "$HOME/.config/i3/configs"
mkdir -p "$HOME/.config/i3/scripts"
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/.config/picom"

# Repo neu klonen (vorher alten Ordner löschen, falls vorhanden)
rm -rf ~/i3-config
git clone https://github.com/Zombiebattler/i3-config.git ~/i3-config

# Kitty & Picom configs kopieren
cp -R ~/i3-config/picom/* "$HOME/.config/picom/"
cp -R ~/i3-config/kitty/* "$HOME/.config/kitty/"

# i3 main config ersetzen
cp -r "$HOME/.config/i3/config" "$HOME/.config/i3/config.backup"
rm -f "$HOME/.config/i3/config"
cp ~/i3-config/i3/config "$HOME/.config/i3/config"

# Scripts kopieren
cp -R ~/i3-config/i3/scripts/* "$HOME/.config/i3/scripts/"
find "$HOME/.config/i3/scripts" -type f -exec chmod +x {} \;

# Weitere i3-configs kopieren
cp -R ~/i3-config/i3/configs/* "$HOME/.config/i3/configs/"



# Done.
echo "✅ Done"