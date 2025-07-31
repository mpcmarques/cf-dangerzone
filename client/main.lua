local inZones = {}
local blips = {}

local toFloat = '%f'

local removeBlip = function(name)
    if blips[name] then
        RemoveBlip(blips[name].blip)
        blips[name]:remove()
        blips[name] = nil
    end
end

local createBlip = function(data)
    if blips[data.name] then
        removeBlip(data.name)
    end

    local blip = AddBlipForRadius(data.location.x, data.location.y, data.location.z,
        tonumber(toFloat:format(data.radius)))

    SetBlipHighDetail(blip, true)
    SetBlipColour(blip, 1)
    SetBlipAlpha(blip, 128)

    blips[data.name] = lib.points.new({
        key = data.name,
        blip = blip,
        coords = vec3(data.location.x, data.location.y, data.location.z),
        distance = data.radius,
        onEnter = function(self)
            inZones[self.key] = true
        end,
        onExit = function(self)
            inZones[self.key] = nil
        end
    })
end

exports('inZone', function()
    return next(inZones) ~= nil
end)

RegisterNetEvent('cf-dangerzone:new', function(data)
    createBlip(data)
end)

RegisterNetEvent('cf-dangerzone:remove', function(name)
    removeBlip(name)
end)

RegisterNetEvent('cf-dangerzone:updateAll', function(data)
    for _, v in pairs(data) do
        createBlip(v)
    end
end)
