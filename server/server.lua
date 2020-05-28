-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
--			Created By: diorgesl AKA diorgera   		  --
--			 Protected By: ATG-Github AKA ATG			  --
-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --

ESX								= nil
local CopsConnected				= 0
local activeCops = {}
local PlayersHarvesting			= {}
local PlayersTransforming		= {}
local PlayersSelling			= {}
local Drug						= {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()
    return CopsConnected
end

function fetchCops()
    local xPlayers = ESX.GetPlayers()
    CopsConnected = 0
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == "police" then
            CopsConnected = CopsConnected + 1
            activeCops[#activeCops + 1] = xPlayer.source
        end
    end
    SetTimeout(120 * 1000, fetchCops)
end

Citizen.CreateThread(fetchCops)

function ensureLegitness(xPlayer, drug, stage)
	local xPlayer, drug, stage = xPlayer, drug, stage;
	local legit = {["legit"] = true, ["reason"] = "No flags found."}
	if xPlayer ~= nil then
		local pCoord = xPlayer.getCoords();
		if pCoord ~= nil then
			if drug ~= nil then
				if stage ~= nil then
					local dCoord = Config.Drugs[drug];
					if dcoord ~= nil then
						local radius = tonumber(Config.ZoneSize.x * Config.ZoneSize.y * Config.ZoneSize.z)
						if stage == "collect" then
							local x, y, z = dCoord.Zones.Field.x, dCoord.Zones.Field.y, dCoord.Zones.Field.z;
							local distance = #(pCoord - vector3(x, y, z));
							if distance < radius * 2.5 then
								return legit
							else
								legit = {["legit"] = false, ["reason"] = "Player was out of the radius."}
								return legit
							end
						elseif stage == "process" then
							local x, y, z = dCoord.Zones.Processing.x, dCoord.Zones.Processing.y, dCoord.Zones.Processing.z;
							local distance = #(pCoord - vector3(x, y, z));
							if distance < radius * 2.5 then
								return legit
							else
								legit = {["legit"] = false, ["reason"] = "Player was out of the radius."}
								return legit
							end
						else
							legit = {["legit"] = false, ["reason"] = "The drug stage could not be matched."}
							return legit
						end
					else
						legit = {["legit"] = false, ["reason"] = "The drug could not be matched."}
						return legit
					end
				else
					legit = {["legit"] = false, ["reason"] = "The drug stage was not supplied."}
					return legit
				end
			else
				legit = {["legit"] = false, ["reason"] = "The drug type was not supplied."}
				return legit
			end
		else
			legit = {["legit"] = false, ["reason"] = "Player coords were nil."}
			return legit
		end
	else
		legit = {["legit"] = false, ["reason"] = "xPlayer was nil."}
		return legit
	end
end

local function Harvest(source, drug)
	local v = Config.Drugs[""..drug ..""]
	if CopsConnected < v.RequiredCops then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, v.RequiredCops))
		return
	end
	SetTimeout(v.TimeToFarm * 1000, function()
		if PlayersHarvesting[source] == true and Drug[source] == drug then
			local _source = source;
			local xPlayer  = ESX.GetPlayerFromId(_source)
			local item = xPlayer.getInventoryItem(v.Item)
			local qtd = math.random(1,10)

			local legit = ensureLegitness(xPlayer, drug, "collect");
			if legit["legit"] == true then
				if xPlayer.canCarryItem(v.Item, qtd) then
					xPlayer.addInventoryItem(v.Item, qtd)
					Harvest(source, drug)
				else
					TriggerClientEvent('esx_drugs:hasExitedMarker')
					TriggerClientEvent('esx:showNotification', _source, _U('inv_full'))
				end
			else
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to collect ^2%s^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), drug, legit["reason"]
					)
				)
				TriggerClientEvent('esx_drugs:hasExitedMarker')
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvest')
AddEventHandler('esx_drugs:startHarvest', function(drug)
	local _source = source
	PlayersHarvesting[_source] = true
	Drug[source] = drug
	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))
	Harvest(_source, drug)
