
"# votl, Vim Outliner
"#
"# Copyright (C) 2001,2003 by Steve Litt (slitt@troubleshooters.com)
"# Copyright (C) 2012 by Eric Davis (edavis@insanum.com)
"#
"# votl is free software: you can redistribute it and/or modify
"# it under the terms of the GNU General Public License as published by
"# the Free Software Foundation, either version 3 of the License, or
"# (at your option) any later version.
"#
"# votl is distributed in the hope that it will be useful,
"# but WITHOUT ANY WARRANTY; without even the implied warranty of
"# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"# GNU General Public License for more details.
"#
"# You should have received a copy of the GNU General Public License
"# along with votl.  If not, see <http://www.gnu.org/licenses/>.

" Colors {{{

if &background == "light"

    hi OL1 guifg=black      ctermfg=black
    hi OL2 guifg=red        ctermfg=red
    hi OL3 guifg=blue       ctermfg=blue
    hi OL4 guifg=darkviolet ctermfg=magenta
    hi OL5 guifg=black      ctermfg=black
    hi OL6 guifg=red        ctermfg=red
    hi OL7 guifg=blue       ctermfg=blue
    hi OL8 guifg=darkviolet ctermfg=magenta
    hi OL9 guifg=black      ctermfg=black

    " colors for tags
    hi outlTags guifg=darkred ctermfg=darkred

    " color for body text
    hi BT1 guifg=darkgreen  ctermfg=green
    hi BT2 guifg=darkgreen  ctermfg=green
    hi BT3 guifg=darkgreen  ctermfg=green
    hi BT4 guifg=darkgreen  ctermfg=green
    hi BT5 guifg=darkgreen  ctermfg=green
    hi BT6 guifg=darkgreen  ctermfg=green
    hi BT7 guifg=darkgreen  ctermfg=green
    hi BT8 guifg=darkgreen  ctermfg=green
    hi BT9 guifg=darkgreen  ctermfg=green

    " color for pre-formatted text
    hi PT1 guifg=darkblue   ctermfg=cyan
    hi PT2 guifg=darkblue   ctermfg=cyan
    hi PT3 guifg=darkblue   ctermfg=cyan
    hi PT4 guifg=darkblue   ctermfg=cyan
    hi PT5 guifg=darkblue   ctermfg=cyan
    hi PT6 guifg=darkblue   ctermfg=cyan
    hi PT7 guifg=darkblue   ctermfg=cyan
    hi PT8 guifg=darkblue   ctermfg=cyan
    hi PT9 guifg=darkblue   ctermfg=cyan

    " color for tables
    hi TA1 guifg=darkviolet ctermfg=cyan
    hi TA2 guifg=darkviolet ctermfg=cyan
    hi TA3 guifg=darkviolet ctermfg=cyan
    hi TA4 guifg=darkviolet ctermfg=cyan
    hi TA5 guifg=darkviolet ctermfg=cyan
    hi TA6 guifg=darkviolet ctermfg=cyan
    hi TA7 guifg=darkviolet ctermfg=cyan
    hi TA8 guifg=darkviolet ctermfg=cyan
    hi TA9 guifg=darkviolet ctermfg=cyan

    " color for user text (wrapping)
    hi UT1 guifg=darkred    ctermfg=cyan
    hi UT2 guifg=darkred    ctermfg=cyan
    hi UT3 guifg=darkred    ctermfg=cyan
    hi UT4 guifg=darkred    ctermfg=cyan
    hi UT5 guifg=darkred    ctermfg=cyan
    hi UT6 guifg=darkred    ctermfg=cyan
    hi UT7 guifg=darkred    ctermfg=cyan
    hi UT8 guifg=darkred    ctermfg=cyan
    hi UT9 guifg=darkred    ctermfg=cyan

    " color for user text (non-wrapping)
    hi UB1 guifg=darkgray   ctermfg=cyan
    hi UB2 guifg=darkgray   ctermfg=cyan
    hi UB3 guifg=darkgray   ctermfg=cyan
    hi UB4 guifg=darkgray   ctermfg=cyan
    hi UB5 guifg=darkgray   ctermfg=cyan
    hi UB6 guifg=darkgray   ctermfg=cyan
    hi UB7 guifg=darkgray   ctermfg=cyan
    hi UB8 guifg=darkgray   ctermfg=cyan
    hi UB9 guifg=darkgray   ctermfg=cyan

    " colors for folded sections
    hi Folded     guifg=darkcyan guibg=bg ctermfg=cyan ctermbg=white
    hi FoldColumn guifg=darkcyan guibg=bg ctermfg=cyan ctermbg=white

    " colors for experimental spelling error highlighting
    " this only works for spellfix.vim which will cease to exist soon
    hi spellErr gui=underline guifg=darkred cterm=underline ctermfg=darkred
    hi BadWord  gui=underline guifg=darkred cterm=underline ctermfg=darkred

