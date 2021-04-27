set expandtab

" for Mac
set antialias

" file type
filetype indent plugin on

"" syntax highlighting
"syntax on
colorscheme ron
highlight LineNr ctermfg=darkgrey

set whichwrap=b,s,h,l,<,>,[,]

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
" 強く推奨するオプション

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
" バッファを保存しなくても他のバッファを表示できるようにする
set hidden

" Better command-line completion
" コマンドライン補完を便利に
set wildmenu

" Show partial commands in the last line of the screen
" タイプ途中のコマンドを画面最下行に表示
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
" 検索語を強調表示（<C-L>を押すと現在の強調表示を解除する）
set hlsearch
set incsearch

" Modelines have historically been a source of security vulnerabilities.  As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" 歴史的にモードラインはセキュリティ上の脆弱性になっていたので、
" オフにして代わりに上記のsecuremodelinesスクリプトを使うとよい。
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Allow backspacing over autoindent, line breaks and start of insert action
" オートインデント、改行、インサートモード開始直後にバックスペースキーで
" 削除できるようにする。
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
" オートインデント
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
" 画面最下行にルーラーを表示する
set ruler

" Always display the status line, even if only one window is displayed
" ステータスラインを常に表示する
set laststatus=2
set statusline=[%n]%y[%{&fenc!=''?&fenc:&enc}:%{&ff}]\ %F%m%r%h%w\ %=%l%-4(,%v%)\ \ %LL\ %4P

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
" バッファが変更されているとき、コマンドをエラーにするのでなく、保存する
" かどうか確認を求める
set confirm

" Use visual bell instead of beeping when doing something wrong
" ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
" そしてビジュアルベルも無効化する
set t_vb=

" Enable use of the mouse for all modes
" 全モードでマウスを有効化
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
" コマンドラインの高さを2行に
set cmdheight=1 " KOU_CHANG

" Display line numbers on the left
" 行番号を表示
set number
set ruler

" Quickly time out on keycodes, but never time out on mappings
" キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
" <F11>キーで'paste'と'nopaste'を切り替える
set pastetoggle=<F11>

"------------------------------------------------------------
" Mappings {{{1
" マッピング
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
" Yの動作をDやCと同じにする
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" <C-L>で検索後の強調表示を解除する
nnoremap <C-L> :nohl<CR><C-L>

set showtabline=2

"----------------------------------------------------------------

set encoding=utf-8
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        if has('mac')
            let &fileencodings = 'utf-8,' . s:enc_jis .','. s:enc_euc
            let &fileencodings = &fileencodings .','. s:fileencodings_default
        else
            let &fileencodings = 'utf-8,' . s:enc_jis .','. s:enc_euc .',cp932'
            let &fileencodings = &fileencodings .','. s:fileencodings_default
        endif
        unlet s:fileencodings_default
    else
        let &fileencodings = 'uff-8,' . &fileencodings .','. s:enc_jis
        set fileencodings+=ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    unlet s:enc_euc
    unlet s:enc_jis
endif


"-------------------------------------------------------
set tabpagemax=20


"added by KOU_CHANG
set list listchars=tab:^_,trail:_

" tab setting
set shiftwidth=4
set tabstop=4

filetype off

" Dein Setting begin

" Add the dein installation directory into runtimepath
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

" Let dein manage dein
call dein#add('Shougo/dein.vim')
if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
" originalrepos on github
call dein#add('Shougo/vimproc.vim')
call dein#add('vim-script/VimClojure')
call dein#add('Shougo/vimshell')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neocomplcache')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')

" <C-C> でコピーしたいために下記フラグを指定
" https://github.com/jpalardy/vim-slime#advanced-configuration
let g:slime_no_mappings = 1
call dein#add('jpalardy/vim-slime')
call dein#add('scrooloose/syntastic')
""call dein#add('https://bitbucket.org/kovisoft/slimv')

" erlangのシンタクスハイライト
call dein#add('vim-erlang/vim-erlang-runtime')
" erlangのオムニ補完
call dein#add('vim-erlang/vim-erlang-omnicomplete')

call dein#add('vim-jp/vimdoc-ja')

" Markdown
" Vim + Markdown - Qiita
" https://qiita.com/iwataka/items/5355bdf03d0afd82e7a7
call dein#add('tpope/vim-markdown')
call dein#add('iwataka/vim-markdown-ex')

" MacVimをMarkdownプレビュー＆編集ツールにする - Qiita
" https://qiita.com/watanata/items/c5dc698afef32284f5c1
call dein#add('kannokanno/previm')

call dein#end()

" Required by dein
filetype plugin indent on
syntax enable

" Dein Settings End

filetype indent on

:set helplang=ja,en

"-------------------------
" End Neobundle Settings.
"-------------------------


"tab control
noremap <silent> <C-H> :tabp<CR>
noremap <silent> <C-L> :tabn<CR>
noremap <silent> <ESC><ESC> :nohlsearch<CR>

"error window next(pre) line
noremap <silent> <C-J> :cn<CR>
noremap <silent> <C-K> :cN<CR>

"tag jump
noremap <C-]> g<C-]>

"*serch
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
"vim grep
nnoremap <expr> gr ':vimgrep ;\<' . expand('<cword>') . '\>; **/*.' . expand("%:e") . ' \| cw'

" オムニ補完を<C-F>でできるようにする
imap <C-f> <C-x><C-o>

function! ErlangTagsSettings()
  if exists(":ErlangTags")
    echom "ErlangTags detected"
    let g:erlang_tags_ignore = "**/.eunit"
  else
    echom "Could not detect ErlangTags plugin"
  endif
endfunction

autocmd VimEnter * call ErlangTagsSettings()

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" MacVimをMarkdownプレビュー＆編集ツールにする - Qiita
" https://qiita.com/watanata/items/c5dc698afef32284f5c1
" {{{ previm plugin settings
"---------------------------------------------------
let g:previm_open_cmd = 'open -a Google\ Chrome'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
" }}}

" カットアンドペーストの設定
vmap <C-C> "+y
" vmap <C-V> "+p

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

