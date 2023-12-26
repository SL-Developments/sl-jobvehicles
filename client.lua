SLCore = exports[Config.CoreName]:GetCoreObject()

local display = false
local PlayerData = {}

RegisterNetEvent(Config.ServerPrefix..':Client:OnPlayerLoaded')
AddEventHandler(Config.ServerPrefix..':Client:OnPlayerLoaded', function()
    PlayerData = SLCore.Functions.GetPlayerData()
end)

RegisterNetEvent(Config.ServerPrefix..':Client:OnJobUpdate')
AddEventHandler(Config.ServerPrefix..':Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    local found = false
    for k, v in pairs(Config.Garages) do
        if k == PlayerData.job.name then
            found = true
        end
    end
    if not found then
        SetDisplay(false)
    end
end) 

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
		PlayerData = SLCore.Functions.GetPlayerData()
    end
end)

RegisterCommand("opentest", function(source, args)
    if checkAuthorized() then
        SetDisplay(not display)
    end
end)

RegisterNUICallback("exit", function()
    SetDisplay(false)
end)

RegisterNUICallback("buyvehicle", function(car, method)
    SetDisplay(false)
    local PlayerData = SLCore.Functions.GetPlayerData()
    print(car.method)
    local vehicle = Config.Garages[PlayerData.job.name].Vehicles[car.id].model
    local price = Config.Garages[PlayerData.job.name].Vehicles[car.id].price
    local method = car.method
    if method == "cash" then
        if price <= PlayerData.money.cash then
            print(price)
            print(PlayerData.money.cash)
            SLCore.Functions.SpawnVehicle(vehicle, function(veh)
                local props = SLCore.Functions.GetVehicleProperties(veh)
                SetVehicleNumberPlateText(veh, Config.Garages[PlayerData.job.name].plateStart .. tostring(math.random(10000, 99999)))
                Config.Fuel(veh, 100.0)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", SLCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
                TriggerServerEvent("sl-jobvehicles:server:buyvehicle", props, vehicle, GetHashKey(veh), SLCore.Functions.GetPlate(veh), car.id, price, method)
            end, Config.Garages[PlayerData.job.name].spawnLocation, true)
        else
            SLCore.Functions.Notify(Config.lang.nomoney, "error")
    end
    elseif method == "bank" then
        if price <= PlayerData.money.bank then
            print(price + PlayerData.money.bank)
        SLCore.Functions.SpawnVehicle(vehicle, function(veh)
            local props = SLCore.Functions.GetVehicleProperties(veh)
            SetVehicleNumberPlateText(veh, Config.Garages[PlayerData.job.name].plateStart ..tostring(math.random(10000, 99999)))
            Config.Fuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", SLCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            TriggerServerEvent("sl-jobvehicles:server:buyvehicle", props, vehicle, GetHashKey(veh), SLCore.Functions.GetPlate(veh), car.id, price, method)
             end, Config.Garages[PlayerData.job.name].spawnLocation, true)
        else
            SLCore.Functions.Notify(Config.lang.nomoney, "error")
        end
    else
        SLCore.Functions.Notify("Error occured", "error")
    end
end)

function checkAuthorized()
    local found = false
    for k, v in pairs(Config.Garages) do
        if k == PlayerData.job.name then
            found = true
        end
    end
    return found
end

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    if not bool then
        SendNUIMessage({
            type = "ui",
            status = bool,
        })
    elseif bool then
        SendNUIMessage({
            type = "ui",
            status = bool,
            vehicles = Config.Garages[PlayerData.job.name].Vehicles,
            name = "Welcome, " ..PlayerData.job.grade.name.. ' ' ..PlayerData.charinfo.lastname:sub(1,1):upper()..PlayerData.charinfo.lastname:sub(2),
            garagename = Config.Garages[PlayerData.job.name].garageName,
            logo = Config.Garages[PlayerData.job.name].logo
        })
    end
end

RegisterNetEvent("sl-jobvehicles:opengarage", function()
    if checkAuthorized() then
        SetDisplay(true)
    end
end)

CreateThread(function()
    for k,v in pairs(Config.Garages) do
        print(k)
        exports[Config.TargetName]:SpawnPed({
            model = v.ped,
            coords = v.buyVehicleLocationPed,
            minusOne = true,
            invincible = true,
            blockevents = true,
            freeze = true,
            animDict = 'abigail_mcs_1_concat-0',
            anim = 'csb_abigail_dual-0',
            flag = 1,
            scenario = 'WORLD_HUMAN_CLIPBOARD',
            spawnNow = Config.firstinstall, --Change to true only on first install!!!
            target = {
              options = {
                {
                    type = "client",
                    event = "sl-jobvehicles:opengarage",
                    icon = "fa-solid fa-warehouse",
                    label = "Open Garage",
                    job = k,
                },
              },
              distance = 2.5,
            },
            currentpednumber = 0,
          })
    end
end)