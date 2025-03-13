ESX = nil
QBcore = nil
playerData = nil
PlayerJob = nil
PlayerGrade = nil

local HeistStart = false
local GuardSpawn = {}
local hacking = false

RegisterNetEvent('angelicxs-humanelabs:Notify', function(message, type)
	if Config.UseCustomNotify then
        TriggerEvent('angelicxs-humanelabs:CustomNotify',message, type)
	elseif Config.UseESX then
		ESX.ShowNotification(message)
	elseif Config.UseQBCore then
		QBCore.Functions.Notify(message, type)
	end
end)


CreateThread(function()

    AddRelationshipGroup('HumanePlayers')
    AddRelationshipGroup('HumanePolice')
    AddRelationshipGroup('HumaneGuards')

    if Config.UseESX then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(0)
        end
    
        while not ESX.IsPlayerLoaded() do
            Wait(100)
        end
    
        playerData = ESX.GetPlayerData()
        CreateThread(function()
            while true do
                if playerData ~= nil then
                    PlayerJob = playerData.job.name
                    PlayerGrade = playerData.job.grade
                    break
                end
                Wait(100)
            end
        end)
        RegisterNetEvent('esx:setJob', function(job)
            PlayerJob = job.name
            PlayerGrade = job.grade
        end)

    elseif Config.UseQBCore then

        QBCore = exports['qb-core']:GetCoreObject()
        
        CreateThread(function ()
			while true do
                playerData = QBCore.Functions.GetPlayerData()
				if playerData.citizenid ~= nil then
					PlayerJob = playerData.job.name
					PlayerGrade = playerData.job.grade.level
					break
				end
				Wait(100)
			end
		end)

        RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
            PlayerJob = job.name
            PlayerGrade = job.grade.level
        end)
    end
    
    if Config.StartJobBlip then
		local blip = AddBlipForCoord(Config.StartJobLocation[1],Config.StartJobLocation[2],Config.StartJobLocation[3])
		SetBlipSprite(blip, Config.StartJobIcon)
		SetBlipColour(blip, Config.StartJobColour)
		SetBlipScale(blip, 0.7)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(Config.StartJobText)
		EndTextCommandSetBlipName(blip)
	end
    if Config.UseThirdEye then
        exports[Config.ThirdEyeName]:AddBoxZone("initalhackhumane", vector3(3523.88, 3704.34, 20.99), 1.5, 1.6, {
            name = "initalhackhumane",
            heading = 170.0,
            debugPoly = false,
            minZ = 19.7,
            maxZ = 21.9,
        }, {
            options = {
                {
                event = "angelicxs-humanelabs:starthack",
                icon = 'fas fa-address-card', -- This is the icon that will display next to this trigger option
                label = 'Swipe Card', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
                }
            },
            distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
        })
    end
end)

CreateThread(function()
    while not HeistStart do
        local ped = PlayerPedId()
        local Sleep = 10000
        local dist = #(GetEntityCoords(ped)-vector3(3524.76, 3702.24, 20.99))
        if dist <= 100 then
            Sleep = 1000
            local firstdoor = DoorSystemFindExistingDoor(3525.18, 3702.27, 20.99, 19193616)
            DoorSystemSetDoorState(firstdoor, 1, false, false) -- locked
            if dist <= 10 then
                Sleep = 0
                if Config.Use3DText then
                    local dist2 = #(GetEntityCoords(ped)-vector3(3523.81, 3704.3, 20.99))
                    if dist2 <= 4 then
                        DrawText3Ds(3523.81, 3704.3, 20.99, Config.Lang['swipe'])
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent('angelicxs-humanelabs:starthack')
                        end
                    end
                end
                if hacking then
                    DoorSystemSetDoorState(firstdoor, 0, false, false) -- unlocked
                    HeistStart = true
                end
            end
        end
        Wait(Sleep)
    end
end)

