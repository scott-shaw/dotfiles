set encoding=utf-8
"set background=dark

syntax on
set number
set title
set hlsearch

set autoindent
"set smartindent
set expandtab
set tabstop=4
set mouse=a
set shiftwidth=4

" for command mode
nnoremap <Tab> >>
" for command mode
nnoremap <S-Tab> <<
" for insert mode
inoremap <S-Tab> <C-d>

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
