" autoload/epitech.vim
"
" made by x4m3

" dictionary of the comments styles for supported languages
" 1: first line
" 2: middle lines
" 3: last line
let s:comStyles = {
			\'make': {'1': '##', '2': '##', '3': '##'},
			\'c': {'1': '/*', '2': '**', '3': '*/'},
			\'cpp': {'1': '/*', '2': '**', '3': '*/'},
			\'python': {'1': '#!/usr/bin/env python3\n##', '2': '##', '3': '##'},
			\}

" quotes to insert in file_description
let s:quotes = [
			\"try not to segfault, good luck :)",
			\"hello world?",
			\"programmers start to count from 0",
			\"man man",
			\"vim-epitech made by x4m3",
			\"https://github.com/x4m3/vim-epitech",
			\"echo $?",
			\"don't forget to free at the end",
			\"check your malloc!",
			\"segmentation fault (core dumped)",
			\"you're a bad developer",
			\"csfml is the best thing ever",
			\"vim > emacs",
			\"xkcd.com/378",
			\"hey. real programmers use vim",
			\"well, real programmers use ed",
			\"no, real programmers use cat",
			\"r/ProgrammerHumor",
			\"rm -rf --no-preserve-root /",
			\"example of bad code:",
			\"01100010 01101001 01101110 01100001 01110010 01111001",
			\"fireplace 4k",
			\"epitech < 42",
			\"epitech > epita",
			\"code on paper!",
			\"if you code on paper, you're not a real programmer",
			\"C-x C-c",
			\":wq",
			\"M-x doctor",
			\"there's a problem: the intra is not down",
			\]

" check if current filetype is supported
function! s:CheckFiletype()
	" check dictionary for current filetype
	return has_key(s:comStyles, &filetype)
endfunction

" function to prompt user for file description
function! s:InputFileDescription()
	" call inputsave() to prompt user for input
	" call inputrestore() to finish user prompt

	let currentSecond = strftime('%S') / 2
	let file_description = s:quotes[currentSecond]
	return file_description
endfunction

" function to get current year
function! s:GetCurrentYear()
	let currentYear = strftime("%Y")
	return currentYear
endfunction

" function to insert the epitech header
function AddTekHeader()
	" if checkFiletype() fails, return error
	if !s:CheckFiletype()
		echoerr "Unsupported filetype for Epitech header: " . &filetype
		return
	endif

	let l:com1 = s:comStyles[&filetype]['1']
	let l:com2 = s:comStyles[&filetype]['2']
	let l:com3 = s:comStyles[&filetype]['3']

	let l:let = l:com1 .'\r'.
	\l:com2 . " EPITECH PROJECT, " .
	\s:GetCurrentYear() .'\r'.
	\l:com2 . " " .
	\expand('%:r') .'\r'.
	\l:com2 . " File description:" .'\r'.
	\l:com2 . " " . s:InputFileDescription() .'\r'.
	\l:com3
	return l:let
endfunction

command	-nargs=0 AddTekHeader	:call AddTekHeader()
