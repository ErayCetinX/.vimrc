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
  Plug 'pangloss/vim-javascript'    " JavaScript support
  Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
  Plug 'ianks/vim-tsx'
  Plug 'jparise/vim-graphql'        " GraphQL syntax
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mkitt/tabline.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'elzr/vim-json'
  Plug 'ekalinin/dockerfile.vim'
  Plug 'townk/vim-autoclose'
  Plug 'joshdick/onedark.vim'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'fatih/vim-go' 
call plug#end()

set encoding=UTF-8

set t_Co=256   " This is may or may not needed.

set background=dark
set number
set laststatus=2
map <F6> :TagbarToggle <CR>

colorscheme onedark
syntax on
let g:airline_theme='onedark'

"NerdConfig
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-b> :NERDTree<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let $FZF_DEFAULT_COMMAND='find -L'

"Editor Options
syntax enable
set guifont=fira_Code:h14:cTURKISH
set guioptions-=T
set laststatus=2
set wrap
set showcmd
set cursorline
set wildmenu
set showmatch
set hlsearch
set incsearch
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
nnoremap <C-A> <M-h>
inoremap <C-A> <M-h>
vnoremap <C-A> <M-h>

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
let g:ctrlp_custom_ignore = 'coverage\|dist\|dist-*\|node_modules\|DS_Store\|git'
" open ctrl p file in new buffer
 let g:ctrlp_switch_buffer = 0
 let g:ctrlp_prompt_mappings = {
     \ 'AcceptSelection("e")': ['<c-v>', '<2-LeftMouse>'],
     \ 'AcceptSelection("v")': ['<cr>', '<RightMouse>'],
\ }

"ctrl-w + o full screen
nnoremap <silent> <C-w>w :ZoomWin<CR>

"CoC
"" Kullanış 
" CTRL + y => kabul edip kullanıyor
" " ctrl + n =>  yukarıdan aşşağıya doğru gidecek şekilde seçenekler arasında
" " geziniyor
" " ctrl + p => aşağıdan yukarı olacak şekilde seçeneklerde geziniyor
let g:coc_global_extensions = [
      \ 'coc-tsserver'
      \ ]

" Coc eslint ve prettier ayarları
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
          let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
          let g:coc_global_extensions += ['coc-eslint']
endif

function! ShowDocIfNoDiagnostic(timer_id)
          if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
                        silent call CocActionAsync('doHover')
                              endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" Tabline
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
" enable the close button in upper file
let g:tablineclosebutton=1

nnoremap <leader>1 :1tabnext<CR>
nnoremap <leader>2 :2tabnext<CR>
nnoremap <leader>3 :3tabnext<CR>
nnoremap <leader>4 :4tabnext<CR>
nnoremap <leader>5 :5tabnext<CR>
nnoremap <leader>6 :6tabnext<CR>
nnoremap <leader>7 :7tabnext<CR>
nnoremap <leader>8 :8tabnext<CR>
nnoremap <leader>9 :9tabnext<CR>

"" nerdteree syntax
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name  "

"" vim de arama yaptıktan sonra highlights kaldırma
set nohlsearch

set guifont=BitstreamVeraSansMono_NF:h13

" golang settings
filetype plugin indent on
setlocal omnifunc=go#complete#Complete

set autowrite

"Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
 let l:file = expand('%')
   if l:file =~# '^\f\+_test\.go$'
     call go#test#Test(0, 1)
   elseif l:file =~# '^\f\+\.go$'
     call go#cmd#Build(0)
   endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
