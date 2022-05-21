#!/bin/bash

#check run as sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

source functions.sh

echo "Please enter non-root user:"
read non_root_user

#Update system
echoTitle 1 16 'Start Update System'

sudo yum -y update && sudo yum -y upgrade

#Install xclip
echoTitle 2 16 'Install xclip'

sudo yum -y install epel-release.noarch
sudo yum -y install xclip

#Install xsel
echoTitle 3 16 'Install xsel'

sudo yum -y install epel-release.noarch
sudo yum -y install xsel

#Install wget curl nano tar
echoTitle 4 16 'Install wget curl nano tar'

sudo dnf -y install wget curl nano tar

#Install and config tmux
echoTitle 5 16 'Install and config tmux'

sudo yum -y install tmux
sudo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sudo cp -v ./.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf




#Install and config kakoune
echoTitle 6 16 'Install and config kakoune'

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
sudo echo 'plug "andreyorst/plug.kak" noload'>>/usr/share/kak/kakrc


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
echoTitle 7 16 'Install wp cli'

sudo wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
export WP_CLI_ALLOW_ROOT=true

#Install bashtop:
echoTitle 8 16 'Install bashtop'

sudo git clone https://github.com/aristocratos/bashtop.git
sudo yum -y install make
(cd bashtop/ && sudo make install)

#Install ctop:
echoTitle 9 16 'Install ctop'

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
echoTitle 10 16 'Install clameav anti virus'

sudo yum info perl
sudo yum -y install perl
perl -v
sudo yum -y install -y epel-release
sudo yum -y install -y clamav

#Install Rkhunter
echoTitle 11 16 'Install Rkhunter'

sudo yum -y install rkhunter

#Install sendmail :
echoTitle 12 16 'Install sendmail'

sudo yum install sendmail -y

#Install CSF :
echoTitle 13 16 'Install CSF'

cd /usr/src
sudo rm -fv csf.tgz
sudo wget https://download.configserver.com/csf.tgz
sudo tar -xzf csf.tgz
cd csf
sudo sh install.sh
sudo perl /usr/local/csf/bin/csftest.pl
sudo yum -y install perl-libwww-perl.noarch perl-LWP-Protocol-https.noarch perl-GDGraph
#ADD CloudFlare And Uptimerobot to white list:

echoTitle 13 16 'ADD CloudFlare And Uptimerobot to white list'

for i in `curl https://www.cloudflare.com/ips-v4`; do sudo csf -a $i; done

for i in `curl https://www.cloudflare.com/ips-v4`; do sudo echo $i >> /etc/csf/csf.ignore; done

curl -s https://uptimerobot.com/inc/files/ips/IPv4andIPv6.txt | while read i; do sudo csf -a $i; done

sudo csf -r

sudo systemctl restart docker

#Install rsync :
echoTitle 14 16 'Install rsync'

sudo dnf -y install rsync

#Install docker and docker compose
echoTitle 15 16 'Install docker and docker compose'

sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo 
sudo dnf update 
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker 
sudo systemctl start docker 
#sudo systemctl status docker 

sudo dnf install -y fuse-overlayfs
sudo dnf install -y iptables
sudo systemctl disable --now docker.service docker.socke
dockerd-rootless-setuptool.sh install
systemctl --user start docker
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker $non_root_user 

#Clean cache alias
echoTitle 1 16 'Clean cache alias'

echo "alias cleancache='docker exec -it webserver rm -rf ./etc/nginx-cache/'">>~/.bashrc
source ~/.bashrc

echoTitle 2 16 'Please reboot'