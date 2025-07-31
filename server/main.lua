local QBCore = exports['qb-core']:GetCoreObject()
local DangerZones = require "server.model.zones"

lib.locale()

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DangerZones:reset()
    end
end)

AddEventHandler('rp_dangerzone:new', function(name, location, radius)
    DangerZones:add(name, location, radius)
end)

AddEventHandler('rp_dangerzone:remove', function(name)
    DangerZones:remove(name)
end)

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local _source = source
    local player = QBCore.Functions.GetPlayer(_source)

    if player then
        TriggerLatentClientEvent("cf-dangerzone:updateAll", _source, 1000, DangerZones:getZones())
    end
end)

lib.addCommand("createdangerzone", {
    help = "Creates a Danger Blip",
    restricted = 'group.admin',
    params = {
        {
            name = 'name',
            help = 'Name',
            type = 'string',
            optional = false
        },
        {
            name = 'radius',
            help = 'Radius',
            type = 'number'
        },
    },
}, function(source, args)
    if source == 0 then return end

    if not args.name then return end

    local ped = GetPlayerPed(source)
    local location = GetEntityCoords(ped)

    DangerZones:add(args.name, location, args.radius or 100.0)
end)

lib.addCommand("1010", {
    help = "Creates a 1010 zone (danger zone)",
    params = {
        {
            name = 'radius',
            help = 'Zone radius, optional (default = 100)',
            type = 'number'
        },
    },
}, function(source, args)
    if source == 0 then return end

    local ped = GetPlayerPed(source)
    local location = GetEntityCoords(ped)

    local player = QBCore.Functions.GetPlayer(source)

    if not player then return end

    if player.PlayerData?.job?.name ~= 'police' then
        TriggerClientEvent("QBCore:Notify", source, locale("only_police_allowed"), "error")
        return
    end

    if DangerZones:get(player.PlayerData.citizenid) then
        DangerZones:remove(player.PlayerData.citizenid)
        Wait(100)
    end

    DangerZones:add(player.PlayerData.citizenid, location, args.radius or 100.0)
end)

lib.addCommand("removedangerzone", {
    help = "Removes a Danger Blip",
    restricted = 'group.admin',
    params = {
        {
            name = 'name',
            help = 'Name',
            type = 'string',
            optional = false
        },
    },
}, function(source, args)
    if source == 0 then return end

    if not args.name then return end

    DangerZones:remove(args.name)
end)

lib.addCommand("remove1010", {
    help = "Removes a 1010 zone",
}, function(source)
    if source == 0 then return end

    local player = QBCore.Functions.GetPlayer(source)

    if not player then return end

    if player.PlayerData?.job?.name ~= 'police' then
        TriggerClientEvent("QBCore:Notify", source, locale("only_police_allowed"), "error")
        return
    end

    DangerZones:remove(player.PlayerData.citizenid)
end)
