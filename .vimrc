"
" author: Martin Krauskopf <martin.krauskopf at gmail.com>
"

"*********************** START: BASIC SETTING /*{{{*/
" override e.g. $VIM/vimrc
" !!! be careful about this options, might make Vim behaves strangely
"set all&
" use Vim settings instead of Vi
set nocompatible
syntax on
" show mode (INSERT, VISUAL, ...)
set showmode
" show sequence of inserting command
set showcmd
" show cursor position
set ruler
" don't show line number in front of each row
set nonumber
" do not wrap long lines by default
set nowrap
" number of spaces for indenting
set shiftwidth=2
" Round indent to multiple of 'shiftwidth'. Applies to > and < commands.
set shiftround
" set tabs width
set tabstop=2
" use shiftwidth when inserting
set smarttab
" smart indenting
set smartindent
" disable wrap searching
set nowrapscan
" highlight searched result
set hlsearch
" increasing search
set incsearch
" case insensitive searching
set ignorecase
" smart caseSearching (works with ignorecase)
set smartcase
" backspace is always on
set bs=indent,eol,start
" replace tabulators by spaces
set expandtab
" use visual beep instead of sound
set t_vb= vb
" enabale menu upon the command line
set wildmenu
set cmdheight=2
" has completion like bash
set wildmode=longest:full,full
"set wildmode=list:longest,list:full
" hidden on
set hidden
" list of directory names for the swap file
set directory=~/tmp/vim,.,/tmp
" use a dialog when an operation has to be confirmed
set confirm
" using more than default (octal, hex)
set nrformats=hex
" status line setting
set laststatus=2
set statusline=%1*%n:%*\ %<%f\ %y%m%2*%r%*%{fugitive#statusline()}%=[%b,0x%B]\ \ %l/%L,%c%V\ \ %P
" highlight current line
"set cursorline
" when splitting windows (vertical, vsplit, ... commands ), show the new window
" on the right
set splitright

" set langmap=+1,ě2,š3,č4,ř5,ž6,ý7,á8,í9,é0,-/,_?

" set dictionary files
"set dictionary+=/space/storage/misc/an-cs.txt
let s:cz_dictionary='/space/slovnik/peki-converted/slovnik_data-utf8.txt'
exe 'set dictionary += ' + s:cz_dictionary
" dictionaries for keyword completion (CTRL-P, CTRL-N, CTRL-L)
" (option descriptions was copied from help
"    . - scan the current buffer ('wrapscan' is ignored)
"    w - scan buffers from other windows
"    b - scan other loaded buffers that are in the buffer list
"    u - scan the unloaded buffers that are in the buffer list
"    k - scan the files given with the 'dictionary' option
"    i - scan current and included files
"    t - tag completion (same as ``]'')
set complete=.,w,b,u,i,t " k
" (option descriptions was copied from help (:h fo-table)
" t - Auto-wrap text using textwidth (does not apply to comments)
" c - Auto-wrap comments using textwidth, inserting the current comment leader
"     automatically.
" r - Automatically insert the current comment leader after hitting <Enter> in
"     Insert mode.
" o - Automatically insert the current comment leader after hitting 'o' or 'O'
"     in Normal mode.
" q - Allow formatting of comments with "gq". Note that formatting will not
"     change blank lines or lines containing only the comment leader. A new
"     paragraph starts after such a line, or when the comment leader changes.
" n - When formatting text, recognize numbered lists.
" 2 - When formatting text, use the indent of the second line of a paragraph
"     for the rest of the paragraph
set formatoptions=tcroqn2

set viminfo='50,\"500
" set command history
set history=2500
" break line character
set showbreak=\>\ 
" detect plugins and provide intelligent indent for various filetypes
filetype plugin indent on
" When editing a file, always jump to the last cursor position
au BufReadPost * if line("'\"") | exe "'\"" | endif
"au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"z." | endif
" sets status line is always on
set laststatus=2
set number
set display=lastline
" Right mouse button pops up a menu
set mousemodel=popup

" minimal visible area
set scrolloff=5
set sidescroll=5

" define <Leader> and <LocalLeader> for map commands
let mapleader = ","
let maplocalleader = ","

" Don't insert two spaces after a '.', '?' and '!' with a join command.
set nojoinspaces

" Replace selected text by the text in the register. (by Bram Moolenaar)
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Spelling
set spellfile=~/.vim/mk-dictionary.add

set listchars+=extends:>,precedes:<
"set keywordprg=pinfo
"*********************** END: BASIC SETTING /*}}}*/

"*********************** START: GLOBAL KEY-MAPPING /*{{{*/
" ==== standard motion ====
nmap <Down> gj
nmap <Up> gk

"imap <C-h> <Left>
"imap <C-j> <Down>
"imap <C-k> <Up>
"imap <C-l> <Right>

" I'm using ',' as a leader. See ':h ,'
nnoremap \ ,

" Move a line of text using control (http://www.amix.dk/vim/vimrc.html)
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Instead of Tab move just about Space
imap <C-d> <Esc>mp0x`pa
imap <C-t> <Esc>mp0<Space>`pla
vmap <Space> :s/^/ /<CR>gv

" ==== command-line mode ====
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" motion
"cnoremap <C-A> <Home>
"cnoremap <C-F> <Right>
"cnoremap <C-B> <Left>
"cnoremap <C-E> <End>
"cnoremap <C-D> <Del>
"cnoremap <C-h> <S-Left>
"cnoremap <C-l> <S-Right>
" split help window vertically instead of horizontally
cmap <Leader>v <C-A>vertical <CR>

" windows resizing
nmap <C-S-up> <C-w>-
nmap <C-S-down> <C-w>+
nmap <C-S-left> <C-w><
nmap <C-S-right> <C-w>>

" ==== buffer editing ====
vmap <C-l> >gv
vmap <C-h> <gv
nmap <S-CR> o<ESC>
imap <S-CR> <ESC>o
nmap <C-S-CR> O<ESC>
imap <C-S-CR> <ESC>O
nmap <SPACE> i<SPACE><ESC>
imap <C-a> <ESC>A
" Not you cannot use <C-i> which mean the same as pressin <Tab>, so using
" <C-b> ('b' as beginning (of line))
imap <C-b> <ESC>I
" underscore line
nmap <Leader>ul yyp^v$r-j
imap <Leader>ul <ESC><Leader>ulko
nmap <Leader>hl o <ESC>70a-<ESC>o<ESC>
imap <Leader>hl <ESC><Leader>hli
imap <buffer> <C-Space> <C-v><Space>

" ==== save ====
nmap <C-s> :w<CR>
vmap <C-s> <ESC><C-s>
imap <C-s> <ESC><C-s>
cmap <C-s> <ESC><C-s>
omap <C-s> <ESC><C-s>

vmap DP :diffput<CR>
vmap DO :diffget<CR>

" ==== buffers switching ====
nmap <c-p> :bprevious<CR>
nmap <c-n> :bnext<CR>
" switching to buffer 1 - 9 is mapped to ,[nOfBuffer]
for buffer_no in range(1, 9)
  execute "nmap <Leader>" . buffer_no . " :b" . buffer_no . "\<CR>"
endfor

" switching to buffer 10 - 100 is mapped to ,0[nOfBuffer]
for buffer_no in range(10, 100)
  execute "nmap <Leader>0" . buffer_no . " :b" . buffer_no . "\<CR>"
endfor

" ==== miscellaneous ====
" tags
nmap <Leader>rt :call RegenerateTags()<CR>
"nmap <C-]> g<C-]>
" Ctrl-a to select whole text
nmap <C-A-a> ggVG
" Y yanks to the end of line
noremap Y y$

" Backspace pasting and yanking
cmap <C-BS> <C-R>+
cmap <S-BS> <C-R>*
imap <C-BS> <C-R>+
imap <S-BS> <C-R>*
nmap <C-S-BS> <C-BS><CR><S-BS>
imap <C-S-BS> <C-BS><CR><S-BS>
nmap <BS> "*p
nmap <C-BS> "+P
nmap <C-S-BS> <C-BS><S-CR><S-BS>
nmap <S-BS> "*P
vmap <BS> "*y
vmap <C-BS> "+y
" Copy content of the file into '+' buffer
nmap <C-S-BS> :0,$yank +<CR>
" Simulating above with <Leader>pa
map <Leader>pa a,pa<Esc>
imap <Leader>pa <C-r>+<CR><C-r>*

" ESC is too far on the keyboard (tips 1324 and 285)
imap jj <ESC>
" closing buffer or whole Vim. For some reason the MiniBufferExplorer lost its
" coloring. So I need to refresh the color scheme. TODO: investigate
nmap ZC :bdelete<CR>
" Suppress 'Q'. Used to safe exit instead.
nmap Q :qa<CR>
vmap Q <ESC>Q
" jump to next or previous mark
map <F2> ]`
map <S-F2> [`
nmap <silent> <C-q>h :nohlsearch<cr>
" Edit another file in the same directory as the current file uses expression
" to extract path from current file's path (thanks Douglas Potts)
if has("unix")
  nmap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
