fx_version 'cerulean'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
game 'gta5'

name 'mustache-stashes'
author 'mustache_dom'
version '3.1.1'
description 'Stashes by mustache dom'

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

files {
  'locales/*.lua',
  'web/build/index.html',
  'web/build/**/*'
}
