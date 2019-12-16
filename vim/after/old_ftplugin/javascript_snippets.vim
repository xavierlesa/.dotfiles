" snippets para javacript, jquery y html 
let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim


exec "Snippet linkcss <link rel=\"stylesheet\" href=\"".st.et."\" type=\"text/css\" />"
exec "Snippet linkjs <script src=\"".st.et."\" type=\"text/javascript\"></script>"
exec "Snippet script <script type=\"text/javascript\"><CR>".st.et."<CR></script>"

exec "Snippet fu function(".st.et."){<CR>".st.et."<CR>}"
exec "Snippet $ $(".st.et.")"
