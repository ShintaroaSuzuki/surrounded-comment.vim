if exists('g:loaded_surrounded_comment')
    finish
endif
let g:loaded_surrounded_comment = 1

command! SurroundedComment call surrounded_comment#go()

nnoremap gs :SurroundedComment<CR>
