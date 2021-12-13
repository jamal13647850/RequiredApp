#!/bin/bash

#check run as sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#Update system
echo -e '\e[1;31mStart Update System \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'
sudo yum -y update && sudo yum -y upgrade

#Install xclip
echo -e '\e[1;31mInstall xclip \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'
sudo yum -y install epel-release.noarch
sudo yum -y install xclip

#Install xsel
echo -e '\e[1;31mInstall xsel \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'

sudo yum -y install epel-release.noarch
sudo yum -y install xsel

#Install wget curl nano
echo -e '\e[1;31mInstall wget curl nano \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'

sudo dnf -y install wget curl nano

#Install and config tmux
echo -e '\e[1;31mInstall and config tmux \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'

sudo yum -y install tmux
sudo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sudo cp -v ./.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf




#Install and config kakoune
echo -e '\e[1;31mInstall and config kakoun \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'

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

echo "alias crontab='EDITOR=kak /usr/bin/crontab'">>~/.bashrc



#Install wp cli
echo -e '\e[1;31mInstall wp cli \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'
sudo wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
export WP_CLI_ALLOW_ROOT=true

#Install bashtop:
echo -e '\e[1;31mInstall bashtop \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'
sudo git clone https://github.com/aristocratos/bashtop.git
sudo yum -y install make
(cd bashtop/ && sudo make install)

#Install ctop:
echo -e '\e[1;31mInstall ctop \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'
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

#Install clameav anti virus:
echo -e '\e[1;31mInstall clameav anti virus \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'

sudo yum info perl
sudo yum -y install perl
perl -v
sudo yum -y install -y epel-release
sudo yum -y install -y clamav

#Install sendmail :
echo -e '\e[1;31mInstall sendmail  \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'
sudo yum install sendmail -y

#Install CSF :
echo -e '\e[1;31mInstall CSF  \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'

cd /usr/src
sudo rm -fv csf.tgz
sudo wget https://download.configserver.com/csf.tgz
sudo tar -xzf csf.tgz
cd csf
sudo sh install.sh
sudo perl /usr/local/csf/bin/csftest.pl
sudo yum -y install perl-libwww-perl.noarch perl-LWP-Protocol-https.noarch perl-GDGraph
#ADD CloudFlare And Uptimerobot to white list:
echo -e '\e[1;31mADD CloudFlare And Uptimerobot to white list  \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'
for i in `curl https://www.cloudflare.com/ips-v4`; do sudo csf -a $i; done

for i in `curl https://www.cloudflare.com/ips-v4`; do sudo echo $i >> /etc/csf/csf.ignore; done

curl -s https://uptimerobot.com/inc/files/ips/IPv4andIPv6.txt | while read i; do sudo csf -a $i; done

sudo csf -r

sudo systemctl restart docker

#Install rsync :
echo -e '\e[1;31mInstall rsync  \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'

sudo dnf -y install rsync

#Clean cache alias
echo -e '\e[1;31mClean cache alias  \e[1;35m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'
echo "alias cleancache='docker exec -it webserver rm -rf ./etc/nginx-cache/'">>~/.bashrc
source ~/.bashrc