function! ehdawhich#find(mods, filename, command) abort
  let l:filepath = system('ehdawhich ' .  a:filename)

  if stridx(filepath, 'Cannot find')
    execute a:command . ' ' . l:filepath
  endif
endfunction

command! -nargs=* -complete=command Ew  call ehdawhich#find(<q-mods>, <q-args>, 'e')
command! -nargs=* -complete=command Ewn call ehdawhich#find(<q-mods>, <q-args>, 'new')