end)

RegisterServerEvent('esx_drugs:stopHarvest')
AddEventHandler('esx_drugs:stopHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = false
	Drug[source] = false
end)

local function Transform(source, drug)
	local v = Config.Drugs[""..drug ..""]
	if CopsConnected < v.RequiredCops then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, v.RequiredCops))
		return
	end
	SetTimeout(v.TimeToProcess * 1000, function()
		if PlayersTransforming[source] == true and Drug[source] == drug then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local itemQuantity = xPlayer.getInventoryItem(v.Item).count
			local transformQuantity = xPlayer.getInventoryItem(v.ItemTransform).count

			local legit = ensureLegitness(xPlayer, drug, "process");
			if legit["legit"] == true then
				if transformQuantity > 100 then
					TriggerClientEvent('esx:showNotification', _source, _U('too_many_pouches'))
				elseif itemQuantity < 25 then
					TriggerClientEvent('esx:showNotification', _source, _U('not_enough', drug))
				else
					xPlayer.removeInventoryItem(v.Item, 25)
					xPlayer.addInventoryItem(v.ItemTransform, 1)
					Transform(_source, drug)
				end
			else
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to collect ^2%s^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), drug, legit["reason"]
					)
				)
				TriggerClientEvent('esx_drugs:hasExitedMarker')
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransform')
AddEventHandler('esx_drugs:startTransform', function(drug)
	local _source = source
	PlayersTransforming[_source] = true
	Drug[source] = drug
	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))
	Transform(_source, drug)
end)

RegisterServerEvent('esx_drugs:stopTransform')
AddEventHandler('esx_drugs:stopTransform', function()
	local _source = source
	PlayersTransforming[_source] = false
	Drug[source] = false
end)

local function Sell(source, drug)
	local v = Config.Drugs[""..drug ..""]
	if CopsConnected < v.RequiredCops then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, v.RequiredCops))
		return
	end
	SetTimeout(v.TimeToSell * 1000, function()
		if PlayersSelling[source] == true and Drug[source] == drug then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local item = xPlayer.getInventoryItem(v.ItemTransform).count

			if item == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough', drug))
			else
				xPlayer.removeInventoryItem(v.ItemTransform, 1)
				if CopsConnected <= 1 then
					xPlayer.addAccountMoney('black_money', math.random(v.Zones.Dealer.sellMin, v.Zones.Dealer.sellMax))
				else
					xPlayer.addAccountMoney('black_money', math.random( v.Zones.Dealer.sellMin * CopsConnected, v.Zones.Dealer.sellMax * CopsConnected))
				end
				TriggerClientEvent('esx:showNotification', source, _U('sold_one', drug))
				Sell(source, drug)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSell')
AddEventHandler('esx_drugs:startSell', function(drug)
	local _source = source
	PlayersSelling[_source] = true
	Drug[source] = drug
	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
	Sell(_source, drug)
end)

RegisterServerEvent('esx_drugs:stopSell')
AddEventHandler('esx_drugs:stopSell', function()
	local _source = source
	PlayersSelling[_source] = false
	Drug[source] = false
end)

ESX.RegisterServerCallback('esx_drugs:getInventoryItem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local oItem = xPlayer.getInventoryItem(item)
	cb(oItem)
end)

for k,v in pairs(Config.Drugs) do
	if v.Usable then
		ESX.RegisterUsableItem(v.Item, function(source)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			xPlayer.removeInventoryItem(v.Item, 5)
			if v.UseEffect then
				TriggerClientEvent('esx_drugs:onUse', _source, v.Item)
			end
			TriggerClientEvent('esx:showNotification', _source, _U('used_one', k))
		end)
	end
end

local calledUsers = {};
ESX.RegisterServerCallback('esx_drugs:getCoords', function(source, cb)
	if calledUsers[source] == nil then
		calledUsers[source] = true;
		cb(Config.CircleZones)
	end
end)