#!/bin/bash

#############
# Functions #
#############
function set_owner_priv() {
    set -ex
    find . -type d -print0 | xargs -0 chmod 700
    find . -type f -print0 | xargs -0 chmod go-rwx
    find . -type f -print0 | xargs -0 chmod u+rw
    set +ex
}

function set_readable_for_all() {
    if [ $# -eq 1 ]; then
        if [ ! -d "$1" ]; then
            echo "$1 is not a directory"
            return
        fi
        echo "Changing to $1"
        cd "$1"
    fi
    set -x
    find . -type d -print0 | xargs -0 chmod a+rx
    find . -type f -print0 | xargs -0 chmod a+r
    set +x
}

function set_writable_for_all() {
    read -p "Are you sure? (yes to confirm): " result
    [ $result != 'yes' ] && return
    if [ $# -eq 1 ]; then
        if [ ! -d "$1" ]; then
            echo "$1 is not a directory"
            return
        fi
        echo "Changing to $1"
        cd "$1"
    fi
    set -x
    find . -type d -print0 | xargs -0 chmod a+rwx
    find . -type f -print0 | xargs -0 chmod a+rw
    set +x
}

function tardir {
    checkparams 1 "$#" "Usage: tardir <directory>" || return 1
    if [ ! -d "$1" ]; then 
        echo "\"$1\" is not a directory."
        return 2
    fi
    dir_name=${1%/}
    echo tar -czf "$dir_name.tar.gz" "$dir_name"
    tar -czf "$dir_name.tar.gz" "$dir_name"
}

function untar {
    checkparams 1 "$#" "Usage: untar <tarball>" || return 1
    if [ ! -f "$1" ]; then 
        echo "\"$1\" is not a file."
        return 2
    fi
    echo tar -xzf "$1"
    tar -xzf "$1"
}

function untard {
    checkparams 1 "$#" "Usage: untar <tarball>" || return 1
    if [ ! -f "$1" ]; then 
        echo "\"$1\" is not a file."
        return 2
    fi
    dirname=`basename "$1" .tar.gz`
    dirname=`basename "$dirname" .tgz`
    echo tar -C "$dirname" -xzf "$1"
    mkdir "$dirname"
    tar -C "$dirname" -xzf "$1"
}

function bzipdir {
    checkparams 1 "$#" "Usage: bzipdir <directory>" || return 1
    if [ ! -d "$1" ]; then 
        echo "\"$1\" is not a directory."
        return 2
    fi
    echo tar -cjvf "$1.tar.bz2" "$1"
    tar -cjvf "$1.tar.bz2" "$1"
}

function unbzip {
    checkparams 1 "$#" "Usage: unbzip <tarball>" || return 1
    if [ ! -f "$1" ]; then 
        echo "\"$1\" is not a file."
        return 2
    fi
    echo tar -xjf "$1"
    tar -xjf "$1"
}

function unbzipd {
    checkparams 1 "$#" "Usage: unbzip <tarball>" || return 1
    if [ ! -f "$1" ]; then 
        echo "\"$1\" is not a file."
        return 2
    fi
    dirname=`basename "$1" .tar.bz2`
    dirname=`basename "$dirname" .bz2`
    echo tar "$dirname" -xjf "$1"
    mkdir "$dirname"
    tar -C $dirname -xjf "$1"
}

function unzipd {
    checkparams 1 "$#" "Usage: unzipd <archive>" || return 1
    if [ ! -f "$1" ]; then 
        echo "\"$1\" is not a file."
        return 2
    fi
    dirname=`basename "$1" .zip`
    echo unzip -q "$1" -d "$dirname"
    unzip -q "$1" -d "$dirname"
}

function unrard {
    checkparams 1 "$#" "Usage: unrard <archive>" || return 1
    if [ ! -f "$1" ]; then 
        echo "\"$1\" is not a file."
        return 2
    fi
    dirname=`basename "$1" .rar`
    mkdir "$dirname"
    cd "$dirname"
    unrar x "../$1"
    cd ..
}

function unjard {
    checkparams 1 "$#" "Usage: unjard <jar>" || return 1
    if [ ! -f "$1" ]; then 
        echo "\"$1\" is not a file."
        return 2
    fi
    dirname=`basename "$1" .jar`
    echo unzip -q "$1" -d "$dirname"
    unzip -q "$1" -d "$dirname"
}

function zipdir {
    checkparams 1 "$#" "Usage: zipdir <directory>" || return 1
    if [ ! -d "$1" ]; then 
        echo "\"$1\" is not a directory."
        return 2
    fi
    cmd="zip -r $1.zip $1"
    echo $cmd
    $cmd
}

function tarless {
    checkparams 1 "$#" "Usage: tarless <tarball>" || return 1
    if [ ! -f "$1" ]; then 
        echo "\"$1\" is not a file."
        return 2
    fi
    echo tar -xzf "$1"
    tar -tzvf "$1" | less
}

function setlocale {
    checkparams 1 "$#" "Usage: setlocale locale" || return 1
    if [ "$1" = "cs" ]; then
        # Czech
        echo "Nastavuji ceske prostredi...."
        export LC_ALL=cs_CZ
        export LANG=cs
        export LANGUAGE=cs:sk
        export LINGUAS="cs sk"
        #setfont -v lat2-16
    else
        echo "Setting \"$1\" environment...."
        export LC_ALL=$1
        export LANG=$1
        export LANGUAGE=$1
        export LINGUAS=$1
    fi
}

function whfile {
    C=${1?"Prvni argument musi byt nazev programu!"}
    X=`which "$C"` && file -b "$X" && ls -la "$X"
}

function findre() {
    checkparams 2 "$#" "Usage: findre <file-mask> <regex>" || return 1
    find . -type f -iname "$1" -exec grep -il "$2" {} \;
}

function findInJava() {
    checkparams 1 "$#" "Usage: findInJava <regex>" || return 1
    findre "*.java" "$1"
}

function findInBundle() {
    checkparams 1 "$#" "Usage: findInBundle <regex>" || return 1
    findre "Bundle.properties" "$1"
}

function findTrash() {
    find . -type f | grep '\(\.*\#.*\)\|\(.*\.bak$\)'
}

function setexecoff() {
    find . -type f -print0 | xargs -0 chmod -v ugo-x
}

function gwhich {
    checkparams 1 "$#" "Usage: gwhich whichArgumentToEdit" || return 1
    res=`which "$1"`
    [ -z "$res" ] || gvim "$res"
}

function gcat {
    checkparams 1 "$#" "Usage: gcat whichArgumentToCat" || return 1
    res=`which "$1"`
    [ -z "$res" ] || cat "$res"
}

function nblocate() {
    locate_place="\/space-hdd\/java\/netbeans-hg\/main\/.*"
    _do_locate $*
}

function ijclocate() {
    locate_place="\/space\/java\/ijc.git\/.*"
    _do_locate $*
}

function _do_locate() {
    local nb_open=false
    while getopts "o" optname $@; do
        case "$optname" in
            "o")
                local nb_open=true
                shift
                ;;
        esac
    done

    res=`locate -i -r $locate_place$1 | grep -v \\\\.hg | grep -v \\\\.svn`
    echo "$res"
    if [ "$nb_open" = "true" ]; then
        _open_files_in_nb $res
    fi
    unset OPTSTRING
    unset OPTIND
}

function _open_files_in_nb() {
    read -p "Do you want to open the files in NetBeans? (y/n): " result
    if [ "$result" == 'y' ]; then
        nb --open "$1"
    fi
}

function Man() {
    checkparams 1 "$#" "Usage: man man_page_name" || return 1
    $VIM_CMD -c "Man $1" -c "only"
}

function docgrep() {
    cdmydocs
    export VIM_SERVER='MYDOCS'
    mygrep "$@"
    cd -
}

function cphere() {
    checkparams 1 "$#" "Usage: cphere <file_to_copy>" || return 1
    if [ -f "`basename "$1"`" ]; then
        echo "INFO: '$1' already exists in the current directory"
    else
        cp -av "$1" .
    fi
}

function checkparams() {
    expectedNumOfParams=$1
    actualNumOfParams=$2
    message=$3
    if [ "$expectedNumOfParams" -ne "$actualNumOfParams" ]; then
        echo $message
        return 1
    fi
}

function vimserver() {
    checkparams 1 "$#" "Usage: vimserver <vim_session_name>" || return 1
    if wmctrl -l | grep "$1"; then
        wmctrl -a "$1"
    else
        gvim --servername $1
    fi
}

function vimsession_named() {
    checkparams 1 "$#" "Usage: vimsession_named <vim_session_name>" || return 1
    if wmctrl -l | grep "$1"; then
        wmctrl -a "$1"
    else
        vimsession --servername $1
    fi
}

function vimdirdiff() {
    vim -g -c "DirDiff $1 $2"
}

function git_log1() {
    git log --pretty=format:'%h|%an|%s' $1 |
        while IFS='|' read hash author message; do
            printf '%s %-12s %s\n' "$hash" "$author" "$message"
        done
}

function git_add_ss() {
    checkparams 1 "$#" "Usage: git_add_ss <stash-message>" || return 1
    git add . && git ss "$1"
}

function git_logpr_since() {
    git logpr $1^1..
}

function taillogs {
    cd /var/log
    find . -follow -type f | egrep -v \(scripts\|packages\) | xargs ls -t1r | \
        xargs file | egrep -v data\|'MySQL replication' | cut -f 1 -d ':' | \
        xargs tail -f ~emdot/tmp/startxlog
}

function rm_linked_dir() {
    file=`readlink $1`
    dir=`dirname $file`
    read -p "Do you really want to delete '$dir' directory? (yes to confirm): " result
    [ $result != 'yes' ] && return
    if [ ! -d "$dir" ]; then
        echo "$dir is not a directory"
        return
    fi
    rm -rv "$dir"
}

# Dry run of 'cabal install' with highlight-versions tool
function cid {
    cabal install $1 --dry-run -v | highlight-versions
}

# Dry run of 'cabal-dev install' with highlight-versions tool
function cidd {
    cabal-dev install $1 --dry-run -v | highlight-versions
}

# List Haskell package(s). Both - remote and installed
function hlspkg {
    cabal list --simple-output $1
}

# List Haskell package(s). Both - remote and installed
function hlspkgd {
    cabal-dev list --simple-output $1
}

# List installed Haskell package(s)
function hlspkgi {
    cabal list --simple-output --installed $1
}

# List installed Haskell package(s)
function hlspkgid {
    cabal-dev list --simple-output --installed $1
}

# Show modules exposed by the given package.
function hlesspkg {
    ghc-pkg field $1 exposed-modules
}

function rename_dir_here() {
    checkparams 1 "$#" "Usage: rename_dir_here <dir_to_rename>" || return 1
    dir_name="`mkdir-first`"
    rm -r "$dir_name"
    mv -v "$1" "$dir_name"
}

function mnt() {
    checkparams 1 "$#" "Usage: mnt <device>" || return 1
    mntdir="/media/$1"
    if [ ! -d $mntdir ]; then
        sudo mkdir -p $mntdir
    fi
    # try Windows partition first
    sudo mount -t auto -o noauto,rw,users,gid=1000,uid=1000,umask=0002,quiet,showexec,noexec /dev/$1 $mntdir && cd $mntdir
    if [ $? -ne 0 ]; then
        # likely linux partition, try it
        sudo mount -t auto -o noauto,rw,users /dev/$1 $mntdir && cd $mntdir
    fi
}

function umnt() {
    checkparams 1 "$#" "Usage: umnt <device>" || return 1
    mntdir="/dev/$1"
    sudo umount -v $mntdir
}

function vimhelp2html() {
    checkparams 1 "$#" "Usage: vimhelp2html <vim-help-file>" || return 1
    gvim -f +"syn on" +":let g:html_number_lines=0" +"let g:html_no_pre=1" +"run! syntax/2html.vim" +"wq" +"q" "$1"
}

function mydocs2html() {
    set -e
    dirs="science cs languages"
    for dir in $dirs; do
        mkdir -p ~/tmp/mydocs-html/$dir
        for f in `find $MYDOCS/$dir -name "*.txt" -type f`; do
            vimhelp2html $f
            mv $f.html ~/tmp/mydocs-html/$dir
        done
    done
    echo "~/tmp/mydocs-html/ ready"
    set +e
}

