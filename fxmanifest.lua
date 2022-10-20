fx_version 'cerulean'

game 'gta5'
lua54 'yes'

author 'Dalkoe of Koe Scripts'
description 'Vendor system for buying and selling goods with XP system.'
version '1.0.0'


client_scripts {
	'client.lua',
	'config.lua'
 }
 
 server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
	'config.lua'
 }


server_export 'getCrimLevel'
server_export 'giveCrimLevel'
server_export 'setCrimlevel'

server_export 'getCivLevel'
server_export 'giveCivLevel'
server_export 'setCivLevel'


shared_script '@ox_lib/init.lua'
shared_script '@es_extended/imports.lua'