" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Jump file 
set path=src,node_modules
set suffixesadd=.js,.jsx,.ts,.tsx,.vim

" Stop putting comments in front of new lines
augroup auto-comment-off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" コマンド、検索パターンの履歴
set history=50		" keep 50 lines of command line history
set ignorecase 
set smartcase
set incsearch
set ruler		" show the cursor position all the time
set hlsearch
syntax on

" === window, buffer === 
" タイトルをウィンドウ枠に表示する
set title
set number
set splitbelow
set splitright

" === status line ===
"ステータス行を表示
set laststatus=2
" ステータスラインの色
" highlight statusline   term=NONE cterm=NONE guifg=red ctermfg=yellow ctermbg=red
"入力中のコマンドをステータスに表示する
set showcmd
set statusline=<%{winnr()}>\%f%r%h%w\%=[POS=%04v,%04l][%p%%]\ [LEN=%L]

" === その他 ===
" swapをファイル作らない
set noswapfile

"内容が変更されたら自動的に再読み込み
" set autoread
augroup reload-file-diff
  autocmd!
  autocmd InsertEnter,WinEnter * checktime
augroup END

" ビープ音消す
set vb t_vb=
set ttimeoutlen=4

" クリップボード連携
set clipboard=unnamed

set autoindent

" ファイルのバックアップを有効にする
set backup
" 取得するバックアップを編集前のファイルとする(無効化する場合は「nowritebackup」)
set writebackup
" バックアップ先のディレクトリ指定
set backupdir=$HOME/.vimbackup

if has('mouse')
  set mouse=a
endif
