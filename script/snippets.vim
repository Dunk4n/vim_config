function GetPosStrInStr(str, to_find)
	let l:ret = stridx(a:str, '{{CURSOR}}')
	let l:pos = [0, 0, 0]
	if l:ret == -1
		let l:pos[2] = -1
		let l:ret = strlen(a:str)
	endif
	let l:idx = 0
	while l:idx < l:ret
		if a:str[l:idx] == "\n"
			let l:pos[0] += 1
			let l:pos[1] = 0
		else
			let l:pos[1] += 1
		endif
		let l:idx += 1
	endwhile
	return l:pos
endfunction

function PutSnippet(name)
	let l:lineno = line('.')
	let l:colno = col('.')
	let l:file = join(readfile(a:name), "\n")
	let l:file = TemplateExpandSnippetString(l:file)
	let l:pos = GetPosStrInStr(l:file, '{{CURSOR}}')
	let l:file = substitute(l:file, '{{CURSOR}}', '', '')
	set paste
	if l:pos[2] == -1
		exec ':normal i' . l:file
		call cursor(l:lineno + l:pos[0], l:pos[1] + 1)
		set nopaste
		return ''
	endif

	exec ':normal i' . l:file
	set nopaste
	if l:pos[0] > 0
		call cursor(l:lineno + l:pos[0], l:pos[1] + 1)
	else
		call cursor(l:lineno + l:pos[0], l:colno + l:pos[1])
	endif
	return ''
endfunction

iabbrev MAIN <C-R>=PutSnippet($MYPWD.'/snippets/main.snippet')<CR>
iabbrev MAINE <C-R>=PutSnippet($MYPWD.'/snippets/main_env.snippet')<CR>
iabbrev IF <C-R>=PutSnippet($MYPWD.'/snippets/if.snippet')<CR>
iabbrev IFE <C-R>=PutSnippet($MYPWD.'/snippets/ife.snippet')<CR>
iabbrev IFEL <C-R>=PutSnippet($MYPWD.'/snippets/ifel.snippet')<CR>
iabbrev IFELE <C-R>=PutSnippet($MYPWD.'/snippets/ifele.snippet')<CR>
iabbrev WHILE <C-R>=PutSnippet($MYPWD.'/snippets/while.snippet')<CR>
iabbrev FOR <C-R>=PutSnippet($MYPWD.'/snippets/for.snippet')<CR>
