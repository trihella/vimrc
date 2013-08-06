#!/bin/sh

# Cloning vundle
git submodule init
git submodule update

# Creating symbolik links
ln -s vimrc ~/.vimrc
ln -s vimrc.bundle ~/.vimrc.bundle
ln -s vim ~/.vim
