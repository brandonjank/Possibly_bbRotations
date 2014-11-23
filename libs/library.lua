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

-- GetFollowDistance(), SetFollowDistance(Distance), GetFollowTarget(), SetFollowTarget(Target).
--SetFollowDistance(5)
-- WorldToScreen and GetCameraPosition
-- UnitCanInteract(Unit, Other). Other can be a unit or game object.


function bbLib.prePot()
	-- DBM Options -> Global and Spam Filters -> un-check "Do not show Pull/Break Timer bar"
	-- /script if DBM.Bars.numBars and DBM.Bars.numBars > 0 then for bar in pairs(DBM.Bars.bars) do if bar.id == "Pull in" and bar.timer < 3 then print("Found pull bar! ID: "..bar.id.."  Time Left: "..bar.timer.."  Total Time: "..bar.totalTime) end end end
	if DBM.Bars.numBars and DBM.Bars.numBars > 0 then
		for bar in pairs(DBM.Bars.bars) do
			if bar.id == "Pull in" and bar.timer < 3 then
				-- print("Found pull bar! ID: "..bar.id.."  Time Left: "..bar.timer.."  Total Time: "..bar.totalTime)
				return true
				-- TODO: force usage of pot because pe is dumb. based on class
			end
		end
	end
	return false
end

function bbLib.NeedHealsAroundUnit(spell, unit, count, distance, threshold)
	if not unit or ( unit and unit == 'lowest' ) then
		unit = PossiblyEngine.raid.lowestHP(spell)
	end
	if UnitExists(unit) then
		if not count then count = 2 end
		if not distance then distance = 15 end
		if not threshold then threshold = 80 end
		local total = 0
		local totalObjects = ObjectCount() or 0
		for i = 1, totalObjects do
			local object = ObjectWithIndex(i)
			if ObjectExists(object) and ObjectIsType(object, ObjectTypes.Player)
				and UnitCanAssist("player", object)
				and ((UnitHealth(object) / UnitHealthMax(object)) * 100) <= threshold
				and Distance(object, unit) <= distance then
					total = total + 1
			end
			if total >= count then return true end
		end
	end
	return false
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

function bbLib.rateLimit(miliseconds)
    return ((GetTime()*1000) % miliseconds) == 0
end


function bbLib.engaugeUnit(unitName, searchRange, isMelee)
	if UnitIsDeadOrGhost("player")
		or ( UnitExists("target") and UnitIsFriend("player", "target") )
		or ((UnitHealth("player") / UnitHealthMax("player")) * 100) < 60 then
			return false
	end

	if UnitClass("player") == "Hunter" and UnitBuff("player", "Sniper Training") ~= nil then
		searchRange = searchRange + 5
	end

	-- local toxin = select(4,UnitDebuff("player", "Gulp Frog Toxin")) or 0
	-- if toxin > 3 then
	-- 	if UnitClass("player") == "Paladin" and GetSpellCooldown("Divine Shield") == 0 then
	-- 		Cast("Divine Shield", "player")
	-- 	elseif UnitClass("player") == "Shaman" and GetSpellCooldown("Earth Elemental Totem") == 0 then
	-- 		Cast("Earth Elemental Totem", "player")
	-- 	end
	-- 	searchRange = 3
	-- end

	if UnitExists("target") then
		if UnitIsDeadOrGhost("target")
			or ( UnitIsTapped("target") and not UnitIsTappedByPlayer("target")
			and UnitThreatSituation("player", "target")
			and UnitThreatSituation("player", "target") < 2 ) then
				ClearTarget()
		end
	end

	-- Find closest unit.
	if not UnitExists("target") then
		local totalObjects = ObjectCount() or 0
		local closestUnitObject = nil
		local closestUnitDistance = 9999
		local objectCount = 0
		for i = 1, totalObjects do
			local object = ObjectWithIndex(i)
			if ObjectExists(object) then
				local objectName = ObjectName(object) or 0
				if string.find(objectName, unitName) ~= nil then
					-- TODO: Loot lootable objects! /script print(ObjectInteract("target")) ObjectTypes.Corpse = 128 ObjectTypes.Container = 4
					if UnitExists(object) and UnitIsVisible(object) and not UnitIsDeadOrGhost(object) then
						if not UnitIsTapped(object) or UnitIsTappedByPlayer(object)
							or ( UnitThreatSituation("player", object) and UnitThreatSituation("player", object) > 1 ) then
								local objectDistance = Distance("player", object)
								if objectDistance <= searchRange and objectDistance < closestUnitDistance and LineOfSight("player", object) then
									closestUnitObject = object
									closestUnitDistance = objectDistance
									objectCount = objectCount + 1
								end
						end
					end
				end
			else
				return false
			end
		end
		if objectCount == 0 or closestUnitObject == nil then return false end
		TargetUnit(closestUnitObject)
		FaceUnit(closestUnitObject)
	end

	-- Always Face Target
	--if UnitExists("target") then
	--	FaceUnit("target")
	--end

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

