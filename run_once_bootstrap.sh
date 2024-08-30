#!/bin/bash

os_code_name=$(lsb_release -cs)
font_name="Ubuntu Mono"

# mirror
## ubuntu
sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources
sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources
sudo sed -i 's/http:/https:/g' /etc/apt/sources.list.d/ubuntu.sources
sudo apt-get update
## pip
pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/simple
## npm
npm config set registry https://registry.npmmirror.com
## nvm
NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/
NODE_MIRROR=https://mirrors.ustc.edu.cn/node/

# font
if test -z "$(fc-list | grep $font_name)"; then
    font_version="$(curl https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep -E 'tag_name\": \"v[0-9]+\.[0-9]+\.[0-9]+' -o |head -n 1| tr -d 'tag_name\": \"')"
    wget -O /tmp/ubuntu_mono.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/download/$font_version/UbuntuMono.tar.xz
    tar -xf /tmp/ubuntu_mono.tar.xz
    if [ ! -d "~/.fonts" ]; then
	mkdir ~/.fonts
    fi
    cp /tmp/ubuntu_mono/* ~/.fonts
    fc-cache -f
fi
# fishshell
sudo apt-get install fish
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish 
# alacritty
sudo add-apt-repository ppa:system76/pop
sudo sed -i 's/https:\/\/ppa.launchpadcontent.net/https:\/\/launchpad.proxy.ustclug.org/g' /etc/apt/sources.list.d/system76-ubuntu-pop-$os_code_name.list
sudo apt-get update
sudo apt-get install alacritty

