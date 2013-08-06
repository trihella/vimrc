" vim: set sw=4 ts=4 sts=4 tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" ===========================================================================
"       Vimrc
"
"       Author: Thomas Hiscock
"       Mail: hiscockt@minatec.inpg.fr
" ===========================================================================

" Paramètres globaux {
    set autoread            " Rafraichissement automatique du fichier en cours d'édition
    set showcmd             " Affichage de la commande que l'on est en train de taper
    set  nocp               " Désactivation de la compatibilité avec vi (pour les plugins)
    filetype on             " Activation des plugins
    filetype indent on 
    filetype plugin on
    set mouse=a             " Activation de la souris en shell
    set so=7                " Imposer 7 lignes au dessus du curseur pour les mouvements verticaux
    set nomousehide         " Curseur toujours visible
    set wildmenu            " Activer le wild menu (proposition des choix de complétion)
                            " Ignorer certains types de fichiers pour la complétion
    set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz
    set wildmode=list:longest,full
    set ruler               " Toujours afficher la position actuelle
    set cmdheight=1         " Hauteur de la barre de commande
    set hid                 " Ne pas afficher les buffer que l'on a fermé
    set ignorecase          " Ignorer la casse lors d'une recherche
    set smartcase           " Recherche intelligente
    set hlsearch            " Surligner les résultats de recherches
    set incsearch           " Affichage des résultats en même temps que la saisie
    set lazyredraw          " Optimisation des macros
    set magic               " Pour les expréssion régulières dans les remplacements
    set showmatch           " Afficher les parenthèses correspondantes
    set mat=2               " Vitesse de clignotement des parenthèses correspondantes
    set noerrorbells        " Désactiver les sons
    set novisualbell
    set tm=500
    "set formatprg=par\ -w80jr " par pour remettre en forme les paragraphes avec gq
    set spelllang=fr        " Langue pour la vérification orthographique
    set fo+=o               " Inserer automatiquement un commentaire en passant en mode insertion
    set fo-=r               " Ne pas inserer de commentaire en pressant ENTER
" }
" Bundles {
    "set rtp+=~/.vim/bundle/vundle/
    "call vundle#rc()
    "source ~/.vimrc.bundles
" }
" Interface {
    syntax enable           " On active la coloration syntaxique
    set nu                  " Afficher les numéros de ligne
    if has('gui')
        set go-=m
        set go-=T
        set go-=r
        set go-=l
    endif
    
    set background=dark     " Thème de couleur
    "colorscheme mustang
    colorscheme molokai
    set tw=80
    au BufNewFile,BufRead *.tex set tw=100
    
    set encoding=utf-8      " Encodage utilisé
    set fileencoding=utf-8
    set ffs=unix,dos,mac
    
    set nobackup            "Configuration des backups (pas de sauvegarde)
    set nowb
    set noswapfile
    
    set expandtab           " remplacer les tabulations par des espaces
    set smarttab            " Tabulation intelligente
    set  tabstop=4          " Taille d'une tabulation
    set  shiftwidth=4
    set  softtabstop=4
    
    set lbr                 " Saut de ligne lorsque tw est dépassé
    set ai                  " Indentation automatique
    set si                  " Indentation intelligente
    set wrap
" }
" Déplacements modifs clavier {

    set backspace=indent,eol,start " Définition du comportement de backspace
    set whichwrap+=<,>,h,l
    
    let mapleader = ","     " On définit la touche leader pour définir quelques raccourcis
    let g:mapleader = ","
    nmap <leader>w :w!<CR>  " Sauvegarde rapide
    nmap <leader>q :q!<cr>  " Fermeture rapide
    map <leader>u :redo<CR>
    nmap <leader>bd :Bclose<cr> " Raccourci fermeture du buffer actuel
    nmap <leader>tn :tabnew<cr> " Raccourci pour gerer les onglets
    nmap <leader>to :tabonly<cr>
    nmap <leader>tc :tabclose<cr>
    nmap <leader>tm :tabmove 
    nmap <leader>tl :tabnext<cr>
    nmap <F5> :!ctags -R &<cr><cr>
    inoremap <leader><leader> <ESC>
    
    " Déplacement facile entre les fenètres ouvertes
    map <C-k> <C-W>k
    map <C-j> <C-W>j
    map <C-h> <C-W>h
    map <C-l> <C-W>l
    
    highlight NbSp ctermbg=lightgray guibg=lightred
    match NbSp /\%xa0/
    
    nmap <F4> :Ggrep expand("<cword>")

" }
" Fonctions {

    function! MyFoldFunction()
    		let line = getline(v:foldstart)
    		let sub = substitute(line,'/\*\|\*/\|^\s+', '', 'g')
    		let lines = v:foldend - v:foldstart + 1
    		return v:folddashes.sub.'...'.lines.'Lines...'.getline(v:foldend)
    endfunction
    
    
    " Fold automatique
    set  foldmethod =syntax
    set  foldtext =MyFoldFunction()    
    
    " fill rest of line with characters
    function! FillLine( str )
        " set tw to the desired total length
        let tw = &textwidth
        if tw==0 | let tw = 80 | endif
        " strip trailing spaces first
        .s/[[:space:]]*$//
        " calculate total number of 'str's to insert
        let reps = (tw - col("$")) / len(a:str)
        " insert them, if there's room, removing
        trailing spaces (though forcing
        " there to be one)
        if reps > 0
            .s/$/\=(' '.repeat(a:str,reps))/
        endif
    endfunction '

" Plugins{
     "Powerline (la barre d'état en bas)
    "set laststatus=2
    "set t_Co=256 
    
    "CTRL-P bindings
    "let g:ctrlp_map = '<leader>p'
    "let g:ctrlp_cmd = 'CtrlP'
    "let g:ctrlp_extensions = ['funky', 'line', 'dir']
    "nmap ,b :CtrlPLine<CR>
    "nmap ,m :CtrlPMRUFiles<CR>
    
     "Python mode
    "let g:pymode_rope = 0    Disable pythonmode rope, using jedi instead
    "let g:pymode_indent = 1  Enable indent
    "let g:pymode_doc = 0     Disable pythonmode doc
    "let g:pymode_lint = 1    Syntax checker pylint, pep8
    "let g:pymode_lint_checker = "pyflakes,pep8"
    "let g:pymode_lint_write = 1   Auto check on save
     "Support virtualenv
    "let g:pymode_virtualenv = 1
    
     "Enable breakpoints plugin
    "let g:pymode_breakpoint = 1
    "let g:pymode_breakpoint_key = '<leader>b'
    
     "syntax highlighting
    "let g:pymode_syntax = 1
    "let g:pymode_syntax_all = 1
    "let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    "let g:pymode_syntax_space_errors = g:pymode_syntax_all
    
     "Don't autofold code
    "let g:pymode_folding = 0
    
     "Supertab complétion avec la touche tab 
    "set omnifunc=syntaxcomplete#Complete
    "let g:SuperTabDefaultCompletionType = "context"
    
    "nmap <F6> :TlistToggle<cr>
    "let Tlist_Use_Right_Window = 1
    
    "nnoremap <F7> :GundoToggle<CR>
" }