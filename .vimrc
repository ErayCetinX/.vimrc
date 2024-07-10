call plug#begin()
    Plug 'scrooloose/nerdtree'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'vim-airline/vim-airline'
    Plug 'leafgarland/typescript-vim'
    Plug 'scrooloose/syntastic'
    Plug 'tpope/vim-surround'
    Plug 'kien/ctrlp.vim'
    Plug 'w0rp/ale'
    Plug 'vim-scripts/ZoomWin'
    Plug 'majutsushi/tagbar'
call plug#end()

set t_Co=256   " This is may or may not needed.

set background=dark
colorscheme PaperColor
set number
set laststatus=4

map <F6> :TagbarToggle <CR>

"NerdConfig
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-b> :NERDTree<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"Editor Options
syntax enable
set guifont=fira_Code:h12:cTURKISH
set guioptions-=T
set laststatus=2
set wrap
set showcmd
set cursorline
set wildmenu
set showmatch
set hlsearch
set incsearch
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" ilk açtığında proje yoksa nerdTree açılcak
function! StartUp()
        if 0 == argc()
            NERDTree
        end
endfunction
autocmd VimEnter * call StartUp()


map <c-p> :CtrlP <CR>
let g:ctrlp_custom_ignore= {
            \ 'dir': 'node_modules\|packaged\|dist',}
"open ctrl p file in new buffer
 let g:ctrlp_switch_buffer = 0
 let g:ctrlp_prompt_mappings = {
     \ 'AcceptSelection("e")': ['<c-v>', '<2-LeftMouse>'],
     \ 'AcceptSelection("v")': ['<cr>', '<RightMouse>'],
\ }

"ctrl-w + o full screen
nnoremap <silent> <C-w>w :ZoomWin<CR>
