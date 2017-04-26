votl
====

Vim Outliner Plugin

```
*votl.txt*	For Vim version 7.35	Last change: 2012 Sep 22

                                                                        *votl*
votl - Vim Outliner~

votl is an outline processor designed for super fast authoring. It was
originally forked from *VimOutliner* and features include tree expand and
collapse, tree promotion and demotion, sorting children, level sensitive
colors, checkboxes and completion percentages for todo lists, tags, quick
time and date entry, unformatted and formatted body text, tables, and
support for calendar entries.

The file extension used by votl is *.votl* and remains compatible with the
existing *.otl* file format that *VimOutliner* uses.

Jump to all the |votl-commands|.

The votl enhancements not found in *VimOutliner* are:

 - Cycle over folds under the current header with <Tab>.
 - Quickly jumping between sections with the [[ ]] { } keystrokes.
 - Better coloring and support for much finer grained syntax highlighting.
 - Support for daily diary/journaling with a Calendar.
 - New support for tagging and the ability to quickly search for tags.
   Formatted exactly like Emacs org-mode tags.
 - Support for RestructuredText formatted tables.
 - Code cleanup/simplification and a better user experience.

License                                                         |votl-license|
Version                                                         |votl-version|
Objects                                                         |votl-objects|
Calendar                                                       |votl-calendar|
Tags                                                               |votl-tags|
Checkboxes                                                   |votl-checkboxes|
Commands                                                       |votl-commands|
Colors                                                           |votl-colors|
HTML                                                               |votl-html|

============================================================================
                                                                *votl-license*
License~

Copyright (C) 2001,2003 by Steve Litt (slitt@troubleshooters.com)
Copyright (C) 2004 by Noel Henson (noel@noels-lab.com)
Copyright (C) 2012 by Eric Davis (edavis@insanum.com)

votl is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

votl is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

See <http://www.gnu.org/licenses/>.

============================================================================
                                                                *votl-objects*
Objects~

There are several object/line types that votl supports. The most common are
simple headings and body text. Simple headings are tab-indented lines that
start with any non-whitespace character except ':', ';', '|', '<', '>'.
These characters specify other objects. Here is a list of each of the
non-heading types:

  Start    Description~
    :      body text (with wrapping)
    ;      preformatted body text (no wrapping)
    |      table
    >      user defined text block (with wrapping)
    <      user defined preformatted text block (no wrapping)

Body Text~

The body text marker ':' is used to specify lines that are automatically
wrapped and reformatted. votl and post-processors are free to wrap and
reformat this text as well as use proportionally spaced fonts. A
post-processor will probably change the appearance of what you have written.
If you are writing a book or other document, most of the information you
enter will be body text.

Here is an example:
>
    Kirby the Wonder Dog
        : Kirby is nine years old. He understand about 70-100
        : English words. Kirby also understands 11 different hand
        : signals. He is affectionate, playful and attentive.
        :
        : His breeding is unknown. He appears to be a mix between
        : a German Shepherd and a Collie.
<

When folded, body text looks something like this:
>
    Kirby the Wonder Dog
        [TEXT] -------------------------------- (6 lines)
<

Preformatted Body Text~

The preformatted text marker ';' is used to mark text that should not be
reformatted or wrapped by votl or any post-processor. A post-processor would
use a fixed-space font to render these lines. A post-processor should not
change the appearance of what you have written. This is useful for making
text picture, program code, or other format-dependent text.

Here is an example:
>
    Output Waveform
        ;       _______                ______
        ; _____/       \______________/
        ;      |-10us--|----35us------|
<

When folded, preformatted body text looks something like this:
>
    Output Waveform
        [TEXT BLOCK] -------------------------- (3 lines)
<

Tables~

There are two types of table formats supported by votl. The original
*VimOutliner* format and the *RestructuredText* format.

The original *VimOutliner* format uses a table marker '|' to create tables.
The marker is used as if it were are real vertical line. A double '||'
is optionally used to mark a table heading line which is useful for
post-processors.

Here is an example:
>
    Pets
        || Name  | Age | Animal | Inside/Outside |
        | Kirby  |   9 |    dog |           both |
        | Hoover |   1 |    dog |           both |
        | Sophia |   9 |    cat |         inside |
<

With the above format there is NO automatic alignment of columns.

The other, and much better, format supported by votl is the
*RestructuredText* format. The table above would be formatted as:
>
    Pets
        +--------+-----+--------+----------------+
        | Name   | Age | Animal | Inside/Outside |
        +========+=====+========+================+
        | Kirby  | 9   | dog    | both           |
        +--------+-----+--------+----------------+
        | Hoover | 1   | dog    | both           |
        +--------+-----+--------+----------------+
        | Sophia | 9   | cat    | inside         |
        +--------+-----+--------+----------------+
<

Your first thought might be that this format would be very difficult to
maintain by hand and you're right. Fortunately there is an awesome Vim
plugin by Vincent Driessen that automates the table creation and flow. This
plugin is named *vim-rst-tables* and can be downloaded from git. There is
also a nice video showing its functionality.
>
    vim-rst-tables:  https://github.com/nvie/vim-rst-tables
    video demo:      http://vimeo.com/14300874
<

Regardless of the table format used the syntax coloring of the tables
is the same for both. The color of the table "lines" is controlled
with the VotlTableLines highlight group. The actual color of the text
in the table cells is inherited from the current heading level.

When folded, a table looks something like this:
>
    Pets
        [TABLE] ------------------------------- (4 lines)
<

User-defined Text~

User-defined text is similar to body text but more flexible and its use is
not pre-defined by votl. The basic, user-defined text block marker '>'
behaves just like body text.

For example:
>
    Kirby the Wonder Dog
        > Kirby is nine years old. He understand about 70-100
        > English words. Kirby also understands 11 different hand
        > signals. He is affectionate, playful and attentive.
        >
        > His breeding is unknown. He appears to be a mix between
        > a German Shepherd and a Collie.
<

When folded, user-defined text looks something like this:
>
    Kirby the Wonder Dog
        [USER] -------------------------------- (6 lines)
<

But unlike body text, user-defined text can be expanded. You can have
user-defined text types. For example, if you were writing a book, in addition
to body text for paragraphs you might need special paragraphs for tips and
warnings. User-defined text blocks can accomplish this:
>
    >Tips
    > Don't forget to back up your computer daily. You don't
    > need to back up the entire computer. You just need to
    > backup up the files that have changed.
    >Warning
    > Never store you backup floppy disks on the side of you
    > file cabinets by adhering them with magnets.
<

A post processor will know how to remove the style tags (Tips and Warning)
and how you want the text to be formatted.

When folded, the above would appear as:
>
    [USER Tips] --------------------------- (4 lines)
    [USER Warning]------------------------- (3 lines)
<

Preformatted User-defined Text~

The user-defined, preformatted text block marker, <, behaves just like
preformatted text. But like >, it leaves the functional definition up to the
user. A simple user-defined, preformatted text block could be:
>
    Foobar
    <    ___       ___       ___       ___       ___       ___
    <   /\  \     /\  \     /\  \     /\  \     /\  \     /\  \
    <  /::\  \   /::\  \   /::\  \   /::\  \   /::\  \   /::\  \
    < /::\:\__\ /:/\:\__\ /:/\:\__\ /::\:\__\ /::\:\__\ /::\:\__\
    < \/\:\/__/ \:\/:/  / \:\/:/  / \:\::/  / \/\::/  / \;:::/  /
    <    \/__/   \::/  /   \::/  /   \::/  /    /:/  /   |:\/__/
    <             \/__/     \/__/     \/__/     \/__/     \|__|
<

When folded it would be:
>
    Foobar
	[USER BLOCK] -------------------------- (7 lines)
<

Like user-defined text, these blocks can be given user-defined styles. For
example:
>
    <Foobar
    <    ___       ___       ___       ___       ___       ___
    <   /\  \     /\  \     /\  \     /\  \     /\  \     /\  \
    <  /::\  \   /::\  \   /::\  \   /::\  \   /::\  \   /::\  \
    < /::\:\__\ /:/\:\__\ /:/\:\__\ /::\:\__\ /::\:\__\ /::\:\__\
    < \/\:\/__/ \:\/:/  / \:\/:/  / \:\::/  / \/\::/  / \;:::/  /
    <    \/__/   \::/  /   \::/  /   \::/  /    /:/  /   |:\/__/
    <             \/__/     \/__/     \/__/     \/__/     \|__|
    <Code
    < int main(int argc, char * argv[])
    < {
    <     printf("Hello world!"); 
    < }
<

When folded, the above would appear as:
>
    [USER BLOCK Foobar] ------------------- (8 lines)
    [USER BLOCK Code] --------------------- (5 lines)
<

Executables~

Executable lines enable you to launch any command from a specially
constructed headline within votl. The line must be constructed like this:
>
    Description _exe_ command
<

Here's an example to pull up Troubleshooters.Com:
>
    insanum.com _exe_ chromium http://insanum.com
<

Executable lines offer a nice benefit of a single-source knowledge tree,
where all your knowledge, no matter what its format, exists within a single
tree of outlines connected with external links and executable lines.

============================================================================
                                                               *votl-calendar*
Calendar~

votl has built in support for daily entries like a journal or diary. This
requires you have Yasuhiro Matsumoto's awesome Calendar plugin installed.
>
    calendar: http://www.vim.org/scripts/script.php?script_id=52
<

Open up your votl file and execute '\\jc'. This will bring up the calendar.
Type '?' to learn how to move around in the Calendar. Move the cursor over
a date and hit <Enter>. This will jump to a special heading in your votl
file under the top level header named *Journal* which can be located anywhere
in the file. If this header does not exist then it will be automatically
created at the bottom of the file. For example, assume I highlight 4/8/12
I would end up with with the following headlines and the cursor on that day.
Now I can enter my journal/diary/meeting/notes/etc for that day.
>
       <Prev Today Next>  |
                          |
         2012/4(Apr)      |-Journal
     Su Mo Tu We Th Fr Sa |+  2011 ------------------------------------------
      1  2  3  4  5  6  7 |-  2012
      8  9 10 11 12 13 14 |-    2012-04
     15 16 17 18 19 20 21 |-      2012-04-08
     22 23 24 25 26 27 28 |-        : Now is the time for all good men
     29 30                |5        : to come to the aid of their country.
                          |+    2012-09 -------------------------------------
         2012/5(May)      |+    2012-10 -------------------------------------
     Su Mo Tu We Th Fr Sa | ~
            1  2  3  4  5 | ~
      6  7  8  9 10 11 12 | ~
     13 14 15 16 17 18 19 | ~
     20 21 22 23 24 25 26 | ~
     27 28 29 30 31       | ~
                          | ~
         2012/6(Jun)      | ~
     Su Mo Tu We Th Fr Sa | ~
                     1  2 | ~
      3  4  5  6  7  8  9 | ~
     10 11 12 13 14 15 16 | ~
     17 18 19 20 21 22 23 | ~
     24 25 26 27 28 29 30 | ~
                          | ~
                          | ~
    foo.votl -------------------------------------- [x32/d50] [10,4] [50] All
<

The *Journal* is automatically sorted in ascending order at each level (i.e.
by year, then by year-month, and finally by year-month-day). Whenever you
enter a new entry it will be inserted in the proper location in the *Journal*
(chronological order).

Additionally, the Calendar plugin will show you which days you have journal
entries with the date being highlighted in a different color.

If you would like to jump to today's *Journal* entry then execute '\\jt'
which bypasses the Calendar and quickly jumps to the entry.

============================================================================
                                                                   *votl-tags*
Tags~

votl supports inline tags for tracking that can be used in a future query.
A header can have any number of tags assigned to it and the format for tags
are:

  :tag1:           for a single tag
  :tag1:tag2:      for two tags
  :tag1:tag3:etc:  for any number of tags

A tag is required to have a space both before the first ':' and after the
last ':' (or be at the end of the line). Note that a tag cannot exist at
the beginning of the line. If a tag is at the end of the line votl can easily
right align it to the |textwidth| using the '\\gr' command. This will align
the tag (if it exists) on the line under the cursor. You can also specify a
range or select a visual range to align tags for multiple lines.

Example:

  Test                                               :a:b:d:
    foo                                                :foo:
      bar :test:fail: geek
    doh                                           :blah:foo:

Tags can be deleted using the '\\gd' command. Any tags found on the line will
be deleted. Additionally, you can specify a range or select a visual range to
delete tags for multiple lines.

A tag can be easily queried (i.e. grep'ed for) using the *:VotlTag* *<tag>*
command. This command searches the current buffer for the specific tag,
creates a location list, and opens up the |location-list| window for the
buffer.

The *:VotlTag* command supports <Tab> completion for the tag name.

Example (executing *:VotlTag* *foo* to query the *foo* tag):

  Test                                               :a:b:d:
    foo                                                :foo:
      bar :test:fail: geek
    doh                                           :blah:foo:
  test.votl ----------------------- [x54/d84] [1,1] [95] All
  | foo                                                :foo:
  | doh                                           :blah:foo:

Inside the |location-list| window hitting <Enter> on any line will jump
to that line in the votl file and open all folds needed to view the line.
To jump around use the |:lne| and |:lpr| commands. To close the |location-list|
window use |:lcl| and |:lop| to open it back up.

============================================================================
                                                             *votl-checkboxes*
Checkboxes~

Checkboxes enable votl to understand tasks and calculate the current
status of todo lists. Three special notations are used:
>
    [_]   an unchecked item or incomplete task
    [X]   a checked item or complete task
    %     a placeholder for percentage of completion
<

Example. Let's plan a barbecue.

1. Make the initial outline.
>
    Barbecue
        Guests
            Bill and Barb
            Larry and Louise
            Marty and Mary
        Food
            Chicken
            Ribs
            Corn on the cob
        Beverages
            Soda
            Beer
        Materials
            Paper Plates
            Napkins
            Cups
<

2. Add the check boxes.

This can be done by visually selecting them and typing '\\cb'. When done
you should see this:
>
    [_] Barbecue
        [_] Guests
            [_] Bill and Barb
            [_] Larry and Louise
            [_] Marty and Mary
        [_] Food
            [_] Chicken
            [_] Ribs
            [_] Corn on the cob
        [_] Beverages
            [_] Soda
            [_] Beer
        [_] Materials
            [_] Paper Plates
            [_] Napkins
            [_] Cups
<

3. Now check off what's done.

Check off what is complete with the '\\cx' command. Just place the cursor on
a heading and '\\cx' it. Note that a heading with children will only, and
automatically, get checked when each of its children are complete.
>
    [_] Barbecue
        [X] Guests
            [X] Bill and Barb
            [X] Larry and Louise
            [X] Marty and Mary
        [_] Food
            [X] Chicken
            [X] Ribs
            [_] Corn on the cob
        [_] Beverages
            [_] Soda
            [X] Beer
        [_] Materials
            [X] Paper Plates
            [_] Napkins
            [X] Cups
<

4. Add percentages for a better view.

You can get a much better view of what's going on, especially with collapsed
headings, if you add percentages. Visually select all the items and execute
'\\cp'. Note that you can manually add a percentage to single lines (i.e. a
'%' character with a single space before and after it). Put this after the
checkbox and before the heading. Thereafter you can manually update the
completion percentages with the '\\cu' command. Note that all the other
'\\c[bBpPx]' commands update the percentages automatically (if they exist).
>
    [_] 70% Barbecue
        [X] 100% Guests
            [X] 100% Bill and Barb
            [X] 100% Larry and Louise
            [X] 100% Marty and Mary
        [_] 66% Food
            [X] 100% Chicken
            [X] 100% Ribs
            [_] 0% Corn on the cob
        [_] 50% Beverages
            [_] 0% Soda
            [X] 100% Beer
        [_] 66% Materials
            [X] 100% Paper Plates
            [_] 0% Napkins
            [X] 100% Cups
<

5. Complete a few more just for fun.

When you '\\cx' any lines (to complete or uncomplete it) you'll see the
percentages automatically recalculated in each header.

============================================================================
                                                               *votl-commands*
Commands~

For maximum authoring speed, votl features are accessed through keyboard
commands starting with two(2) commas. Here is a list of all the available
keyboard shortcuts. Remember that all Vim commands can be performed in votl
files. This is especially useful for copy, paste, moving around, and similar
commands. It is advised that you know all the Vim |folding| commands.

Command formats: [command] [mode] [description]

Movement~

  [[  normal  Jump to previous section at higher level
  ]]  normal  Jump to next section at higher level
  {   normal  Jump to previous section at same or higher level
  {   normal  Jump to next section at same or higher level

Folding~

  <Tab>  normal  Cycle through all tab levels under heading
  \\1    normal  set foldlevel=0
  \\2    normal  set foldlevel=1
  \\3    normal  set foldlevel=2
  \\4    normal  set foldlevel=3
  \\5    normal  set foldlevel=4
  \\6    normal  set foldlevel=5
  \\7    normal  set foldlevel=6
  \\8    normal  set foldlevel=7
  \\9    normal  set foldlevel=8
  \\0    normal  set foldlevel=99999

Calendar~

  \\jc  normal  Bring up calendar (requires calendar.vim plugin)
  \\jt  normal  Jump to today's journal entry

Time and Date~

  date stamp       YYYY-MM-DD
  time stamp       HH:MM:SS
  date/time stamp  YYYY-MM-DD HH:MM:SS

  \\d  normal  Prepend date to heading (after any checkbox/percentage)
  \\D  normal  Append date to heading (before any trailing tags)
  \\t  normal  Prepend time to heading (after any checkbox/percentage)
  \\T  normal  Append time to heading (before any trailing tags)
  \\x  normal  Prepend date/time to heading (after any checkbox/percentage)
  \\X  normal  Append date/time to heading (before any trailing tags)

Checkboxes~

  \\cb  normal  Insert a checkbox on the current line or range 
  \\cB  normal  Delete a checkbox on the current line or range
  \\cp  normal  Insert a checkbox with percentage placeholder
  \\cP  normal  Delete a checkbox percentage on the current line or range
  \\cx  normal  Toggle checkbox state and update completion percentages
  \\cu  normal  Update completion percentages for the current tree

Tags~

  \\gr  normal  Right align tags at end of line
  \\gr  visual  Right align tags at end of line for a range of lines
  \\gd  normal  Delete all tags on the line
  \\gd  visual  Delete all tags on the line for a range of lines
  \\gf  normal  Find all occurrences of the tag under the cursor

Formatting~

  \\s    normal  Sort children under cursor in ascending order
  \\S    normal  Sort children under cursor in descending order
  \\b    normal  Change body text start with a colon and space
  \\B    normal  Change body text start with a space
  >>     normal  Demote headline
  <<     normal  Promote headline
  >      visual  Demote a range of headlines
  <      visual  Promote a range of headlines
  <C-T>  insert  Demote headline
  <C-D>  insert  Promote headline

Other~

  \\-  all     Draw dashed line
  \\e  normal  Execute the executable tag line under cursor
  \\w  insert  Save changes and return to insert mode
  \\W  normal  Export to HTML (foobar.votl -> foobar_votl.html)

============================================================================
                                                                 *votl-colors*
Colors~

Color schemes specify the colors votl uses when displaying an outline.
Heading colors are specified by object and level. These objects currently
include headings, body text, user text, and tables. Other color groups
include executables, checkboxes, percentages, and dates/times.

To override the color scheme add the following to your *.vimrc* file (see
|highlight| for more information) and modify as needed:
>
    function! MyVotlColors()
          highlight OL1 ctermfg=lightblue
          highlight OL2 ctermfg=red
          highlight OL3 ctermfg=brown
          highlight OL4 ctermfg=yellow
          highlight OL5 ctermfg=lightblue
          highlight OL6 ctermfg=red
          highlight OL7 ctermfg=brown
          highlight OL8 ctermfg=yellow
          highlight OL8 ctermfg=white

          " color for body text
          for i in range(1, 9)
             execute "highlight BT" . i . " ctermfg=lightgreen"
          endfor

          " ...etc...
    endfunction
    autocmd FileType votl call MyVotlColors()
<

Highlight groups used by votl are:

  *OL[1-9]*         headers
  *BT[1-9]*         body text
  *BP[1-9]*         preformatted body text
  *UT[1-9]*         user-defined text
  *UP[1-9]*         preformatted user-defined text
  *VotlTags*        tags formatted as ':tag1:tag2:etc:'
  *VotlDate*        'YYYY-MM-DD' date stamp
  *VotlTime*        'HH-MM-SS' time stamp
  *VotlCheckbox*    checkboxes
  *VotlChecked*     'X' in a checkbox
  *VotlPercentage*  percentage completions
  *VotlTableLines*  lines for tables (table text inherits header color)

============================================================================
                                                                   *votl-html*
HTML~

A votl file can easily be exported to HTML using the '\\W' command. This
export utilizes the Vim builtin |TOhtml| exporter. The final HTML will look
exactly like the outline text in your terminal with all folds unfolded.

============================================================================
                                                                *votl-version*
Version~

  Version 0.1 (2012-09-22)
    - Initial release
    - forked from VimOutliner
        . major code cleanup, refactored, and simplified
        . removed all old/outdated scripts
        . removed the smart_paste and hoist plugins
        . incorporated the checkbox plugin as native
        . removed support for inter-outline linking
    - new file type and extension *votl* - compatible with *otl*
    - better coloring and much finer grained syntax highlighting
    - support for cycling over folds under the current header
    - support for quickly jumping between sections
    - support for tagging (like Emacs org-mode tags)
    - support for journaling with the *Calendar.vim* Vim plugin
    - support for RestructuredText tables with the *vim-rst-tables* Vim plugin

vim:set filetype=help textwidth=78:
```

