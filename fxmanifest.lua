fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'
version "ALPHA"
client_scripts{ 
"client/*.lua", 
}

server_script { 
    '@oxmysql/lib/MySQL.lua',
    "server/*.lua"
}
shared_scripts {
    '@ox_lib/init.lua',
    "config.lua",
}

requires{
    'ox_lib',
    'oxmysql',
    'esx_addonaccount'
}