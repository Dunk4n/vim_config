
function <SID>GetComplementaryFile()
	let l:extention = expand('%:e')

	if l:extention == 'hpp'
		let l:newExtention = 'cpp'
	elseif l:extention == 'h'
		let l:newExtention = 'c'
	elseif l:extention == 'cpp'
		let l:newExtention = 'hpp'
	elseif l:extention == 'c'
		let l:newExtention = 'h'
	else
		return
	endif
	let l:filename = expand('%:r') . '.' . l:newExtention
	execute "e ".l:filename
endfunction

command	-nargs=0 ToComplementaryFile	:call <SID>GetComplementaryFile()

if exists(g:KeyToComplementaryFile)
	let g:KeyToComplementaryFile = '<TAB>'
endif

execute 'map' . g:KeyToComplementaryFile . ' :ToComplementaryFile<CR>'
