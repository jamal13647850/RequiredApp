#!/bin/bash

#chech run as sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#Update system
echo "Start Update System . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . "
sudo yum -y update && sudo yum -y upgrade

#Install xclip
echo "Install xclip . . . . . . . . . . . . . . . . . . . . . . "
sudo yum -y install epel-release.noarch
sudo yum -y install xclip

#Install xsel
echo "Install xsel . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . "
sudo yum -y install epel-release.noarch
sudo yum -y install xsel

#Install wget curl nano
echo "Install wget curl nano . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . "
sudo dnf -y install wget curl nano

#Install and config tmux
echo "Install and config tmux . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . "
sudo yum -y install tmux
sudo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sudo cp -v ./.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf




#Install and config kakoun
echo "Install and config kakoun . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . "
sudo yum -y install epel-release
sudo yum repolist
sudo yum -y install kakoune

sudo mkdir -p $HOME/.config/kak/plugins 

sudo git clone https://github.com/andreyorst/plug.kak.git $HOME/.config/kak/plugins/plug.kak 



sudo echo "map global user y '<a-|>xclip -i -selection clipboard<ret>'">>/usr/share/kak/kakrc
sudo echo "map global user p '!xclip -o<ret>'">>/usr/share/kak/kakrc

sudo echo 'hook global ModeChange (push|pop):insert:.* %{
    set-face global PrimaryCursor      rgb:ffffff,rgb:008800+F
}

hook global ModeChange (push|pop):.*:insert %{
    set-face global PrimaryCursor      rgb:ffffff,rgb:880000+F
}'>>/usr/share/kak/kakrc

sudo echo 'source "%val{config}/plugins/plug.kak/rc/plug.kak"'>>/usr/share/kak/kakrc
sudo echo 'plug "andreyorst/plug.kak" noload"'>>/usr/share/kak/kakrc


sudo echo 'source "plug "andreyorst/kaktree" config %{ 

    hook global WinSetOption filetype=kaktree %{

        remove-highlighter buffer/numbers

        remove-highlighter buffer/matching

        remove-highlighter buffer/wrap

        remove-highlighter buffer/show-whitespaces

    }

    kaktree-enable

} '>>/usr/share/kak/kakrc


#Install wp cli
echo "Install wp cli . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . "
sudo wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
sudo chmod +x wp-cli.phar 
sudo mv wp-cli.phar /usr/local/bin/wp 
export WP_CLI_ALLOW_ROOT=true

#Install bashtop: 
echo "Install bashtop . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . "
sudo git clone https://github.com/aristocratos/bashtop.git 
sudo yum -y install make
(cd bashtop/ && sudo make install)

#Install ctop: 
echo "Install ctop . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . "
sudo wget https://github.com/bcicen/ctop/releases/download/0.7.6/ctop-0.7.6-linux-amd64 -O /usr/local/bin/ctop 
sudo chmod +x /usr/local/bin/ctop 

#Install and config ZSH
# echo "Install and config ZSH . . . . . . . . . . . . . . . . . . . . . . "
# sudo yum -y install zsh 
# zsh --version

# sudo dnf install util-linux-user
# sudo chsh -s $(which zsh)

# echo $SHELL

# echo "alias crontab='EDITOR=kak /usr/bin/crontab'">>~/.zshrc
# echo "alias crontab='EDITOR=kak /usr/bin/crontab'">>~/.bashrc

# sudo sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"