#!/bin/sh
sudo apt update
sudo apt install dos2unix

dos2unix ~/.zshrc
ln -f ./zshrc ~/.zshrc
dos2unix ~/.gitconfig
ln -f ./gitconfig ~/.gitconfig
dos2unix ~/.vimrc
ln -f ./vimrc ~/.vimrc
