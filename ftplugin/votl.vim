
"# votl, Vim Outliner
"#
"# Copyright (C) 2001,2003 by Steve Litt (slitt@troubleshooters.com)
"# Copyright (C) 2004 by Noel Henson (noel@noels-lab.com)
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

if exists("votl_loaded")
    finish
endif
let votl_loaded=1

" User Preferences {{{

let maplocalleader = ",,"  " this is prepended to VO key mappings
let g:votl_use_calendar = 1

if g:votl_use_calendar
    let g:calendar_action = 'VotlCalendarAction'
    let g:calendar_sign = 'VotlCalendarSign'
endif

" End User Preferences }}}

" VimOutliner Standard Settings {{{

setlocal ignorecase  " searches ignore case
setlocal smartcase   " searches use smart case
setlocal autoindent
setlocal backspace=2
setlocal noexpandtab
setlocal nosmarttab
setlocal softtabstop=0 
setlocal foldlevel=0
setlocal foldcolumn=1       " turns on "+" at the beginning of close folds
setlocal tabstop=2          " tabstop and shiftwidth must match
setlocal shiftwidth=2       " values from 2 to 8 work well
setlocal foldmethod=expr
setlocal foldexpr=VotlFoldLevel(v:lnum)
setlocal indentexpr=
setlocal nocindent
setlocal iskeyword=@,39,45,48-57,_,129-255
setlocal fillchars=vert:\|,fold:\ 

" This should be a setlocal but that doesn't work when switching to a
" new .otl file within the same buffer. Using :e has demonstrated this.
set foldtext=VotlFoldText()

" End of VimOutliner Standard Settings }}}

function! s:VotlTwoDigitNum(num) "{{{
    if a:num < 10
        return '0'.a:num
    endif
    return a:num
endfunction "}}}

" Determine the indent level of a line.
function! s:VotlIndent(line) "{{{
    return indent(a:line) / &tabstop
endfunction "}}}

" Get the root parent for any child
function! s:VotlFindRootParent(line) "{{{
    if s:VotlIndent(a:line) == 0
        return (a:line)
    endif
    let l:i = a:line
    while l:i > 1 && s:VotlIndent(l:i) > 0
        let l:i = l:i - 1
    endwhile
    return l:i
endfunction "}}}

" Return 1 if this line is a parent
function! VotlIsParent(line) "{{{
    return (s:VotlIndent(a:line)+1) == s:VotlIndent(a:line+1)
endfunction "}}}

" Return line if parent or the line's parent
function! VotlFindParent(line) "{{{
    if VotlIsParent(a:line)
        return a:line
    else
        let l:parentindent = s:VotlIndent(a:line)-1
        let l:searchline = a:line
        while (s:VotlIndent(l:searchline) != l:parentindent) &&
              \ (l:searchline > 0)
            let l:searchline = l:searchline-1
        endwhile
        return l:searchline
    endif
endfunction "}}}

" Return previous section at parent level
function! VotlPrevParent() "{{{
    let l:line = line(".")
    let l:parentindent = s:VotlIndent(l:line)
    if l:parentindent > 0
        let l:parentindent = l:parentindent-1
    endif
    let l:searchline = l:line-1
    while (l:searchline > 0) &&
          \ ((getline(l:searchline) == "") ||
          \  (s:VotlIndent(l:searchline) != l:parentindent))
        let l:searchline = l:searchline-1
    endwhile
    return l:searchline
endfunction "}}}

" Return next section at parent level
function! VotlNextParent() "{{{
    let l:line = line(".")
    let l:last = line("$")
    let l:parentindent = s:VotlIndent(l:line)
    if l:parentindent > 0
        let l:parentindent = l:parentindent-1
    endif
    let l:searchline = l:line+1
    while (l:searchline < l:last) &&
          \ ((getline(l:searchline) == "") ||
          \  (s:VotlIndent(l:searchline) > l:parentindent))
        let l:searchline = l:searchline+1
    endwhile
    return l:searchline
endfunction "}}}

" Return previous section at current level
function! VotlPrevSibling() "{{{
    let l:line = line(".")
    let l:curindent = s:VotlIndent(l:line)
    let l:searchline = l:line-1
    while (l:searchline > 0) &&
          \ ((getline(l:searchline) == "") ||
          \  (s:VotlIndent(l:searchline) > l:curindent))
        let l:searchline = l:searchline-1
    endwhile
    return l:searchline
endfunction "}}}

" Return next section at current level
function! VotlNextSibling() "{{{
    let l:line = line(".")
    let l:last = line("$")
    let l:curindent = s:VotlIndent(l:line)
    let l:searchline = l:line+1
    while (l:searchline < l:last) &&
          \ ((getline(l:searchline) == "") ||
          \  (s:VotlIndent(l:searchline) > l:curindent))
        let l:searchline = l:searchline+1
    endwhile
    return l:searchline
endfunction "}}}

" Return the last decendent of parent line
function! VotlFindLastChild(line) "{{{
    let l:parentindent = s:VotlIndent(a:line)
    let l:searchline = a:line+1
    while s:VotlIndent(l:searchline) > l:parentindent
        let l:searchline = l:searchline+1
    endwhile
    return l:searchline-1
endfunction "}}}

" Move a heading down by one
function! VotlMoveDown() "{{{
    call cursor(line("."), 0)
    del x
    put x
endfunction "}}}

" Delete a heading into register x
function! VotlDelHead(line) "{{{
    let l:fstart = foldclosed(a:line)
    if l:fstart == -1
        let l:execstr = a:line . "del x"
    else
        let l:fend = foldclosedend(a:line)
        let l:execstr = l:fstart . "," . l:fend . "del x"
    endif
    exec l:execstr
endfunction "}}}

" Put a heading from register x
function! VotlPutHead(line) "{{{
    let l:fstart = foldclosed(a:line)
    if l:fstart == -1
        let l:execstr = a:line . "put x"
    else
        let l:fend = foldclosedend(a:line)
        let l:execstr = l:fend . "put x"
    endif
    exec l:execstr
endfunction "}}}

" Return next heading
function! VotlNextHead(line) "{{{
    let l:fend = foldclosedend(a:line)
    if l:fend == -1
        return a:line+1
    else
        return l:fend+1
    endif
endfunction "}}}

" Compare headings (1) next is greater (0) same (-1) next is less
function! VotlCompHead(line) "{{{
    let nexthead = VotlNextHead(a:line)
    if indent(a:line) != indent(nexthead)
        return 0
    endif
    let l:thisline=getline(a:line)
    let l:nextline=getline(nexthead)
    if l:thisline <# l:nextline
        return 1
    elseif l:thisline ># l:nextline
        return -1
    else
        return 0
    endif
endfunction "}}}

" Compare headings and swap if out of order
" Direction is 0 for forward and 1 for reverse
" Return a 1 if a change was made, 0 otherwise
function! VotlSortLine(line, dir) "{{{
    if (VotlCompHead(a:line) == -1) && (a:dir == 0)
        call VotlDelHead(a:line)
        call VotlPutHead(a:line)
        return 1
    elseif (VotlCompHead(a:line) == 1) && (a:dir == 1)
        call VotlDelHead(a:line)
        call VotlPutHead(a:line)
        return 1
    else
        return 0
    endif
endfunction "}}}

" Single pass sort of heading range
" Direction is 0 for forward and 1 for reverse
" Return the changed count, 0 if no changes
function! VotlSortPass(fstart, fend, dir) "{{{
    let l:i = a:fstart
    let l:changed = 0
    while l:i < a:fend
        let l:changed = l:changed + VotlSortLine(l:i, a:dir)
        let l:i = VotlNextHead(l:i)
    endwhile
    return l:changed
endfunction "}}}

" Sort the range of headings
" Direction is 0 for forward and 1 for reverse
function! VotlSortRange(fstart, fend, dir) "{{{
    let l:changed = 1
    while l:changed != 0
        let l:changed = VotlSortPass(a:fstart, a:fend, a:dir)
    endwhile
endfunction "}}}

" Sort the children of a parent 
" Direction is 0 for forward and 1 for reverse
function! VotlSortChildren(dir) "{{{
    let l:oldcursor = line(".")
    let l:fstart = VotlFindParent(line("."))
    let l:fend = VotlFindLastChild(l:fstart)
    let l:fstart = l:fstart
    if l:fend <= l:fstart + 1
        return
    endif
    call append(line("$"),"Temporary last line for sorting")
    mkview
    let l:execstr = "set foldlevel=" . foldlevel(l:fstart)
    exec l:execstr
    call VotlSortRange(l:fstart + 1, l:fend, a:dir)
    call cursor(line("$"), 0)
    del x
    loadview
    call cursor(l:oldcursor, 0)
endfunction "}}}

