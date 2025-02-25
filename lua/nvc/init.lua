require( 'nvc.gen_obj' )

require( 'nvc.gen_obj' ).load_project()

vim.api.nvim_create_user_command(
	'NVCGenObj',
	function( opts )
		local object_name = opts.args
		require( 'nvc.gen_obj' ).generate_object( object_name )
	end,
	{ nargs = 1 }
)
