#My .vimrc

##Requirements
   * Linux distribution
   * Git
   * Vim 7.3+

##Installation

```bash
    $ git clone https://github.com/trihella/vimrc.git
    $ cd vimrc && ./install.sh
```
And go !

```bash
    $ vim
```
##Windows
 * Install Git for windows, clone this repository, lets call %VIMRC_DIR% its absolute path.
 * Manually install vundle
 * Edit vimrc in the repository and put the absolute path where you install vundle in the following line
```vim 
   set rtp+=~/.vim/bundle/vundle/
``` 
 * Replace the path with %VIMRC_DIR%/vimrc.bundles (note that there is not the first dot in 'vimrc.bundle') in this line in the vimrc
```vim
   source ~/.vimrc.bundles
```
 * copy vimrc in the repository in your user directory as _vimrc
 * Launch vim (you should have lots of errors on start) and run :BundleInstall
 * You can restart vim and it will be fine

Some plugins like TagBar requires tools such as ctags that you must install to use the plugins, and place them in your path. But vim will not print any error message if you do not try to use them.