" Make a string of characters
function VotlMakeChars(count, char) "{{{
    let i = 0
    let l:chars=""
    while i < a:count
        let l:chars = l:chars . a:char
        let i = i + 1
    endwhile
    return l:chars
endfunction "}}}

" Make a string of spaces
function VotlMakeSpaces(count) "{{{
    return VotlMakeChars(a:count, " ")
endfunction "}}}

" Make a string of dashes
function VotlMakeDashes(count) "{{{
    return VotlMakeChars(a:count, "-")
endfunction "}}}

" Create string used for folded text blocks
function VotlFoldText() "{{{
    let l:MySpaces = VotlMakeSpaces(&sw)
    let l:line = getline(v:foldstart)
    let l:bodyTextFlag=0
    if l:line =~ "^\t* \\S" || l:line =~ "^\t*\:"
        let l:bodyTextFlag=1
        let l:MySpaces = VotlMakeSpaces(&sw * (v:foldlevel-1))
        let l:line = l:MySpaces."[TEXT]"
    elseif l:line =~ "^\t*\;"
        let l:bodyTextFlag=1
        let l:MySpaces = VotlMakeSpaces(&sw * (v:foldlevel-1))
        let l:line = l:MySpaces."[TEXT BLOCK]"
    elseif l:line =~ "^\t*\> "
        let l:bodyTextFlag=1
        let l:MySpaces = VotlMakeSpaces(&sw * (v:foldlevel-1))
        let l:line = l:MySpaces."[USER]"
    elseif l:line =~ "^\t*\>"
        let l:ls = stridx(l:line,">")
        let l:le = stridx(l:line," ")
        if l:le == -1
            let l:l = strpart(l:line, l:ls+1)
        else
            let l:l = strpart(l:line, l:ls+1, l:le-l:ls-1)
        endif
        let l:bodyTextFlag=1
        let l:MySpaces = VotlMakeSpaces(&sw * (v:foldlevel-1))
        let l:line = l:MySpaces."[USER ".l:l."]"
    elseif l:line =~ "^\t*\< "
        let l:bodyTextFlag=1
        let l:MySpaces = VotlMakeSpaces(&sw * (v:foldlevel-1))
        let l:line = l:MySpaces."[USER BLOCK]"
    elseif l:line =~ "^\t*\<"
        let l:ls = stridx(l:line,"<")
        let l:le = stridx(l:line," ")
        if l:le == -1
            let l:l = strpart(l:line, l:ls+1)
        else
            let l:l = strpart(l:line, l:ls+1, l:le-l:ls-1)
        endif
        let l:bodyTextFlag=1
        let l:MySpaces = VotlMakeSpaces(&sw * (v:foldlevel-1))
        let l:line = l:MySpaces."[USER BLOCK ".l:l."]"
    elseif l:line =~ "^\t*[|+]"
        let l:bodyTextFlag=1
        let l:MySpaces = VotlMakeSpaces(&sw * (v:foldlevel-1))
        let l:line = l:MySpaces."[TABLE]"
    endif
    let l:sub = substitute(l:line,'\t',l:MySpaces,'g')
    let l:len = strlen(l:sub)
    let l:sub = l:sub . " " . VotlMakeDashes(58 - l:len) 
    let l:sub = l:sub . " (" . ((v:foldend + l:bodyTextFlag)- v:foldstart)
    if ((v:foldend + l:bodyTextFlag)- v:foldstart) == 1
        let l:sub = l:sub . " line)" 
    else
        let l:sub = l:sub . " lines)" 
    endif
    return l:sub
endfunction "}}}

" Insert the date/time.
function VotlInsertDateTime(location, stamp) "{{{
    if a:stamp == 0
        let @x = strftime("%Y-%m-%d")
    elseif a:stamp == 1
        let @x = strftime("%T")
    else " a:stamp == 2
        let @x = strftime("%Y-%m-%d %T")
    endif

    if a:location == 0
        let l:line = getline(".")
        if match(l:line, '\v(^\s*\[.\] )@<=\d*\%\s') != -1
            " insert date after a checkbox/percentage
            execute "normal! ^2W\"xPa \<esc>^"
        elseif match(l:line, '\v^\s*\[.\]\s') != -1
            " insert date after a checkbox
            execute "normal! ^W\"xPa \<esc>^"
        else
            " insert date at the beginning of the line
            execute "normal! ^\"xPa \<esc>^"
        endif
    else " a:location == 1
        let l:line = getline(".")
        if match(l:line, '\v\s:(\w+:)+\s*$') != -1
            " insert date before the trailing tags
            execute "normal! $Bgelcw \<esc>\"xpa \<esc>^"
        else
            " insert date at the end of the line
            execute "normal! $a \<esc>\"xp^"
        endif
    endif
