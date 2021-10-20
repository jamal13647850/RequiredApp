#Update system
sudo yum -y update && sudo yum -y upgrade

#Install xclip
sudo yum -y install epel-release.noarch
sudo yum -y install xclip

#Install xsel
sudo yum -y install epel-release.noarch
sudo yum -y install xsel

#Install and config tmux
sudo yum -y install tmux
sudo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sudo cp -v ./.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf




#Install and config kakoun
sudo yum -y install epel-release
sudo yum repolist
sudo yum -y install kakoune

sudo mkdir -p $HOME/.config/kak/plugins 

sudo git clone https://github.com/andreyorst/plug.kak.git $HOME/.config/kak/plugins/plug.kak 



echo "map global user y '<a-|>xclip -i -selection clipboard<ret>'">>/usr/share/kak/kakrc
echo "map global user p '!xclip -o<ret>'">>/usr/share/kak/kakrc

echo 'hook global ModeChange (push|pop):insert:.* %{
    set-face global PrimaryCursor      rgb:ffffff,rgb:008800+F
}

hook global ModeChange (push|pop):.*:insert %{
    set-face global PrimaryCursor      rgb:ffffff,rgb:880000+F
}'>>/usr/share/kak/kakrc

echo 'source "%val{config}/plugins/plug.kak/rc/plug.kak"'>>/usr/share/kak/kakrc
echo 'plug "andreyorst/plug.kak" noload"'>>/usr/share/kak/kakrc


echo 'source "plug "andreyorst/kaktree" config %{ 

    hook global WinSetOption filetype=kaktree %{

        remove-highlighter buffer/numbers

        remove-highlighter buffer/matching

        remove-highlighter buffer/wrap

        remove-highlighter buffer/show-whitespaces

    }

    kaktree-enable

} '>>/usr/share/kak/kakrc





#Install and config ZSH
sudo yum -y install zsh 
zsh --version
chsh -s $(which zsh)
echo $SHELL

sudo dnf -y install wget git
sudo sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"