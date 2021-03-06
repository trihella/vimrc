" vim: set sw=4 ts=4 sts=4 tw=80 foldmarker={,} foldlevel=0 foldmethod=marker nospell:
" =========================================================================== "
"       Vimrc
"
"       Author: Thomas Hiscock
"       Mail: hiscockt@minatec.inpg.fr
" =========================================================================== "

" Editor {
    "set autoread           " Autoreload file while editing
    set encoding=utf-8
    set fileencoding=utf-8
    set ffs=unix,dos,mac

    set nobackup            " No backup and swap files
    set nowb
    set noswapfile

    set showcmd             " Print current command
    set  nocp               " Vi compatibility disabled
    set mouse=a             " Mouse active in vim shell version
    set so=7                " 7 line bellow vertical moves
    set nomousehide         " Always show cursor
    set wildmenu            " Completion menu
    set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz
    set wildmode=list:longest,full
    set ruler               " Show current position (in line and col)
    set cmdheight=1
    set hid                 " Ne pas afficher les buffer que l'on a fermé
    set ignorecase
    set smartcase
    set hlsearch            " Highlight search results
    set incsearch           " Search while typing the search string
    set lazyredraw
    set magic
    set showmatch           " Show matching brackets, parenthesis ect...
    set mat=2
    set noerrorbells        " No bell !
    set novisualbell
    set tm=500
    "set formatprg=par\ -w78jr " Paragraph formating with par, give better
                               " results but require par installed
    set spelllang=fr        " Spellchecking : FR
    "set nospell
    set fo+=o               " Automatically insert a comment while passing in
                            " insert mode
    set fo-=r               " Do not automatically insert comment when pressing
                            " <ENTER> in insert mode
    set list
    set listchars=tab:›-,trail:.,extends:#,nbsp:.
" }
" Bundles {
    " Vundle manage all plugins, configure the next line to point vundle
    " install directory
    set rtp+=~/.vim/bundle/Vundle.vim/
    set rtp+=~/.vim/bundle/vimproc.vim/
    call vundle#begin()
    source ~/.vimrc.bundles
    call vundle#end()
    " Must be called after plugin are loaded otherwise causes some trouble with
    " ultisnips
    filetype on
    filetype indent on
    filetype plugin on

" }
" UI Look {
    set cursorline          " Highlight the current line
    set t_Co=256            " 256 color mode
    syntax enable
    set nu
    set foldmethod =syntax " Automatic folding
    if has('gui_running')
       set go-=m            " Make gui looks like the shell, remove menu,
       set go-=T            " side scroller ect...
       set go-=r
       set go-=l
       set go-=rL
       set go-=e
       set guicursor=a:blinkon0
       set background=dark
       colorscheme kolor
       set antialias
       " set guifont=Monospace\ 9
       set guifont=Consolas\ 11
    else
        if &term=="xterm-256color"
            set background=dark
            "let g:solarized_termcolors=256
            let g:solarized_underline=0
            colorscheme solarized
        else
            set background=dark
            colorscheme kolor
            " colorscheme bubblegum
        endif
        "colorscheme hybrid
    endif

    " Some color customisations
    hi clear SpellBad
    hi SpellBad cterm=underline
    "hi ColorColumn ctermbg=236
    "hi CursorLine ctermbg=236 cterm=NONE

    " set tw=80              " Max line width 78 : Disabled, cursor column is a
                             " better indicator
    set cc=79               " Show cursor column

    set expandtab           " Replace tabs with spaces
    set tabstop=4           " Tabulation width
    set shiftwidth=4
    set softtabstop=4
    set smarttab
    set autoindent

    "set lbr                " Break when a line goes over tw chars
    "set wrap               " Show long lines on multiple lines
    set nowrap

    set laststatus=2        " Always show status bar
" }
" Keyboard mappings {

    set backspace=indent,eol,start
    set whichwrap+=<,>,h,l

    let mapleader = ","
    let g:mapleader = ","
    nmap <leader>w :w!<CR>
    nmap <leader>q :q!<CR>
    map <leader>u :redo<CR>
    nmap <leader>bd :Bclose<CR>
    nmap <leader>tn :tabnew<CR>
    nmap <leader>to :tabonly<CR>
    nmap <leader>tc :tabclose<CR>
    nmap <leader>tm :tabmove<CR>
    nmap <leader>tl :tabnext<CR>
    nmap <leader>tp :tabprevious<cr>
    " nmap <F5> :!ctags -R &<cr><cr>
    inoremap <leader><leader> <ESC>

    let g:use_bepo_keyboard = 1
    if (g:use_bepo_keyboard == 1)
        source ~/.vimrc.bepo
    endif

    nmap <F4> :Ggrep expand("<cword>")