endfunction "}}}

" Is the line body text?
function! VotlBodyText(line) "{{{
    return (match(getline(a:line), "^\t*:") == 0)
endfunction "}}}

" Is the line preformatted body text?
function! VotlPreBodyText(line) "{{{
    return (match(getline(a:line), "^\t*;") == 0)
endfunction "}}}

" Is the line user text?
function! VotlUserText(line) "{{{
    return (match(getline(a:line), "^\t*>") == 0)
endfunction "}}}

" Is the line user text with a space?
function! VotlUserTextSpace(line) "{{{
    return (match(getline(a:line), "^\t*> ") == 0)
endfunction "}}}

" Is the line preformatted user text?
function! VotlPreUserText(line) "{{{
    return (match(getline(a:line), "^\t*<") == 0)
endfunction "}}}

" Is the line preformatted user text with a space?
function! VotlPreUserTextSpace(line) "{{{
    return (match(getline(a:line), "^\t*< ") == 0)
endfunction "}}}

" Is the line preformatted table?
function! VotlPreTable(line) "{{{
    return (match(getline(a:line), "^\t*[|+]") == 0)
endfunction "}}}

" Determine the fold level of a line.
function VotlFoldLevel(line) "{{{
    let l:myindent = s:VotlIndent(a:line)
    if VotlBodyText(a:line)
        if (VotlBodyText(a:line-1) == 0)
            return '>'.(l:myindent+1)
        endif
        if (VotlBodyText(a:line+1) == 0)
            return '<'.(l:myindent+1)
        endif
        return (l:myindent+1)
    elseif VotlPreBodyText(a:line)
        if (VotlPreBodyText(a:line-1) == 0)
            return '>'.(l:myindent+1)
        endif
        if (VotlPreBodyText(a:line+1) == 0)
            return '<'.(l:myindent+1)
        endif
        return (l:myindent+1)
    elseif VotlPreTable(a:line)
        if (VotlPreTable(a:line-1) == 0)
            return '>'.(l:myindent+1)
        endif
        if (VotlPreTable(a:line+1) == 0)
            return '<'.(l:myindent+1)
        endif
        return (l:myindent+1)
    elseif VotlPreUserText(a:line)
        if (VotlPreUserText(a:line-1) == 0)
            return '>'.(l:myindent+1)
        endif
        if (VotlPreUserTextSpace(a:line+1) == 0)
            return '<'.(l:myindent+1)
        endif
        return (l:myindent+1)
    elseif VotlUserText(a:line)
        if (VotlUserText(a:line-1) == 0)
            return '>'.(l:myindent+1)
        endif
        if (VotlUserTextSpace(a:line+1) == 0)
            return '<'.(l:myindent+1)
        endif
        return (l:myindent+1)
    else
        let l:nextindent = s:VotlIndent(a:line+1)
        if l:myindent < l:nextindent
            return '>'.(l:myindent+1)
        endif
        if l:myindent > l:nextindent
            return '<'.(l:myindent+1)
        endif
        return l:myindent
    endif
endfunction "}}}

" Execute an executable line
function VotlSpawn() "{{{
    let theline = getline(".")
    let idx = matchend(theline, "_exe_\\s*")
    if idx == -1
        echo "Not an executable line"
    else
        let command = strpart(theline, idx)
        let command = "!".command
        exec command
    endif
endfunction "}}}

" Cycle over fold levels
function VotlToggleFolding() "{{{
    let l:line = line(".")

    if foldclosed(l:line) != -1
        normal! zo
        return
    endif

    let l:fstart = l:line
    let l:fend = VotlFindLastChild(l:fstart)
    if l:fstart == l:fend
        " no children
        return
    endif

    " is there a child that is folded?
    let l:ind = 0
    for l:i in range(l:fstart, l:fend)
        if foldclosed(l:i) != -1
            let l:ind = s:VotlIndent(foldclosed(l:i))
            break
        endif
    endfor

    if l:ind == 0
        " nothing folded, fold all back down
        execute l:fstart.",".l:fend."foldclose!"
        for l:i in range(s:VotlIndent(l:line))
            normal! zo
        endfor
    else
        " open one more level of folds
        execute l:fstart.",".l:fend."foldopen"
    endif