else
  nmap <Leader>e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif
" Sort and uniq visual block
vmap <Leader>so :sort u<CR>
vmap <Leader>sO :sort iu<CR>
nmap <Leader>so ggVG,so
nmap <Leader>sO ggVG,so
" Toggle NerdTree
nmap <Leader>E :NERDTreeToggle<CR>
" Translator keys
if has("unix")
  " translating mapping
  let dict_tail = ' ' . s:cz_dictionary . ' \| grep "^[^	]*	[^	].*" \| head -400 \| cut -f 1,2 \| sed -e "s/\t/ ===> /"<CR>'

  " search for whole words only
  imap <F5> <Esc><F5>
  exe "nmap <F5> \"*yiw:!grep -wih '<C-R>*'" . dict_tail
  exe "vmap <F5> y:!grep -wih '<C-R>*'" . dict_tail

  " search for whole words only and put result into a buffer
  imap <S-F5> <Esc><S-F5>
  exe "nmap <S-F5> \"*yiw:r!grep -wih '<C-R>*'" . dict_tail
  exe "vmap <S-F5> y:r!grep -wih '<C-R>*'" . dict_tail

  " search for any appearance of the input pattern
  imap <F6> <Esc><F6>
  exe "nmap <F6> \"*yiw:!grep -ih '<C-R>*'" . dict_tail
  exe "vmap <F6> y:!grep -ih '<C-R>*'" . dict_tail

  " search for any appearance of the input pattern and put result into a buffer
  imap <C-F6> <Esc><C-F6>
  exe "nmap <C-F6> \"*yiw:r!grep -ih '<C-R>*'" . dict_tail
  exe "vmap <C-F6> y:r!grep -ih '<C-R>*'" . dict_tail
