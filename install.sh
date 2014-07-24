#!/bin/sh


pushd `dirname $0` > /dev/null
SCRIPT_PATH=`pwd`
mkdir -p $SCRIPT_PATH/vim/bundle

# Creating symbolik links
ln -sf $SCRIPT_PATH/vimrc ~/.vimrc
ln -sf $SCRIPT_PATH/vimrc.bundles ~/.vimrc.bundles
ln -sf $SCRIPT_PATH/vimrc.bepo ~/.vimrc.bepo
ln -sf $SCRIPT_PATH/vim ~/.vim

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -u $SCRIPT_PATH/vimrc.install +PluginInstall

#rm -rf $TEMP_VUNDLE_PATH
popd > /dev/null
