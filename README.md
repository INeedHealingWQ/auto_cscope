# auto_cscope
Shell script and vim script for load cscope automatically

# Getting start
# Usage：
使用此脚本需要你按如下格式组织你的目录：
/home/<user>/csdatabase/<project>/<project-src>

注：<project>为项目目录，<project-src>为项目源码目录，如：
/home/wang/csdatabase/linux/linux-4.12.0
脚本选项：
Usage: csupdate -p <project dir> [options] [file]
Options:
-p    Build cscope database for the project you give
-d    Build cscope database for the src you give
-a    Build cscope database for all src in the proj you give
-q    Quick mode, use original database, not collect new-add files
-h    Show this help message

一般使用-p、-d选项，-p后跟项目目录，如linux，-d后跟具体的源码目录，如：linux-4.12.0
运行脚本：

ex: 以上述“/home/wang/csdatabase/linux/linux-4.12.0”的目录组织方式为例：
csupdata_w -p ~/linux -d ~/linux/linux-4.12.0

#Update vim:
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

#Add these lines in your .vimrc：
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

此时若你已按照第一步运行完毕了csupdate_w脚本，则只要在linux-4.12.0目录下打开文件就便可以自动索引源码。

# You can access this web for usage:
http://whilewq/index.php/2020/05/25/auto-load-cscope-data-with-vim/