endif

" runs current line in the current buffer and put the result underneath it
map <Leader>rr V"ry:execute "silent r! " . @*<BS><CR>
imap <Leader>rr <ESC><Leader>rr
vmap <Leader>rr "ryG<Leader>rr

" Run external shell in the directory of currently selected file
nmap <Leader>sh :cd %:p:h<CR>:silent !mate-terminal &<CR>:cd -<CR>
" Run Midnight Commander with current file's owning directory opened
nmap <Leader>mc :silent !mate-terminal -e "mc %:p:h"<CR>
vmap <Leader>mc y:call system("mate-terminal -e 'mc <C-r>"' &")<CR>
" Open or close taglist window
nmap <Leader>l :TlistToggle<CR>

" search lastly found string through all buffers
nmap <F3> :silent exec "while !search( @/, \"W\") \| bnext \| 0 \| endwhile"<cr>
" search for the selected string
vnoremap * y/<C-r>"<CR>

" open in browser
nmap <Leader>b yiW:call system("firefox '<C-r>"' &")<CR>
vmap <Leader>b y:call system ("firefox '<C-r>"' &")<CR>
vmap <Leader>go y:call system ("firefox 'http://www.google.com/search?hl=en&q=<C-r>"&aq=f&oq=&aqi=' &")<CR>
vmap <Leader>gw y:call system ("firefox 'http://en.wikipedia.org/w/index.php?title=Special%3ASearch&search=<C-r>"' &")<CR>

" completion
imap <C-f> <C-x><C-f>

" color schemes
nmap <Leader>CL :SetDayColorScheme<CR>
nmap <Leader>CD :SetNightColorScheme<CR>

" grepping
vmap <Leader>gr <BS>:copen<CR>:vimgrep /<S-BS>/ **/*
nmap <Leader>gr :copen<CR>:vimgrep // **/*<C-b><C-b><C-b><C-b><C-b><C-b>

" quick spell correction (ck == check)
nmap <Leader>ck 1z=

" Go to source
nnoremap gs :call b:GoToSource()<CR>

" Change to current directory
map <Leader>D :cd %:h<CR>:echo "Changed to " . expand("%:p:h")<CR>

" Go to parent directory
map <Leader>gu :cd ..<CR>

" Errors navigation
map <C-Down> :cn<CR>
map <C-Up> :cp<CR>

" special mapping for terminal mode
map [11~ <F1>
map [12~ <F2>
map [13~ <F3>
map [14~ <F4>
map [15~ <F5>
map [16~ <F6>
map [17~ <F7>
map [19~ <F8>
map [20~ <F9>
map [21~ <F10>

map [23~ <S-F1>
map [24~ <S-F2>
map [25~ <S-F3>
map [26~ <S-F4>
map [28~ <S-F5>
map [29~ <S-F6>
map [31~ <S-F7>
map [32~ <S-F8>
map [33~ <S-F9>
map [34~ <S-F10>

map [23^ <C-S-F1>
map [24^ <C-S-F2>
map [25^ <C-S-F3>
map [26^ <C-S-F4>
map [28^ <C-S-F5>
map [29^ <C-S-F6>
map [31^ <C-S-F7>
map [32^ <C-S-F8>
map [33^ <C-S-F9>
map [34^ <C-S-F10>

"*********************** END: GLOBAL KEY-MAPPING /*}}}*/

"*********************** START: FILETYPE EVENTS /*{{{*/
let tmpDir = $HOME . "/.vim/tmp"
if !isdirectory(tmpDir)
  call mkdir(tmpDir, "p")
endif
"*********************** END: FILETYPE EVENTS /*}}}*/
"
"*********************** START: FILETYPE EVENTS /*{{{*/
autocmd BufEnter [Mm][Aa][Kk][Ee][Ff][Ii][Ll][Ee]* set noexpandtab
" nicely opens pdf files (tip 1356)
autocmd BufReadPre *.pdf set ro
autocmd BufReadPost *.elm set ft=haskell
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78
"autocmd FileType haskell LoadComponentScion
"autocmd FileType haskell command! SetGHCTags
    "\ setlocal tags+=/space/haskell/sources/packages-base/tags
"*********************** END: FILETYPE EVENTS /*}}}*/

"*********************** START: FUNCTIONS /*{{{*/

" Add buffer name into current buffer to a line under the cursor.
fun DumpBufferName()
  execute "normal o".bufname("%")
endf
command DumpBufferName call DumpBufferName()

" Sets color scheme with light background suitable for sunny days.
fun SetDayColorScheme()
  colorscheme mayansmoke
endf
command SetDayColorScheme call SetDayColorScheme()


" Sets color scheme with dark background suitable for night working hours.
fun SetNightColorScheme()
  colorscheme jellybeans
endf
command SetNightColorScheme call SetNightColorScheme()

" Regenerates tags with ctags in the current file's directory
function RegenerateTags()
  call confirm('Abstract method. Override "RegenerateTags()" for "'. &ft . '" filetype.')
  "let prev_dir = getcwd()
  "let tags_dir = expand("%:p:h")
  "execute "cd " . tags_dir
  "execute "silent !ctags -R --sort"
  "execute "cd " . prev_dir
endfunction

" Filtering some content from cvs commit log; ideal for pasting commit logs
" somehwere (e.g. to IssueZilla)
function CvsFilter()
  execute "%s/Checking in //g"
  execute "g/^\\/cvs\\//d"
  execute "g/^done$/d"
  execute "g/^RCS file: /d"
endfunction
com! CVSFilter call CvsFilter()

function SaveJavaThreadDump()
  execute "silent! %s/^        /	/g"
  saveas! ~/tmp/misc/threaddump.txt
  execute "silent! !nb --open /home/emdot/java/Testor/src/mk/FileDumper.java"
endfunction
command SaveJavaThreadDump call SaveJavaThreadDump()

let s:subscriptChars = {
  \ "0": "₀",
  \ "1": "₁",
  \ "2": "₂",
  \ "3": "₃",
  \ "4": "₄",
  \ "5": "₅",
  \ "6": "₆",
  \ "7": "₇",
  \ "8": "₈",
  \ "9": "₉",
  \ "+": "₊",
  \ "-": "₋",
  \ "=": "₌",
  \ "(": "₍",
  \ ")": "₎",
\}


let s:superscriptChars = {
  \ "0": "⁰",
  \ "1": "¹",
  \ "2": "²",
  \ "3": "³",
  \ "4": "⁴",
  \ "5": "⁵",
  \ "6": "⁶",
  \ "7": "⁷",
  \ "8": "⁸",
  \ "9": "⁹",
  \ "+": "⁺",
  \ "-": "⁻",
  \ "=": "⁼",
  \ "(": "⁽",
  \ ")": "⁾",
  \ "n": "ⁿ",
  \ "i": "ⁱ",
\}

fun! MakeSub()
  let c = GetCharUnderCursor()
  if has_key(s:subscriptChars, c)
    let newC = s:subscriptChars[c]
    exe "normal r".newC
  endif
endf
command MakeSub call MakeSub()
map <Leader>msb :MakeSub<CR>

fun! MakeSup()
  let c = GetCharUnderCursor()
  if has_key(s:superscriptChars, c)
    let newC = s:superscriptChars[c]
    exe "normal r".newC
  endif
endf
command MakeSup call MakeSup()
map <Leader>msp :MakeSup<CR>

fun! ReplaceTrailingSpaces()
  exe "%s/\ \ *$//gc"
endf
command ReplaceTrailingSpaces call ReplaceTrailingSpaces()

fun! ConverToHTMLWholeFile()
  let g:html_number_lines=0
  TOhtml
  unlet g:html_number_lines
endf

fun! ConverToHTMLVisual()
  let g:html_number_lines=0
	let start = line("'<")
  let end = line("'>")
  exec ":" . start . "," . end . "TOhtml"
  unlet g:html_number_lines
endf

command UpdateLicenceYear bufdo %s/-20[01][^3]/-2013/g


fun! OpenInNetBeans() "{{{
  silent execute "!nb --open '%':" . line('.')
endfunction "}}}

" command for invoking "git-cola" for a repository of the current file
command GitCola silent exe "!git-cola -r " . expand("%:p:h") " &"

"set foldmethod=marker
"set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1

"*********************** END: FUNCTIONS /*}}}*/

"*********************** START: Individual plugin configurations /*{{{*/
" Pathogen
call pathogen#infect()

" Vundle {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
 " let Vundle manage Vundle. Required!
Bundle 'gmarik/vundle.git'
" generic libraries
Bundle 'L9'

"""" languages support start {{{
"" Haskell
Bundle 'dag/vim2hs.git'
Bundle 'eagletmt/ghcmod-vim.git'
Bundle 'feuerbach/vim-hs-module-name.git'
Bundle 'hlint'
Bundle 'kana/vim-filetype-haskell.git'
Bundle 'ujihisa/neco-ghc.git'
Bundle 'pbrisbin/html-template-syntax.git'
" Non-Vundle compatible
" - haskellmode

"" Python
Bundle 'jaredly/vim-debug'
Bundle 'klen/python-mode'

"" Clojure
Bundle 'VimClojure'
Bundle 'slimv.vim'
Bundle 'jpalardy/vim-slime.git'

"" SQL
Bundle 'SQLUtilities'

"" Other languages
Bundle 'HTML.zip'
Bundle 'LaTeX-Suite-aka-Vim-LaTeX.git'
Bundle 'Vim-R-plugin'
Bundle 'bash-support.vim'
"" languages generic
Bundle 'majutsushi/tagbar.git'
Bundle 'bitc/lushtags.git'
Bundle 'taglist.vim'
"""" languages support end }}}

" miscellaneous
Bundle 'Align'
Bundle 'ColorV'
Bundle 'FuzzyFinder'

" powerline produce a lot of issues on each redraw - try it later
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

Bundle 'Rykka/mathematic.vim.git'
Bundle 'Shougo/vimproc.git'
Bundle 'Stormherz/tablify.git'
Bundle 'Switch'
Bundle 'Syntastic'
Bundle 'Tabular'
Bundle 'The-NERD-Commenter'
Bundle 'UltiSnips'
Bundle 'bufexplorer.zip'
Bundle 'ervandew/supertab.git'
Bundle 'fontzoom.vim'
Bundle 'neocomplcache'
Bundle 'operator-camelize'
Bundle 'operator-user'
Bundle 'reload.vim'
Bundle 'roman/golden-ratio.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'surround.vim'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'tpope/vim-rsi.git'
Bundle 'vcscommand.vim'
Bundle 'xolox/vim-misc.git'
Bundle 'xolox/vim-session.git'

" colorschemes
Bundle 'nanotech/jellybeans.vim.git'
Bundle 'mayansmoke'
" }}}


" HTML plugin
" generate lowercase html tags
let html_tag_case = "lower"
" turn off its toolbar
let no_html_toolbar = "true"
" turn off <tab> mapping in HTML plugin (produces some errors and I do not use
" it)
"let no_html_tab_mapping = "true"
" do not override mapping
let no_html_map_override = "true"

" Calendar plugin
let calendar_diary = expand('~/.vim/vim-diary')

" operator-camelize
map <Leader>cml <Plug>(operator-camelize)
map <Leader>ucml <Plug>(operator-decamelize)

" CVS plugin
let CVSCommandDiffOpt='u'

"""""" Haskell """"""
" configure browser for haskell-mode (haskell_doc.vim)
let haddock_browser = "/usr/bin/firefox"
" configure Haddock documentation for haskell-mode (haskell_doc.vim)
let haddock_docdir="/space/haskell/0_doc/ghc-latest/libraries"
" index file for Haskell documentation
let haddock_indexfiledir = expand('~/.vim/tmp/')
"""""""""""""""""""""

" bash-support
let BASH_Template_File = '../skeletons/bash.sh'
let BASH_Ctrl_j = "off"


" NERDTree
let NERDTreeWinSize=50
let NERDTreeShowHidden=0
let NERDTreeShowBookmarks=1
let NERDTreeWinPos='right'

" NERDCommenter
imap <C-c> <plug>NERDCommenterInInsert
let NERDAltComMap=",Ca"
let NERDComAlignLeftMap=",Cl"
let NERDComAlignRightMap=",Cr"
let NERDComLineInvertMap=",Ci"
let NERDComLineMap=",Cc"
let NERDComLineNestMap=",Cn"
let NERDComLineSexyMap=",Cs"
let NERDShutUp=1

" TagList
"let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth=50

" vcscommand
let VCSCommandSplit='vertical'
let VCSCommandDiffSplit='vertical'
let VCSCommandEdit="edit"
nmap <Leader>cUU <Plug>VCSUpdate
" hint for VCS type detection (see :h VCSCommandVCSTypeOverride)
let VCSCommandVCSTypeOverride = [["work/projects/dcpl", "HG"]]
" Splits screen vertically. Shows the diff on in the left window and windows
" where commit message shall be written in the right window.
"map <Leader>cD ,cd<C-w>v,cc
map <Leader>cd :VCSDiff<CR><C-w>v,cc

" need by latex-suite plugin. TODO: set only for latex files?
set grepprg=grep\ -nH\ $*

" Project
" load project
"nmap <silent> <Leader>P :Project .vimproject<CR>
"nmap <silent> <Leader>p <Plug>ToggleProject
" width
let proj_window_width=34

" vimwiki
let vimwiki_home = expand("$HOME/tmp/vimwiki/")

let speckyRunRdocKey = ',rd'

" MRU (Most Recently Used)
let MRU_File = expand("$HOME/.vim/tmp/mru_files.txt")

let MRU_Max_Entries = 100
let MRU_SubMenus = 0

" FuzzyFinder
" Ignore cabal-dev
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])(\.(hg|git|bzr)|cabal-dev|dist)($|[/\\])'
" Most Recently Used files
nnoremap mru :FufMruFile<CR>
let g:fuf_modesDisable = []
"nnoremap <Leader>e :FuFFile <C-r>=fnamemodify(getcwd(), ':p')<CR><CR>
nnoremap <Leader>e :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <Leader>ff :FufFile<CR>
nnoremap <Leader>, :FufBuffer<CR>
nnoremap <Leader>. :FufTag<CR>
nnoremap <C-h> :FufHelp<CR>

let fuf_abbrevMap  = {
      \   '\C^GVR' : [
      \     '$VIMRUNTIME/**/',
      \     '~/.vim/**/',
      \     '$VIM/.vim/**/',
      \     '$VIM/vimfiles/**/',
      \   ],
      \   '\C^VR' : [
      \     '~/.vim/**/',
      \   ],
      \   '\C^ZZ' : [
      \     '~/.vim/**/zz_',
      \   ],
      \ }

" Scion
set runtimepath+=/space/haskell/sources/scion-backend-vim/
"source /home/emdot/.cabal/share/scion-0.1.0.2/vim_runtime_path/plugin/haskell_scion.vim
let scion_connection_setting = ['scion', "/home/emdot/.cabal/bin/scion-server"]
let scion_quickfixes_always_open = 0
"set runtimepath+=/space/haskell/sources/scion.mkrauskopf/vim_runtime_path/
"source /space/haskell/sources/scion.mkrauskopf/vim_runtime_path/plugin/haskell_scion.vim

" xptemplate
" I'm using autoclose.vim instead which does better job for me.
"let g:xptemplate_brace_complete = 0

" MiniBufferExplorer
" This makes the explorer much faster. See the issue for details:
"   --> https://github.com/fholgado/minibufexpl.vim/issues/6
let g:miniBufExplCheckDupeBufs = 0

" Buffer explorer
map <leader>bu :BufExplorer<CR>

" ------ neocomplcache start ------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
"   " Set minimum syntax keyword length.
"   let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"   
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
" ------ neocomplcache end ------

" SuperTab plugin
let g:SuperTabDefaultCompletionType = "<c-n>"

let g:UltiSnipsExpandTrigger="<C-Bslash>"
let g:UltiSnipsSnippetsDir="~/.vim/bundle/zzz_mk/UltiSnips"
"let g:UltiSnipsSnippetsDir="~/.vim/mk-ultisnips"

" VimClojure
let vimclojure#SetupKeyMapRunTests = 0

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

" tagbar
nmap <F8> :TagbarToggle<CR>

let g:jellybeans_overrides = {
\    'Cursor': { 'guifg': '000000', 'guibg': 'b0d0f0' }
\}

" vim-fugitive
map <Leader>gs :Gstatus<CR>

" vim-session
let g:session_autoload = 'no'

"*********************** END: Individual plugin configurations /*}}}*/

"*********************** START: TESTING SECTION /*{{{*/
"if &term =~ "xterm"
"    if has("terminfo")
"        set t_Co=8
"        set t_Sf=[3%p1%dm
"        set t_Sb=[4%p1%dm
"    else
"        set t_Co=8
"        set t_Sf=[3%dm
"        set t_Sb=[4%dm
"    endif
"endif
" END

"autocmd FileType sql syntax sync minlines=1000
"autocmd FileType jsp syntax sync minlines=1000
"
"*********************** END: TESTING SECTION /*}}}*/

" black background by default - must be trigered after colorscheme bundles are
" loaded
"SetNightColorScheme
SetDayColorScheme

" vi: set fdm=marker:

