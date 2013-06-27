"
" author: Martin Krauskopf <martin.krauskopf at gmail.com>
"

"*********************** START: MENU /*{{{*/
" "Custom" menu
amenu C&ustom.&Font.Small         :set guifont=Bitstream\ Vera\ Sans\ Mono\ 7<CR>
amenu C&ustom.&Font.Smaller       :set guifont=Bitstream\ Vera\ Sans\ Mono\ 8<CR>
amenu C&ustom.&Font.Normal        :set guifont=Bitstream\ Vera\ Sans\ Mono\ 9<CR>
amenu C&ustom.&Font.Bigger        :set guifont=Bitstream\ Vera\ Sans\ Mono\ 12<CR>
amenu C&ustom.&Font.Big           :set guifont=Bitstream\ Vera\ Sans\ Mono\ 14<CR>
amenu C&ustom.En&coding.Set\ latin&1\ mode  :call SetLatin1Mode()<CR>
amenu C&ustom.En&coding.Set\ latin&2\ mode  :call SetLatin2Mode()<CR>
amenu C&ustom.En&coding.Set\ utf&8\ mode    :call SetUTF8Mode()<CR>
amenu C&ustom.File\ &type.diff    :set ft=diff<CR>
amenu C&ustom.File\ &type.java    :set ft=java<CR>
amenu C&ustom.File\ &type.mail    :set ft=mail<CR>
amenu C&ustom.File\ &type.xml     :set ft=xml<CR>
amenu C&ustom.-Sep-               :
amenu C&ustom.&Day                :call SetDayColorScheme()<CR>
amenu C&ustom.&Night              :call SetNightColorScheme()<CR>
amenu C&ustom.-Sep1-              :
amenu C&ustom.Underscore\ Line    yypVr-k
amenu C&ustom.-Sep2-              :
amenu C&ustom.differ\ to\ gvim\ -d 0cwgvim -dWWdw$BDD,rruj0
amenu C&ustom.change\ to\ current\ directory :cd %:h<CR>
amenu C&ustom.mixplayer\ -s       :silent! !mixplayer -s<CR>

" "CVS" submenu
amenu C&VS.Process\ &Modified\ Output /apisupport3wv11bd0d2WjddkJl2dWW2dWhxDBPa -> j0dd0
amenu C&VS.Process\ &New\ Output      2dd0/apisupport3wv11bd0d2WjddkJldwdwdwjdd0

" "Open File --> Others" submenu
amenu &Open\ File.&Other.Browser\ &Bookmark\ (My)  :e ~/work/mydocs/misc_comp/bookmarks/bookmarks-my.html<CR>
amenu &Open\ File.&Other.Browser\ &Bookmark\ (Web) :e ~/work/mydocs/misc_comp/bookmarks/bookmarks-web.html<CR>
amenu &Open\ File.&Other.Math\ Symbols             :e ~/.vim/plugin/unicodemacros.vim<CR>
" "Open File" submenu
amenu &Open\ File.\.&bashrc :e ~/.bashrc<CR>
amenu &Open\ File.\.&gvimrc :e ~/.gvimrc<CR>
amenu &Open\ File.\.&vimrc  :e ~/.vimrc<CR>
amenu &Open\ File.-Sep1-    :
amenu &Open\ File.current\ in\ Browser          :silent execute "!firefox-start " . expand("%:p")<CR>
amenu &Open\ File.under-cursor\ in\ Browser\ 1  yiW:!firefox-start "<CR<CR>
amenu &Open\ File.in\ NetBeans  :call OpenInNetBeans()<CR>
"*********************** END: MENU /*}}}*/

"****************************** GUI GLOBAL SETTINGS
" disable menu
set guioptions-=m
" disable toolbar
set guioptions-=T
" don't paste the selection into system clipboard in Visual Mode
set guioptions-=a
" turn-off scrollbars
"set guioptions-=r
" turn-off left-hand scrollbar when there is vertically split window
set guioptions-=L

if has('unix')
  " ****************** "
  " Unix style setting "
  " ****************** "

  " font setting
  "set guifont=-*-fixed-medium-r-normal-*-13-*-*-*-*-*-iso8859-2
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
  " window position in pixels
  winpos 0 0
  " maximize window (in my case)
  set columns=179
  set lines=57
elseif has("gui_win32")
  " *************** "
  " Windows setting "
  " *************** "

  autocmd GUIEnter * simalt ~x " start in maximized window
  "set guifont=courier:h10:cansi
  "au GUIEnter * simalt ~x
  " set guifont=Courier:h10:cANSI
  " set guifont=Courier:h10:cEASTEUROPE
  " set guifont=Fixedsys:h10:cEASTEUROPE
  set guifont=Lucida_Console:h8:cEASTEUROPE
endif

" Toggle guioptions
function <SID>ToggleGuiOptions()
  if match(&guioptions, '\Cm') == -1
    set guioptions+=m
    set guioptions+=T
  else
    set guioptions-=m
    set guioptions-=T
  endif
endf
map <unique> <Leader>gm :call <SID>ToggleGuiOptions()<CR>

" ************************ "
" **** F U N T I O N S *** "
" ************************ "

" ********* UTF8 mode ****************** START
function SetUTF8Mode()
  if has('unix')
    "set guifont=-misc-fixed-medium-r-normal-*-13-*-*-*-c-*-iso10646-1
    set encoding=utf-8
    "set termencoding=iso-8859-2
  endif
endfunction
" ********* UTF8 mode ******************* END

" ********* Latin1 mode **************** START
function SetLatin1Mode()
  if has('unix')
    "set guifont=-*-fixed-medium-r-normal-*-13-*-*-*-*-*-iso8859-1
    set encoding=iso-8859-1
    "set termencoding=
  endif
endfunction
" ********* Latin1 mode ***************** END

" ********* Latin2 mode **************** START
function SetLatin2Mode()
  if has('unix')
    "set guifont=-*-fixed-medium-r-normal-*-13-*-*-*-*-*-iso8859-2
    set encoding=iso-8859-2
    "set termencoding=
  endif
endfunction
" ********* Latin2 mode ***************** END

" Possibility to change font size easily
command -nargs=1 SetFont set guifont=Bitstream\ Vera\ Sans\ Mono\ <args>

" use visual beep instead of sound (must be also here for some reason, not just
" in .vimrc)
set t_vb= vb


"*********************** START: Individual plugin configurations /*{{{*/
map <C-ScrollWheelUp> :Fontzoom +1<CR>
map <C-ScrollWheelDown> :Fontzoom -1<CR>
"*********************** END: Individual plugin configurations /*}}}*/

" vi:fdm=marker
