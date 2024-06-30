if has("systax")
    syntax on
endif

set autoindent
set cindent
set smartindent
set ts=4
set shiftwidth=4
set hlsearch
set nu

set list lcs=tab:\ \ │
set relativenumber
" Enable copy to clipboard
set clipboard=unnamed

" === 터미널 관련 설정 ===
"set termwinsize=10x210 " vim 안에서 ':term' 명령을 통해 생성된 터미널의 크기입니다. (수직)x(수평)
"autocmd VimEnter * below term  
"autocmd VimEnter * wincmd k " 생성된 터미널에 있는 커서를 편집중인 파일로 이동합니다.
" === 터미널 관련 설정 끝 ===
"
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on    " required
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' "let Vundle manage Vundle, required
" add airline design
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree' "FileTreePlugin. :NERDTreeToggle로 on off가능
Plugin 'scrooloose/syntastic' "코드 문법체크 플러그인
Plugin 'nathanaelkane/vim-indent-guides' " 인던트 라인
call vundle#end()            " required
" vimplug_init
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

filetype plugin indent on    " required

autocmd VimEnter * NERDTree | wincmd p " nerdtree를 toggle on하고 커서를 우측(편집중인 파일)로 이동합니다.
autocmd VimEnter * highlight CocFloating ctermbg=0
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" .zshrc 파일의 마지막에 ls를 추가하면 목록이 출력됩니다.