endfunction "}}}

function! VotlCalendarAction(day, month, year, week, dir) "{{{

    let l:day = s:VotlTwoDigitNum(a:day)
    let l:month = s:VotlTwoDigitNum(a:month)
    let l:entry_date = a:year.'-'.l:month.'-'.l:day

    " Calendar.vim will set dir to either 'H' or 'V'
    " If dir is 'X' then this is a call from inside votl
    if a:dir != 'X'
        wincmd p
    endif

    " search for the Journal outline (wrap search and moves cursor)
    let l:journal = search("^Journal$", "cw")
    if l:journal == 0
        " journal not found so make one at the end of the the file
        execute "normal! GoJournal\<cr>\<esc>"
        execute "normal! i\<tab>".a:year."\<cr>\<esc>"
        execute "normal! i\<tab>\<tab>".a:year."-".l:month."\<cr>\<esc>"
        execute "normal! i\<tab>\<tab>\<tab>".l:entry_date."\<esc>"
        normal! ^zx
        return
    endif

    " journal found now search for the entry
    if search("^\t\t\t".l:entry_date."$", "cW") != 0
        " entry found, unfold it
        normal! ^zx
        return
    endif

    " add a new entry algorithm:
    "   search for y
    "   if not found then add y / y-m / y-m-d, sort on y, then jump to entry
    "   if y found then
    "     search for y-m
    "     if not found then add y-m / y-m-d, sort on y-m, then jump to entry
    "     if y-m found then
    "       search for d
    "       if not found then add y-m-d, sort on y-m-d, then jump to entry
    "       if y-m-d found... not possible (caught above!)

    if search("^\t".a:year."$", "cW") == 0
        " year not found
        execute "normal! zvo\<tab>".a:year."\<esc>"
        execute "normal! o\<tab>".a:year."-".l:month."\<esc>"
        execute "normal! o\<tab>".l:entry_date."\<esc>^"

        " sort the children on the year
        normal! kkk
        normal ,,s

        call cursor(l:journal, 0)
        if search("^\t\t\t".l:entry_date."$", "cW") != 0
            " entry found, unfold it
            normal! ^zx
        endif

        return
    endif

    " year found, search for year-month

    if search("^\t\t".a:year."-".l:month."$", "cW") == 0
        " year-month not found
        execute "normal! zvo\<tab>".a:year."-".l:month."\<esc>"
        execute "normal! o\<tab>".l:entry_date."\<esc>^"

        " sort the children on the year-month
        normal! kk
        normal ,,s

        call cursor(l:journal, 0)
        if search("^\t\t\t".l:entry_date."$", "cW") != 0
            " entry found, unfold it
            normal! ^zx
        endif

        return
    endif

    " year-month found, add new year-month-day entry
    execute "normal! zvo\<tab>".l:entry_date."\<esc>^"

    " sort the children on the year-month-day
    normal! k
    normal ,,s

    call cursor(l:journal, 0)
    if search("^\t\t\t".l:entry_date."$", "cW") != 0
        " entry found, unfold it
        normal! ^zv
    endif
endfunction "}}}

function! VotlCalendarSign(day, month, year) "{{{
    let l:day = s:VotlTwoDigitNum(a:day)
    let l:month = s:VotlTwoDigitNum(a:month)
    let l:savecursor = getpos(".") " save cursor

    " search for the Journal outline (wrap search and moves cursor)
    let l:journal = search("^Journal$", "cw")
    if l:journal == 0
        call setpos(".", l:savecursor) " reset cursor
        return 0
    endif

    " search for the entry from Journal start (nowrap search)
    let l:sign = search("^\t\t\t".a:year."-".l:month."-".l:day."$", "cW")

    call setpos(".", l:savecursor) " reset cursor
    return l:sign
endfunction "}}}

" Jump to today's Journal entry
function! VotlGotoToday() "{{{
    let l:day = str2nr(strftime("%d"))
    let l:month = str2nr(strftime("%m"))
    let l:year = strftime("%Y")
    call VotlCalendarAction(l:day, l:month, l:year, 0, 'X')
endfunction "}}}

" Insert a checkbox at the beginning of a header
function! VotlInsertCheckbox() "{{{
    let l:line = getline(".")
    if match(l:line, '\v^\t*[<>:;|+]') != -1
        return
    endif
    if match(l:line, '\v^\t*\[[X_]\] ') == -1
        execute "normal! ^i[_] \<esc>^"
        call VotlComputeHowMuchDone(s:VotlFindRootParent(line(".")))
    endif
