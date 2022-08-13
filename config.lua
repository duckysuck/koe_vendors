
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

Config.DebugPrints = false

-- blip = {label = 'Jax Collectibles Stash', sprite = 442, colour = 5}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.

Config.VendorLocations = {
	legalFishing = {
		location = 'Fish Vendor', 
        pzCoords = vector3(-1600.18, -976.5, 13.02),
        pzW = 2.4,
        pzH = 1,
        pzHeading = 320,
		pzMin = 12.02,
        pzMax = 14.62,
        illegal = false,
        type = 'vendor',
        blip = {label = 'Fish Items', sprite = 59, colour = 5}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.
        itemsforsale = { 
            {itemname = 'fishingrod', label = 'Fishing Rod', price = 35, image = 'https://media.discordapp.net/attachments/1004690515700224010/1006526771992207451/fishingrod.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'legalbait', label = 'Legal Bait', price = 8, image = 'https://media.discordapp.net/attachments/1004690515700224010/1006526816317620264/fishbait.png'},
        }
    },
    divingSupplies = {
		location = 'Diving Supplies', 
        pzCoords = vector3(-1685.91, -1073.01, 13.15),
        pzW = 2.0,
        pzH = 1,
        pzHeading = 140,
		pzMin = 12.15,
        pzMax = 14.958,
        illegal = false,
        type = 'vendor',
        blip = {label = 'Diving Supplies', sprite = 366, colour = 54}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.
        itemsforsale = { 
            {itemname = 'kuz_divinggear', label = 'Diving Gear', price = 1000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007937783337340979/kuz_divinggear.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'kuz_divinggeargood', label = 'Scuba Gear', price = 5000, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007937790929018880/kuz_divinggeargood.png'},
        },
    },
    blackMarket = {
		location = 'Black Market', 
        pzCoords = vector3(288.34, 2844.24, 44.7),
        pzW = 1.6,
        pzH = 1,
        pzHeading = 211,
		pzMin = 43.7,
        pzMax = 46.1,
        illegal = true,
        blip = nil,
        type = 'vendor',
        itemsforsale = { 
            {itemname = 'boosting_tablet', label = 'Boosting Tablet', price = 50000, requiredXP = 25, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357263603826749/boosting_tablet.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_pistol', label = 'Pistol', price = 500, requiredXP = 50, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357299314135050/WEAPON_PISTOL.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_switchblade', label = 'Switchblade', price = 1000, requiredXP = 100, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357363918995496/WEAPON_SWITCHBLADE.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_machinepistol', label = 'Machine Pistol', price = 20000, requiredXP = 900, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357410966511616/WEAPON_MACHINEPISTOL.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_appistol', label = 'AP Pistol', price = 20000, requiredXP = 900, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357432059662376/WEAPON_APPISTOL.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_minismg', label = 'Mini SMG', price = 35000, requiredXP = 1500, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357501659938937/WEAPON_MINISMG.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_microsmg', label = 'Micro SMG', price = 35000, requiredXP = 1500, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357557494521996/WEAPON_MICROSMG.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_smg', label = 'SMG', price = 50000, requiredXP = 4000, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357579212619877/WEAPON_SMG.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'WEAPON_COMPACTRIFLE', label = 'Draco', price = 50000, requiredXP = 4000, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357600280608978/WEAPON_COMPACTRIFLE.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_gusenberg', label = 'Gusenberg', price = 50000, requiredXP = 4000, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357633201713273/weapon_gusenberg.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'WEAPON_ASSAULTRIFLE', label = 'Assault Rifle', price = 75000, requiredXP = 5000, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357661525852210/WEAPON_ASSAULTRIFLE.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'weapon_carbinerifle', label = 'Police Issued: Carbine Rifle', price = 75000, requiredXP = 5000, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1007357674322665493/WEAPON_CARBINERIFLE.png'}, --Name of the item, the LABEL of the item, Price, direct image link

        },
    },
    attachmentsVendor = {
		location = 'Attachments Vendor', 
        pzCoords = vector3(-579.81, -1589.42, 26.75),
        pzW = 1.6,
        pzH = 1,
        pzHeading = 200,
		pzMin = 25.75,
        pzMax = 28.75,
        illegal = true,
        blip = nil,
        type = 'vendor',
        itemsforsale = { 
            {itemname = 'at_flashlight', label = 'Tatical Flashlight', price = 2000, requiredXP = 50, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005255646951772290/unknown.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'at_clip_extended_pistol', label = 'Extended Pistol Magazine', price = 10000, requiredXP = 250, stock = 2, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005255787804901506/unknown.png'},
            {itemname = 'at_clip_extended_smg', label = 'Extended Smg Magazine', price = 25000, requiredXP = 300, stock = 3, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256270166634546/unknown.png'},
            {itemname = 'at_clip_extended_shotgun', label = 'Extended Shotgun Magazine', price = 25000, requiredXP = 300, stock = 4, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256320913526824/unknown.png'},
            {itemname = 'at_clip_extended_rifle', label = 'Extended Rifle Magazine', price = 37500, requiredXP = 300, stock = 5, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256387871387749/unknown.png'},
            {itemname = 'at_suppressor_light', label = 'Suppressor', price = 20000, requiredXP = 500, stock = 6, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256436818903040/unknown.png'},
            {itemname = 'at_suppressor_heavy', label = 'Heavy Suppressor', price = 75000, requiredXP = 700, stock = 7, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256502468157530/unknown.png'}
        },
    },
    --Sellers--------------------------------------------
    -----------------------------------------------------
    legalHunting = {
		location = 'Legal NPC - Hunting', 
        pzCoords = vector3(591.98, 2782.16, 43.48),
        pzW = 1.6,
        pzH = 1,
        pzHeading = 274,
		pzMin = 42.48,
        pzMax = 44.88,
        blip = {label = 'Legal Hunting Vendor', sprite = 442, colour = 5},
		illegal = false,
        type = 'sellers',
        sellableitems = { 
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
        pzCoords = vector3(-1593.65, 5202.6, 4.31),
        pzW = 1.4,
        pzH = 1,
        pzHeading = 205,
		pzMin = 3.31,
        pzMax = 6.11,
        blip = nil,
		illegal = true,
        type = 'sellers',
        sellableitems = { 
			lion_pelt_1 = {price = 200, label = 'Lion Pelt: Quality 1'},
			lion_pelt_2 = {price = 300, label = 'Lion Pelt: Quality 2'},
			lion_pelt_3 = {price = 450, label = 'Lion Pelt: Quality 3'},
        }
    },
	pawnShop = {
		location = 'Pawn Shop', 
        pzCoords = vector3(286.56, 136.26, 104.3),
        pzW = 5.4,
        pzH = 1,
        pzHeading = 250,
		pzMin = 103.3,
        pzMax = 106.3,
        blip = {label = 'Pawnshop', sprite = 500, colour = 2},
		illegal = false,
        type = 'sellers',
        sellableitems = { 
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
        pzCoords = vector3(-1842.68, -1198.91, 14.3),
        pzW = 2.4,
        pzH = 1,
        pzHeading = 150,
		pzMin = 13.3,
        pzMax = 16.5,
        blip = {label = 'Fish Market', sprite = 371, colour = 18},
		illegal = false,
        type = 'sellers',
        sellableitems = { 
			swordfish = {price = 100, label = 'Sword Fish'},
			tunafish = {price = 100, label = 'Tuna Fish'},
			mahifish = {price = 100, label = 'Mahi Fish'},
			halibut = {price = 100, label = 'Halibut'},
			redfish = {price = 100, label = 'Red Fish'},
			bluefish = {price = 100, label = 'Blue Fish'},
			seaturtle = {price = 100, label = 'Seaturtle'},
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
        pzCoords = vector3(1321.8, 4314.41, 38.22),
        pzW = 1.6,
        pzH = 1,
        pzHeading = 169,
		pzMin = 37.22,
        pzMax = 40.02,
        blip = nil,
		illegal = true,
        type = 'sellers',
        sellableitems = { 
			pufferfish = {price = 1000, label = 'Puffer Fish'},
			piranha = {price = 1100, label = 'Piranha'},
			hammerhead = {price = 1300, label = 'Hammer Head'},
			greatwhite = {price = 1500, label = 'Great White'},
        }
    },
    scrapper = {
		location = 'Scrapper', 
        pzCoords = vector3(1130.3, -777.6, 57.61),
        pzW = 1.6,
        pzH = 1,
        pzHeading = 269,
		pzMin = 56.61,
        pzMax = 59.41,
        blip = {label = 'Scrapper', sprite = 527, colour = 18},
		illegal = false,
        type = 'sellers',
        sellableitems = { 
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
        pzCoords = vector3(-20.07, 6489.99, 31.5),
        pzW = 1.6,
        pzH = 1,
        pzHeading = 315,
		pzMin = 30.5,
        pzMax = 32.9,
        blip = {label = 'Jeweler/Collector', sprite = 617, colour = 4},
		illegal = false,
        type = 'sellers',
        sellableitems = { 
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
        pzCoords = vector3(1642.46, 4853.54, 42.03),
        pzW = 1.6,
        pzH = 1,
        pzHeading = 8,
		pzMin = 41.03,
        pzMax = 43.43,
        blip = nil,
		illegal = true,
        type = 'sellers',
        sellableitems = { 
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