else

    hi OL1 guifg=white      ctermfg=white
    hi OL2 guifg=red        ctermfg=red
    hi OL3 guifg=lightblue  ctermfg=lightblue
    hi OL4 guifg=darkviolet ctermfg=magenta
    hi OL5 guifg=white      ctermfg=white
    hi OL6 guifg=red        ctermfg=red
    hi OL7 guifg=lightblue  ctermfg=lightblue
    hi OL8 guifg=darkviolet ctermfg=magenta
    hi OL9 guifg=white      ctermfg=white

    " colors for tags
    hi outlTags guifg=darkred ctermfg=darkred

    " color for body text
    hi BT1 guifg=darkgreen  ctermfg=green
    hi BT2 guifg=darkgreen  ctermfg=green
    hi BT3 guifg=darkgreen  ctermfg=green
    hi BT4 guifg=darkgreen  ctermfg=green
    hi BT5 guifg=darkgreen  ctermfg=green
    hi BT6 guifg=darkgreen  ctermfg=green
    hi BT7 guifg=darkgreen  ctermfg=green
    hi BT8 guifg=darkgreen  ctermfg=green
    hi BT9 guifg=darkgreen  ctermfg=green

    " color for pre-formatted text
    hi PT1 guifg=darkblue   ctermfg=cyan
    hi PT2 guifg=darkblue   ctermfg=cyan
    hi PT3 guifg=darkblue   ctermfg=cyan
    hi PT4 guifg=darkblue   ctermfg=cyan
    hi PT5 guifg=darkblue   ctermfg=cyan
    hi PT6 guifg=darkblue   ctermfg=cyan
    hi PT7 guifg=darkblue   ctermfg=cyan
    hi PT8 guifg=darkblue   ctermfg=cyan
    hi PT9 guifg=darkblue   ctermfg=cyan

    " color for tables
    hi TA1 guifg=darkviolet ctermfg=cyan
    hi TA2 guifg=darkviolet ctermfg=cyan
    hi TA3 guifg=darkviolet ctermfg=cyan
    hi TA4 guifg=darkviolet ctermfg=cyan
    hi TA5 guifg=darkviolet ctermfg=cyan
    hi TA6 guifg=darkviolet ctermfg=cyan
    hi TA7 guifg=darkviolet ctermfg=cyan
    hi TA8 guifg=darkviolet ctermfg=cyan
    hi TA9 guifg=darkviolet ctermfg=cyan

    " color for user text (wrapping)
    hi UT1 guifg=darkred    ctermfg=cyan
    hi UT2 guifg=darkred    ctermfg=cyan
    hi UT3 guifg=darkred    ctermfg=cyan
    hi UT4 guifg=darkred    ctermfg=cyan
    hi UT5 guifg=darkred    ctermfg=cyan
    hi UT6 guifg=darkred    ctermfg=cyan
    hi UT7 guifg=darkred    ctermfg=cyan
    hi UT8 guifg=darkred    ctermfg=cyan
    hi UT9 guifg=darkred    ctermfg=cyan

    " color for user text (non-wrapping)
    hi UB1 guifg=darkgray   ctermfg=cyan
    hi UB2 guifg=darkgray   ctermfg=cyan
    hi UB3 guifg=darkgray   ctermfg=cyan
    hi UB4 guifg=darkgray   ctermfg=cyan
    hi UB5 guifg=darkgray   ctermfg=cyan
    hi UB6 guifg=darkgray   ctermfg=cyan
    hi UB7 guifg=darkgray   ctermfg=cyan
    hi UB8 guifg=darkgray   ctermfg=cyan
    hi UB9 guifg=darkgray   ctermfg=cyan

    " colors for folded sections
    hi Folded     guifg=darkcyan guibg=bg ctermfg=cyan ctermbg=black
    hi FoldColumn guifg=darkcyan guibg=bg ctermfg=cyan ctermbg=black

    " colors for experimental spelling error highlighting
    " this only works for spellfix.vim which will cease to exist soon
    hi spellErr gui=underline guifg=yellow cterm=underline ctermfg=yellow
    hi BadWord  gui=underline guifg=yellow cterm=underline ctermfg=yellow

endif

" End of Colors }}}

" Syntax {{{

syn clear
syn sync fromstart

syn match outlTags '_tag_\w*' contained
syn match outlTags '_ilink_\s*\(.\{-}:\s\)\?.*' contained

