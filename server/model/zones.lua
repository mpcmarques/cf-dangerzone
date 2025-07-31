local DangerZones = lib.class("DangerZone")

function DangerZones:constructor()
    self.zones = {}
end

function DangerZones:add(name, location, radius)
    self.zones[name] = {
        name = name,
        location = location,
        radius = type(radius) == "number" and radius or tonumber(radius)
    }

    TriggerClientEvent('cf-dangerzone:new', -1, self.zones[name])
end

function DangerZones:remove(name)
    if not self.zones[name] then return end

    self.zones[name] = nil

    TriggerClientEvent('cf-dangerzone:remove', -1, name)
end

function DangerZones:getZones()
    return self.zones
end

function DangerZones:reset()
    self.zones = {}
end

function DangerZones:get(name)
    return self.zones[name]
end

return DangerZones:new()
