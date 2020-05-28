-- Before add any drug/item here you have to add the translation of the item
Config.Drugs = {
	-- Translated name
	[_U('weed')] = {
		Item			= 'weed',				 	-- Item to pickup
		ItemTransform	= 'weed_pooch', 			-- Item to transform
		AlertCops		= true, 					-- Alert police?
		RequiredCops	= 0, 						-- How many cops need to the action start??
		QToProcess		= 5,						-- Quantity necessary to process
		QToSell			= 1,						-- Quantity necessary to sell
		TimeToFarm		= 5,						-- Time to farm in seconds
		TimeToProcess	= 10,						-- Time to process in seconds
		TimeToSell		= 10,						-- Time to sell in seconds
		Usable			= true,						-- Can it be consumed?
		UseEffect		= true,						-- Effect after consume
		Zones			= {
			-- Field: Farm location
			-- Processing: Process location
			-- Dealer: Seller location
			-- callPolice: true/false, call the police in the position?
			-- callPoliceChance: chance in percentage to call the police
			-- sellMin: Min receveid by selling
			-- sellMax: Max received by selling
			-- multiplierPolice: true/false Multiply the min/max based on cops online
			Field 			= {x = 2225.93,	y = 5576.79,	z = 53.96-1.0001,	name = _U('field', _U('weed')),			sprite = 496,	color = 52, callPolice = false, callPoliceChance = 100},
			Processing 		= {x = 1035.94,	y = -3205.76,	z = -38.17-1.0001,	name = _U('processing', _U('weed')),	sprite = 496,	color = 52, callPolice = false, callPoliceChance = 100},
			--Dealer 		= {x = 478.27,	y = -3369.85,	z = 6.07-1.0001, h = 45.24,	name = _U('dealer', _U('weed')),		sprite = 500,	color = 75, callPolice = false, callPoliceChance = 100, NPCHash = 653210662, sellMin = 200, sellMax = 500, multiplierPolice = true},
		}
	},
	-- Translated name
	[_U('meth')] = {
		Item			= 'meth',				 	-- Item to pickup
		ItemTransform	= 'meth_pooch', 			-- Item to transform
		AlertCops 		= true, 					-- Alert police?
		RequiredCops	= 0, 						-- How many cops need to the action start??
		QToProcess		= 5,						-- Quantity necessary to process
		QToSell			= 1,						-- Quantity necessary to sell
		TimeToFarm		= 5,						-- Time to farm in seconds
		TimeToProcess 	= 10,						-- Time to process in seconds
		TimeToSell		= 10,						-- Time to sell in seconds
		Usable			= true,						-- Can it be consumed?
		UseEffect		= true,						-- Effect after consume
		Zones 			= {
			-- Field: Farm location
			-- Processing: Process location
			-- Dealer: Seller location
			-- callPolice: true/false, call the police in the position?
			-- callPoliceChance: chance in percentage to call the police
			-- sellMin: Min receveid by selling
			-- sellMax: Max received by selling
			-- multiplierPolice: true/false Multiply the min/max based on cops online
			Field 			= {x = 1525.29,	y = 1710.02,	z = 109.00,	        name = _U('field', _U('meth')),			sprite = 499,	color = 26, callPolice = false, callPoliceChance = 100},
			Processing 		= {x = 1004.7,	y = -3200.24,	z = -38.99-1.0001,	name = _U('processing', _U('meth')),	sprite = 499,	color = 26, callPolice = false, callPoliceChance = 100},
			--Dealer 		= {x = 999.04,	y = -3200.39,	z = -38.99-1.0001, h = 45.24,	name = _U('dealer', _U('meth')),		sprite = 500,	color = 75, callPolice = false, callPoliceChance = 100, NPCHash = 653210662, sellMin = 200, sellMax = 500, multiplierPolice = true},
		}
	},
	-- Translated name
	[_U('opium')] = {
		Item			= 'opium',				 	-- Item to pickup
		ItemTransform	= 'opium_pooch', 			-- Item to transform
		AlertCops 		= true, 					-- Alert police?
		RequiredCops	= 0, 						-- How many cops need to the action start??
		QToProcess		= 5,						-- Quantity necessary to process
		QToSell			= 1,						-- Quantity necessary to sell
		TimeToFarm		= 5,						-- Time to farm in seconds
		TimeToProcess 	= 10,						-- Time to process in seconds
		TimeToSell		= 10,						-- Time to sell in seconds
		Usable			= true,						-- Can it be consumed?
		UseEffect		= true,						-- Effect after consume
		Zones 			= {
			-- Field: Farm location
			-- Processing: Process location
			-- Dealer: Seller location
			-- callPolice: true/false, call the police in the position?
			-- callPoliceChance: chance in percentage to call the police
			-- sellMin: Min receveid by selling
			-- sellMax: Max received by selling
			-- multiplierPolice: true/false Multiply the min/max based on cops online
			Field 			= {x = 1972.78,	y = 3819.39, z = 32.50,	name = _U('field', _U('opium')), sprite = 51, color = 60, callPolice = false, callPoliceChance = 100},
			Processing 		= {x = 98.0, y = -1290.48, z = 29.27,	name = _U('processing', _U('opium')), sprite = 51, color = 60, callPolice = false, callPoliceChance = 100},
			Dealer 			= {x = 1053.95, y = -3246.49, z = 5.89-1.0001, h = 45.24, name = _U('dealer', _U('opium')),	sprite = 500,	color = 75, callPolice = false, callPoliceChance = 100, NPCHash = 653210662, sellMin = 200, sellMax = 500, multiplierPolice = true},
		}
	},
	-- Translated name
	[_U('coke')] = {
		Item			= 'coke',				 	-- Item to pickup
		ItemTransform	= 'coke_pooch', 			-- Item to transform
		AlertCops		= true, 					-- Alert police?
		RequiredCops	= 0, 						-- How many cops need to the action start??
		QToProcess		= 5,						-- Quantity necessary to process
		QToSell			= 1,						-- Quantity necessary to sell
		TimeToFarm		= 5,						-- Time to farm in seconds
		TimeToProcess 	= 10,						-- Time to process in seconds
		TimeToSell		= 10,						-- Time to sell in seconds
		Usable			= true,						-- Can it be consumed?
		UseEffect		= true,						-- Effect after consume
		Zones 			= {
			-- Field: Farm location
			-- Processing: Process location
			-- Dealer: Seller location
			-- callPolice: true/false, call the police in the position?
			-- callPoliceChance: chance in percentage to call the police
			-- sellMin: Min receveid by selling
			-- sellMax: Max received by selling
			-- multiplierPolice: true/false Multiply the min/max based on cops online
			Field 			= {x = 2524.57,	y = -1843.93,	z = 41.33-1.0001,	name = _U('field', _U('coke')),			sprite = 501,	color = 40, callPolice = false, callPoliceChance = 100},
			Processing 		= {x = 1100.61,	y = -3194.43,	z = -38.99-1.0001,	name = _U('processing', _U('coke')),	sprite = 478,	color = 40, callPolice = false, callPoliceChance = 100},
			--Dealer 			= {x = 1124.14,	y = -3151.38,   z = -37.06-1.0001, h = 45.24,	name = _U('dealer', _U('coke')),		sprite = 500,	color = 75, callPolice = false, callPoliceChance = 100, NPCHash = 653210662, sellMin = 200, sellMax = 500, multiplierPolice = true}
		}
	}
}