" }
" Extra Functions {
    " Delete trailing white space on save
    func! DeleteTrailingWS()
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
    endfunc

    autocmd BufRead *.rs :set ft=rust
    augroup whitespace
        autocmd!
        autocmd BufWrite *.hs :call DeleteTrailingWS()
    augroup END
" }
" Plugins{
    " CTRL-P (Fuzzy finder) {
        let g:ctrlp_map = ',e'
        nmap ,g :CtrlPBufTag<CR>
        nmap ,G :CtrlPBufTagAll<CR>
        nmap ,f :CtrlPLine<CR>
        nmap ,m :CtrlPMRUFiles<CR>
        nmap ,c :CtrlPCmdPalette<CR>
        " Don't change working directory
        let g:ctrlp_working_path_mode = 0
        " Ignore files on fuzzy finder
        let g:ctrlp_custom_ignore = {
          \ 'dir':  '\v[\/](\.git|\.hg|\.svn|dist)$',
          \ 'file': '\v\.(bin|pyc|o)$',
          \ }
    "}
    " vim-haskell {
        let g:haskell_conceal_wide = 1
        let g:haskell_conceal_enumerations = 1

        set completeopt+=longest
        " Use buffer words as default tab completion
        let g:SuperTabDefaultCompletionType = '<c-x><c-p>'
        " But provide (neco-ghc) omnicompletion
        if has("gui_running")
            imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
        else " no gui
            if has("unix")
                inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
            endif
        endif

        " Show types in completion suggestions
        let g:necoghc_enable_detailed_browse = 1
        " Type of expression under cursor
        nmap <silent> <leader>ht :GhcModType<CR>
        " Insert type of expression under cursor
        nmap <silent> <leader>hT :GhcModTypeInsert<CR>
        " GHC errors and warnings
        nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>
        " Haskell Lint
        " let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['haskell'] }
        " nmap <silent> <leader>hl :SyntasticCheck hlint<CR>
    " }
    " Slime {
    "    vmap <silent> <Leader>rs <Plug>SendSelectionToTmux
    "    nmap <silent> <Leader>rs <Plug>NormalModeSendToTmux
    "    nmap <silent> <Leader>rv <Plug>SetTmuxVars
    " }
    " vim-airline {
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme="jellybeans"
        let g:airline_detect_modified=1
    " }
    " Python Mode {
        "let g:pymode = 1
        let g:pymode_rope = 1
        let g:pymode_rope_goto_definition_bind = '<leader>rg'

        " Documentation
        let g:pymode_doc = 1
        let g:pymode_doc_key = 'K'

        "Linting
        let g:pymode_lint = 1
        let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
        let g:pymode_lint_ignore = "W0"
        let g:pyflakes_use_quickfix = 0 " Ne pas utiliser quickfix

        " Coloration syntaxique
        let g:pymode_syntax = 1
        let g:pymode_syntax_all = 1
        let g:pymode_syntax_indent_errors = g:pymode_syntax_all
        let g:pymode_syntax_space_errors = g:pymode_syntax_all
        " Don't autofold code
        "let g:pymode_folding = 1

        let g:pymode_indent = 1
    " }
    " Ctags {
        set tags+=./tags;/,~/.vimtags
    " }
    " Undo Tree {
        " let g:undotree_SetFocusWhenToggle=1
        " nnoremap <F7> :GundoToggle<CR>
    " }
    " SuperTab {
        " set omnifunc=syntaxcomplete#Complete
        "let g:SuperTabDefaultCompletionType = "context"
    " }
    " Snipmate {
        let g:UltiSnipsUsePythonVersion = 2
        let g:UltiSnipsExpandTrigger="<C-a>"
        let g:UltiSnipsJumpForwardTrigger="<C-b>"
        let g:UltiSnipsJumpBackwardTrigger="<C-z>"
        let g:UltiSnipsEditSplit="vertical"
    " }
" }
