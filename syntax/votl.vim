
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

" colors for headings
hi link OL1 Statement
hi link OL2 Identifier
hi link OL3 Constant
hi link OL4 PreProc
hi link OL5 Statement
hi link OL6 Identifier
hi link OL7 Constant
hi link OL8 PreProc
hi link OL9 Statement

" colors for tags
hi link VotlTags Todo

" colors for dates and time
hi link VotlDate PreProc
hi link VotlTime PreProc

" colors for checkboxes
hi link VotlChecked    Todo
hi link VotlCheckbox   Todo
hi link VotlPercentage Todo

" colors for table lines
hi link VotlTableLines Delimiter

" color for body text
hi link BT1 Comment
hi link BT2 Comment
hi link BT3 Comment
hi link BT4 Comment
hi link BT5 Comment
hi link BT6 Comment
hi link BT7 Comment
hi link BT8 Comment
hi link BT9 Comment

" color for pre-formatted body text
hi link BP1 Special
hi link BP2 Special
hi link BP3 Special
hi link BP4 Special
hi link BP5 Special
hi link BP6 Special
hi link BP7 Special
hi link BP8 Special
hi link BP9 Special

" color for tables 
hi link TA1 Type
hi link TA2 Type
hi link TA3 Type
hi link TA4 Type
hi link TA5 Type
hi link TA6 Type
hi link TA7 Type
hi link TA8 Type
hi link TA9 Type

" color for user text (wrapping)
hi link UT1 Debug
hi link UT2 Debug
hi link UT3 Debug
hi link UT4 Debug
hi link UT5 Debug
hi link UT6 Debug
hi link UT7 Debug
hi link UT8 Debug
hi link UT9 Debug

" color for pre-formatted user text (non-wrapping)
hi link UP1 Underlined
hi link UP2 Underlined
hi link UP3 Underlined
hi link UP4 Underlined
hi link UP5 Underlined
hi link UP6 Underlined
hi link UP7 Underlined
hi link UP8 Underlined
hi link UP9 Underlined

" End of Colors }}}

" Syntax {{{

syn clear
syn sync fromstart

syn match VotlTags "\v\s@<=:(\w+:)+(\s|$)" contained

syn match VotlDate "\v\s@<=\d\d\d\d-\d\d-\d\d(\s|$)" contained
syn match VotlTime "\v\s@<=\d\d:\d\d:\d\d(\s|$)" contained

syn match VotlChecked "X" contained
syn match VotlCheckbox "\v^\s*\[.\]\s" contained contains=VotlChecked
syn match VotlPercentage "\v(^\s*\[.\]\s)@<=\d*\%\s" contained

syn match VotlTableLines '|\|+\%(=\+\|-\+\)\=' contained
syn match VotlTable '^\t*\(+[-=+]\+\)\|\(|.*|\)$' transparent contained contains=VotlTableLines

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
syntax region BP1 start=+^;+ skip=+^;+ end=+^\S+me=e-1 end=+^\(\t\)\{1}\S+me=e-2 contains=spellErr,SpellErrors,BadWord contained
syntax region BP2 start=+^\(\t\)\{1};+ skip=+^\(\t\)\{1};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BP3 start=+^\(\t\)\{2};+ skip=+^\(\t\)\{2};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BP4 start=+^\(\t\)\{3};+ skip=+^\(\t\)\{3};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BP5 start=+^\(\t\)\{4};+ skip=+^\(\t\)\{4};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BP6 start=+^\(\t\)\{5};+ skip=+^\(\t\)\{5};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BP7 start=+^\(\t\)\{6};+ skip=+^\(\t\)\{6};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BP8 start=+^\(\t\)\{7};+ skip=+^\(\t\)\{7};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region BP9 start=+^\(\t\)\{8};+ skip=+^\(\t\)\{8};+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained

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
syntax region UP1 start=+^<+ skip=+^<+ end=+^\S+me=e-1 end=+^\(\t\)\{1}\S+me=e-2 contains=spellErr,SpellErrors,BadWord contained
syntax region UP2 start=+^\(\t\)\{1}<+ skip=+^\(\t\)\{1}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UP3 start=+^\(\t\)\{2}<+ skip=+^\(\t\)\{2}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UP4 start=+^\(\t\)\{3}<+ skip=+^\(\t\)\{3}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UP5 start=+^\(\t\)\{4}<+ skip=+^\(\t\)\{4}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UP6 start=+^\(\t\)\{5}<+ skip=+^\(\t\)\{5}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UP7 start=+^\(\t\)\{6}<+ skip=+^\(\t\)\{6}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UP8 start=+^\(\t\)\{7}<+ skip=+^\(\t\)\{7}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained
syntax region UP9 start=+^\(\t\)\{8}<+ skip=+^\(\t\)\{8}<+ end=+^\(\t\)*\S+me=s-1 contains=spellErr,SpellErrors,BadWord contained

