name "mustache-stashes"
author "mustache_dom"
description "stashes by mustache dom"
fx_version "cerulean"
game "gta5"
version '2.2.0'

client_scripts {
	'client/**.lua',
}
server_scripts {
	'server/**.lua',
}
shared_scripts {
    'shared/**.lua',
	 '@ox_lib/init.lua',
}

lua54 'yes'

