
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

function <SID>TemplateExpandSnippet()
	if exists("*g:FunctionForHeader")
		let l:header = g:FunctionForHeader()
		if l:header != ''
			call <SID>ExpandTemplate('HEADER', g:FunctionForHeader())
		else
			silent! execute '%s/{{HEADER}}//gI'
		endif
	else
		silent! execute '%s/{{HEADER}}//gI'
	endif
	let	l:macro_guard = <SID>PrepareMacro(expand('%:t'))
	let	l:macro_guard_full = <SID>PrepareMacro(@%)

	call <SID>ExpandTemplate('MACRO_GUARD', l:macro_guard)
	call <SID>ExpandTemplate('MACRO_GUARD_FULL', l:macro_guard_full)
	call <SID>ExpandTemplate('FILE', expand('%:t:r'))
	call <SID>ExpandTemplate('CLASS', expand('%:t:r'))
	call <SID>ExpandTemplate('FILEE', expand('%:t'))
	call <SID>ExpandTemplate('FILEF', @%)
	call <SID>ExpandTemplate('FILER', expand('%:p'))
endfunction

function <SID>TemplateExpand()
	normal mm
	call <SID>TemplateExpandSnippet()

	execute ':$d'
	normal `m
	let l:cursor_found = <SID>MoveCursor()

	if !l:cursor_found
		normal `m
	endif
endfunction

command	-nargs=0 TemplateExpandSnippet	:call <SID>TemplateExpandSnippet()
command	-nargs=0 TemplateExpand			:call <SID>TemplateExpand()

function <SID>ExpandTemplateString(str, tmpl, value)
	return substitute(a:str, '{{'. a:tmpl .'}}', a:value, 'g')
endfunction

function TemplateExpandSnippetString(str)
	let	l:macro_guard = <SID>PrepareMacro(expand('%:t'))
	let	l:macro_guard_full = <SID>PrepareMacro(@%)
	let l:new = a:str

	let l:new = <SID>ExpandTemplateString(l:new, 'MACRO_GUARD', l:macro_guard)
	let l:new = <SID>ExpandTemplateString(l:new, 'MACRO_GUARD_FULL', l:macro_guard_full)
	let l:new = <SID>ExpandTemplateString(l:new, 'FILE', expand('%:t:r'))
	let l:new = <SID>ExpandTemplateString(l:new, 'CLASS', expand('%:t:r'))
	let l:new = <SID>ExpandTemplateString(l:new, 'FILEE', expand('%:t'))
	let l:new = <SID>ExpandTemplateString(l:new, 'FILEF', @%)
	let l:new = <SID>ExpandTemplateString(l:new, 'FILER', expand('%:p'))
	return l:new
endfunction