function bbLib.bossMods()
	-- Darkmoon Faerie Cannon
	-- if select(7, UnitBuffID("player", 102116))
	--   and select(7, UnitBuffID("player", 102116)) - GetTime() < 1.07 then
	-- 	CancelUnitBuff("player", "Magic Wings")
	-- end

	-- -- Raid Boss Checks
	-- if UnitExists("boss1") then
	-- 	for i = 1,4 do
	-- 		local bossCheck = "boss"..i
	-- 		if UnitExists(bossCheck) then
	-- 			local npcID = tonumber(UnitGUID(bossCheck):sub(6, 10), 16)
	-- 			--local bossCasting,_,_,_,_,castEnd = UnitCastingInfo(bossCheck)
	-- 			--local paragons = {71161, 71157, 71156, 71155, 71160, 71154, 71152, 71158, 71153}
	-- 			if npcID == 71515 then  -- SoO: Paragons of the Klaxxi
	-- 				--if UnitBuffID("target", 71) then
	-- 					--SpellStopCasting()
	-- 					--return true
	-- 				--end
	-- 			end
	-- 		end
	-- 	end
	-- end
	-- StrafeRightStart() StrafeRightStop()

	if UnitExists("target") and (UnitBuff("target", "Reckless Provocation") -- Iron Docks - Fleshrender
		or UnitBuff("target", "Sanguine Sphere")) then -- Iron Docks - Enforcers
			SpellStopCasting()
			--StopAttack()
			return true
	end

	if UnitBuff("player", "Food")
		or GetNumLootItems() > 0 then
			return true
	end

	return false
end

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
		if UnitExists("focus") and UnitIsFriend("player", "focus") and not UnitIsDeadOrGhost("focus") then
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

function bbLib.isMounted()
	if IsMounted() then
		return true
	end
	return false
end

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

-- Thanks to PCMD
bbLib.darkSimSpells = { "Froststorm Bolt", "Arcane Shock", "Rage of the Empress", "Chain Lightning", "Hex", "Mind Control", "Cyclone", "Polymorph", "Pyroblast", "Tranquility", "Divine Hymn", "Hymn of Hope", "Ring of Frost", "Entangling Roots" }
function bbLib.canDarkSimulacrum(unit)
	for _,v in pairs(bbLib.darkSimSpells) do
 		if PossiblyEngine.condition["casting"](unit, v) then
			return true
		end
	end
	return false
end

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

function bbLib.isNPC(unit)
	if unit and UnitExists(unit) then
		if string.find(UnitGUID(unit), "Creature") and UnitReaction("player", unit) == 5 then
			return true
		end
	end
	return false
end

function bbLib.isPlayer(unit)
	if unit and UnitExists(unit) then
		if string.find(UnitGUID(unit), "Player") then
			return true
		end
	end
	return false
end

function bbLib.isCreature(unit)
	if unit and UnitExists(unit) then
		if string.find(UnitGUID(unit), "Creature") then
			return true
		end
	end
	return false
end

function bbLib.isPet(unit)
	if unit and UnitExists(unit) then
		if string.find(UnitGUID(unit), "Pet") then
			return true
		end
	end
	return false
