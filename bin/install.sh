# Requires git installation and takes care of all regularly used plugins after
# that
#sudo apt-get install zsh
#sudo apt-get install git-core

#wget https://github.com/robbyrussel/oh-my-zsh/raw/master/tools/install.sh -O - |
#zsh

#chsh -s `which zsh`

#sudo shutdown -r 0


git clone https://github.com/dadarakt/dotfiles.git ~/dotfiles
cp ~/dotfiles/{.vimrc, .profile, .zshrc} ~/

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

