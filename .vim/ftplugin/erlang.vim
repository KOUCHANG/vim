setlocal expandtab
setlocal softtabstop=4
setlocal shiftwidth=4

set noautochdir

" erlファイルをerlangとして認識する
" au BufNewFile,BufRead *.erl setf erlang
" :makeでerlang構文チェック
" au FileType erlang setlocal makeprg=erlc\ %
setlocal errorformat=%f:%l:\ %m

