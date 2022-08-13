
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

Config.DebugPrints = true

-- blip = {label = 'Jax Collectibles Stash', sprite = 442, colour = 5}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.

Config.VendorLocations = {
	legalFishing = {
		location = 'Fish Vendor', 
        npccoords = vector3(-1600.76, -976.0, 12.0),
        npcheading = 50.84,
		npcmodel = 'a_m_y_surfer_01',
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
        npccoords = vector3(-1639.36, -1018.88, 12.16),
        npcheading = 50.84,
		npcmodel = 'a_f_y_beach_01',
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
        npccoords = vector3(315.04, 2892.16, 45.48), 
        npcheading = 32.36,
		npcmodel = 'g_m_y_lost_03',
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
        npccoords = vector3(-580.44, -1589.6, 25.76), 
        npcheading = 107.04,
		npcmodel = 'a_m_m_og_boss_01',
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
        npccoords = vector3(591.88, 2782.72, 42.48), 
        npcheading = 3.52,
		npcmodel = 'cs_hunter',
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
        npccoords = vector3(1996.02, 4982.71, 40.63), 
        npcheading = 219.41, 
		npcmodel = 'cs_hunter',
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
        npccoords = vector3(-1841.4, -1235.64, 12.1), 
        npcheading = 322.08,
		npcmodel = 'ig_money', 
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
        npccoords = vector3(-1842.12, -1199.36, 13.32), 
        npcheading = 238.32,
		npcmodel = 's_m_y_factory_01', 
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
        npccoords = vector3(-1811.08, -1235.72, 7.6), 
        npcheading = 232.08,
		npcmodel = 'a_m_y_jetski_01', 
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
        npccoords = vector3(1132.04, -776.76, 56.6), 
        npcheading = 1.88,
		npcmodel = 'mp_m_waremech_01', 
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
        npccoords = vector3(182.28, -1319.36, 29.32), 
        npcheading = 239.0,
		npcmodel = 'a_m_m_business_0', 
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
        npccoords = vector3(522.36, -971.76, 26.44), 
        npcheading = 357.44,
		npcmodel = 'a_m_m_paparazzi_01', 
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


Config.SellerLocations = {
	
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