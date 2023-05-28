local elevatorList = {}

local CheckJob = function(job)
    for i = 1, #job, 1 do
        if ESX.PlayerData.job.name == job[i] then return true end
    end
    return false
end

local TeleportToPoint = function(name)
    local elevators = Config.Elevators
    for k, v in pairs(elevators) do
        for _, data in pairs(v) do
            if data.name == name then
                local coords = data.coords
                DoScreenFadeOut(1000)
                while not IsScreenFadedOut() do
                    Wait(0)
                end
                RequestCollisionAtCoord(coords.x, coords.y, coords.z)
                while not HasCollisionLoadedAroundEntity(cache.ped) do
                    Wait(0)
                end
                SetEntityCoords(cache.ped, coords.x, coords.y, coords.z, false, false, false, false)
                if coords.w then
                    SetEntityHeading(cache.ped, coords.w)
                end
                Wait(700)
                DoScreenFadeIn(1000)
            end
        end
    end
end

local OpenElevatorMenu = function(elevator, data, currentLocation)
    local elements = { { unselectable = true, icon = "fas fa-elevator", title = elevator } }
    for i = 1, #data, 1 do
        if data[i].jobs then
            local job = CheckJob(data[i].jobs)
            if data[i].name ~= currentLocation and job then
                elements[#elements + 1] = { icon = "", title = data[i].title, value = data[i].name }
            end
        else
            if data[i].name ~= currentLocation then
                elements[#elements + 1] = { icon = "", title = data[i].title, value = data[i].name }
            end
        end
    end

    ESX.OpenContext("right", elements, function(menu, element)
        ESX.CloseContext()
        TeleportToPoint(element.value)
    end)
end

local CreateElevators = function()
    for elevator, v in pairs(Config.Elevators) do
        for _, data in pairs(v) do
            local zone = exports.ox_target:addSphereZone({
                coords = data.coords,
                radius = 3,
                options = {
                    {
                        name = data.name,
                        icon = 'fa-solid fa-elevator',
                        label = 'Ascensor',
                        onSelect = function()
                            OpenElevatorMenu(elevator, v, data.name)
                        end
                    }
                }
            })
            elevatorList[#elevatorList + 1] = zone
        end
    end
end

local DeleteElevators = function()
    for i = 1, #elevatorList, 1 do
        if not elevatorList[i] then return end
        exports.ox_target:removeZone(elevatorList[i])
    end
    elevatorList = {}
end

CreateThread(function()
    CreateElevators()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
    CreateElevators()
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
    DeleteElevators()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    DeleteElevators()
end)