RegisterNetEvent('angelicxs-humanelabs:starthack',function()
    local ped = PlayerPedId()
    local item = false
    item = false
    if Config.UseESX then
        ESX.TriggerServerCallback('angelicxs-humanelabs:SecurityCard:ESX', function(cb) 
            item = cb
        end)                                
    elseif Config.UseQBCore then
        local hasItem = QBCore.Functions.HasItem(Config.LockpickName)
        if hasItem then
            item = true
            QBCore.Functions.TriggerCallback('angelicxs-humanelabs:SecurityCard:QBCore', function(cb))
        end
    end
    Wait(500)
    if item then
        TriggerEvent('angelicxs-humanelabs:SpawnNPCs')
        RequestAnimDict('amb@prop_human_muscle_chin_ups@male@idle_a')
        while not HasAnimDictLoaded('amb@prop_human_muscle_chin_ups@male@idle_a') do
            Wait(10)
        end
        TaskPlayAnim(ped,'amb@prop_human_muscle_chin_ups@male@idle_a','idle_a', 2.0, 8.0, -1, 50, 0, 0, 0, 0)
        Wait (1500)
        ClearPedTasks(ped)
        hacking = true
        TriggerEvent('angelicxs-humanelabs:PoliceDispatch')
    end
end)

RegisterNetEvent('angelicxs-humanelabs:client:relationships',function()
    local ped = PlayerPedId()
    if PlayerJob == Config.LEOJobName then
        SetPedRelationshipGroupHash(ped, GetHashKey("HumanePolice"))
    else
        SetPedRelationshipGroupHash(ped, GetHashKey("HumanePlayers"))
    end
end)


RegisterNetEvent('angelicxs-humanelabs:SpawnNPCs',function()
    local hash = HashGrabber('s_m_m_security_01')
    for i=1, #Config.GuardSpawn do
        local Guard = Config.GuardSpawn[i]
        GuardSpawn[i] = CreatePed(3, hash, Guard.coords[1], Guard.coords[2], (Guard.coords[3]-1), Guard.coords[4], false, true)
        NetworkRegisterEntityAsNetworked(GuardSpawn[i])
		SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(GuardSpawn[i]), true)
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(GuardSpawn[i]), true)
		SetPedArmour(GuardSpawn[i], math.random(70,100))
		SetPedAccuracy(GuardSpawn[i], math.random(70,90))
--		SetEntityInvincible(GuardSpawn[i], false)
--		SetEntityVisible(GuardSpawn[i], true)
		SetEntityAsMissionEntity(GuardSpawn[i])
        GiveWeaponToPed(GuardSpawn[i], GetHashKey(Guard.weapon), 255, false, false)
		SetPedFleeAttributes(GuardSpawn[i], 0, false)	
        SetPedCombatRange(GuardSpawn[i], 2)
        SetPedCombatAttributes(GuardSpawn[i], 0, true)
        SetPedCombatAttributes(GuardSpawn[i], 46, true)
		SetPedRelationshipGroupHash(GuardSpawn[i], GetHashKey("HumaneGuards"))	
		TaskGuardCurrentPosition(GuardSpawn[i], 10.0, 10.0, 1)
    end
    TriggerServerEvent('angelicxs-humanelabs:server:relationships')
    Wait(1000)
    SetRelationshipBetweenGroups(0, GetHashKey("HumaneGuards"), GetHashKey("HumaneGuards"))
	SetRelationshipBetweenGroups(5, GetHashKey("HumaneGuards"), GetHashKey("HumanePlayers"))
	SetRelationshipBetweenGroups(5, GetHashKey("HumanePlayers"), GetHashKey("HumaneGuards"))
    SetRelationshipBetweenGroups(1, GetHashKey("HumaneGuards"), GetHashKey("HumanePolice"))
	SetRelationshipBetweenGroups(1, GetHashKey("HumanePolice"), GetHashKey("HumaneGuards"))
    SetModelAsNoLongerNeeded('s_m_m_security_01')
end)

-- Events
function HashGrabber(model)
    local hash = GetHashKey(model)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
      Wait(10)
    end
    return hash
end

-- 3D Text Functionality
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end