name 'mustache-stashes'
author 'mustache_dom'
version '3.0.0'
description 'Stashes by mustache dom'
fx_version 'cerulean'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
game 'gta5'

ui_page 'web/build/index.html' -- thanks @ThatMadCaptain for the help with this :)

client_scripts {
	'client/**.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
  'server/**.lua',
}

shared_scripts {
	'shared/**.lua',
}

files {
  'locales/*.lua',
  'web/build/index.html',
  'web/build/**/*'
}
