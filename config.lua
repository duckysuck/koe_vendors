
-- ░█████╗░██████╗░███████╗░█████╗░████████╗███████╗██████╗░  ██████╗░██╗░░░██╗  ██╗░░██╗░█████╗░███████╗
-- ██╔══██╗██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔══██╗  ██╔══██╗╚██╗░██╔╝  ██║░██╔╝██╔══██╗██╔════╝
-- ██║░░╚═╝██████╔╝█████╗░░███████║░░░██║░░░█████╗░░██║░░██║  ██████╦╝░╚████╔╝░  █████═╝░██║░░██║█████╗░░
-- ██║░░██╗██╔══██╗██╔══╝░░██╔══██║░░░██║░░░██╔══╝░░██║░░██║  ██╔══██╗░░╚██╔╝░░  ██╔═██╗░██║░░██║██╔══╝░░
-- ╚█████╔╝██║░░██║███████╗██║░░██║░░░██║░░░███████╗██████╔╝  ██████╦╝░░░██║░░░  ██║░╚██╗╚█████╔╝███████╗
-- ░╚════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═════╝░  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░╚════╝░╚══════╝

-- ░██████╗░█████╗░██████╗░██╗██████╗░████████╗░██████╗
-- ██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
-- ╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░╚█████╗░
-- ░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░░╚═══██╗
-- ██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░██████╔╝
-- ╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░

Config = {}
Config.Framework = 'qb'                -- 'esx' for es_extended legacy, 'qb' for Qb-Core ||| If using ESX please read the fxmanifest.

------IMPORTANT INFORMATION------------------
-- Type Vendor means you BUY items from them
-- Type Seller means you SELL items to them
-- blip = {label = 'Koes Store of Awesome', sprite = 442, colour = 5}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.
-- if vendor is marked illegal then be sure to add requiredXP = 25 to require certain crim rating to buy the item. Each item can be different.
---------------------------------------------


Config.VendorLocations = {
    --LEGAL VENDOR EXAMPLE
	legalFishing = {                                        --Simple Name for the vendor, must be unique
		location = 'Fish Vendor',                           -- Location name, shows in menus
        coords = vector3(-1600.4915, -976.0989, 12.0177),   -- Location of the NPC
        model = 'ig_chef2',                                 -- Model for the NPC
        heading = 50.9371,                                  --Heading of the NPC (Direction they face)
        illegal = false,                                    -- Is this vendor illegal? if illegal then you must use required xp in the items table, see a illegal one below for reference
        type = 'vendor',                                    -- vendor means BUY items, sellers means SELL items
        blip = {label = 'Fish Items', sprite = 59, colour = 5}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.
        items = {  --Put all the items you wish to sell/buy depending on the vendor TYPE
            {itemname = 'fishingrod', label = 'Fishing Rod', price = 35, image = 'https://media.discordapp.net/attachments/1004690515700224010/1006526771992207451/fishingrod.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'legalbait', label = 'Legal Bait', price = 8, image = 'https://media.discordapp.net/attachments/1004690515700224010/1006526816317620264/fishbait.png'},
        }
    },
    --ILLEGAL VENDOR EXAMPLE
    blackMarket = {
		location = 'Black Market', 
        coords = vector3(287.56, 2843.76, 43.72),
        model = 'u_m_m_streetart_01',
        heading = 70.84,
        illegal = true,
        blip = nil,
        type = 'vendor',
        items = { 
            {itemname = 'boosting_tablet', label = 'Boosting Tablet', price = 50000, requiredXP = 25, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357263603826749/boosting_tablet.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_pistol', label = 'Pistol', price = 500, requiredXP = 50, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357299314135050/WEAPON_PISTOL.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_switchblade', label = 'Switchblade', price = 1000, requiredXP = 100, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357363918995496/WEAPON_SWITCHBLADE.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_machinepistol', label = 'Machine Pistol', price = 20000, requiredXP = 900, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357410966511616/WEAPON_MACHINEPISTOL.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_appistol', label = 'AP Pistol', price = 20000, requiredXP = 900, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357432059662376/WEAPON_APPISTOL.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_minismg', label = 'Mini SMG', price = 35000, requiredXP = 1500, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357501659938937/WEAPON_MINISMG.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_microsmg', label = 'Micro SMG', price = 35000, requiredXP = 1500, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357557494521996/WEAPON_MICROSMG.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_smg', label = 'SMG', price = 50000, requiredXP = 4000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357579212619877/WEAPON_SMG.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'WEAPON_COMPACTRIFLE', label = 'Draco', price = 50000, requiredXP = 4000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357600280608978/WEAPON_COMPACTRIFLE.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_gusenberg', label = 'Gusenberg', price = 50000, requiredXP = 4000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357633201713273/weapon_gusenberg.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'WEAPON_ASSAULTRIFLE', label = 'Assault Rifle', price = 75000, requiredXP = 5000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357661525852210/WEAPON_ASSAULTRIFLE.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_carbinerifle', label = 'Police Issued: Carbine Rifle', price = 75000, requiredXP = 5000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357674322665493/WEAPON_CARBINERIFLE.png'}, --Name of the item, the LABEL of the item, Price, direct image link

        },
    },
    --Sellers--------------------------------------------
    -----------------------------------------------------

    --LEGAL SELLER EXAMPLE
    legalHunting = {
		location = 'Legal NPC - Hunting', 
        coords = vector3(591.88, 2782.76, 42.48),
        model = 'cs_hunter',
        heading = 6.32,
        blip = {label = 'Legal Hunting Vendor', sprite = 442, colour = 5},
		illegal = false,
        type = 'sellers',
        items = { 
            repairkit = {price = 100, label = 'Repair Kit'},
        }
    },
    --ILLEGAL SELLER EXAMPLE
	illegalHunting = {
		location = 'Illegal NPC Hunting', 
        coords = vector3(-1593.08, 5202.88, 3.32),
        model = 'u_m_m_streetart_01',
        heading = 296.48,
        blip = nil,
		illegal = true,
        type = 'sellers',
        items = { 
			repairkit = {price = 500, label = 'Repair kit'},
        }
    },
}

-- USE BELOW TO GIVE CRIM RATING TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- exports['koe_vendors']:giveCrimLevel(identifier, 200)


-- USE BELOW TO GET THE CURRENT CRIM RATING TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- local crimrating = exports['koe_vendors']:getCrimLevel(identifier)


-- USE BELOW TO SET THE CURRENT CRIM RATING TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- exports['koe_vendors']:setCrimlevel(identifier, 0)
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- USE BELOW TO GIVE CIVILIAN RATING TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- exports['koe_vendors']:giveCivLevel(identifier, 200)


-- USE BELOW TO GET THE CURRENT CIVILIAN RATING TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- local civRating = exports['koe_vendors']:getCivLevel(identifier)


-- USE BELOW TO SET THE CURRENT CIVILIAN RATING TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- exports['koe_vendors']:setCivlevel(identifier, 0)