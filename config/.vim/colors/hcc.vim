" Howard's Vim color file, designed to look the same both in gvim
" and in a 256-color terminal.

" This is modified from the color file "h80", from:
" http://bytefluent.com/vivify

set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "hcc"

hi ColorColumn guibg=#303030 ctermbg=234
"hi IncSearch -- no settings --
"hi WildMenu -- no settings --
"hi SignColumn -- no settings --
hi SpecialComment guifg=#A9EE8A guibg=NONE guisp=NONE gui=NONE ctermfg=156 ctermbg=NONE cterm=NONE
hi Typedef guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
hi Title guifg=#8DB8C3 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE
hi Folded guifg=#000000 guibg=#FFC0C0 guisp=#FFC0C0 gui=NONE ctermfg=NONE ctermbg=217 cterm=NONE
hi PreCondit guifg=#d75fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
"ORIG: hi PreCondit guifg=#F9449A guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi Include guifg=#d75fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
"ORIG: hi Include guifg=#F9449A guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
"hi TabLineSel -- no settings --
hi StatusLineNC guifg=#000000 guibg=#b2b2b2 guisp=#000000 gui=bold ctermfg=0 ctermbg=249 cterm=bold
"ORIG: hi StatusLineNC guifg=#004443 guibg=#067C7B guisp=#067C7B gui=bold ctermfg=23 ctermbg=6 cterm=bold
"hi CTagsMember -- no settings --
hi NonText guifg=NONE guibg=#000000 guisp=#334C75 gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
"ORIG: hi NonText guifg=#9FADC5 guibg=#334C75 guisp=#334C75 gui=NONE ctermfg=146 ctermbg=60 cterm=NONE
"hi CTagsGlobalConstant -- no settings --
"hi DiffText -- no settings --
"hi ErrorMsg -- no settings --
"hi Ignore -- no settings --
hi Debug guifg=#A9EE8A guibg=NONE guisp=NONE gui=NONE ctermfg=156 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#848688 guisp=#848688 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi Identifier guifg=#555555 guibg=NONE guisp=NONE gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#ff5fff guibg=NONE guisp=NONE gui=bold ctermfg=207 ctermbg=NONE cterm=NONE
"ORIG: hi SpecialChar guifg=#A9EE8A guibg=NONE guisp=NONE gui=NONE ctermfg=156 ctermbg=NONE cterm=NONE
hi Conditional guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
hi StorageClass guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
hi Todo guifg=#FFFFFF guibg=#FF0000 guisp=#FF0000 gui=NONE ctermfg=15 ctermbg=196 cterm=NONE
hi Special guifg=#A9EE8A guibg=NONE guisp=NONE gui=NONE ctermfg=156 ctermbg=NONE cterm=NONE
"hi LineNr -- no settings --
"hi StatusLine -- no settings -- guifg=#c0ffff guibg=#004443 guisp=#004443 gui=NONE ctermfg=159 ctermbg=23 cterm=NONE
hi Normal guifg=#ffffff guibg=#00005f guisp=#00005f gui=NONE ctermfg=15 ctermbg=17 cterm=NONE
hi Label guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#c0ffff guibg=#004443 guisp=#004443 gui=NONE ctermfg=159 ctermbg=23 cterm=NONE
hi Search guifg=#000020 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=17 ctermbg=15 cterm=NONE
"hi CTagsGlobalVariable -- no settings --
hi Delimiter guifg=#A9EE8A guibg=NONE guisp=NONE gui=NONE ctermfg=156 ctermbg=NONE cterm=NONE
hi Statement guifg=#ffd700 guibg=NONE guisp=NONE gui=bold ctermfg=220 ctermbg=NONE cterm=bold
"ORIG: hi Statement guifg=#ff9742 guibg=NONE guisp=NONE gui=bold,italic ctermfg=215 ctermbg=NONE cterm=bold
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
hi Comment guifg=#afafff guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=bold
"ORIG: hi Comment guifg=#666666 guibg=NONE guisp=NONE gui=italic ctermfg=241 ctermbg=NONE cterm=NONE
hi Character guifg=#A9EE5A guibg=NONE guisp=NONE gui=bold,italic ctermfg=155 ctermbg=NONE cterm=bold
"hi Float -- no settings --
hi Number guifg=#ff0000 guibg=NONE guisp=NONE gui=bold ctermfg=196 ctermbg=NONE cterm=bold
"ORIG: hi Number guifg=#A9EE5A guibg=NONE guisp=NONE gui=bold,italic ctermfg=155 ctermbg=NONE cterm=bold
hi Boolean guifg=#ff9742 guibg=NONE guisp=NONE gui=bold,italic ctermfg=215 ctermbg=NONE cterm=bold
hi Operator guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
"hi CursorLine -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
hi Question guifg=#F4BB7E guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi WarningMsg guifg=#F60000 guibg=NONE guisp=NONE gui=underline ctermfg=196 ctermbg=NONE cterm=underline
"hi VisualNOS -- no settings --
"hi DiffDelete -- no settings --
hi ModeMsg guifg=#404040 guibg=#C0C0C0 guisp=#C0C0C0 gui=NONE ctermfg=238 ctermbg=7 cterm=NONE
"hi CursorColumn -- no settings --
hi Define guifg=#d75fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
"ORIG: hi Define guifg=#F9449A guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi Function guifg=#555555 guibg=NONE guisp=NONE gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=#d2b48c guibg=#800080 guisp=#800080 gui=NONE ctermfg=180 ctermbg=90 cterm=NONE
hi PreProc guifg=#d75fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
"ORIG: hi PreProc guifg=#F9449A guibg=NONE guisp=NONE gui=NONE ctermfg=201 ctermbg=NONE cterm=NONE
"hi EnumerationName -- no settings --
hi Visual guifg=black guibg=#C0FFC0 guisp=#C0FFC0 gui=bold ctermfg=black ctermbg=157 cterm=bold
"ORIG: hi Visual guifg=#000000 guibg=#C0FFC0 guisp=#C0FFC0 gui=bold ctermfg=NONE ctermbg=157 cterm=bold
hi MoreMsg guifg=#00ced1 guibg=#188F90 guisp=#188F90 gui=NONE ctermfg=44 ctermbg=30 cterm=NONE
"hi SpellCap -- no settings --
hi VertSplit guifg=#075554 guibg=#C0FFFF guisp=#C0FFFF gui=NONE ctermfg=23 ctermbg=159 cterm=NONE
hi Exception guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
hi Keyword guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
hi Type guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
"hi DiffChange -- no settings --
hi Cursor guifg=#e3e3e3 guibg=#D74141 guisp=#D74141 gui=NONE ctermfg=254 ctermbg=167 cterm=NONE
"hi SpellLocal -- no settings --
"hi Error -- no settings --
hi PMenu guifg=#004443 guibg=#067C7B guisp=#067C7B gui=NONE ctermfg=23 ctermbg=6 cterm=NONE
hi SpecialKey guifg=#BF9261 guibg=NONE guisp=NONE gui=NONE ctermfg=137 ctermbg=NONE cterm=NONE
hi Constant guifg=#afff00 guibg=NONE guisp=NONE gui=bold ctermfg=154 ctermbg=NONE cterm=bold
"ORIG: hi Constant guifg=#A9EE5A guibg=NONE guisp=NONE gui=bold,italic ctermfg=155 ctermbg=NONE cterm=bold
"hi DefinedName -- no settings --
hi Tag guifg=#A9EE8A guibg=NONE guisp=NONE gui=NONE ctermfg=156 ctermbg=NONE cterm=NONE
hi String guifg=#ff005f guibg=NONE guisp=NONE gui=NONE ctermfg=161 ctermbg=NONE cterm=bold
"ORIG: hi String guifg=#A9EE5A guibg=NONE guisp=NONE gui=bold,italic ctermfg=155 ctermbg=NONE cterm=bold
hi PMenuThumb guifg=NONE guibg=#a4a6a8 guisp=#a4a6a8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
hi Repeat guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
"hi Directory -- no settings --
hi Structure guifg=#55AAFF guibg=NONE guisp=NONE gui=bold,italic ctermfg=75 ctermbg=NONE cterm=bold
hi Macro guifg=#d75fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
"ORIG: hi Macro guifg=#F9449A guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
"hi Underlined -- no settings --
"hi DiffAdd -- no settings --
"hi TabLine -- no settings --
hi mbenormal guifg=#cfbfad guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=187 ctermbg=237 cterm=NONE
hi perlspecialstring guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi doxygenspecial guifg=#00ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi mbechanged guifg=#eeeeee guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=255 ctermbg=237 cterm=NONE
hi mbevisiblechanged guifg=#eeeeee guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=255 ctermbg=60 cterm=NONE
hi doxygenparam guifg=#00ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi doxygensmallspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygenprev guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi perlspecialmatch guifg=#ff5fff guibg=NONE guisp=NONE gui=bold ctermfg=207 ctermbg=NONE cterm=NONE
"ORIG: hi perlspecialmatch guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi cformat guifg=#ff5fff guibg=NONE guisp=NONE gui=bold ctermfg=207 ctermbg=NONE cterm=NONE
"ORIG: hi cformat guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi lcursor guifg=#ffffff guibg=#000000 guisp=#000000 gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi cursorim guifg=#ffffff guibg=#afd7d7 guisp=#afd7d7 gui=bold ctermfg=15 ctermbg=152 cterm=bold
hi doxygenspecialmultilinedesc guifg=#00aa00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi taglisttagname guifg=#808bed guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
hi doxygenbrief guifg=#fdab60 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi mbevisiblenormal guifg=#cfcfcd guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=252 ctermbg=60 cterm=NONE
hi user2 guifg=#7070a0 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=103 ctermbg=60 cterm=NONE
hi user1 guifg=#000000 guibg=#84E12E guisp=#84E12E gui=bold ctermfg=NONE ctermbg=76 cterm=bold
hi doxygenspecialonelinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi doxygencomment guifg=#00ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi cspecialcharacter guifg=#ff5fff guibg=NONE guisp=NONE gui=bold ctermfg=207 ctermbg=NONE cterm=NONE
"ORIG: hi cspecialcharacter guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
"hi clear -- no settings --
hi htmlitalic guifg=#000000 guibg=#90ee90 guisp=#90ee90 gui=NONE ctermfg=NONE ctermbg=120 cterm=NONE
hi htmlboldunderlineitalic guifg=#add8e6 guibg=#000000 guisp=#000000 gui=NONE ctermfg=152 ctermbg=NONE cterm=NONE
hi djangostatement guifg=#005f00 guibg=#ddffaa guisp=#ddffaa gui=NONE ctermfg=22 ctermbg=193 cterm=NONE
hi htmlbolditalic guifg=#000000 guibg=#add8e6 guisp=#add8e6 gui=NONE ctermfg=NONE ctermbg=152 cterm=NONE
hi doctrans guifg=#ffffff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=15 ctermbg=15 cterm=NONE
hi helpnote guifg=#000000 guibg=#ffd700 guisp=#ffd700 gui=NONE ctermfg=NONE ctermbg=220 cterm=NONE
hi htmlunderlineitalic guifg=#90ee90 guibg=#000000 guisp=#000000 gui=NONE ctermfg=120 ctermbg=NONE cterm=NONE
hi doccode guifg=#00aa00 guibg=NONE guisp=NONE gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi docspecial guifg=#4876ff guibg=NONE guisp=NONE gui=NONE ctermfg=69 ctermbg=NONE cterm=NONE
hi htmlbold guifg=#000000 guibg=#efface guisp=#efface gui=NONE ctermfg=NONE ctermbg=230 cterm=NONE
hi htmlboldunderline guifg=#efface guibg=#000000 guisp=#000000 gui=NONE ctermfg=230 ctermbg=NONE cterm=NONE
hi htmlunderline guifg=#d3d3d3 guibg=#000000 guisp=#000000 gui=NONE ctermfg=252 ctermbg=NONE cterm=NONE
hi htmlstatement guifg=#af5f87 guibg=NONE guisp=NONE gui=NONE ctermfg=132 ctermbg=NONE cterm=NONE
hi cterm guifg=#ff5fff guibg=NONE guisp=NONE gui=bold ctermfg=207 ctermbg=NONE cterm=NONE
"ORIG: hi cterm guifg=#efface guibg=#linenr guisp=#linenr gui=NONE ctermfg=230 ctermbg=NONE cterm=NONE
"DISABLE: Gives error because #linenr not defined:  hi gui guifg=#efface guibg=#linenr guisp=#linenr gui=NONE ctermfg=230 ctermbg=NONE cterm=NONE
hi htmllink guifg=#add8e6 guibg=#000000 guisp=#000000 gui=NONE ctermfg=152 ctermbg=NONE cterm=NONE
hi menu guifg=#000000 guibg=#00ffff guisp=#00ffff gui=NONE ctermfg=NONE ctermbg=14 cterm=NONE
hi scrollbar guifg=#008b8b guibg=#00ffff guisp=#00ffff gui=bold ctermfg=30 ctermbg=14 cterm=bold
"hi semicolon -- no settings --
hi browsesuffixes guifg=#cdc8b1 guibg=#1D1F42 guisp=#1D1F42 gui=NONE ctermfg=187 ctermbg=238 cterm=NONE
hi _coperators guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi tooltip guifg=NONE guibg=#ff0000 guisp=#ff0000 gui=NONE ctermfg=NONE ctermbg=196 cterm=NONE
hi unitheader guifg=#000000 guibg=#00ffff guisp=#00ffff gui=bold ctermfg=NONE ctermbg=14 cterm=bold
hi io guifg=#ff0000 guibg=NONE guisp=NONE gui=bold ctermfg=196 ctermbg=NONE cterm=bold
hi communicator guifg=#000000 guibg=#eeee00 guisp=#eeee00 gui=bold ctermfg=NONE ctermbg=11 cterm=bold
hi debugstop guifg=#ffffff guibg=#90ee90 guisp=#90ee90 gui=NONE ctermfg=15 ctermbg=120 cterm=NONE
hi debugbreak guifg=#ffffff guibg=#8b0000 guisp=#8b0000 gui=NONE ctermfg=15 ctermbg=88 cterm=NONE
hi perlsharpbang guifg=#00ff00 guibg=#000000 guisp=#000000 gui=bold ctermfg=10 ctermbg=NONE cterm=bold
hi diffchanged guifg=#00ccff guibg=#000000 guisp=#000000 gui=NONE ctermfg=45 ctermbg=NONE cterm=NONE
hi diffoldline guifg=#00cc00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=40 ctermbg=NONE cterm=NONE
hi doxygenstart guifg=#00ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi perlstatement guifg=#aaaaaa guibg=#000000 guisp=#000000 gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi doxygenstartl guifg=#00ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi diffnewfile guifg=#00cc00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=40 ctermbg=NONE cterm=NONE
hi doxygencommentl guifg=#00aa00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi vimcommenttitle guifg=#00ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi diffadded guifg=#ffaa00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi doxygenparamname guifg=#0000ff guibg=#000000 guisp=#000000 gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi diffoldfile guifg=#00cc00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=40 ctermbg=NONE cterm=NONE
hi doxygenbriefl guifg=#00aa00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi helphypertextjump guifg=#ffaa00" guibg=#000000 guisp=#000000 gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi vimfold guifg=#888888 guibg=#222222 guisp=#222222 gui=NONE ctermfg=102 ctermbg=235 cterm=NONE
hi doxygenbriefline guifg=#00aa00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi diffline guifg=#00ff00 guibg=#000000 guisp=#000000 gui=bold ctermfg=10 ctermbg=NONE cterm=bold
hi doxygenparamdirection guifg=#cccc00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=184 ctermbg=NONE cterm=NONE
hi diffremoved guifg=#ff0000 guibg=#000000 guisp=#000000 gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi perlvarplain guifg=#aaaaaa guibg=#000000 guisp=#000000 gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi perlstatementstorage guifg=#ffffff guibg=#000000 guisp=#000000 gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi rubysharpbang guifg=#8b008b guibg=NONE guisp=NONE gui=NONE ctermfg=90 ctermbg=NONE cterm=NONE
hi perlvarplain2 guifg=#aaaaaa guibg=#000000 guisp=#000000 gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi doxygenargumentword guifg=#0000ff guibg=#000000 guisp=#000000 gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi typedef guifg=#66D9EF guibg=NONE guisp=NONE gui=NONE ctermfg=81 ctermbg=NONE cterm=NONE
hi yamltab guifg=NONE guibg=#FF0000 guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=196 cterm=NONE
hi yamlbasekey guifg=NONE guibg=NONE guisp=NONE gui=bold,underline ctermfg=NONE ctermbg=NONE cterm=bold,underline
hi phpdocblock guifg=#94E1E4 guibg=#050505 guisp=#050505 gui=bold,italic,underline ctermfg=116 ctermbg=232 cterm=bold,underline
hi javaparen2 guifg=#a0c0ff guibg=NONE guisp=NONE gui=NONE ctermfg=153 ctermbg=NONE cterm=NONE
hi javaparen1 guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi javabraces guifg=#406090 guibg=NONE guisp=NONE gui=NONE ctermfg=60 ctermbg=NONE cterm=NONE
hi javaparen guifg=#6080e0 guibg=NONE guisp=NONE gui=NONE ctermfg=68 ctermbg=NONE cterm=NONE
hi javaexternal guifg=#666666 guibg=NONE guisp=NONE gui=NONE ctermfg=241 ctermbg=NONE cterm=NONE
hi javafuncdef guifg=#7080f0 guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi javalangobject guifg=#6080c0 guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi javascopedecl guifg=#8040c0 guibg=NONE guisp=NONE gui=NONE ctermfg=98 ctermbg=NONE cterm=NONE
hi rubyfloat guifg=#8b0000 guibg=NONE guisp=NONE gui=NONE ctermfg=88 ctermbg=NONE cterm=NONE
hi rubypseudovariable guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi rubyinteger guifg=#8b0000 guibg=NONE guisp=NONE gui=NONE ctermfg=88 ctermbg=NONE cterm=NONE
hi rubystringdelimiter guifg=#006400 guibg=NONE guisp=NONE gui=NONE ctermfg=22 ctermbg=NONE cterm=NONE
hi rubysymbol guifg=#008b8b guibg=NONE guisp=NONE gui=NONE ctermfg=30 ctermbg=NONE cterm=NONE
hi rubyinterpolation guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi rubydocumentation guifg=#ffffff guibg=#a9a9a9 guisp=#a9a9a9 gui=NONE ctermfg=15 ctermbg=248 cterm=NONE
hi literal guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
