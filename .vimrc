set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'

call vundle#end()

syntax on

filetype plugin indent on

set fileformats=unix,dos,mac
set nu
set nowrap
set hlsearch
set ruler
set backspace=indent,eol,start

set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

augroup twospaces
	autocmd!
	autocmd FileType javascript,json,html setlocal expandtab ts=2 sts=2 sw=2
augroup END

augroup fourspaces
	autocmd!
	autocmd FileType java,php,python setlocal expandtab ts=4 sts=4 sw=4
augroup END

" Open NERDTree with vim and close when :quit
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Move cursor to main window (not NERDTree)
autocmd VimEnter * wincmd p

nmap <F5> :NERDTreeToggle<CR>

" Insert mode Red Numbers / Normal mode Yellow Numbers 
highlight LineNr ctermfg=3 ctermbg=16
function! InsertStatuslineColor(mode)
	if a:mode == 'i'
		highlight LineNr ctermfg=1 ctermbg=16
	endif
endfunction

function! InsertLeaveActions()
	highlight LineNr ctermfg=3 ctermbg=16
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertLeaveActions()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Check PSR-2 on php files and show errors at the bottom
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'

" 80 column highlight
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(400,999),",")
