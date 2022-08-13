fx_version 'adamant'

game 'gta5'

version '1.0.0'
lua54 'yes'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
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