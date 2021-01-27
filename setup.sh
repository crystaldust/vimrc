#!/bin/bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git submodule update --init --recursive
cp vimrc $HOME/.vimrc
cp -r molokai/* $HOME/.vim/
cp -r solarized/* $HOME/.vim/
