fx_version 'adamant'
lua54 'yes'
game 'gta5'

description 'Garny Elevator'
version '1.0.0'

client_scripts {
    'client.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

dependencies {
    'es_extended',
    'esx_context',
    'ox_lib'
}
