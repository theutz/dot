if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *yabairc setfiletype sh
  au! BufRead,BufNewFile *skhdrc  setfiletype sh
augroup END