" comment-style body text formatting
syntax match Comment "^\s*:.*$"
setlocal fo-=t fo+=crqno
setlocal com=sO:\:\ -,mO:\:\ \ ,eO:\:\:,:\:,sO:\>\ -,mO:\>\ \ ,eO:\>\>,:\>

" headings
syntax region OL1 start=+^[^:\t]+ end=+^[^:\t]+me=e-1 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT1,BT2,BP1,BP2,TA1,TA2,UT1,UT2,UP1,UP2,spellErr,SpellErrors,BadWord,OL2 keepend
syntax region OL2 start=+^\t[^:\t]+ end=+^\t[^:\t]+me=e-2 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT2,BT3,BP2,BP3,TA2,TA3,UT2,UT3,UP2,UP3,spellErr,SpellErrors,BadWord,OL3 keepend
syntax region OL3 start=+^\(\t\)\{2}[^:\t]+ end=+^\(\t\)\{2}[^:\t]+me=e-3 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT3,BT4,BP3,BP4,TA3,TA4,UT3,UT4,UP3,UP4,spellErr,SpellErrors,BadWord,OL4 keepend
syntax region OL4 start=+^\(\t\)\{3}[^:\t]+ end=+^\(\t\)\{3}[^:\t]+me=e-4 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT4,BT5,BP4,BP5,TA4,TA5,UT4,UT5,UP4,UP5,spellErr,SpellErrors,BadWord,OL5 keepend
syntax region OL5 start=+^\(\t\)\{4}[^:\t]+ end=+^\(\t\)\{4}[^:\t]+me=e-5 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT5,BT6,BP5,BP6,TA5,TA6,UT5,UT6,UP5,UP6,spellErr,SpellErrors,BadWord,OL6 keepend
syntax region OL6 start=+^\(\t\)\{5}[^:\t]+ end=+^\(\t\)\{5}[^:\t]+me=e-6 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT6,BT7,BP6,BP7,TA6,TA7,UT6,UT7,UP6,UP7,spellErr,SpellErrors,BadWord,OL7 keepend
syntax region OL7 start=+^\(\t\)\{6}[^:\t]+ end=+^\(\t\)\{6}[^:\t]+me=e-7 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT7,BT8,BP7,BP8,TA7,TA8,UT7,UT8,UP7,UP8,spellErr,SpellErrors,BadWord,OL8 keepend
syntax region OL8 start=+^\(\t\)\{7}[^:\t]+ end=+^\(\t\)\{7}[^:\t]+me=e-8 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT8,BT9,BP8,BP9,TA8,TA9,UT8,UT9,UP8,UP9,spellErr,SpellErrors,BadWord,OL9 keepend
syntax region OL9 start=+^\(\t\)\{8}[^:\t]+ end=+^\(\t\)\{8}[^:\t]+me=e-9 contains=VotlTags,VotlDate,VotlTime,VotlCheckbox,VotlPercentage,VotlTable,BT9,BP9,TA9,UT9,UP9,spellErr,SpellErrors,BadWord keepend

" End of Syntax }}}

" vim: set foldmethod=marker foldlevel=0:
