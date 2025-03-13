Config = {}


Config.UseESX = true						-- Use ESX Framework
Config.UseQBCore = false					-- Use QBCore Framework (Ignored if Config.UseESX = true)

Config.UseCustomNotify = false				-- Use a custom notification script, must complete event below.

-- Only complete this event if Config.UseCustomNotify is true; mythic_notification provided as an example
RegisterNetEvent('angelicxs-VINscratch:CustomNotify')
AddEventHandler('angelicxs-VINscratch:CustomNotify', function(message, type)
    --exports.mythic_notify:SendAlert(type, message, 4000)
end)
-- Visual Preference
Config.Use3DText = false 					-- Use 3D text for interactions; only turn to false if Config.UseThirdEye is turned on and IS working.
Config.UseThirdEye = true 					-- Enables using a third eye (third eye requires the following arguments debugPoly, useZ, options {event, icon, label}, distance)
Config.ThirdEyeName = 'qb-target' 			-- Name of third eye aplication

-- Item Requirement
Config.SecurityCardName = 'security_card_03'		-- Name of the iteme used to start heist 
Config.RemoveSecurityCardName = true				-- If true will remove Config.SecurityCardName upon use

RegisterNetEvent('angelicxs-humanelabs:PoliceDispatch')
AddEventHandler('angelicxs-humanelabs:PoliceDispatch', function()
    --Add prefered method of police dispatch here, event is triggered when the security card is used.
end)

Config.GuardSpawn = {
	[1] = {	coords = {3531.16, 3672.66, 20.99, 75.22},	weapon = 'weapon_pistol'}, --p
	[2] = {	coords = {3529.43, 3674.56, 28.12, 252.33},	weapon = 'weapon_pistol'},
	[3] = {	coords = {3528.73, 3671.86, 28.12, 261.55},	weapon = 'weapon_pistol'},
	[4] = {	coords = {3539.37, 3665.61, 28.12, 355.57},	weapon = 'weapon_pistol'},
	[5] = {	coords = {3529.65, 3650.41, 27.52, 349.59},	weapon = 'weapon_pistol'},
	[6] = {	coords = {3553.14, 3656.32, 28.12, 94.98},	weapon = 'weapon_pistol'}, --s
	[7] = {	coords = {3551.39, 3663.82, 28.13, 171.79},	weapon = 'weapon_pistol'},
	[8] = {	coords = {3560.47, 3675.23, 28.12, 127.18},	weapon = 'weapon_pistol'},
	[9] = {	coords = {3561.02, 3668.31, 28.12, 37.74},	weapon = 'weapon_pistol'},
	[10] = {coords = {3559.02, 3678.69, 28.12, 170.74},	weapon = 'weapon_pistol'},
	[11] = {coords = {3562.82, 3689.41, 28.12, 244.8},	weapon = 'weapon_pistol'},
	[12] = {coords = {3563.67, 3690.96, 28.12, 244.18},	weapon = 'weapon_pistol'},
	[13] = {coords = {3561.96, 3690.35, 28.12, 229.02},	weapon = 'weapon_pistol'},
	[14] = {coords = {3559.46, 3696.03, 30.12, 257.11},	weapon = 'weapon_pistol'},
	[15] = {coords = {3585.4, 3686.1, 27.62, 10.34},	weapon = 'weapon_pistol'},
	[16] = {coords = {3602.69, 3689.01, 28.82, 53.2},	weapon = 'weapon_pistol'}, --s
	[17] = {coords = {3590.41, 3714.23, 29.69, 203.05},	weapon = 'weapon_pistol'},
	[18] = {coords = {3596.75, 3712.63, 29.69, 120.65},	weapon = 'weapon_pistol'},
	[19] = {coords = {3596.77, 3722.91, 29.69, 144.65},	weapon = 'weapon_pistol'},
	[20] = {coords = {3604.25, 3710.21, 29.69, 146.51},	weapon = 'weapon_pistol'},
	[21] = {coords = {3612.07, 3716.45, 29.69, 136.72},	weapon = 'weapon_pistol'},

}























-- Visual Preference
Config.Use3DText = false 					-- Use 3D text for interactions; only turn to false if Config.UseThirdEye is turned on and IS working.
Config.UseThirdEye = true 					-- Enables using a third eye (third eye requires the following arguments debugPoly, useZ, options {event, icon, label}, distance)
Config.ThirdEyeName = 'qb-target' 			-- Name of third eye aplication

-- Item Requirement
Config.NeedsLockpick = true 				-- If true will require players to have Config.LockpickName in order to break into vehicle (seperate from any key systems).
Config.LockpickName = 'lockpick'			-- Name of the lockpicking device used if Config.NeedsLockpick = true 
Config.RemoveLockpick = true				-- If true will remove Config.LockpickName upon use when Config.NeedsLockpick = true

--LEO Configuration
Config.RequireMinimumLEO = true 			-- When on will require a minimum number of LEOs to be available to start robbery
Config.RequiredNumberLEO = 2 				-- Minimum number of LEO needed for robbery to start when Config.RequireMinimumLEO = true
Config.LEOJobName = 'police' 				-- Job name of law enforcement officers
Config.LEOScratches = false 				-- Turning this true will allow LEO's to do VIN scratches
Config.CleanGetAway = true 					-- Turning this off means that the vehicle can be turned in with cops beside the drop of point.
Config.CleanGetAWayRadius = 200 			-- How far away the cops need to be to allow for a turn in (with Config.CleanGetAway turned on)
Config.TrackerDistance = 400 				-- How close to the drop off point does the vehicle need to be to turn off tracker.
Config.PoliceDispatch = false 				-- If true, will turn off police messaging through notifications and utilize a custom dispatch system (must fill event out below).

Config.VINCheck = false						-- If true, allows LEOs to check if vehicles have been scratched.
											-- ** IF Config.VINCheck = true YOU MUST ADD 'scratched' AS A COLUMN TO YOUR VEHICLES TABLE.
											------- ALTER TABLE `PLAYERTABLENAME`
											------- ADD `scratched` int(11) NOT NULL DEFAULT 0;
											-- If help is required to implement join discord.
Config.VINCommand = true					-- If true, allows / command to check VINs.
Config.VINCommandWord = 'vincheck'			-- Word used for / command to check VIN.


-- Only complete this event if Config.PoliceDispatch is true
RegisterNetEvent('angelicxs-VINscratch:CustomDisptachFoundIt')
AddEventHandler('angelicxs-VINscratch:CustomDisptachFoundIt', function(coords)
    --DISPATCH EXPORT HERE
end)

--Inital Difficulty Configuration
Config.TimetoFind = 20 						-- How long in minutes, does the robber have to find the vehicle, before the mission fails. 
Config.TimetoRoute = 0 						-- How long in minutes, until the drop off point is shown.

-- Reputation Configuration
Config.UseVINRepSystem = true 				-- Changing this to false will change vehicle choice from 'rep' based to the entire list (Config.ClassZero); if false MUST also disable Config.AllowBoatVIN and Config.AllowHeliVIN
Config.RepPaymentforJob = -3 				-- How much rep will be taken to start a job (should/recommended to be a negative value).
Config.RandomRepGain = true 				-- If true, randomly award rep gain on successful completion.
Config.RepPaymentForDelivery = 5 			-- If Config.RandomRepGain = false, how much reputation will be gained for scratching a vehicle.
Config.RandomRepGainMin = 3 				-- Minimum reputation gained on successful completion.
Config.RandomRepGainMax = 10 				-- Maximum reputation gained on successful completion.

-- Rewards Configuration
Config.AllowKeepingVehicle = true 			-- When true will allow individuals to keep the vehicle instead of gaining rep and other rewards.
Config.RepPaymentForScratch = -7 			-- How much reputation will be taken for scratching a vehicle instead of delivering if Config.AllowKeepingVehicle = true (should/recommended to be a negative value).
Config.AccountMoney = 'cash' 				-- How you want the delivery paid.
Config.MoneyAmount = 5000 					-- If Config.RandomMoneyAmount = false, Amount paid out in Config.AccountMoney for a successful delivery.
Config.RandomMoneyAmount = true 			--If true, will randomly award money ammount on successful completion instead of Config.MoneyAmount.
Config.RandomMoneyAmountMin = 1000 			-- Minimum money gained on successful completion.
Config.RandomMoneyAmountMax = 10000 		-- Maximum money gained on successful completion.
Config.VINCLassDPayMultiplier = 1			-- Pay multiplier for VIN class D turn in
Config.VINCLassCPayMultiplier = 1			-- Pay multiplier for VIN class C turn in
Config.VINCLassBPayMultiplier = 1			-- Pay multiplier for VIN class B turn in
Config.VINCLassAPayMultiplier = 1			-- Pay multiplier for VIN class A turn in
Config.VINCLassSPayMultiplier = 1			-- Pay multiplier for VIN class S turn in
Config.VINCLassSSPayMultiplier = 1			-- Pay multiplier for VIN class SS turn in
Config.VINCLassBoatAPayMultiplier = 1		-- Pay multiplier for Boat VIN class A turn in
Config.VINCLassBoatSPayMultiplier = 1		-- Pay multiplier for Boat VIN class S turn in
Config.VINCLassHeliAPayMultiplier = 1		-- Pay multiplier for Heli VIN class A turn in
Config.VINCLassHeliSPayMultiplier = 1		-- Pay multiplier for Heli VIN class S turn in


--Failure Configuration
Config.NoVehicleChange = true 				-- When true (recommended), will cause robbery to fail if robber gets in a different vehicle after breaking into the mission vehicle.
Config.DamagedVehicle = true 				-- When true, allows vehicle to be badly damaged and still delivered.
Config.DamagedVehicleHealth = 0 			-- If Config.DamagedVehicle = false, sets the lowest amount of health a vehicle can have and still to be delivered.
Config.TimeLimitedEvent = true 				-- When true (recommended), enables a time limit for delivery.
Config.TimeLimit = 60 						-- If Config.TimeLimitedEvent = true, then in minutes, how long do the robbers have complete the heist before they fail.

-- Start Vehicle NPC Information
Config.StartVehicleLocation = {455.8330, -573.3048, 28.4998, 116.5867}
Config.StartVehicleModel = 's_f_m_shop_high'

-- Start Heli NPC Information
Config.AllowHeliVIN = true 					-- If enabled, allow Helis to be VIN scratched
Config.UniqueHeliTimer = true 				-- When true, sets the timer for this VIN scratch seperate from the standard cooldown (1 job at a time).
Config.ServerHeliTimer = true 				-- Requires Config.UniqueHeliTimer = true, when true sets timer for server.
Config.HeliTimer = 1 						-- In hours, how long until this type of boost can be attempted again.
Config.StartHeliLocation = {662.2862, 597.2177, 129.0510, 32.4805}
Config.StartHeliModel = 's_m_m_highsec_01'

-- Start Boat NPC Information
Config.AllowBoatVIN = true 					-- If enabled, allow Boats to be VIN scratched
Config.UniqueBoatTimer = true 				-- When true, sets the timer for this VIN scratch seperate from the standard cooldown (1 job at a time).
Config.ServerBoatTimer = true 				-- Requires Config.UniqueBoatTimer = true, when true sets timer for server.
Config.BoatTimer = 1						-- In hours, how long until this type of boost can be attempted again.
Config.StartBoatLocation = {-190.9512, 791.6352, 198.1074, 346.0929}
Config.StartBoatModel = 's_m_y_xmech_01'

-- Drop Off NPC
Config.DropOffModel = 's_m_m_dockwork_01'

-- Model info: https://docs.fivem.net/docs/game-references/ped-models/
-- Blip info: https://docs.fivem.net/docs/game-references/blips/
-- Vehicle Blip Config
Config.StartVehicleBlip = true 				-- Enable Blip for starting NPC
Config.StartVehicleBlipIcon = 488 			-- Starting blip icon (if Config.StarBlip = true)
Config.StartVehicleBlipColour = 50 			-- Colour of blip icon (if Config.StarBlip = true)
Config.StartVehicleBlipText = 'VIN Scratch Dealer' -- Blip text on map (if Config.StarBlip = true)

-- Boat Blip Config
Config.StartBoatBlip = true 				-- Enable Blip for starting NPC
Config.StartBoatBlipIcon = 488 				-- Starting blip icon (if Config.StarBlip = true)
Config.StartBoatBlipColour = 50 			-- Colour of blip icon (if Config.StarBlip = true)
Config.StartBoatBlipText = 'Boat Scratch Dealer' -- Blip text on map (if Config.StarBlip = true)

--Heli Blip Config
Config.StartHeliBlip = true 				-- Enable Blip for starting NPC
Config.StartHeliBlipIcon = 488 				-- Starting blip icon (if Config.StarBlip = true)
Config.StartHeliBlipColour = 50 			-- Colour of blip icon (if Config.StarBlip = true)
Config.StartHeliBlipText = 'Heli Scratch Dealer' -- Blip text on map (if Config.StarBlip = true)

