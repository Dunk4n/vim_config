
function <SID>GetComplementaryFile()
	let l:extention = expand('%:e')

	if l:extention == ''
		let l:filename = expand('%:r') . '.'
		if filereadable(l:filename.'hpp')
			execute "e ".l:filename.'hpp'
		elseif filereadable(l:filename.'h')
			execute "e ".l:filename.'h'
		elseif filereadable(l:filename.'cpp')
			execute "e ".l:filename.'cpp'
		elseif filereadable(l:filename.'c')
			execute "e ".l:filename.'c'
		endif
		return
	elseif l:extention == 'hpp'
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
	if filereadable(l:filename)
		execute "e ".l:filename
	endif
endfunction

command	-nargs=0 ToComplementaryFile	:call <SID>GetComplementaryFile()

if exists(g:KeyToComplementaryFile)
	let g:KeyToComplementaryFile = '<TAB>'
endif

execute 'map' . g:KeyToComplementaryFile . ' :ToComplementaryFile<CR>'
