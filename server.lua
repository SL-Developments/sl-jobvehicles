local SLCore = exports[Config.CoreName]:GetCoreObject()

RegisterNetEvent('sl-jobvehicles:server:buyvehicle')
AddEventHandler('sl-jobvehicles:server:buyvehicle', function(mods, vehicle, hash, plate, carid, price, method)
    local src = source
    local Player = SLCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData
    
    if Player.Functions.RemoveMoney(method, price) then
        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehicle,
            hash,
            json.encode(mods),
            plate,
            0
        })
        TriggerClientEvent('SLCore:Notify', src, 'Vehicle Successfully Add To Your Grage', "success")  
    else
        TriggerClientEvent("SLCore:Notify", src, Config.lang.nomoney, "error")
    end
end)