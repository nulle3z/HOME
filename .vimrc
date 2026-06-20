" call plug#begin('~\vimfiles\plugin')
	" Plug 'yianwillis/vimcdoc'
" call plug#end()

colorscheme slate
filetype plugin indent on
syntax enable

" set ignorecase
" set lines=37 columns=97
set background=dark
set backspace=indent,eol,start
set fileformat=unix
set foldmethod=indent
" set guifont=Lucida\ Console:h11
set guioptions-=L
set guioptions-=R
set guioptions-=T
set guioptions-=b
set guioptions-=l
set guioptions-=m
set guioptions-=r
set hlsearch
set incsearch
set infercase
set laststatus=2
set list
set nobackup
set noswapfile
set nowritebackup
set number
" set statusline=%F\ \ %y%=\ %p%%\ \ %l,%c\ \ %{strftime(\"%m.%d-%H:%M\")}
set statusline=%F\ %y\ \ %{getcwd()}%=\ %p%%\ \ %l,%c\ \ %{strftime(\"%m.%d-%H:%M\")}
set tabstop=4
set termguicolors
set vb t_vb=

let g:netrw_hide = 0
let g:netrw_liststyle = 3


" Common Hotkey
nnoremap <silent> <leader><space> :nohlsearch<CR>
nnoremap <silent> <leader>b :browse oldfiles<CR>
nnoremap <silent> <leader>c :shell<CR>
" nnoremap <silent> <leader>a :set autochdir<CR>

" Toggle line number display mode
function! ToggleLineNumberMode()
		if &number && !&relativenumber
				set nonumber
				set relativenumber
		elseif !&number && &relativenumber
				set norelativenumber
				set number
		elseif !&number && !&relativenumber
				set number
		else
				echo "Function \"ToggleLineNumberMode\" Error!"
		endif
		echo (&number ? "number " : "") . (&relativenumber ? "relativenumber" : "")
endfunction
nnoremap <silent> <leader>n :call ToggleLineNumberMode()<CR>