endfunction "}}}

" Delete a checkbox if one exists
function! VotlDeleteCheckbox() "{{{
    let l:line = getline(".")
    if match(l:line, '\v^\t*\[[X_]\] \d*\% ') != -1
        execute "normal! ^2dW^"
        call VotlComputeHowMuchDone(s:VotlFindRootParent(line(".")))
    elseif match(l:line, '\v^\t*\[[X_]\] ') != -1
        execute "normal! ^dW^"
        call VotlComputeHowMuchDone(s:VotlFindRootParent(line(".")))
    endif
endfunction "}}}

" Insert a checkbox and percent at the beginning of a header
function! VotlInsertCheckboxPercent() "{{{
    let l:line = getline(".")
    if match(l:line, '\v^\t*[<>:;|+]') != -1
        return
    endif
    call VotlInsertCheckbox() " adds the box if it doesn't exist
    if match(l:line, '\v^\t*\[[X_]\] \d*\% ') == -1
        "if s:VotlIndent(line(".")+1) > s:VotlIndent(line("."))
            execute "normal! ^Wi% \<esc>^"
            call VotlComputeHowMuchDone(s:VotlFindRootParent(line(".")))
        "endif
    endif
endfunction "}}}

" Delete a checkbox percentage if one exists
function! VotlDeleteCheckboxPercent() "{{{
    let l:line = getline(".")
    if match(l:line, '\v^\t*\[[X_]\] \d*\% ') != -1
        execute "normal! ^WdW^"
        call VotlComputeHowMuchDone(s:VotlFindRootParent(line(".")))
    endif
endfunction "}}}

" Switch the state of the checkbox and update percents
function! VotlSwitchCheckbox() "{{{
    call VotlInsertCheckbox() " adds the box if it doesn't exist
    let l:line = getline(".")
    if match(l:line, '\v^\t*\[[X_]\] ') == -1
        return
    endif
    if match(l:line, '\v^\t*\[_\] ') != -1
        execute "normal! ^lrX^"
    elseif match(l:line, '\v^\t*\[X\] ') != -1
        execute "normal! ^lr_^"
    endif
    call VotlComputeHowMuchDone(s:VotlFindRootParent(line(".")))
endfunction "}}}

" Calculates proportion of already done work in the subtree
function! VotlComputeHowMuchDone(line) "{{{
    let l:done = 0
    let l:count = 0
    let l:i = 1
    while s:VotlIndent(a:line) < s:VotlIndent(a:line+l:i)
        if (s:VotlIndent(a:line)+1) == (s:VotlIndent(a:line+l:i))
            let l:childdoneness = VotlComputeHowMuchDone(a:line+l:i)
            if l:childdoneness >= 0
                let l:done = l:done + l:childdoneness
                let l:count = l:count+1
            endif
        endif
        let l:i = l:i+1
    endwhile
    let l:proportion=0
    if l:count>0
        let l:proportion = ((l:done * 100)/l:count)/100
    else
        if match(getline(a:line), "\\[X\\]") != -1
            let l:proportion = 100
        else 
            let l:proportion = 0
        endif
    endif
    call setline(a:line,substitute(getline(a:line)," [0-9]*%"," ".l:proportion."%",""))
    if l:proportion == 100
        call setline(a:line,substitute(getline(a:line),"\\[.\\]","[X]",""))
        return 100
    elseif l:proportion == 0 && l:count == 0
        if match(getline(a:line), "\\[X\\]") != -1
            return 100
        elseif match(getline(a:line), "\\[_\\]") != -1
            return 0
        else
            return -1
        endif
    else
        call setline(a:line,substitute(getline(a:line),"\\[.\\]","[_]",""))
        return l:proportion
    endif
endfunction "}}}

function! VotlToHtml() "{{{
    let l:dest_file = expand("%:r")."_votl.html"
    let l:savecursor = getpos(".") " save cursor

    "let g:html_number_lines = 1

    "let g:html_dynamic_folds = 1
    "normal! 1ggzM
    normal! 1ggzR

    execute "TOhtml"
    execute "w! ".l:dest_file
    execute "q!"
    call setpos(".", l:savecursor) " reset cursor
    normal! zx
endfunction "}}}

