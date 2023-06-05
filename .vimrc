""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initial Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Must be first
  set nocompatible

  " Useful guide: https://github.com/romainl/idiomatic-vimrc
  " Not actually needed 
  " TODO avodi color shifting when opening a window: https://www.reddit.com/r/vim/comments/fos5w/problem_colors_shifting_upon_open/c1hiv5h/; this didn't fix it tho :(
  set t_Co=256

  " Use Unicode (necessary?)
  scriptencoding utf-8
  set encoding=utf-8
  setglobal nobomb

  " Plugin manager
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !sudo curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  Plug 'tmhedberg/SimpylFold'

  Plug 'gcmt/taboo.vim' " Tab renaming
    set sessionoptions+=tabpages,globals " Tabnames are stored in saved sessions

  Plug 'christoomey/vim-tmux-navigator' " Makes it easier to nav b/w tmux and vim panes

  Plug 'tpope/vim-obsession' " Streamlines vim session tracking; TODO make sure this actually works

  Plug 'vim-airline/vim-airline' " Lighter powerline
  Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#bufferline#enabled = 0
    let g:airline_powerline_fonts = 1
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    let g:airline_symbols.space = "\ua0"
    set fillchars+=stl:\ ,stlnc:\
    let g:airline_exclude_preview = 1
    let g:airline_highlighting_cache = 1


  " Using airline instead
  ""Plug 'powerline/powerline'

  " Bufferline extension!
  Plug 'bling/vim-bufferline'
    let g:bufferline_rotate = 1

  " TODO set up syntastic properly
  ""Plug 'vim-syntastic/syntastic'
  ""Plug 'myint/syntastic-extras'
  ""Plug 'nvie/vim-flake8'
  Plug 'rust-lang/rust.vim'
  ""Plug 'ocaml/merlin'

  Plug 'vim-python/python-syntax'
    let g:python_highlight_all=1
  ""Plug 'vim-scripts/indentpython.vim'

  Plug 'bfrg/vim-cpp-modern'

  Plug 'idris-hackers/idris-vim' " Syntastic extension for Idris?

  Plug 'neovimhaskell/haskell-vim'
    let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
    let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
    let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
    let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
    let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
    let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
    let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

  " idk it wasn't working w/ haskell byebye
  ""Plug 'Chiel92/vim-autoformat'
  ""au BufWrite * :Autoformat
  """ Haskell autoformatting
  ""autocmd BufWrite *.hs :Autoformat
  """ vim autoindent for haskell is buggy so don't use it
  ""autocmd FileType haskell let b:autoformat_autoindent=0
  Plug 'nbouscal/vim-stylish-haskell'

  " Makes .S files use RISC-V assembly instead!! TODO upgrade to RIG asm
  Plug 'kylelaker/riscv.vim'

  " Disabled for now because I do this with the native vim browser or the tmux one instead
  ""Plug 'scrooloose/nerdtree'
  "  map <C-@> :NERDTreeToggle<CR> " This is how I got vim to do this for <C-Space>

  " Fuzzy finding
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  "" recc'd by: apt-cache-show fzf
  source /usr/share/doc/fzf/examples/fzf.vim

  " Meson filetype / syntax / indentation
  Plug 'stfl/meson.vim'

  " Don't use it enough, too laggy
  ""Plug 'Valloric/YouCompleteMe'
  ""let g:ycm_autoclose_preview_window_after_completion=1
  ""map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

  " plugin for git stuff, TODO need to figure this out
  Plug 'tpope/vim-fugitive'

  Plug 'chrisbra/csv.vim'

  call plug#end()

  " Has to come after plugins (at least csv.vim)
  syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nonstandard Filetypes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " TODO this should all move into ~/.vim/ftdetect

  " RISC-V assembly!!
  au BufNewFile,BufRead *.asm,*.[sS],*.i set filetype=riscv
  let g:asmsyntax = 'i64'
  ""autocmd FileType asm let b:syntastic_checkers="nasm"

  " objdump dumps
  au BufNewFile,BufRead *.dump set filetype=objdump

  " jflex files
  augroup filetype
    au BufRead,BufNewFile *.flex,*.jflex    set filetype=jflex
  augroup END
  au Syntax jflex    so ~/.vim/syntax/jflex.vim

  " cup
  autocmd BufNewFile,BufRead *.cup set filetype=cup

  "" 'au' vs. 'u!' ?
  au BufRead,BufNewFile *.mri set filetype=json

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Core editor config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Core customization
  set number
  set cursorline
  set ttimeoutlen=10
  set formatoptions+=j
  set cursorcolumn
  set wildmenu
  set wildignorecase
  set wildmode=full

  "" highlight CursorColumn guibg=#404040

  " Editing QoL improvements
  set showcmd
  set autoread
  set linebreak
  set visualbell
  "" set backupdir=~/.cache/vim
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  " Search options
  set ignorecase
  set smartcase " overrides ignorecase if possible
  set incsearch
  set hlsearch

  " config for dir-local vimrc files
  ""set exrc
  ""set secure

  " Open a file tree
  ""autocmd vimenter * NERDTree

  " Fold customization & navigation
  set foldlevelstart=99
  set foldmethod=syntax
  set foldenable
  nnoremap <space> za

  " Automatically fold up vimrc levels
  au Filetype vim    set foldmethod=indent foldlevel=0

  " In-text navigation
  nnoremap <PageDown> $
  nnoremap <PageUp> ^
  inoremap <PageDown> <C-O>$
  inoremap <PageUp> <C-O>^
  nnoremap k gk
  nnoremap j gj

  " Buffer configs
  nnoremap <M-PageDown> :bnext<CR>
  nnoremap <M-PageUp> :bprevious<CR>
  "??
  nnoremap gb :ls<CR>:buffer<Space>
  set hidden

  " Tab management
  " TODO this should move into ~/.vim/indent
  set fileformat=unix
  set expandtab smarttab
  set autoindent
  set                    tabstop=2 softtabstop=2 shiftwidth=2
  au Filetype c      set tabstop=2 softtabstop=2 shiftwidth=2
  au Filetype cpp    set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=80
  au Filetype asm    set tabstop=2 softtabstop=2 shiftwidth=2
  au Filetype nasm   set tabstop=2 softtabstop=2 shiftwidth=2
  au Filetype riscv  set tabstop=4 softtabstop=4 shiftwidth=4
  au Filetype python set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80
  au Filetype java   set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80
  au Filetype csv    set textwidth=0
  au Filetype meson  set textwidth=100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors / style
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Store swapfiles nonlocally
  set directory^=$HOME/.vim/swapfiles//

  " Colorscheme management
  " Currently Installed -- Molokai, Badwolf, Goodwolf
  ""colorscheme                       molokai
  colorscheme                       xoria256
  au Filetype c         colorscheme molokai "elflord
  au Filetype cpp       colorscheme molokai "256-grayvim
  au Filetype asm       colorscheme badwolf "goodwolf
  au Filetype nasm      colorscheme badwolf "goodwolf
  au Filetype riscv     colorscheme badwolf "goodwolf
  au Filetype haskell   colorscheme vorange
  au Filetype gitcommit colorscheme gardener
  au Filetype gitconfig colorscheme gardener
  au Filetype meson     colorscheme turtles
  au Filetype objdump   colorscheme elflord
  au Filetype json      colorscheme molokai
  " I like evening instead if 256 colors aren't enabled
  ""au Filetype c      colorscheme evening
  ""au Filetype cpp    colorscheme slate
  ""au Filetype python colorscheme industry

  " accept /// as a comment for cpp files
  autocmd Filetype c,cpp set comments^=:///

  " highlight matching parentheses/etc.
  highlight MatchParen ctermbg=4

  " WILD
  set wildmenu

  " Sets colorschemes to update per file
  " https://www.reddit.com/r/vim/comments/5uep00/can_vim_auto_change_color_scheme_based_on_file/
  " TODO this one day w/a dictionary
  ""let g:colors_name = get(g:, 'colors_name', 'default')
  ""let s:saved_colorscheme = g:colors_name
  ""function! s:check_colorscheme_on_bufenter() abort
  ""    if (&ft == 'cpp' || &ft == 'c') && g:colors_name != 'molokai'
  ""        let s:saved_colorscheme = g:colors_name
  ""        colorscheme molokai
  ""        syntax on
  ""    elseif (&ft != 'cpp' || &ft != 'c') && g:colors_name == 'molokai'
  ""        exe 'colorscheme '.s:saved_colorscheme
  ""    endif
  ""endfunction
  ""
  ""augroup CppColorScheme
  ""    au!
  ""    au BufEnter * call s:check_colorscheme_on_bufenter()
  ""augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: Currently disabled
  " Recommended Syntastic settings
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  " Syntastic Error symbols
  ""let g:syntastic_error_symbol = "⟶ "
  ""let syntastic_style_error_symbol = "⟶ "
  let g:syntastic_error_symbol = "➤"
  let syntastic_style_error_symbol = "➤"
  let g:syntastic_warning_symbol = "∙∙"
  let syntastic_style_warning_symbol = "∙∙"

  " Syntastic Haskell compiler flags
  let g:syntastic_haskell_hlint_args = "--cross --serialise"
  let s:syn_hlint_lang_extensions =
        \ ['DataKinds', 'GADTs', 'KindSignatures', 'OverloadedStrings',
        \  'ScopedTypeVariables', 'TypeApplications', 'UnicodeSyntax',
        \  'TemplateHaskell', 'KindSignatures', 'QuasiQuotes']
  for ext in s:syn_hlint_lang_extensions
    let g:syntastic_haskell_hlint_args += (' -X' . ext)
  endfor

  " C++ syntastic options
  "" <<?name>> let g:syntastic_cpp_gcc_args = "-std=c++11 -Wall -Wextra -Wpedantic"
  let g:syntastic_cpp_compiler = "g++"
  let g:syntastic_cpp_compiler_options = "-std=c++17"
  let g:syntastic_cpp_checkers = ['gcc']
  let g:syntastic_cpp_check_header = 0
  ""let g:syntastic_debug = 3

  ""let g:syntastic_cpp_config_file = '.syntastic_cpp_config'

  " force syntastic to use Python 3
  " May cause issues if we have to use python2 files
  let g:syntastic_python_python_exec = 'python3'
  let g:syntastic_python_checkers = ['python']

  " NASM syntastic options
  let g:syntastic_nasm_nasm_post_args = "-X gnu -f elf64"
