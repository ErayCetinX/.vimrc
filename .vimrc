" =============================================================================
"  ~/.vimrc  —  Eray
" =============================================================================
" Bölümler:
"   1. Genel davranış (sensible defaults)
"   2. Eklentiler (vim-plug)
"   3. Görünüm / tema
"   4. Arama, girinti, düzenleyici ayarları
"   5. Tuş atamaları (leader, sekmeler, hareket)
"   6. NERDTree
"   7. CtrlP
"   8. CoC (LSP / tamamlama / prettier / eslint)
"   9. Go (vim-go)
"  10. Airline
"  11. Yardımcı fonksiyonlar & autocmd
" =============================================================================

" -----------------------------------------------------------------------------
" 1. Genel davranış
" -----------------------------------------------------------------------------
set nocompatible               " Vi uyumluluğu kapalı, tam Vim özellikleri
set encoding=utf-8
scriptencoding utf-8
set hidden                     " Kaydetmeden buffer'lar arası geçiş
set backspace=indent,eol,start " Backspace her yerde çalışsın
set mouse=a                    " Fare desteği
set clipboard=unnamed          " Sistem panosu ile entegre
set ttimeoutlen=50             " <Esc> gecikmesini azalt
set updatetime=300             " CoC ve gitgutter için daha hızlı tepki
set shortmess+=c               " Tamamlama menüsü mesajlarını kısalt
set signcolumn=yes             " İşaret sütunu her zaman açık (kayma olmasın)
set autoread                   " Dosya dışarıda değişince otomatik yükle
set autowrite                  " Komut çalıştırırken otomatik kaydet

" Başlangıçta çalışma dizini
cd C:\code

" Yedek / swap / undo dosyaları tek yerde toplansın
let s:vimdir = expand('~/.vim')
for s:dir in ['backup', 'swap', 'undo']
  if !isdirectory(s:vimdir . '/' . s:dir)
    call mkdir(s:vimdir . '/' . s:dir, 'p')
  endif
endfor
let &backupdir = s:vimdir . '/backup//'
let &directory = s:vimdir . '/swap//'
set backup
if has('persistent_undo')
  let &undodir = s:vimdir . '/undo//'
  set undofile
endif

" -----------------------------------------------------------------------------
" 2. Eklentiler (vim-plug)
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
  " Görünüm
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'joshdick/onedark.vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'mkitt/tabline.vim'

  " Dosya gezgini
  Plug 'scrooloose/nerdtree'

  " Arama / gezinme (fzf = VSCode benzeri hızlı fuzzy arama)
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'majutsushi/tagbar'
  Plug 'vim-scripts/ZoomWin'

  " Düzenleme yardımcıları
  Plug 'tpope/vim-surround'
  Plug 'townk/vim-autoclose'

  " Git
  Plug 'airblade/vim-gitgutter'

  " Dil desteği / sözdizimi
  Plug 'pangloss/vim-javascript'    " JavaScript
  Plug 'leafgarland/typescript-vim' " TypeScript
  Plug 'ianks/vim-tsx'              " TSX
  Plug 'maxmellon/vim-jsx-pretty'   " JSX
  Plug 'jparise/vim-graphql'        " GraphQL
  Plug 'elzr/vim-json'              " JSON
  Plug 'ekalinin/dockerfile.vim'   " Dockerfile
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " LSP / tamamlama (tek diagnostic kaynağı)
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }

  " İkonlar (EN SONDA yüklenmeli: önce devicons, sonra renklendirme)
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
call plug#end()

" Eklenti + girinti algılama (plug#end sonrası tek noktada)
filetype plugin indent on
syntax enable

