let s:DEBUG = v:false

function! s:bufclose(re) abort
    for l:buf in range(1, bufnr('$'))
        if bufname(l:buf) =~ a:re
          exec 'bd! '. l:buf
        endif
    endfor
endfunction

function! session#load(...) abort
  let l:file = getcwd() . '/.sessions/' . get(a:, 1,  'default' ) . '.vim'
  if s:DEBUG
    echo 'session#load(' . l:file .')'
  endif
  if filereadable(l:file)
    exec 'source' l:file
  endif
endfunction

function! session#store(...) abort 
  let l:file = getcwd() . '/.sessions/' . get(a:, 1,  'default' ) . '.vim'
  if !isdirectory(getcwd() . '/.sessions')
    call mkdir(getcwd() . '/.sessions', 'p')
  endif
  
  let l:nerdtree = v:false
  if exists('g:NERDTree') && g:NERDTree.IsOpen()
    exec 'NERDTreeClose'
    let l:nerdtree = v:true
  endif

  let l:tagbar = v:false
  if exists('*g:tagbar#IsOpen') != -1 && tagbar#IsOpen()
    exec 'TagbarClose'
    let l:tagbar = v:true
  endif

  exec 'mksession! ' . l:file
  
  if l:nerdtree
    call writefile( readfile(l:file) + ['NERDTree'] , l:file)
    NERDTree
  endif

  if l:tagbar
    call writefile( readfile(l:file) + ['Tagbar'] , l:file)
    Tagbar
  endif

endfunction

