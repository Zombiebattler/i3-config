#!bin/bash
ZSH_CONFIG_URL="https://raw.githubusercontent.com/Zombiebattler/linux-customization/refs/heads/main/configs/zshrc"


# Software
sudo pacman -Syu --noconfirm
sudo pacman -S cowsay zsh feh picom kitty mtr curl ttf-droid nerd-fonts rofi --noconfirm
sudo pacman -S --needed base-devel git --noconfirm

rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
yay -S i3lock-color --noconfirm


# oh-my-zsh + plugins & config >
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"

cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
curl -fsSL "$ZSH_CONFIG_URL" -o "$HOME/.zshrc"

# Create Folders

mkdir -R "$HOME/.config/i3/configs"
mkdir -R "$HOME/.config/i3/scripts"
mkdir -R "$HOME/.config/kitty"
mkdir -R "$HOME/.config/picom"

# Download Content



# Done.
echo "✅ Done"