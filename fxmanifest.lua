fx_version 'adamant'

game 'gta5'

author 'BY SL Developments'
description 'sl-jobvehicles made by SL Developments'

version '1.0.0'

ui_page 'html/index.html'

shared_script {
    'config.lua',
}


client_script {
    'client.lua',
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
}

files {
    'html/**/*.*',
    'html/*.*',
}

escrow_ignore {
    'server.lua',
    'config.lua'
}

lua54 'yes'