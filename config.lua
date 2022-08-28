
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
    divingSupplies = {
		location = 'Diving Supplies', 
        coords = vector3(-1686.6241, -1072.4827, 12.1518),
        model = 'a_f_y_beach_01',
        heading = 53.4636,
        illegal = false,
        type = 'vendor',
        blip = {label = 'Diving Supplies', sprite = 366, colour = 54}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.
        items = { 
            {itemname = 'kuz_divinggear', label = 'Diving Gear', price = 1000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007937783337340979/kuz_divinggear.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'kuz_divinggeargood', label = 'Scuba Gear', price = 5000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007937790929018880/kuz_divinggeargood.png'},
        },
    },
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
    attachmentsVendor = {
		location = 'Attachments Vendor', 
        coords = vector3(-580.36, -1589.6, 25.76),
        model = 'u_m_m_streetart_01',
        heading = 99.88,
        illegal = true,
        blip = nil,
        type = 'vendor',
        items = { 
            {itemname = 'at_flashlight', label = 'Tatical Flashlight', price = 2000, requiredXP = 50, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005255646951772290/unknown.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'at_clip_extended_pistol', label = 'Extended Pistol Magazine', price = 10000, requiredXP = 250, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005255787804901506/unknown.png'},
            {itemname = 'at_clip_extended_smg', label = 'Extended Smg Magazine', price = 25000, requiredXP = 300, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256270166634546/unknown.png'},
            {itemname = 'at_clip_extended_shotgun', label = 'Extended Shotgun Magazine', price = 25000, requiredXP = 300, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256320913526824/unknown.png'},
            {itemname = 'at_clip_extended_rifle', label = 'Extended Rifle Magazine', price = 37500, requiredXP = 300, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256387871387749/unknown.png'},
            {itemname = 'at_suppressor_light', label = 'Suppressor', price = 20000, requiredXP = 500, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256436818903040/unknown.png'},
            {itemname = 'at_suppressor_heavy', label = 'Heavy Suppressor', price = 75000, requiredXP = 700, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256502468157530/unknown.png'}
        },
    },
    --Sellers--------------------------------------------
    -----------------------------------------------------
    -----------------------------------------------------
    -----------------------------------------------------
    
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
	illegalHunting = {
		location = 'Illegal NPC Hunting', 
        coords = vector3(-1593.08, 5202.88, 3.32),
        model = 'u_m_m_streetart_01',
        heading = 296.48,
        blip = nil,
		illegal = true,
        type = 'sellers',
        items = { 
			lion_pelt_1 = {price = 200, label = 'Lion Pelt: Quality 1'},
			lion_pelt_2 = {price = 300, label = 'Lion Pelt: Quality 2'},
			lion_pelt_3 = {price = 450, label = 'Lion Pelt: Quality 3'},
        }
    },
	pawnShop = {
		location = 'Pawn Shop', 
        coords = vector3(286.88, 137.08, 103.28),
        model = 'u_m_m_bikehire_01',
        heading = 342,
        blip = {label = 'Pawnshop', sprite = 500, colour = 2},
		illegal = false,
        type = 'sellers',
        items = { 
			rackit_sticker = {price = 40, label = 'Rackit Sticker'},
			witty_sticker = {price = 40, label = 'Witty Sticker'},
			mad_sticker = {price = 40, label = 'Madchild Sticker'},
			jax_sticker = {price = 40, label = 'JaxStash Sticker'},
			lobo_sticker = {price = 40, label = 'Lobo Sticker'},
			monncath_sticker = {price = 40, label = 'Monncath Sticker'},
			kevin_sticker = {price = 40, label = 'Kevin Sticker'},
			elijah_sticker = {price = 40, label = 'Elijah Sticker'},
			cyclopsed_sticker = {price = 40, label = 'Cyclopsed Sticker'},
			strange_sticker = {price = 40, label = 'Strangelove Sticker'},
			under_sticker = {price = 40, label = 'Und3r8ed Sticker'},
        }
    },
	legalFish = {
		location = 'Fish Market', 
        coords = vector3(-1842.04, -1199.32, 13.32),
        model = 's_m_y_factory_01',
        heading = 239.56,
        blip = {label = 'Fish Market', sprite = 371, colour = 18},
		illegal = false,
        type = 'sellers',
        items = { 
			swordfish = {price = 100, label = 'Sword Fish'},
			tunafish = {price = 100, label = 'Tuna Fish'},
			mahifish = {price = 100, label = 'Mahi Fish'},
			halibut = {price = 100, label = 'Halibut'},
			redfish = {price = 100, label = 'Red Fish'},
			bluefish = {price = 100, label = 'Blue Fish'},
			salmon = {price = 100, label = 'Salmon'},
			perch = {price = 100, label = 'Perch'},
			bass = {price = 100, label = 'Bass'},
			tilapia = {price = 100, label = 'Tilapia'},
			catfish = {price = 100, label = 'Cat Fish'},
			shad = {price = 100, label = 'Shad'},
			rainbowfish = {price = 100, label = 'Rainbow Fish'},
        }
    },
    illegalFish = {
		location = 'Illegal Fish Market', 
        coords = vector3(1320.96, 4314.56, 37.16),
        model = 'u_m_m_streetart_01',
        heading = 82,
        blip = nil,
		illegal = true,
        type = 'sellers',
        items = { 
            seaturtle = {price = 100, label = 'Seaturtle'},
			pufferfish = {price = 1000, label = 'Puffer Fish'},
			piranha = {price = 1100, label = 'Piranha'},
			hammerhead = {price = 1300, label = 'Hammer Head'},
			greatwhite = {price = 1500, label = 'Great White'},
        }
    },
    scrapper = {
		location = 'Scrapper', 
        coords = vector3(1130.52, -776.8, 56.6),
        model = 'ig_cletus',
        heading = 357,
        blip = {label = 'Scrapper', sprite = 527, colour = 18},
		illegal = false,
        type = 'sellers',
        items = { 
			rubber = {price = 5, label = 'Rubber'},
            scrap_metal = {price = 5, label = 'Scrap Metal'},
            electric_scrap = {price = 5, label = 'Electronic Scrap'},
            plastic = {price = 5, label = 'Plastic'},
            glass = {price = 5, label = 'Glass'},
            aluminium = {price = 5, label = 'Aluminium'},
            copper = {price = 5, label = 'Copper'},
            steel = {price = 5, label = 'Steel'},
        }
    },
    jeweler = {
		location = 'Jeweler/Collector', 
        coords = vector3(-20.52, 6490.48, 1.52),
        model = 'ig_davenorton',
        heading = 54,
        blip = {label = 'Jeweler/Collector', sprite = 617, colour = 4},
		illegal = false,
        type = 'sellers',
        items = { 
			kuz_watch = {price = 60, label = 'Expensive watch'},
            kuz_pearl = {price = 225, label = 'Pearl'},
            kuz_jewelry = {price = 60, label = 'Jewelry'},
            kuz_rarecoin = {price = 250, label = 'Rare Coin'},
            kuz_goldcoin = {price = 75, label = 'Golden Coin'},
            kuz_silvercoin = {price = 65, label = 'Silver Coin'},
        }
    },
    illegalJeweler = {
		location = 'Illegal Collector', 
        coords = vector3(1641.72, 4853.24, 41.04),
        model = 'u_m_m_streetart_01',
        heading = 100,
        blip = nil,
		illegal = true,
        type = 'sellers',
        items = { 
			kuz_merryweather = {price = 170, label = 'Merryweather parts'},
            kuz_plasmacutter = {price = 550, label = 'Underwater Plasma Cutter'},
            diamond = {price = 1500, label = 'Diamond'},
            engagement_ring = {price = 450, label = 'Engagement Ring'},
            rolex_watch = {price = 600, label = 'Rolex Watch'},
            gold_bracelet = {price = 800, label = 'Gold Bracelet'},
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