" aligns a tag located at the end of the line to the textwidth
function! VotlAlignTags() "{{{
    let l:line = line(".")
    if foldclosed(l:line) != -1
        normal! zv
    endif

    let l:indent = s:VotlIndent(l:line)

    normal! ^

    " search for ending tags and bail if none
    let l:tag_start = searchpos('\v\s:(\w+:)+\s*$', "", l:line)
    if l:tag_start[1] == 0 " no tags on this line
        return
    endif

    " replace all whitespace between heading and tags with a single space
    execute "normal! gelcw "

    " save the current cursor position between header and tags
    let l:insert_loc = getpos(".")

    " delete any trailing whitespace (should use getline/substitute/setline)
    s/\v\s+$//e

    " get the gap length between the end of the tags to the textwidth
    normal! $
    let l:end_loc = getpos(".")
    let l:num_to_insert = &textwidth-l:end_loc[2]-l:indent

    " if there is a gap then right align the tags
    if l:num_to_insert > 0
        call setpos(".", l:insert_loc)
        execute "normal! ".l:num_to_insert."i \<esc>"
        "call feedkeys("i".repeat(' ', l:num_to_insert)."\<esc>", "m")
    endif

    normal! ^
endfunction "}}}

" delete all tags on the line
function! VotlDeleteTags() "{{{
    let l:line = line(".")
    if foldclosed(l:line) != -1
        normal! zv
    endif

    " search for tags and bail if none
    let l:tag_start = searchpos('\v\s@<=:(\w+:)+(\s|$)', "", l:line)
    if l:tag_start[1] == 0 " no tags on this line
        return
    endif

    " trim all whitespace and delete the tags 
    execute "normal! gelcw \<esc>ldW"

    " delete any trailing whitespace (should use getline/substitute/setline)
    s/\v\s+$//e

    normal! ^
endfunction "}}}

" list all tags for tab completion with VotlTag
function! VotlListTags(ArgLead, CmdLine, CursorPos) "{{{
    let l:savecursor = getpos(".") " save cursor

    normal! gg
    let l:list = []

    for l:i in range(1, line("$"))
        let l:line = getline(l:i)
        let l:tags = matchstr(l:line, '\v\s:(\w+:)+(\s|$)', 0)
        if l:tags == -1
            continue
        endif
        for l:t in split(l:tags, ":")
            if l:t == ' ' || match(l:list, l:t) != -1
                continue
            endif
            if match(l:t, "^".a:ArgLead) == -1
                continue
            endif
            call extend(l:list, [l:t])
        endfor
    endfor

    call setpos(".", l:savecursor) " reset cursor
    return l:list
endfunction "}}}

" finds all lines with a given tag and lists them in the quickfix window
function! VotlFindTag(tag) "{{{
    let l:savecursor = getpos(".") " save cursor

    normal! gg
    let l:bufnr = bufnr('%')

    call setloclist(l:bufnr, []) " clear the quickfix window

    for l:i in range(1, line("$"))
        let l:line = getline(l:i)
        if match(l:line,
                \'\v\s:(\w+:)*'.a:tag.'(:\w+)*:(\s|$)') == -1
            continue
        endif
        " can't figure out how to prevent quickfix from squashing
        " whitespace at the beginning of the line. That is why the
        " '|' is prefixes to the line text.
        let l:tmp = { 'bufnr':l:bufnr, 'lnum':l:i, 'text':"|".l:line }
        call setloclist(l:bufnr, [l:tmp], "a")
    endfor

    if len(getloclist(l:bufnr)) == 0
        call setpos(".", l:savecursor) " reset cursor
        echo "No matches for tag: ".a:tag
        return
    endif

    lopen
    setlocal tabstop=2
    setlocal modifiable
    execute "g/^/normal! dW"
    setlocal nomodifiable
    setlocal nomodified
    normal! gg
endfunction "}}}

" Vim Outliner Key Mappings {{{

" insert the date 'YYYY-MM-DD'
nmap <silent><buffer> <localleader>d :call VotlInsertDateTime(0, 0)<cr>
nmap <silent><buffer> <localleader>D :call VotlInsertDateTime(1, 0)<cr>

" insert the time 'HH:MM:SS'
nmap <silent><buffer> <localleader>t :call VotlInsertDateTime(0, 1)<cr>
nmap <silent><buffer> <localleader>T :call VotlInsertDateTime(1, 1)<cr>

