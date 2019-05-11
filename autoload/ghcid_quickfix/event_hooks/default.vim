" Make new instance to argue how to do actions when 'events' occured.
" (A mock for tests.)
"
" 'events'
" - on_reloading(): Be called when ghcid says '^Reloading...' (before :caddexpr).
" - on_outputting_line(line): Be called before showing a line on :caddexpr.
"
" qf_bufnr: a quickfix buffer that should be output ghcid lines.
function! ghcid_quickfix#event_hooks#default#new(qf_bufnr) abort
  let instance = {
    \ 'qf_bufnr': a:qf_bufnr,
  \ }

  function! instance.on_quickfix_buffer_created() abort dict
    copen
  endfunction

  function! instance.on_outputting_line(line) abort dict
    if match(a:line, '^Reloading\.\.\.') isnot -1
      call setqflist([])
      call setbufvar(self.qf_bufnr, '&filetype', 'ghcid_quickfix')
    endif
  endfunction

  return instance
endfunction