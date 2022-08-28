
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

Config.DebugPrints = false           --This will print when rating is given or set or changed

------IMPORTANT INFORMATION------------------
-- Type Vendor means you BUY items from them
-- Type Seller means you SELL items to them
-- blip = {label = 'Koes Store of Awesome', sprite = 442, colour = 5}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.
-- if vendor is marked illegal then be sure to add requiredXP = 25 to require certain crim rating to buy the item. Each item can be different.
---------------------------------------------


Config.VendorLocations = {
    --Example Vendor Below
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
    --Example Seller Below
    legalHunting = {
		location = 'Legal NPC - Hunting', 
        coords = vector3(591.88, 2782.76, 42.48),
        model = 'cs_hunter',
        heading = 6.32,
        blip = {label = 'Legal Hunting Vendor', sprite = 442, colour = 5},
		illegal = false,
        type = 'sellers',
        items = { 
            meat = {price = 12, label = 'Meat'},
			hide = {price = 12, label = 'Hide'},
            coyote_pelt_1 = {price = 30, label = 'Coyote Pelt: Quality 1'},
			coyote_pelt_2 = {price = 60, label = 'Coyote Pelt: Quality 2'},
			coyote_pelt_3 = {price = 80, label = 'Coyote Pelt: Quality 3'},
			deer_pelt_1 = {price = 30, label = 'Deer Pelt: Quality 1'},
			deer_pelt_2 = {price = 60, label = 'Deer Pelt: Quality 2'},
			deer_pelt_3 = {price = 80, label = 'Deer Pelt: Quality 3'},
			pig_pelt_1 = {price = 30, label = 'Pig Pelt: Quality 1'},
			pig_pelt_2 = {price = 60, label = 'Pig Pelt: Quality 2'},
			pig_pelt_3 = {price = 80, label = 'Pig Pelt: Quality 3'},
			boar_pelt_1 = {price = 30, label = 'Boar Pelt: Quality 1'},
			boar_pelt_2 = {price = 60, label = 'Boar Pelt: Quality 2'},
			boar_pelt_3 = {price = 80, label = 'Boar Pelt: Quality 3'},

        }
    },
}


-- ███████ ██   ██ ██████   ██████  ██████  ████████ ███████ 
-- ██       ██ ██  ██   ██ ██    ██ ██   ██    ██    ██      
-- █████     ███   ██████  ██    ██ ██████     ██    ███████ 
-- ██       ██ ██  ██      ██    ██ ██   ██    ██         ██ 
-- ███████ ██   ██ ██       ██████  ██   ██    ██    ███████ 
                                                          
                                                          

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