" insert the date and time 'YYYY-MM-DD HH:MM:SS'
nmap <silent><buffer> <localleader>x :call VotlInsertDateTime(0, 2)<cr>
nmap <silent><buffer> <localleader>X :call VotlInsertDateTime(1, 2)<cr>

" sort a list (forward / reverse)
nmap <silent><buffer> <localleader>s :call VotlSortChildren(0)<cr>
nmap <silent><buffer> <localleader>S :call VotlSortChildren(1)<cr>

" Insert a fence for segmented lists.
" I also use this divider to create a <hr> when converting to html
nmap <silent><buffer> <localleader>- o----------------------------------------<cr><esc>
imap <silent><buffer> <localleader>- <esc>o----------------------------------------<cr>

" switch document between the two types of bodytext styles (marker style / space style)
nmap <silent><buffer><localleader>b :%s/\(^\t*\):/\1/e<cr>:%s/\(^\t*\) /\1: /e<cr>:let @/=""<cr>
nmap <silent><buffer><localleader>B :%s/\(^\t*\):/\1/e<cr>:let @/=""<cr>

nmap <silent><buffer> <localleader>1 :set foldlevel=0<cr>
nmap <silent><buffer> <localleader>2 :set foldlevel=1<cr>
nmap <silent><buffer> <localleader>3 :set foldlevel=2<cr>
nmap <silent><buffer> <localleader>4 :set foldlevel=3<cr>
nmap <silent><buffer> <localleader>5 :set foldlevel=4<cr>
nmap <silent><buffer> <localleader>6 :set foldlevel=5<cr>
nmap <silent><buffer> <localleader>7 :set foldlevel=6<cr>
nmap <silent><buffer> <localleader>8 :set foldlevel=7<cr>
nmap <silent><buffer> <localleader>9 :set foldlevel=8<cr>
nmap <silent><buffer> <localleader>0 :set foldlevel=99999<cr>

imap <silent><buffer> <localleader>w <esc>:w<cr>a
nmap <silent><buffer> <localleader>e :call VotlSpawn()<cr>

nmap <silent><buffer> [[ :call cursor(VotlPrevParent(), 0)<cr>^
nmap <silent><buffer> ]] :call cursor(VotlNextParent(), 0)<cr>^
nmap <silent><buffer> {  :call cursor(VotlPrevSibling(), 0)<cr>^
nmap <silent><buffer> }  :call cursor(VotlNextSibling(), 0)<cr>^

nmap <silent><buffer> <localleader>jc :Calendar<cr>
nmap <silent><buffer> <localleader>jt :call VotlGotoToday()<cr>

" insert/delete a checkbox and/or percentage
map <silent><buffer> <localleader>cb :call VotlInsertCheckbox()<cr>
map <silent><buffer> <localleader>cB :call VotlDeleteCheckbox()<cr>
map <silent><buffer> <localleader>cp :call VotlInsertCheckboxPercent()<cr>
map <silent><buffer> <localleader>cP :call VotlDeleteCheckboxPercent()<cr>

" switch the status of the box
map <silent><buffer> <localleader>cx :call VotlSwitchCheckbox()<cr>

" calculate the proportion of work done on the subtree
map <silent><buffer> <localleader>cu :call VotlComputeHowMuchDone(s:VotlFindRootParent(line(".")))<cr>

" cycle over fold levels
nmap <silent><buffer> <tab> :call VotlToggleFolding()<cr>

" dump vtol to html
nmap <silent><buffer> <localleader>W :call VotlToHtml()<cr>

" right align tags
nmap <silent><buffer> <localleader>gr :call VotlAlignTags()<cr>
vmap <silent><buffer> <localleader>gr :call VotlAlignTags()<cr>
command! -range -nargs=0 -complete=command VotlAlignTags <line1>,<line2>call VotlAlignTags()

" delete tags
nmap <silent><buffer> <localleader>gd :call VotlDeleteTags()<cr>
vmap <silent><buffer> <localleader>gd :call VotlDeleteTags()<cr>
command! -range -nargs=0 -complete=command VotlDeleteTags <line1>,<line2>call VotlDeleteTags()

" find tag and list results in the quickfix window
command! -nargs=1 -complete=customlist,VotlListTags VotlTag call VotlFindTag(<f-args>)
nmap <silent><buffer> <localleader>gf :call VotlFindTag(expand("<cword>"))<cr>

" End of Vim Outliner Key Mappings }}}

" vim:set foldmethod=marker foldlevel=0:
