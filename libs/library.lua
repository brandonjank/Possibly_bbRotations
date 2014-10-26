bbLib = {}
--TODO: Alpha, Beta, and Raid Ready Alert

--IsBoss: (function() return IsEncounterInProgress() and SpecialUnit() end)
--LifeSpirit: (function() return GetItemCount(89640, false, false) > 0 and GetItemCooldown(89640) == 0 end)
--HealPot: (function() return GetItemCount(76097, false, false) > 0 and GetItemCooldown(76097) == 0 end)
--AgiPot: (function() return GetItemCount(76089, false, false) > 0 and GetItemCooldown(76089) == 0 end)
--HealthStone: (function() return GetItemCount(5512, false, true) > 0 and GetItemCooldown(5512) == 0 end)
--Stats (function() return select(1,GetRaidBuffTrayAuraInfo(1)) != nil end)
--Stamina (function() return select(1,GetRaidBuffTrayAuraInfo(2)) != nil end)
--AttackPower (function() return select(1,GetRaidBuffTrayAuraInfo(3)) != nil end)
--AttackSpeed (function() return select(1,GetRaidBuffTrayAuraInfo(4)) != nil end)
--SpellPower (function() return select(1,GetRaidBuffTrayAuraInfo(5)) != nil end)
--SpellHaste (function() return select(1,GetRaidBuffTrayAuraInfo(6)) != nil end)
--CritialStrike (function() return select(1,GetRaidBuffTrayAuraInfo(7)) != nil end)
--Mastery (function() return select(1,GetRaidBuffTrayAuraInfo(8)) != nil end)

--UnitsAroundUnit(unit, distance[, combat])
--Distance(unit, unit)
--FaceUnit(unit)
--IterateObjects(callback, filter)

--timeout(name, duration) -- Used to add a rate limit or stop double casting.

function bbLib.NeedHealsAroundUnit(unit, count, distance, threshold)
	if unit and unit == 'lowest' then unit = PossiblyEngine.raid.lowestHP() end
	if unit and UnitExists(unit) then
		if not count then count = 2 end
		if not distance then distance = 15 end
		if not threshold then threshold = 80 end
		local total = 0
		local totalObjects = ObjectCount()
		for i = 1, totalObjects do
			local object = ObjectWithIndex(i)
			if bit.band(ObjectType(object), ObjectTypes.Player) > 0 then
				if UnitCanAssist("player", unit) and UnitIsFriend("player", unit)
				 	and UnitIsConnected(unit) and not UnitIsDeadOrGhost(unit)
					and not UnitUsingVehicle(unit) and UnitInParty(unit) then
					if ((UnitHealth(unit) / UnitHealthMax(unit)) * 100) <= threshold then
						if Distance(object, unit) <= distance then
								total = total + 1
						end
					end
				end
			end
		end
		if count >= total then
			return true
		end
	end
	return false
end

PossiblyEngine.raid.needsHealing = function (threshold)
  if not threshold then threshold = 80 end

  local start, groupMembers = getGroupMembers()
  local needsHealing = 0
  local unit
  for i = start, groupMembers do
    unit = PossiblyEngine.raid.roster[i]
    if canHeal(unit.unit) and unit.health and unit.health <= threshold then
      needsHealing = needsHealing + 1
    end
  end

  return needsHealing
end



function bbLib.GCDOver(spell)
	local spellID
	if spell == nil then
		spellID = 61304
	else
		spellID = GetSpellID(spell)
	end
	local _, _, lagHome, lagWorld = GetNetStats()
	local lagSeconds = (lagHome + lagWorld) / 1000 + .025
	if lagSeconds < 0.05 then
		lagSeconds = 0.05
	elseif lagSeconds > 0.3 then
		lagSeconds = 0.3
	end
	if GetSpellCooldown(spellID) - lagSeconds <= 0 then
		return true
	end
	return false
end

function bbLib.engaugeUnit(unitName, searchRange, isMelee)
	-- Don't run when dead or targeting a friend.
	if UnitIsDeadOrGhost("player") or ( UnitExists("target") and UnitIsFriend("player", "target") ) or GetMinimapZoneText() ~= "Croaking Hollow" then return false end

	if UnitClass("player") == "Hunter" and UnitBuff("player", "Sniper Training") ~= nil then
		searchRange = searchRange + 5
	end

	-- Shorten search range if debuff is too high from frogs.
	local toxin = select(4,UnitDebuff("player", "Gulp Frog Toxin")) or 0
	if toxin > 6 then
		if UnitClass("player") == "Paladin" and GetSpellCooldown("Divine Shield") == 0 then
			Cast("Divine Shield", "player")
		end
		if UnitClass("player") == "Shaman" and GetSpellCooldown("Earth Elemental Totem") == 0 then
			Cast("Earth Elemental Totem", "player")
		end
		searchRange = 5
	end

	-- Clear targets.
	if UnitIsDeadOrGhost("target") or ( UnitIsTapped("target") and UnitThreatSituation("player", "target") and UnitThreatSituation("player", "target") < 2 )  then
		ClearTarget()
	end

	local totalObjects = ObjectCount() or 0
	local closestUnitObject
	local closestUnitDistance = 9999
	local closestUnitDirection

	-- Find closest unit.
	if not UnitExists("target") or ( UnitExists("target") and UnitIsTapped("target") and not UnitIsTappedByPlayer("target") ) then
		local objectCount = 0
		for i = 1, totalObjects do
			local object = ObjectWithIndex(i)
			if object then
				local objectName = ObjectName(object) or 0
				if objectName == unitName then
					-- TODO: Loot lootable objects! /script print(ObjectInteract("target")) ObjectTypes.Corpse = 128 ObjectTypes.Container = 4
					if UnitExists(object) and UnitIsVisible(object) and not UnitIsDeadOrGhost(object) and ( not UnitIsTapped(object) or UnitIsTappedByPlayer(object) or (UnitThreatSituation("player", object) and UnitThreatSituation("player", object) > 1) ) then
						local objectDistance = Distance("player", object)
						if objectDistance <= searchRange and objectDistance <= closestUnitDistance and LineOfSight("player", object) then
							closestUnitObject = object
							closestUnitDistance = objectDistance
							objectCount = objectCount + 1
						end
					end
				end
			else
				return false
			end
		end
		if objectCount == 0 then return false end
	end

	-- Target unit.
	if ( not UnitExists("target") and UnitExists(closestUnitObject) ) or ( UnitExists("target") and UnitExists(closestUnitObject) and not UnitIsUnit(closestUnitObject, "target") ) then
		TargetUnit(closestUnitObject)
	end

	--Face Unit
	if UnitExists("target") then
		FaceUnit("target")
	end

	-- Tap Unit
	if UnitExists("target") and not UnitIsTapped("target") and not UnitIsTappedByPlayer("target") then
		if UnitClass("player") == "Shaman" and closestUnitDistance <= 30 then
			Cast("Purge", closestUnitObject)
		end
	end

	-- Move to unit.
	-- TODO: Move back to original position after kill.
	--if closestUnitObject and UnitExists("target") and UnitExists(closestUnitObject) and UnitIsUnit(closestUnitObject, "target") and ( not UnitIsTapped(closestUnitObject) or UnitIsTappedByPlayer(closestUnitObject) ) then
		--if isMelee and closestUnitDistance <= searchRange and closestUnitDistance > 0 then
			--MoveTo(ObjectPosition(closestUnitObject))
		--	FaceUnit(closestUnitObject)
		--end
	--end

	return false
end

-- function bbLib.bossMods()
	-- -- Darkmoon Faerie Cannon
	-- --if select(7, UnitBuffID("player", 102116))
	  -- --and select(7, UnitBuffID("player", 102116)) - GetTime() < 1.07 then
		-- --CancelUnitBuff("player", "Magic Wings")
	-- --end

	-- -- Raid Boss Checks
	-- if UnitExists("boss1") then
		-- for i = 1,4 do
			-- local bossCheck = "boss"..i
			-- if UnitExists(bossCheck) then
				-- local npcID = tonumber(UnitGUID(bossCheck):sub(6, 10), 16)
				-- --local bossCasting,_,_,_,_,castEnd = UnitCastingInfo(bossCheck)
				-- --local paragons = {71161, 71157, 71156, 71155, 71160, 71154, 71152, 71158, 71153}
				-- if npcID == 71515 then  -- SoO: Paragons of the Klaxxi
					-- --if UnitBuffID("target", 71) then
						-- --SpellStopCasting()
						-- --return true
					-- --end
				-- end
			-- end
		-- end
	-- end
	-- return false
-- end

function bbLib.stackCheck(spell, otherTank, stacks)
	local name, _, _, count, _, _, _, _, _, _, spellID, _, _, _, _, _ = UnitDebuff(otherTank, spell)
	if name and count >= stacks and not UnitDebuff("player", spell) then
		return true
	end
	return false
end

-- --function bbLib.worthDotting()
-- --	if UnitHealth("target") > UnitHealth("player") or GetNumGroupMembers() < 2 then
-- --		return true
-- --	end
-- --	return false
-- --end

-- function bbLib.worthDotting()
	-- UnitHealth("target")
	-- UnitHealth("player")
	-- if GetItemCount(76097) > 1
	 -- and GetItemCooldown(76097) == 0 then
		-- return true
	-- end
	-- return false
-- end

function bbLib.bossTaunt()
	-- TODO: May be double taunting if we dont get a stack before taunt comes back up.
	-- Thanks to Rubim for the idea!
	-- Make sure we're a tank first and we're in a raid
	if IsInRaid() and UnitGroupRolesAssigned("player") == "TANK" then
		local otherTank
		if UnitExists("focus") and UnitIsFriend("player", "focus") and not UnitIsDeadOrGhost(otherTank) then
			otherTank = "focus"
		else
			otherTank = nil
		end
		-- for i = 1, GetNumGroupMembers() do
			-- local other = "raid" .. i
			-- if not otherTank and not UnitIsUnit("player", other) and UnitGroupRolesAssigned(other) == "TANK" then
				-- otherTank = other
			-- end
		-- end

		if otherTank then
			for j = 1, 4 do
				local bossID = "boss" .. j
				local boss = UnitID(bossID)
				--local boss, _ = UnitName(bossID)
				-- START Siege of Orgrimmar
				if     boss == 71543 then -- Immersus
					if bbLib.stackCheck("Corrosive Blast", otherTank, 1) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 72276 then -- Norushen
					if bbLib.stackCheck("Self Doubt", otherTank, 3) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71734 then -- Sha of Pride
					if bbLib.stackCheck("Wounded Pride", otherTank, 1) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 72249 then -- Galakras
					if bbLib.stackCheck("Flames of Galakrond", otherTank, 3) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71466 then -- Iron Juggernaut
					if bbLib.stackCheck("Ignite Armor", otherTank, 2) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71859 then -- Kor'kron Dark Shaman -- Earthbreaker Haromm
					if bbLib.stackCheck("Froststorm Strike", otherTank, 5) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71515 then -- General Nazgrim
					if bbLib.stackCheck("Sundering Blow", otherTank, 3) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71454 then -- Malkorok
					if bbLib.stackCheck("Fatal Strike", otherTank, 12) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71529 then -- Thok the Bloodsthirsty
					if bbLib.stackCheck("Panic", otherTank, 3)
					  or bbLib.stackCheck("Acid Breath", otherTank, 3)
					  or bbLib.stackCheck("Freezing Breath", otherTank, 3)
					  or bbLib.stackCheck("Scorching Breath", otherTank, 3) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71504 then -- Siegecrafter Blackfuse
					if bbLib.stackCheck("Electrostatic Charge", otherTank, 4) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71865 then -- Garrosh Hellscream
					if bbLib.stackCheck("Gripping Despair", otherTank, 3)
					  or bbLib.stackCheck("Empowered Gripping Despair", otherTank, 3) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				end
				-- END Siege of Orgrimmar

				-- START Throne of Thunder
				if boss == 69465 then -- Jin’rokh the Breaker
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Static Wound")
					local debuffName2, _, _, debuffCount2 = UnitDebuff("player", "Static Wound")
					if debuffName
					  and ( not debuffName2 or debuffCount > debuffCount2) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68476 then -- Horridon
					if bbLib.stackCheck("Triple Puncture", otherTank, 9) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69131 then -- Council of Elders - Frost King Malakk
					if bbLib.stackCheck("Frigid Assault", otherTank, 13) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69712 then -- Ji-Kun
					if bbLib.stackCheck("Talon Rake", otherTank, 2) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68036 then -- Durumu the Forgotten
					if bbLib.stackCheck("Hard Stare", otherTank, 5) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69017 then -- Primordius
					if bbLib.stackCheck("Malformed Blood", otherTank, 8) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69699 then -- Dark Animus - Massive Anima Golem -- TODO: May not show up in boss frames.
					if bbLib.stackCheck("Explosive Slam", otherTank, 5) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68078 then -- Iron Qon -- TODO: check if boss id stays same during encounter
					if bbLib.stackCheck("Impale", otherTank, 4) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68905 then -- Twin Consorts - Lu’lin
					if bbLib.stackCheck("Beast of Nightmare", otherTank, 1) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68904 then -- Twin Consorts - Suen
					if bbLib.stackCheck("Fan of Flames", otherTank, 3) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68397 then -- Lei Shen
					if bbLib.stackCheck("Decapitate", otherTank, 1)
					  or bbLib.stackCheck("Fusion Slash", otherTank, 1)
					  or bbLib.stackCheck("Overwhelming Power", otherTank, 12) then
						PossiblyEngine.dsl.parsedTarget = bossID
						return true
					end
				end
				-- END Throne of Thunder
			end
		end
	end
	return false
end

-- function bbLib.useAgiPot()
	-- -- 76089 = Virmen's Bite
	-- if GetItemCount(76089) > 1
	  -- and GetItemCooldown(76089) == 0
	  -- and ( UnitBuff("player", 3045) or PossiblyEngine.condition["player.hashero"] ) then
		-- return true
	-- end
	-- return false
-- end

-- function bbLib.useIntPot()
	-- -- 114757 = Potion of the Jade Serpent
	-- if GetItemCount(114757) > 1
	  -- and GetItemCooldown(114757) == 0 then
		-- return true
	-- end
	-- return false
-- end

-- function bbLib.useManaGem()
	-- -- 36799 = Mana Gem
	-- if GetItemCount(36799) > 0
	  -- and GetItemCooldown(36799) == 0 then
		-- return true
	-- end
	-- return false
-- end

-- function bbLib.isMounted()
	-- if IsMounted() then
		-- return true
	-- end
	-- return false
-- end

-- function bbLib.conjureManaGem()
	-- -- 36799 = Mana Gem
	-- if GetItemCount(36799) < 1 then -- TODO: make to work with charges
		-- return true
	-- end
	-- return false
-- end

-- bbLib.badMisdirectTargets = { "Kor'kron Warshaman" }
-- function bbLib.canMisdirect()
	-- local targetName = UnitName("target")
	-- for _,v in pairs(bbLib.badMisdirectTargets) do
		-- if v == targetName then
			-- return false
		-- end
	-- end
	-- return true
-- end

-- -- Thanks to PCMD
-- bbLib.darkSimSpells = { "Froststorm Bolt", "Arcane Shock", "Rage of the Empress", "Chain Lightning", "Hex", "Mind Control", "Cyclone", "Polymorph", "Pyroblast", "Tranquility", "Divine Hymn", "Hymn of Hope", "Ring of Frost", "Entangling Roots" }
-- function bbLib.canDarkSimulacrum(unit)
	-- for _,v in pairs(bbLib.darkSimSpells) do
		-- if PossiblyEngine.condition["casting"](unit, v) then
			-- return true
		-- end
	-- end
	-- return false
-- end

-- function bbLib.isTargetingMe(target)
	-- if UnitExists(target) then
		-- return UnitGUID(target.."target") == UnitGUID("player")
	-- end
	-- return false
-- end

function bbLib.highThreatOnPlayerTarget(target)
	if UnitExists(target) and UnitExists("target") then
		local threat = UnitThreatSituation(target,"target")
		if threat and threat > 0 then --not tanking, higher threat than tank.
			return true
		end
	end
	return false
end

-- function bbLib.useHealthPot()
	-- -- 76098 = Master Health Potion
	-- if GetItemCount(76097) > 1
	 -- and GetItemCooldown(76097) == 0 then
		-- return true
	-- end
	-- return false
-- end

-- function bbLib.BGFlag()
	-- if GetBattlefieldStatus(1)=='active'
	  -- or GetBattlefieldStatus(2)=='active' then
		-- InteractUnit('Horde flag')
		-- InteractUnit('Alliance flag')
	-- end
	-- return false
-- end

PossiblyEngine.library.register("bbLib", bbLib)
