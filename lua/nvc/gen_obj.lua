local M = {}

M.dir = '/'
M.dir_inc = M.dir .. 'inc/'
M.dir_src = M.dir .. 'src/'
M.user = vim.fn.system( 'git config user.name' ):gsub('%s+', '')
M.email = vim.fn.system( 'git config user.email' ):gsub('%s+', '')

function M.load_project()
	M.dir = vim.fn.getcwd()
	M.dir_inc = M.dir .. '/inc/'
	M.dir_src = M.dir .. '/src/'
end

function M.generate_object( object_name )
	vim.fn.mkdir( dir_inc, 'p' )
	vim.fn.mkdir( dir_src, 'p' )

	local inc_file = M.dir_inc .. object_name .. '.h';
	local src_file = M.dir_src .. object_name .. '.c';

	local inc_file_dat = [[
/********************************************************************
	Author           : ]] .. M.user .. [[ 
	Email            : ]] .. M.email .. [[ 
	Editor           : ]] .. M.user .. [[ 
	Created at       : ]] .. os.date( '%Y/%m/%d' ) .. [[ 
	Last modified at : ]] .. os.date( '%Y/%m/%d %H:%M' ) .. [[ by ]] .. M.user .. [[ 
********************************************************************/

#ifndef ]] .. object_name:upper() .. [[_H
#define ]] .. object_name:upper() .. [[_H

/* Code comes here */

#endif // ]] .. object_name:upper() .. [[_H 
]]

	local src_file_dat = [[
#include "]] .. object_name .. [[.h"

/* Code comes here */ 
]]

	local header_file = io.open( inc_file, 'w' )
	if header_file then
		header_file:write( inc_file_dat )
		header_file:close()
	else
		print( 'Failed to create ' .. inc_file )
		return
	end

	local source_file = io.open( src_file, 'w' )
	if source_file then
		source_file:write( src_file_dat )
		source_file:close()
	else
		print( 'Failed to create ' .. src_file )
		return
	end

	print( '"' .. object_name .. '" object generated:' )
	print( ' - ' .. inc_file )
	print( ' - ' .. src_file )
end

return M
