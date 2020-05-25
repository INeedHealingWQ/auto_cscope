" For cscope database auto add.
if has("cscope") && filereadable("/usr/bin/cscope")
    set nocsverb
    if filereadable("cscope.out")
    cs add $PWD/cscope.out
    elseif $CS != ""
    cs add $CS
    endif
    set csverb
endif

let s:csdir_s = $HOME . "/csdatabase"
let s:csdir_l = split(s:csdir_s, "/")
let s:wkent_l = readdir($HOME)
let s:csent_l = readdir(s:csdir_s)
let s:cdir_l = split($PWD, "/")
let s:mindep_n = 4

if (len(s:cdir_l) >= s:mindep_n)
    if (-1 != index(s:wkent_l, get(s:cdir_l, 2))
    \&& -1 != index(s:csent_l, get(s:cdir_l, 2))
    \&& -1 != index(readdir("/" .
        \join(add(s:csdir_l,get(s:cdir_l, 2)), "/")), get(s:cdir_l, 3))
    \ )
        let s:csdb_l = add(split(s:csdir_s, "/"), get(s:cdir_l, 2))
        let s:csdb_l = add(s:csdb_l, get(s:cdir_l, 3))
        let s:csdb_s = "/" . join(s:csdb_l, "/")
        set nocsverb
        exe "cs add" s:csdb_s
        set csverb
    endif
endif
" End cscope database auto add
