
if	exists('g:script_template_loaded')
	finish
endif

let	g:script_template_loaded = 1

function <SID>EscapeTemplate(tmpl)
	return escape(a:tmpl, '/')
endfunction

function <SID>ExpandTemplate(tmpl, value)
	silent! execute '%s/{{'. <SID>EscapeTemplate(a:tmpl) .'}}/'. <SID>EscapeTemplate(a:value) .'/gI'
endfunction

function <SID>PrepareMacro(str)
	return toupper(tr(a:str, '/.-', '___'))
endfunction

function <SID>ExpandMacroTemplate()
	let	l:macro_guard = <SID>PrepareMacro(expand('%:t'))
	let	l:macro_guard_full = <SID>PrepareMacro(@%)

	call <SID>ExpandTemplate('MACRO_GUARD', l:macro_guard)
	call <SID>ExpandTemplate('MACRO_GUARD_FULL', l:macro_guard_full)
endfunction

function <SID>MoveCursor()
	normal gg
    if (search('{{CURSOR}}', 'W'))
        let l:lineno = line('.')
        let l:colno = col('.')
		s/{{CURSOR}}//
		startinsert
		call cursor(l:lineno, l:colno)
		return 1
	endif
	return 0
endfunction

function <SID>TemplateExpand()
	normal mm
	if exists("*g:FunctionForHeader")
		call <SID>ExpandTemplate('HEADER', g:FunctionForHeader())
	else
		call <SID>ExpandTemplate('HEADER', '')
	endif
	call <SID>ExpandMacroTemplate()
	call <SID>ExpandTemplate('FILE', expand('%:t:r'))
	call <SID>ExpandTemplate('CLASS', expand('%:t:r'))
	call <SID>ExpandTemplate('FILEE', expand('%:t'))
	call <SID>ExpandTemplate('FILEF', @%)
	call <SID>ExpandTemplate('FILER', expand('%:p'))

	execute ':$d'
	normal `m
	let l:cursor_found = <SID>MoveCursor()

	if !l:cursor_found
		normal `m
	endif
endfunction

command	-nargs=0 TemplateExpand		:call <SID>TemplateExpand()
