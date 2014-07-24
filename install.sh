#!/bin/sh

# Cloning vundle
git submodule init
git submodule update

# Creating symbolik links
currDir=$(pwd)
ln -sf $currDir/vimrc ~/.vimrc
ln -sf $currDir/vimrc.bundles ~/.vimrc.bundles
ln -sf $currDir/vimrc.bepo ~/.vimrc.bepo
ln -sf $currDir/vim ~/.vim

vim -u $currDir/vimrc.install +PluginInstall
