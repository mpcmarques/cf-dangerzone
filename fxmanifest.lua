fx_version 'cerulean'
game 'gta5'
author 'Codex Factory'
name 'CF - Danger Zone'
version "1.0"

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

lua54 'yes'

file {
    'server/model/**/*.lua',
    'locales/*'
}

dependencies {
    'ox_lib'
}
