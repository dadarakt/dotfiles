# Installation on Ubuntu (or other systems which support apt-get)
# Requires git installation and takes care of all regularly used plugins after
# that

# fundamentals
sudo apt-get install zsh
sudo apt-get install git-core
sudo add-apt repository ppa:gnome-terminator
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator
sudo apt-get install vim-nox;


# install oh-my-zsh and set the shell
wget https://github.com/robbyrussel/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# used to clone the dotfiles and put them in their respective place
git clone https://github.com/dadarakt/dotfiles.git ~/dotfiles
cp ~/dotfiles/{.vimrc, .profile, .zshrc} ~/
cp ~/dotfiles/jannis.vim ~/.vim/colors/
cp ~/dotfiles/bureau-jannis.zsh-theme ~/.oh-my-zsh/themes/

# install powerline font - remember to use a patched version that also support file symbols for vim
# https://github.com/ryanoasis/nerd-fonts
cd
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf ~/.fonts/
mkdir -p .config/fontconfig/conf.d #if directory doesn't exists
fc-cache -vf ~/.fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