end

function bbLib.isGameObject(unit)
	if unit and UnitExists(unit) then
		if string.find(UnitGUID(unit), "GameObject") then
			return true
		end
	end
	return false
end

function bbLib.isVehicle(unit)
	if unit and UnitExists(unit) then
		if string.find(UnitGUID(unit), "Vehicle") then
			return true
		end
	end
	return false
end

function bbLib.isVignette(unit)
	if unit and UnitExists(unit) then
		if string.find(UnitGUID(unit), "Vignette") then
			return true
		end
	end
	return false
end

function bbLib.isTank(unit)
	if unit and UnitExists(unit) then
		if GetPartyAssignment("MAINTANK", unit) or UnitGroupRolesAssigned(unit) == "TANK" then
			return true
		end
	end
	return false
end

function bbLib.isNotTank(unit)
	if unit and UnitExists(unit) then
		if GetPartyAssignment("MAINTANK", unit) or UnitGroupRolesAssigned(unit) == "TANK" then
			return false
		end
	end
	return true
end

function bbLib.canDireBeast()
  local _, activeRegen = GetPowerRegen()
  local DBname, _, _, DBcastTime = GetSpellInfo("Dire Beast")
	local ASname, _, _, AScastTime = GetSpellInfo("Aimed Shot")
  if DBname and ASname and activeRegen then
    local db_cast_regen = DBcastTime/1000 * activeRegen
		local as_cast_regen = AScastTime/1000 * activeRegen
    local focus_deficit = UnitPowerMax("player", 2) - UnitPower("player", 2)
		return (db_cast_regen + as_cast_regen) < focus_deficit
  end
  return false
end

function bbLib.poolSteady()
	local _, activeRegen = GetPowerRegen()
	local name, _, _, castTime = GetSpellInfo("Steady Shot")
	local start, duration, enabled = GetSpellCooldown("Rapid Fire")
	if name and activeRegen and start then
		local rapid_cooldown = 0
		if start ~= 0 then rapid_cooldown = start + duration - GetTime() end
		if castTime == 0 then castTime = 1500 end
		local cast_regen = castTime/1000 * activeRegen
		local focus_deficit = UnitPowerMax("player", 2) - UnitPower("player", 2)
		if focus_deficit == 0 then focus_deficit = 1 end
		return (focus_deficit * (castTime/1000) % (14 + cast_regen)) > rapid_cooldown
	end
	return false
end

function bbLib.poolFocusing()
	local _, activeRegen = GetPowerRegen()
	local name, _, _, castTime = GetSpellInfo("Focusing Shot")
	local start, duration, enabled = GetSpellCooldown("Rapid Fire")
	if name and activeRegen and start then
		local rapid_cooldown = 0
		if start ~= 0 then rapid_cooldown = start + duration - GetTime() end
		if castTime == 0 then castTime = 1500 end
		local cast_regen = castTime/1000 * activeRegen
		local focus_deficit = UnitPowerMax("player", 2) - UnitPower("player", 2)
		if focus_deficit == 0 then focus_deficit = 1 end
		return (focus_deficit * (castTime/1000) % (50 + cast_regen)) > rapid_cooldown
	end
	return false
end

function bbLib.steadyFocus()
	local _, activeRegen = GetPowerRegen()
	local SSname, _, _, SScastTime = GetSpellInfo("Steady Shot")
	local ASname, _, _, AScastTime = GetSpellInfo("Aimed Shot")
	if SSname and ASname and activeRegen then
		local ss_cast_regen = SScastTime/1000 * activeRegen
		local as_cast_regen = AScastTime/1000 * activeRegen
		local focus_deficit = UnitPowerMax("player", 2) - UnitPower("player", 2)
		return (14 + ss_cast_regen + as_cast_regen) <= focus_deficit
	end
	return false
end

