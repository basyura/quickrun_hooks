let s:hook = {
\   'config': {
\     'files': [],
\   }
\ }

function! s:hook.init(session) abort
endfunction

function! s:hook.on_ready(session, context) abort
  let path = s:target_path(a:session)
  if path == ""
    return
  endif

  call delete(path)
endfunction

function! s:hook.on_success(session, context) abort

  let path = s:target_path(a:session)
  if path == ""
    return
  endif

  let cmd = "open"
  if executable("explorer")
    let cmd ="explorer"
  endif

  call system(cmd . " " . path)
endfunction

function! s:target_path(session)
  if !has_key(a:session.config, 'hook/open')
    return
  endif

  let file = a:session.config['hook/open']
  let dir = fnamemodify(a:session.config.srcfile, ':p:h')

  let path = dir . "/" . file
  if executable("explorer")
    let path = dir . "\\" . file
  endif

  if !filereadable(path)
    return ""
  endif

  return path
endfunction

function! quickrun#hook#open#new() abort
  return deepcopy(s:hook)
endfunction

