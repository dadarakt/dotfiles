# Installation on Ubuntu (or other systems which support apt-get)
# Requires git installation and takes care of all regularly used plugins after
# that

# fundamentals
sudo apt-get install zsh
sudo apt-get install git-core

# install oh-my-zsh and set the shell
wget https://github.com/robbyrussel/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

# used to clone the dotfiles and put them in their respective place
git clone https://github.com/dadarakt/dotfiles.git ~/dotfiles
cp ~/dotfiles/{.vimrc, .profile, .zshrc} ~/

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Installs vim with ruby support - mostly for command-t to work
sudo apt-get install vim-nox;

# further steps:
# - run :PluginInstall to setup all the configured plugins
# - go to ~/.vim/bundle/command-t and run `rake make` to link the c extensions needed for command t
# install 'hack' fontset to use everywhere
