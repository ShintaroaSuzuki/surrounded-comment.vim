function! s:count_string_length(l) abort
    let l = a:l
    return strlen(substitute(l, '[^\x01-\x7E]', 'xx', 'g'))
endfunction

function! s:get_comment_out_token() abort
    return substitute(&commentstring, '%s', '', '')
endfunction

function! surrounded_comment#go() abort
    let l:line = getline('.')
    let l:line_length = s:count_string_length(l:line)
    let l:line_without_space = substitute(substitute(l:line, '^\s\+', '', ''), '\s\+$', '', '')
    let l:line_without_space_length = s:count_string_length(l:line_without_space)
    let l:comment_out_token = s:get_comment_out_token()
    let l:line_with_comment_out_token = l:comment_out_token . " " . l:line_without_space . " " . l:comment_out_token
    let l:head_space = repeat(" ", l:line_length - l:line_without_space_length)
    let l:comment_out_block_line = l:head_space . repeat(l:comment_out_token, s:count_string_length(l:line_with_comment_out_token) / s:count_string_length(l:comment_out_token))

    call append(line('.'), l:comment_out_block_line)
    call setline(line("."), l:head_space . l:line_with_comment_out_token)
    call append(line('.') - 1, l:comment_out_block_line)
endfunction
