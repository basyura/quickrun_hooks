let s:hook = {
\   'config': {
\     'files': [],
\   }
\ }

function! s:hook.init(session) abort
endfunction

function! s:hook.on_success(session, context) abort
  let dir = fnamemodify(a:session.config.srcfile, ':p:h')
  let file = a:session.config['hook/open']

  let cmd = "open"
  let path = dir . "/" . file
  if executable("explorer")
    let path = dir . "\\" . file
  endif

  if !filereadable(path)
    return
  endif

  call system(cmd . " " . path)
endfunction

function! quickrun#hook#open#new() abort
  return deepcopy(s:hook)
endfunction