" -----------------------------------------------------------------------------
" 3. Görünüm / tema
" -----------------------------------------------------------------------------
set t_Co=256                   " 256 renk (terminal için)
" True-color yalnızca destekleyen ortamda (GVim veya truecolor terminal)
if has('termguicolors') && (has('gui_running') || $COLORTERM =~# '\v(truecolor|24bit)')
  set termguicolors
endif
set background=dark
colorscheme iceberg

" GUI (GVim) ayarları
if has('gui_running')
  set guifont=FiraCode_Nerd_Font_Mono:h11:cTURKISH
  set winaltkeys=no            " Alt kombinasyonları menüye değil, mapping'lere gitsin (<A-1>..)
  set guioptions-=m            " Menü çubuğu
  set guioptions-=T            " Araç çubuğu
  set guioptions-=r            " Sağ kaydırma çubuğu
  set guioptions-=L            " Sol kaydırma çubuğu
endif

set number
set relativenumber
set cursorline
set showcmd
set showmatch                  " Eşleşen parantezi göster
set laststatus=2               " Durum çubuğu her zaman görünsün
set wildmenu                   " Komut satırı tamamlama menüsü
set scrolloff=5                " İmleç kenara gelince kaydır

" -----------------------------------------------------------------------------
" 4. Arama & girinti
" -----------------------------------------------------------------------------
set ignorecase                 " Aramada büyük/küçük harf duyarsız...
set smartcase                  " ...ama büyük harf yazınca duyarlı ol
set incsearch                  " Yazarken artımlı arama
set hlsearch                   " Sonuçları vurgula (temizlemek için <leader><space>)

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent
set smartindent
set nowrap                     " Uzun satırları sarma

" -----------------------------------------------------------------------------
" 5. Tuş atamaları
" -----------------------------------------------------------------------------
let mapleader = "\<Space>"     " Leader = boşluk

" Arama vurgusunu temizle
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Ok tuşlarını devre dışı bırak (hjkl alışkanlığı)
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

" Tab'lar (Alt + rakam) — GUI'de winaltkeys=no ile çalışır
nnoremap <silent> <A-1> 1gt
nnoremap <silent> <A-2> 2gt
nnoremap <silent> <A-3> 3gt
nnoremap <silent> <A-4> 4gt
nnoremap <silent> <A-5> 5gt
nnoremap <silent> <A-6> 6gt
nnoremap <silent> <A-7> 7gt
nnoremap <silent> <A-8> 8gt
nnoremap <silent> <A-9> 9gt

" Buffer'lar (leader = Boşluk + rakam) — airline tabline'daki sıra numarasına atla
" NOT: Terminalde Shift+rakam sembol (@ # % * ...) üretip Vim komutlarını ezdiği
"      için buffer geçişinde leader+rakam kullanılır. <Plug> => nmap.
nmap <silent> <leader>1 <Plug>AirlineSelectTab1
nmap <silent> <leader>2 <Plug>AirlineSelectTab2
nmap <silent> <leader>3 <Plug>AirlineSelectTab3
nmap <silent> <leader>4 <Plug>AirlineSelectTab4
nmap <silent> <leader>5 <Plug>AirlineSelectTab5
nmap <silent> <leader>6 <Plug>AirlineSelectTab6
nmap <silent> <leader>7 <Plug>AirlineSelectTab7
nmap <silent> <leader>8 <Plug>AirlineSelectTab8
nmap <silent> <leader>9 <Plug>AirlineSelectTab9
" <A-,> / <A-.> => önceki / sonraki buffer
nmap <silent> <A-,> <Plug>AirlineSelectPrevTab
nmap <silent> <A-.> <Plug>AirlineSelectNextTab
nnoremap <silent> <S-t> :tabnew<CR>

" <A-w> => sekmeyi kapat ve kapanan buffer'ı bellekten sil (bayat içerik kalmasın)
function! s:close_and_wipe() abort
  let l:buf = bufnr('%')
  if tabpagenr('$') > 1
    tabclose
  else
    quit
  endif
  " Buffer artık hiçbir pencerede görünmüyor ve değişmemişse tamamen temizle
  if bufexists(l:buf) && bufwinnr(l:buf) == -1 && !getbufvar(l:buf, '&modified')
    execute 'silent! bwipeout' l:buf
  endif
endfunction
noremap <silent> <A-w> :call <SID>close_and_wipe()<CR>

" Tagbar
nnoremap <F6> :TagbarToggle<CR>

" ZoomWin — pencereyi tam ekran yap/geri al
" NOT: <C-w>w Vim'in varsayılan 'sonraki pencere' tuşu; ezmemek için <C-w>z kullan.
nnoremap <silent> <C-w>z :ZoomWin<CR>

" -----------------------------------------------------------------------------
" 6. NERDTree
" -----------------------------------------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-f>     :NERDTreeFind<CR>

" <C-b> => çalışılan dizinin (getcwd) ağacını aç, açıksa kapat
function! s:toggle_nerdtree_cwd() abort
  if g:NERDTree.IsOpen()
    NERDTreeClose
  else
    NERDTreeCWD
  endif
endfunction
nnoremap <silent> <C-b> :call <SID>toggle_nerdtree_cwd()<CR>

let g:NERDTreeShowHidden = 1
let g:NERDTreeWinPos = 'right'

" nerdtree-syntax-highlight ayarları
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile  = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName    = 1
let g:NERDTreePatternMatchHighlightFullName  = 1
let g:NERDTreeHighlightFolders               = 1
let g:NERDTreeHighlightFoldersFullName       = 1

" -----------------------------------------------------------------------------
" 7. fzf — VSCode benzeri hızlı fuzzy arama
" -----------------------------------------------------------------------------
" Dosya listesini ripgrep üretsin: .gitignore'a saygılı, gizli dosyalar dahil,
" .git klasörü hariç (node_modules/dist otomatik dışlanır çünkü .gitignore'da).
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

" Ortalanmış açılır (popup) pencere — VSCode hissi
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.85 } }

