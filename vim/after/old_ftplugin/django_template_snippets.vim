let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim
let current_file = "%:t:r"

exec "Snippet tpl {% comment %}<CR># fdm=marker foldenable sw=4 ts=4 sts=4 filetype=htmldjango<CR>Block: ".current_file."<CR>{% endblock %}<CR>"
