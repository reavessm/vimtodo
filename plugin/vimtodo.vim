"------------------------------------------------------------------------------
" VimTodo

exec "let g:scriptdir = expand('<sfile>:p:h')"

fun! s:toggleComplete()
  let l:line = getline('.')
  let l:char = matchstr(l:line, '\[\zs.\ze]')

  if l:char == 'X'
    let l:char = ' '
  else
    let l:char = 'X'
  endif

  call setline(line('.'), substitute(l:line, '\[\zs.\ze]', l:char, ''))
endfun
command! ToggleComplete call s:toggleComplete()

fun! s:openTodo()
  echom g:scriptdir
  let s:example = g:scriptdir.'/examplevimtodo'
  if (!filereadable(expand("~/.vimtodo"))) && filereadable(s:example)
    execute 'silent !cp ' . s:example . ' ~/.vimtodo'
  endif
  autocmd BufNew,BufRead,BufNewFile *.vimtodo set filetype=markdown
  autocmd BufNew,BufRead,BufNewFile *.vimtodo nnoremap q :wq<CR>
  autocmd BufNew,BufRead,BufNewFile *.vimtodo nnoremap <Space> :ToggleComplete<CR>
  autocmd BufNew,BufRead,BufNewFile *.vimtodo nnoremap t A<CR>[<Space>]<Space>
  autocmd BufNew,BufRead,BufNewFile *.vimtodo setlocal textwidth=35

  execute "40vsp ~/.vimtodo"
  execute "set winfixwidth"
  execute "redraw!"
endfun
command! Todo call s:openTodo()