" body text
syntax region BT1 start=+^ \S+ skip=+^ \S+ end=+^\S+me=e-1 end=+^\(\t\)\{1}\S+me=e-2 contains=spellErr,SpellErrors,BadWord contained
syntax region BT2 start=+^\(\t\)\{1} \S+ skip=+^\(\t\)\{1} \S+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT3 start=+^\(\t\)\{2} \S+ skip=+^\(\t\)\{2} \S+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT4 start=+^\(\t\)\{3} \S+ skip=+^\(\t\)\{3} \S+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT5 start=+^\(\t\)\{4} \S+ skip=+^\(\t\)\{4} \S+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT6 start=+^\(\t\)\{5} \S+ skip=+^\(\t\)\{5} \S+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT7 start=+^\(\t\)\{6} \S+ skip=+^\(\t\)\{6} \S+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT8 start=+^\(\t\)\{7} \S+ skip=+^\(\t\)\{7} \S+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT9 start=+^\(\t\)\{8} \S+ skip=+^\(\t\)\{8} \S+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained

" comment-style body text
syntax region BT1 start=+^:+ skip=+^:+ end=+^\S+me=e-1 end=+^\(\t\)\{1}\S+me=e-2 contains=spellErr,SpellErrors,BadWord contained
syntax region BT2 start=+^\(\t\)\{1}:+ skip=+^\(\t\)\{1}:+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT3 start=+^\(\t\)\{2}:+ skip=+^\(\t\)\{2}:+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT4 start=+^\(\t\)\{3}:+ skip=+^\(\t\)\{3}:+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT5 start=+^\(\t\)\{4}:+ skip=+^\(\t\)\{4}:+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT6 start=+^\(\t\)\{5}:+ skip=+^\(\t\)\{5}:+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT7 start=+^\(\t\)\{6}:+ skip=+^\(\t\)\{6}:+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT8 start=+^\(\t\)\{7}:+ skip=+^\(\t\)\{7}:+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BT9 start=+^\(\t\)\{8}:+ skip=+^\(\t\)\{8}:+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained

" preformatted body text
syntax region PT1 start=+^;+ skip=+^;+ end=+^\S+me=e-1 end=+^\(\t\)\{1}\S+me=e-2 contains=spellErr,SpellErrors,BadWord contained
syntax region PT2 start=+^\(\t\)\{1};+ skip=+^\(\t\)\{1};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region PT3 start=+^\(\t\)\{2};+ skip=+^\(\t\)\{2};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region PT4 start=+^\(\t\)\{3};+ skip=+^\(\t\)\{3};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region PT5 start=+^\(\t\)\{4};+ skip=+^\(\t\)\{4};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region PT6 start=+^\(\t\)\{5};+ skip=+^\(\t\)\{5};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region PT7 start=+^\(\t\)\{6};+ skip=+^\(\t\)\{6};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region PT8 start=+^\(\t\)\{7};+ skip=+^\(\t\)\{7};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region PT9 start=+^\(\t\)\{8};+ skip=+^\(\t\)\{8};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained

" preformatted tables
syntax region TA1 start=+^|+ skip=+^|+ end=+^\S+me=e-1 end=+^\(\t\)\{1}\S+me=e-2 contains=spellErr,SpellErrors,BadWord contained
syntax region TA2 start=+^\(\t\)\{1}|+ skip=+^\(\t\)\{1}|+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region TA3 start=+^\(\t\)\{2}|+ skip=+^\(\t\)\{2}|+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region TA4 start=+^\(\t\)\{3}|+ skip=+^\(\t\)\{3}|+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region TA5 start=+^\(\t\)\{4}|+ skip=+^\(\t\)\{4}|+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region TA6 start=+^\(\t\)\{5}|+ skip=+^\(\t\)\{5}|+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region TA7 start=+^\(\t\)\{6}|+ skip=+^\(\t\)\{6}|+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region TA8 start=+^\(\t\)\{7}|+ skip=+^\(\t\)\{7}|+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region TA9 start=+^\(\t\)\{8}|+ skip=+^\(\t\)\{8}|+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained

" wrapping user text
syntax region UT1 start=+^>+ skip=+^>+ end=+^\S+me=e-1 end=+^\(\t\)\{1}\S+me=e-2 contains=spellErr,SpellErrors,BadWord contained
syntax region UT2 start=+^\(\t\)\{1}>+ skip=+^\(\t\)\{1}>+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UT3 start=+^\(\t\)\{2}>+ skip=+^\(\t\)\{2}>+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UT4 start=+^\(\t\)\{3}>+ skip=+^\(\t\)\{3}>+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UT5 start=+^\(\t\)\{4}>+ skip=+^\(\t\)\{4}>+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UT6 start=+^\(\t\)\{5}>+ skip=+^\(\t\)\{5}>+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UT7 start=+^\(\t\)\{6}>+ skip=+^\(\t\)\{6}>+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UT8 start=+^\(\t\)\{7}>+ skip=+^\(\t\)\{7}>+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UT9 start=+^\(\t\)\{8}>+ skip=+^\(\t\)\{8}>+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained

" non-wrapping user text
syntax region UB1 start=+^<+ skip=+^<+ end=+^\S+me=e-1 end=+^\(\t\)\{1}\S+me=e-2 contains=spellErr,SpellErrors,BadWord contained
syntax region UB2 start=+^\(\t\)\{1}<+ skip=+^\(\t\)\{1}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UB3 start=+^\(\t\)\{2}<+ skip=+^\(\t\)\{2}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UB4 start=+^\(\t\)\{3}<+ skip=+^\(\t\)\{3}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UB5 start=+^\(\t\)\{4}<+ skip=+^\(\t\)\{4}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UB6 start=+^\(\t\)\{5}<+ skip=+^\(\t\)\{5}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UB7 start=+^\(\t\)\{6}<+ skip=+^\(\t\)\{6}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UB8 start=+^\(\t\)\{7}<+ skip=+^\(\t\)\{7}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UB9 start=+^\(\t\)\{8}<+ skip=+^\(\t\)\{8}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained

" comment-style body text formatting
syntax match Comment "^\s*:.*$"
setlocal fo-=t fo+=crqno
setlocal com=sO:\:\ -,mO:\:\ \ ,eO:\:\:,:\:,sO:\>\ -,mO:\>\ \ ,eO:\>\>,:\>

" headings
syntax region OL1 start=+^[^:\t]+ end=+^[^:\t]+me=e-1 contains=outlTags,BT1,BT2,PT1,PT2,TA1,TA2,UT1,UT2,UB1,UB2,spellErr,SpellErrors,BadWord,OL2 keepend
syntax region OL2 start=+^\t[^:\t]+ end=+^\t[^:\t]+me=e-2 contains=outlTags,BT2,BT3,PT2,PT3,TA2,TA3,UT2,UT3,UB2,UB3,spellErr,SpellErrors,BadWord,OL3 keepend
syntax region OL3 start=+^\(\t\)\{2}[^:\t]+ end=+^\(\t\)\{2}[^:\t]+me=e-3 contains=outlTags,BT3,BT4,PT3,PT4,TA3,TA4,UT3,UT4,UB3,UB4,spellErr,SpellErrors,BadWord,OL4 keepend
syntax region OL4 start=+^\(\t\)\{3}[^:\t]+ end=+^\(\t\)\{3}[^:\t]+me=e-4 contains=outlTags,BT4,BT5,PT4,PT5,TA4,TA5,UT4,UT5,UB4,UB5,spellErr,SpellErrors,BadWord,OL5 keepend
syntax region OL5 start=+^\(\t\)\{4}[^:\t]+ end=+^\(\t\)\{4}[^:\t]+me=e-5 contains=outlTags,BT5,BT6,PT5,PT6,TA5,TA6,UT5,UT6,UB5,UB6,spellErr,SpellErrors,BadWord,OL6 keepend
syntax region OL6 start=+^\(\t\)\{5}[^:\t]+ end=+^\(\t\)\{5}[^:\t]+me=e-6 contains=outlTags,BT6,BT7,PT6,PT7,TA6,TA7,UT6,UT7,UB6,UB7,spellErr,SpellErrors,BadWord,OL7 keepend
syntax region OL7 start=+^\(\t\)\{6}[^:\t]+ end=+^\(\t\)\{6}[^:\t]+me=e-7 contains=outlTags,BT7,BT8,PT7,PT8,TA7,TA8,UT7,UT8,UB7,UB8,spellErr,SpellErrors,BadWord,OL8 keepend
syntax region OL8 start=+^\(\t\)\{7}[^:\t]+ end=+^\(\t\)\{7}[^:\t]+me=e-8 contains=outlTags,BT8,BT9,PT8,PT9,TA8,TA9,UT8,UT9,UB8,UB9,spellErr,SpellErrors,BadWord,OL9 keepend
syntax region OL9 start=+^\(\t\)\{8}[^:\t]+ end=+^\(\t\)\{8}[^:\t]+me=e-9 contains=outlTags,BT9,PT9,TA9,UT9,UB9,spellErr,SpellErrors,BadWord keepend

" End of Syntax }}}

" vim: set foldmethod=marker foldlevel=0:
