
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
-- blip = {label = 'Jax Collectibles Stash', sprite = 442, colour = 5}, --Blip will use the location of the NPC, set to NIL if you dont want a blip.

Config.VendorLocations = {
	Collectibles = {
		location = 'Test Legal', 
        npccoords = vector3(1663.56, 2.64, 172.76),
        npcheading = 116.36,
		npcmodel = 'u_m_m_streetart_01',
        illegal = false,
        blip = nil,
        itemsforsale = { 
            {itemname = 'bread', label = 'Bread', price = 25, image = 'https://media.discordapp.net/attachments/1002676276936577134/1002678668654559352/bread.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'water', label = 'Water', price = 22, image = 'https://media.discordapp.net/attachments/1002676276936577134/1002678884375990313/water.png'},
            {itemname = 'steak', label = 'Steak', price = 50, image = 'https://media.discordapp.net/attachments/1002676276936577134/1002678898594684948/steak.png'}
        }
    },
    blackMarket = {
		location = 'Black Market', 
        npccoords = vector3(1665.04, -0.16, 172.76), 
        npcheading = 115.72,
		npcmodel = 'g_m_y_mexgoon_01',
        illegal = true,
        blip = nil,
        itemsforsale = { 
            {itemname = 'weapon_assaultrifle', label = 'Assault Rifle', price = 200000, requiredXP = 50000, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005315960821002270/WEAPON_ASSAULTRIFLE.png'}, --Name of the item, the LABEL of the item, Price, direct image link
        }
    },
    attachmentsVendor = {
		location = 'Attachments Vendor', 
        npccoords = vector3(1664.4, 1.16, 172.76), 
        npcheading = 122.52,
		npcmodel = 'a_m_m_og_boss_01',
        illegal = true,
        blip = nil,
        itemsforsale = { 
            {itemname = 'at_flashlight', label = 'Tatical Flashlight', price = 25, requiredXP = 50000, stock = 1, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005255646951772290/unknown.png'}, --Name of the item, the LABEL of the item, Price, direct image link
            {itemname = 'at_clip_extended_pistol', label = 'Extended Pistol Magazine', price = 22, requiredXP = 100, stock = 2, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005255787804901506/unknown.png'},
            {itemname = 'at_clip_extended_smg', label = 'Extended Smg Magazine', price = 50, requiredXP = 200, stock = 3, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256270166634546/unknown.png'},
            {itemname = 'at_clip_extended_shotgun', label = 'Extended Shotgun Magazine', price = 50, requiredXP = 200, stock = 4, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256320913526824/unknown.png'},
            {itemname = 'at_clip_extended_rifle', label = 'Extended Rifle Magazine', price = 50, requiredXP = 200, stock = 5, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256387871387749/unknown.png'},
            {itemname = 'at_suppressor_light', label = 'Suppressor', price = 50, requiredXP = 200, stock = 6, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256436818903040/unknown.png'},
            {itemname = 'at_suppressor_heavy', label = 'Heavy Suppressor', price = 50, requiredXP = 200, stock = 7, image = 'https://media.discordapp.net/attachments/1004690515700224010/1005256502468157530/unknown.png'}
        }
    }
}




-- USE BELOW TO GIVE XP TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- exports['koe_vendors']:giveCrimLevel(identifier, 200)


-- USE BELOW TO GET THE CURRENT XP TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- local crimlevel = exports['koe_vendors']:getCrimLevel(identifier)


-- USE BELOW TO SET THE CURRENT XP TO SOMEONE SERVER SIDE
-- local identifier =  ESX.GetPlayerFromId(source).identifier
-- exports['koe_vendors']:setCrimlevel(identifier, 0)