" <C-p>     => proje dosyalarında fuzzy arama (VSCode Ctrl-P)
" <leader>f => proje genelinde içerik arama / live grep (VSCode Ctrl-Shift-F)
" <A-p>     => açık buffer'lar arasında geçiş
" <leader>h => son açılan dosyalar (history / MRU)
nnoremap <silent> <C-p>     :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <A-p>     :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>

" Seçili öğeyi açma tuşları (VSCode alışkanlığı: Enter = aynı pencere)
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ }

" -----------------------------------------------------------------------------
" 8. CoC — LSP / tamamlama
" -----------------------------------------------------------------------------
" Kullanım:
"   <C-y>  => seçili öneriyi kabul et
"   <C-n>  => sonraki öneri (yukarıdan aşağı)
"   <C-p>  => önceki öneri (aşağıdan yukarı)
let g:coc_global_extensions = ['coc-tsserver']

" Proje bağımlılıklarına göre prettier/eslint ekle
if isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Gezinme (GoTo)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" K => imlecin altındaki sembol için dokümantasyon
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation() abort
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  endif
endfunction

" İmleç bekleyince otomatik dokümantasyon (diagnostic yoksa)
function! ShowDocIfNoDiagnostic(timer_id) abort
  if coc#float#has_float() == 0 && CocHasProvider('hover') == 1
    silent call CocActionAsync('doHover')
  endif
endfunction
function! s:show_hover_doc() abort
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction
autocmd CursorHold  * call <SID>show_hover_doc()

" -----------------------------------------------------------------------------
" 9. Go (vim-go)
" -----------------------------------------------------------------------------
let g:go_highlight_fields         = 1
let g:go_highlight_functions      = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types    = 1
let g:go_highlight_operators      = 1
let g:go_fmt_autosave  = 1
let g:go_fmt_command   = 'goimports'
let g:go_auto_type_info = 1

" :GoBuild veya test dosyasıysa :GoTestCompile
function! s:build_go_files() abort
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)

" -----------------------------------------------------------------------------
" 10. Airline
" -----------------------------------------------------------------------------
let g:airline_theme = 'iceberg'
let g:airline_powerline_fonts = 1              " Nerd Font ok/ayraç glyph'leri
let g:airline#extensions#tabline#enabled    = 1
let g:airline#extensions#tabline#left_sep     = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter    = 'jsformatter'
let g:airline#extensions#tabline#buffer_idx_mode = 1   " Buffer'lara sıra numarasıyla atla (<A-1>..<A-9>)

" -----------------------------------------------------------------------------
" 10b. İkonlar (vim-devicons) — dosya tipi ikonları
" -----------------------------------------------------------------------------
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1          " NERDTree'de ikonlar
let g:webdevicons_enable_airline_tabline = 1   " Sekme çubuğunda ikonlar
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1 " Klasör ikonları
let g:DevIconsEnableFoldersOpenClose = 1        " Açık/kapalı klasör ayrımı

" -----------------------------------------------------------------------------
" 11. Yardımcı fonksiyonlar & autocmd
" -----------------------------------------------------------------------------
" Dışarıda değişen dosyaları odak/buffer değişince otomatik yeniden yükle
autocmd FocusGained,BufEnter,CursorHold * silent! checktime

" Vim proje olmadan açılınca NERDTree'yi göster
function! s:start_up() abort
  if argc() == 0
    NERDTree
  endif
endfunction
autocmd VimEnter * call <SID>start_up()

" :E <dizin>  =>  o dizine geç ve NERDTree'yi orada aç
function! OpenDirAndNERDTree(dir) abort
  execute 'cd' fnameescape(a:dir)
  if exists(':NERDTreeClose')
    NERDTreeClose
  endif
  execute 'NERDTree' fnameescape(a:dir)
endfunction
command! -nargs=1 -complete=dir E call OpenDirAndNERDTree(<q-args>)
