name "mustache-stashes"
author "mustache_dom"
description "stashes by mustache dom"
fx_version "cerulean"
game "gta5"
version '3.0.0'
ui_page 'web/build/index.html'
client_scripts {
	'client/**.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/**.lua',
}

shared_scripts {
	'@ox_lib/init.lua',
	'shared/**.lua',
}


lua54 'yes'

files {
  'locales/*.lua',
  'web/build/index.html',
  'web/build/**/*'
}
