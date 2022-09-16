let s:DEBUG = v:false

if exists('g:session_loaded') && !s:DEBUG
  finish
endif

let g:session_loaded = v:true

nnoremap <Plug>SessionLoad :call session#load()<CR>
nnoremap <Plug>SessionStore :call session#store()<CR>
" Reload the plugin
nnoremap <Leader>sl <Plug>SessionLoad
nnoremap <Leader>ss <Plug>SessionStore

command -nargs=* SessionLoad call session#load(<f-args>)
command -nargs=* SessionStore call session#store(<f-args>)