--VIN Rep Levels
Config.VINClassDLevel = 10 					-- Below this range is class D (average ~5 successful at Class D to pass)
Config.VINClassCLevel = 30 					-- Below this range and above VINClassDLevel is Class C (average ~10 successful at Class C to pass)
Config.VINClassBLevel = 70 					-- Below this range and above VINClassCLevel is Class B (average ~20 successful at Class B to pass)
Config.VINClassALevel = 130 				-- Below this range and above VINClassBLevel is Class A (average ~30 successful at Class A to pass)
Config.VINClassSLevel = 210 				-- Below this range and above VINClassALevel is Class S; above this range is Class SS (average ~40 successful at Class S to pass)

-- Language Configuration
Config.LangType = {
	['error'] = 'error',
	['success'] = 'success',
	['info'] = 'primary'
}

Config.Lang = {
	['swipe'] = 'Press ~r~[E]~w~ to swipe card.',





	['request'] = 'Press ~r~[E]~w~ to request VIN scratch. \n Press ~r~[G]~w~ to check your reputation level.',
	['notallowed'] = 'Sorry, I don\'t think I will ever get information on potential vehicles of this type to scratch.',
	['start'] = 'I think I have something that may fit your skill level. I marked the rough location on your map.',
	['delay'] = 'Huh, what\'s your rep like around here?',
	['RepOff'] = 'You don\'t need rep for the jobs I have for you!',
	['ClassD'] = 'Looks like your still fresh around here, only Class D VINs are available for you.',
	['ClassC'] = 'I think I have heard about your work... How about you try a Class C VIN for size.',
	['ClassB'] = 'Hell ya! You sure are reliable, I think you may be able to take on some Class B contracts.',
	['ClassA'] = 'You are a pro at this! Class A VIN scratches are right up your alley!',
	['ClassS'] = 'I can\'t believe your skills! Get to work boosting these Class S vehicles!',
	['ClassSPlus'] = 'Folks are actively seeking you out to help them out with S Plus scratches!',
	['nocop'] = 'What? I am minding my own business, I\'m not talking to any cops.',
	['lockpick'] = 'Press ~r~[E]~w~ to break into the vehicle.',
	['missing_lockpick'] = 'You need a '..Config.LockpickName..'!',
	['locate'] = 'I found a vehicle, go grab it. It is going to be a ',
	['working'] = 'Someone else is currently on a job. Come back later.',
	['mincops'] = 'No risk, no reward. Come back later!',
	['delivery_blip'] = 'Drop off location.',
	['dropoff'] = 'Press ~r~[E]~w~ to drop off vehicle. \n Press ~r~[G]~w~ to keep scratch for your own.',
	['tracker_removed'] = 'The vehicle tracker has been removed, lose any pursuers before turning in!',
	['faraway'] = 'Your vehicle is too far away, bring it closer.',
	['no_scratch'] = 'You are responsible for delivery only, no way do you get to keep this.',
	['garage'] = 'The vehicle has been successfully scratched and has been delivered to your garage.',
	['reward'] = 'You successfully delivered the vehicle and have been paid out.',
	['track_on'] = 'A vehicle tracking device has been activated, GPS signal has been activated.',
	['track_off'] = 'A vehicle tracking device has been deactivated, the GPS signal is no longer available.',
	['failed_death'] = 'Robbery failed as you have been incapacitated.',
	['failed_vehicleswap'] = 'Robbery failed as you got in a different vehicle.',
	['failed_locate'] = 'Robbery failed as you took to long to find the vehicle.',
	['failed_timeup'] = 'Robbery failed as you took to long to deliver the vehicle.',
	['failed_damage'] = 'Robbery failed as the vehicle is too badly damaged to deliver.',
	['notclear'] = 'Shit are those sirens? The area is too hot to deal with this right now.',
	['job'] = 'I gave you a vehicle, now go get it!',
	['startmessage'] = 'An increase in stolen ',
	['startvehicle'] = ' vehicles has been reported.',
	['startboat'] = ' boats has been reported.',
	['startheli'] = ' helicopters has been reported.',
	['find_dropoff'] = 'Looking for a drop off point now, I will send it to you in a few minutes!',
	['droppoint_given'] = 'I found a spot, head there now!',
	['boat_timer'] = 'I don\'t have anymore boats to boost right now. Come back later!',
	['heli_timer'] = 'I don\'t have anymore helis to boost right now. Come back later!',
	['finish'] = 'I already dealt with the vehicle, get out of here!',
	['QtargetUser_Confirm'] = 'You found the correct vehicle!',
	['far_vin'] = 'Not close enough to check VIN!',
	['vin_stolen'] = 'This VIN has been scratched off!',
	['vin_good'] = 'This VIN is clearly visable.',
	['low_rep'] = 'Never heard of you, get out of here',
}