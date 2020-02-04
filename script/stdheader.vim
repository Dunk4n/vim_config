" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    stdheader.vim                                      :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: zaz <zaz@staff.42.fr>                      +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2013/06/15 12:45:56 by zaz               #+#    #+#              "
"    Updated: 2020/02/04 15:15:32 by niduches         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "


let s:asciiart = [
			\"        :::      ::::::::",
			\"      :+:      :+:    :+:",
			\"    +:+ +:+         +:+  ",
			\"  +#+  +:+       +#+     ",
			\"+#+#+#+#+#+   +#+        ",
			\"     #+#    #+#          ",
			\"    ###   ########.fr    "
			\]

let s:styles = [
			\{
			\'extensions': ['\.c$', '\.h$', '\.cc$', '\.hh$', '\.cpp$', '\.hpp$'],
			\'start': '/*', 'end': '*/', 'fill': '*'
			\},
			\{
			\'extensions': ['\.htm$', '\.html$', '\.xml$'],
			\'start': '<!--', 'end': '-->', 'fill': '*'
			\},
			\{
			\'extensions': ['\.js$'],
			\'start': '//', 'end': '//', 'fill': '*'
			\},
			\{
			\'extensions': ['\.tex$'],
			\'start': '%', 'end': '%', 'fill': '*'
			\},
			\{
			\'extensions': ['\.ml$', '\.mli$', '\.mll$', '\.mly$'],
			\'start': '(*', 'end': '*)', 'fill': '*'
			\},
			\{
			\'extensions': ['\.vim$', 'vimrc$', '\.myvimrc$', 'vimrc$'],
			\'start': '"', 'end': '"', 'fill': '*'
			\},
			\{
			\'extensions': ['\.el$', '\.emacs$', '\.myemacs$'],
			\'start': ';', 'end': ';', 'fill': '*'
			\},
			\{
			\'extensions': ['\.f90$', '\.f95$', '\.f03$', '\.f$', '\.for$'],
			\'start': '!', 'end': '!', 'fill': '/'
			\}
			\]

let s:linelen		= 80
let s:marginlen		= 5
let s:contentlen	= s:linelen - (3 * s:marginlen - 1) - strlen(s:asciiart[0])

function s:trimlogin ()
	let l:trimlogin = strpart($USER, 0, 9)
	if strlen(l:trimlogin) == 0
		let l:trimlogin = "marvin"
	endif
	return l:trimlogin
endfunction

function s:trimemail ()
	let l:trimemail = strpart($MAIL, 0, s:contentlen - 16)
	if strlen(l:trimemail) == 0
		let l:trimemail = "marvin@42.fr"
	endif
	return l:trimemail
endfunction

function s:midgap ()
	return repeat(' ', s:marginlen - 1)
endfunction

function s:lmargin ()
	return repeat(' ', s:marginlen - strlen(s:start))
endfunction

function s:rmargin ()
	return repeat(' ', s:marginlen - strlen(s:end))
endfunction

function s:empty_content ()
	return repeat(' ', s:contentlen)
endfunction

function s:left ()
	return s:start . s:lmargin()
endfunction

function s:right ()
	return s:rmargin() . s:end
endfunction

function s:bigline ()
	return s:start . ' ' . repeat(s:fill, s:linelen - 2 - strlen(s:start) - strlen(s:end)) . ' ' . s:end
endfunction

function s:logo1 ()
	return s:left() . s:empty_content() . s:midgap() . s:asciiart[0] . s:right()
endfunction

function s:fileline ()
	let l:trimfile = strpart(fnamemodify(bufname('%'), ':t'), 0, s:contentlen)
	return s:left() . l:trimfile . repeat(' ', s:contentlen - strlen(l:trimfile)) . s:midgap() . s:asciiart[1] . s:right()
endfunction

function s:logo2 ()
	return s:left() . s:empty_content() . s:midgap() .s:asciiart[2] . s:right()
endfunction

function s:coderline ()
	let l:contentline = "By: ". s:trimlogin () . ' <' . s:trimemail () . '>'
	return s:left() . l:contentline . repeat(' ', s:contentlen - strlen(l:contentline)) . s:midgap() . s:asciiart[3] . s:right()
endfunction

function s:logo3 ()
	return s:left() . s:empty_content() . s:midgap() .s:asciiart[4] . s:right()
endfunction

function s:dateline (prefix, logo)
	let l:date = strftime("%Y/%m/%d %H:%M:%S")
	let l:contentline = a:prefix . ": " . l:date . " by " . s:trimlogin ()
	return s:left() . l:contentline . repeat(' ', s:contentlen - strlen(l:contentline)) . s:midgap() . s:asciiart[a:logo] . s:right()
endfunction

function s:createline ()
	return s:dateline("Created", 5)
endfunction

function s:updateline ()
	return s:dateline("Updated", 6)
endfunction

function s:emptyline ()
	return s:start . repeat(' ', s:linelen - strlen(s:start) - strlen(s:end)) . s:end
endfunction

function s:filetype ()
	let l:file = fnamemodify(bufname("%"), ':t')

	let s:start = '#'
	let s:end = '#'
	let s:fill = '*'

	for l:style in s:styles
		for l:ext in l:style['extensions']
			if l:file =~ l:ext
				let s:start = l:style['start']
				let s:end = l:style['end']
				let s:fill = l:style['fill']
			endif
		endfor
	endfor
endfunction

function Insert42Header ()
	call s:filetype ()

	let l:ret = s:bigline() . '\r' . s:emptyline() . '\r' .
				\s:logo1() . '\r' .
				\s:fileline() . '\r' .
				\s:logo2() . '\r' .
				\s:coderline() . '\r' .
				\s:logo3() . '\r' .
				\s:createline() . '\r' .
				\s:updateline() . '\r' .
				\s:emptyline() . '\r' .
				\s:bigline()
	return l:ret
endfunction

function s:update ()
	call s:filetype ()

	let l:pattern = s:start . repeat(' ', 5 - strlen(s:start)) . "Updated: [0-9]"
	let l:pos = search(l:pattern, 'n')

	if l:pos == 0
		return
	endif
	let l:line = getline(l:pos)
	if l:line =~ l:pattern
		call setline(l:pos, s:updateline())
	endif
endfunction

autocmd BufWritePre * call s:update ()