function bbLib.aimedShot()
	local _, activeRegen = GetPowerRegen()
	local name, _, _, castTime = GetSpellInfo("Aimed Shot")
	if name and activeRegen then
		local cast_regen = castTime/1000 * activeRegen
		local focus = UnitPower("player", 2)
		local minFocus = 85
		if UnitBuff("player", "Thrill of the Hunt") then minFocus = 65 end
		return (focus + cast_regen) >= minFocus
	end
	return false
end

function bbLib.focusingShot()
	local _, activeRegen = GetPowerRegen()
	local name, _, _, castTime = GetSpellInfo("Focusing Shot")
	if name and activeRegen then
		local cast_regen = castTime/1000 * activeRegen
		local focus_deficit = UnitPowerMax("player", 2) - UnitPower("player", 2)
		return (50 + cast_regen - 10) < focus_deficit
	end
	return false
end

-- START SHADOW PRIEST
function bbLib.PriestCoPAdvancedMFIDots()
	--(shadow_orb>=4|target.dot.shadow_word_pain.ticking|target.dot.vampiric_touch.ticking|target.dot.devouring_plague.ticking)
	if UnitPower(target, SPELL_POWER_SHADOW_ORBS) >= 4
		or UnitAura("target", "Shadow Word: Pain", nil, "HARMFUL|PLAYER")
		or UnitAura("target", "Vampiric Touch", nil, "HARMFUL|PLAYER")
		or UnitAura("target", "Devouring Plague", nil, "HARMFUL|PLAYER") then
			return true
	end
	return false
end

function bbLib.PriestCoPAdvancedMFIDotsMindSpike()
	--((target.dot.shadow_word_pain.ticking&target.dot.shadow_word_pain.remains<gcd)|(target.dot.vampiric_touch.ticking&target.dot.vampiric_touch.remains<gcd))&!target.dot.devouring_plague.ticking
	if UnitAura("target", "Devouring Plague", nil, "HARMFUL|PLAYER") == nil then
		local SWPname, _, _, _, _, _, SWPexpires = UnitAura("target", "Shadow Word: Pain", nil, "HARMFUL|PLAYER")
		local VTname, _, _, _, _, _, VTexpires = UnitAura("target", "Vampiric Touch", nil, "HARMFUL|PLAYER")
		local MSname, _, _, MScastTime = GetSpellInfo("Mind Spike")
		if ( SWPname and SWPexpires - GetTime() < MScastTime )
		or ( VTname and VTexpires - GetTime() < MScastTime ) then
			return true
		end
	end
	return false
end

function bbLib.PriestCoPAdvancedMFIDotsMindSpikeX2()
	--((target.dot.shadow_word_pain.ticking&target.dot.shadow_word_pain.remains<gcd)|(target.dot.vampiric_touch.ticking&target.dot.vampiric_touch.remains<gcd))&!target.dot.devouring_plague.ticking
	if UnitAura("target", "Devouring Plague", nil, "HARMFUL|PLAYER") == nil then
		local SWPname, _, _, _, _, _, SWPexpires = UnitAura("target", "Shadow Word: Pain", nil, "HARMFUL|PLAYER")
		local VTname, _, _, _, _, _, VTexpires = UnitAura("target", "Vampiric Touch", nil, "HARMFUL|PLAYER")
		local MSname, _, _, MScastTime = GetSpellInfo("Mind Spike")
		if ( SWPname and SWPexpires - GetTime() < MScastTime )
		or ( VTname and VTexpires - GetTime() < 2 * MScastTime ) then
			return true
		end
	end
	return false
end

function bbLib.PriestCoPAdvancedMFIDotsInsanity()
	--buff.shadow_word_insanity.remains<0.5*gcd
	if UnitAura("target", "Devouring Plague", nil, "HARMFUL|PLAYER") == nil then
		local SWPname, _, _, _, _, _, SWPexpires = UnitAura("target", "Shadow Word: Pain", nil, "HARMFUL|PLAYER")
		local VTname, _, _, _, _, _, VTexpires = UnitAura("target", "Vampiric Touch", nil, "HARMFUL|PLAYER")
		local MSname, _, _, MScastTime = GetSpellInfo("Mind Spike")
		if ( SWPname and SWPexpires - GetTime() < MScastTime )
		or ( VTname and VTexpires - GetTime() < MScastTime ) then
			return true
		end
	end
	return false
end
-- END SHADOW PRIEST

-- START BALANCE DRUID
--[[
PossiblyEngine.condition.register("balance.eclipsechange", function(target, spell)
  -- Eclipse power goes from -100 to 100, and its use as solar or lunar power is determined by what buff is active on the player.
  -- Buffs activate at -100 and 11 respectively and remain on the player until the power crosses the 0 threshold.
  -- moon == moving toward Lunar Eclipse
  -- sun == moving toward Solar Eclipse
  -- /script print("Eclipse direction: "..GetEclipseDirection().."  Eclipse: "..UnitPower("player", 8))
    if not spell then return false end
    local direction = GetEclipseDirection()
    if not direction or direction == "none" then return false end
    local name, _, _, casttime = GetSpellInfo(spell)
    if name and casttime then casttime = casttime / 1000 else return false end
    local eclipse = UnitPower("player", 8)
    local timetozero = 0
    local eclipsepersecond = 5

    -- Euphoria Check
    local group = GetActiveSpecGroup()
    local _, _, _, selected, active = GetTalentInfo(7, 1, group)
    if selected and active then
      eclipsepersecond = 10
    end

    if direction == "moon" and eclipse > 0 then
      timetozero = eclipse / eclipsepersecond
    elseif direction == "moon" and eclipse <= 0 then
      timetozero = ( 100 + ( 100 - math.abs(eclipse) ) ) / eclipsepersecond
    elseif direction == "sun" and eclipse >= 0 then
      timetozero = ( 100 + ( 100 - eclipse ) ) / eclipsepersecond
    elseif direction == "sun" and eclipse < 0 then
      timetozero = math.abs(eclipse) / eclipsepersecond
    end

    if timetozero > casttime then return true end
    return false
end)
]]--
-- END BALANCE DRUID

function bbTest()
    if UnitBuff("player", "Lunar Peak") then return 0 end
    local direction = GetEclipseDirection()
    local eclipse = UnitPower("player", 8)
    if not direction or not eclipse or direction == "none" then return 999 end
    local eclipsepersecond = 10

    -- Euphoria Check
    local group = GetActiveSpecGroup()
    local _, _, _, selected, active = GetTalentInfo(7, 1, group)
    if selected and active then
      eclipsepersecond = 20
    end

    if direction == "moon" and eclipse < 0 then
      return (100 - abs(eclipse)) / eclipsepersecond
    elseif direction == "moon" and eclipse >= 0 then
      return (100 + eclipse) / eclipsepersecond
    elseif direction == "sun" and eclipse < 0 then
      return (300 + abs(eclipse)) / eclipsepersecond
    elseif direction == "sun" and eclipse >= 0 then
      return (200 + (100 - eclipse)) / eclipsepersecond
    end

    return 999
end


PossiblyEngine.library.register("bbLib", bbLib)

-- TODO: Auto accept rez AcceptResurrect()
if not myErrorFrame then
	local myErrorFrame = CreateFrame('Frame')
	myErrorFrame:RegisterEvent('UI_ERROR_MESSAGE')
	myErrorFrame:SetScript('OnEvent', function(self, event, message)
		if message then
			-- Face Target on Error
			if string.find(message, "front of you") and UnitExists("target") and select(1,GetUnitSpeed("player")) == 0 then
				FaceUnit("target")
			end

			-- Shapeshift Errors
			--local ssmessages = { ERR_MOUNT_SHAPESHIFTED, ERR_NO_ITEMS_WHILE_SHAPESHIFTED, ERR_NOT_WHILE_SHAPESHIFTED, ERR_TAXIPLAYERSHAPESHIFTED, ERR_CANT_INTERACT_SHAPESHIFTED }
			if string.find(message, "shapeshifted") and GetShapeshiftForm() ~= 0 then
				--for amessage in ssmessages do
					--if message == amessage then
						CancelShapeshiftForm()
					--end
				--end
			end
		end
	end)
end
