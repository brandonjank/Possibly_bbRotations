-- PossiblyEngine Rotation
-- Custom Feral Druid Rotation
-- Created on Oct 15th 2014
-- PLAYER CONTROLLED:
-- SUGGESTED BUILD:
-- CONTROLS:

--TODO:  ttd, deathin, range -> distance, 
--enemies: (function() return UnitsAroundUnit('target', 10) > 2 end)
--IsBoss: (function() return IsEncounterInProgress() and SpecialUnit() end)
--SynapseSprings: (function() for i=1,9 do if select(7,GetProfessionInfo(i)) == 202 then hasEngi = true break end end if hasEngi and GetItemCooldown(GetInventoryItemID("player", 10)) == 0 then return true end return false end)
--LifeSpirit: (function() return GetItemCount(89640, false, false) > 0 and GetItemCooldown(89640) == 0 end)
--HealthStone: (function() return GetItemCount(5512, false, true) > 0 and GetItemCooldown(5512) == 0 end)
--Stats (function() return select(1,GetRaidBuffTrayAuraInfo(1)) != nil end)
--Stamina (function() return select(1,GetRaidBuffTrayAuraInfo(2)) != nil end)
--AttackPower (function() return select(1,GetRaidBuffTrayAuraInfo(3)) != nil end)
--AttackSpeed (function() return select(1,GetRaidBuffTrayAuraInfo(4)) != nil end)
--SpellPower (function() return select(1,GetRaidBuffTrayAuraInfo(5)) != nil end)
--SpellHaste (function() return select(1,GetRaidBuffTrayAuraInfo(6)) != nil end)
--CritialStrike (function() return select(1,GetRaidBuffTrayAuraInfo(7)) != nil end)
--Mastery (function() return select(1,GetRaidBuffTrayAuraInfo(8)) != nil end)


PossiblyEngine.rotation.register_custom(103, "bbDruid Feral", {
-- COMBAT ROTATION
---- Solo - This first priority list is for when you are questing or soloing content. It is assumed any target you attack will die in less then 20 seconds. You won't use  Rip in this priority.
	-- Prowl
--[[	{ "Prowl", { "!player.buff", "!player.combat" } },
	-- Apply Rake (you get  Savage Roar for free from the glyph)
	{ "Rake", "!target.debuff" },
	-- Moonfire (If Lunar Inspiration)
	{ "Moonfire", "talent(7, 1)" }, -- Lunar Inspiration
	-- Shred until 5 combo points
	{ "Shred", "player.combopoints < 5" },
	-- Ferocious Bite to finish off the target
	{ "Ferocious Bite", "player.combopoints > 4" },
	{ "Ferocious Bite", "target.health < 20" },
	-- Reapply Savage Roar if < 10 seconds
	{ "Savage Roar", "player.buff(Savage Roar).duration < 10" },
	-- Tiger's Fury if you run low on energy
	{ "Tiger's Fury", "player.energy < 40" }, ]]--

---- Single Target (Dungeon/LFR) - This priority list is for attacking a boss creature in a Dungeon/LFR.
	-- Prowl
--	{ "Prowl", { "!player.buff", "!player.combat" } },
	-- Rake
	{ "Rake", "!target.debuff(Rake)" },
	-- Moonfire (If Lunar Inspiration)
	{ "Moonfire", "talent(7, 1)" }, -- Lunar Inspiration Talent
	-- Shred until 5 combo points or you get below 20 energy
	{ "Shred", "player.combopoints < 5" },
	{ "Shred", "player.energy < 20" },
	-- Tiger's Fury/ Berserk together
	{ "Tiger's Fury", "player.spell(Berserk).cooldown < 1" },
	{ "Berserk", "player.buff(Tiger's Fury)" },
	-- Shred if you still need to reach 5 combo points
	{ "Shred", "player.combopoints < 5" },
	-- Healing Touch (If using Bloodtalons)
	{ "Healing Touch", "talent(7, 2)", "player" }, -- Bloodtalons Talent
	-- Rip
	{ "Rip", "!target.debuff(rip)" }, --- need to evaluate for smart ripping and when to reapply to keep debuff up (ie rip.duration < 3)

---- From here on the priorities are:
	-- Refresh Savage Roar before it expires
	{ "Savage Roar", "player.buff(Savage Roar).duration < 5" },
	-- Rake when it expires
	{ "Rake", "target.debuff(Rake).duration >= 2" },
	-- Moonfire when it expires (If Lunar Inspiration)
	{ "Moonfire", { "talent(7, 1)","!target.debuff(Moonfire)" } }, -- Lunar Inspiration Talent
	-- Rip when it expires
	{ "Rip", { "!target.debuff(Rip)", "target.health >= 25" } },
	-- Below 25% you can replace using Rip with Ferocious Bite which will refresh Rip back to 24 seconds. When Berserk is up it is OK to replace Shred with Shred
	{ "Ferocious Bite", { "target.debuff(Rip) < 5", "target.health < 25" } },
	-- Use Shred and Rake refreshes to build combo points
	{ "Rake", "!modifier.last" },
	{ "Shred", "!modifier.last" },
	-- (If  Bloodtalons Always use your  Healing Touch before every finisher to get  Bloodtalons charges)
	{ "Healing Touch", "talent(7, 2)", "player" }, -- Bloodtalons Talent
	-- Tiger's Fury on cooldown (below 20 energy)
	{ "Tiger's Fury", "player.energy < 20" },
	-- Berserk on cooldown
	{ "Berserk" },
	-- If you have 5 combo points and both  Savage Roar and  Rip are above 12 seconds  Ferocious Bite (this won't happen a bunch at lower gear levels).
	{ "Ferocious Bite", { "player.combopoints > 4", "target.debuff(Savage Roar).duration > 12", "target.debuff(Rip).duration > 12" } },
	-- If you get an  Omen of Clarity proc and both  Savage Roar and  Rip have more then 10 seconds left use  Thrash.
	{ "Thrash", { "player.buff(Omen of Clarity)", "target.debuff(Savage Roar).duration > 10", "target.debuff(Rip).duration > 10" } },

---- AOE (Trash/adds) - These are the abilities you will use on trash or to cleave adds.
	-- If the adds are going to live for over 10 seconds:
		-- Keep up  Savage Roar
		-- Keep Thrash up on all targets
		-- Rake every target
		-- (If  Lunar Inspiration Moonfire every target)
		-- Apply  Rip every time you get 5 combo points (most likely to your primary target)
	-- If the adds are going to live less then 10 seconds:
		-- Keep up  Savage Roar
		-- Keep Thrash up on all targets
		-- Continue single target rotation on main target
		-- You can use  Berserk/ Tiger's Fury or  Incarnation to allow you to pile on the cleave damage for a short time.

},
{	
-- OUT OF COMBAT ROTATION
	-- Pauses
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },

	-- Buffs
	{ "Mark of the Wild", (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil end) },
	
	-- Rez and Heal
	{ "Revive", { "mouseover.exists", "mouseover.dead", "mouseover.isPlayer", "mouseover.range < 40", "player.level >= 12" }, "mouseover" },
	{ "Rejuvenation", { "!player.buff(Prowl)", "!player.casting", "player.alive", "!player.buff(Rejuvenation)", "player.health <= 70" } },
	
	-- Cleanse Debuffs
	{ "Remove Corruption", "player.dispellable(Remove Corruption)" },
	
	-- Forms
	{ "Aquatic Form", { "player.swimming", "!player.buff(Aquatic Form)" }, "player" },
	{ "Cat Form", { "target.exists", "target.alive", "target.enemy", "!player.buff(Cat Form)", "player.health > 20", "!modifier.last(Cat Form)" } },
	
	-- Pre-Combat
	{ "Savage Roar", { "player.buff(Prowl)", "!player.buff(Heart of the Wild)", "player.buff(Cat Form)", "target.enemy", "target.alive", "target.range < 10" } },	
	{ "Shred", { "target.behind", "player.combopoints < 5", "player.power > 98", "target.enemy", "target.alive", "target.range < 8", "player.level >= 16" } },
	
},
-- TOGGLE BUTTONS
function()
	PossiblyEngine.toggle.create( 'boss', 'Interface\\Icons\\Ability_Creature_Cursed_02.png‎', 'Boss Function Toggle', 'Enable or Disable Specific Boss Functions to Improve DPS')
	PossiblyEngine.toggle.create( 'defensive', 'Interface\\Icons\\ability_druid_tigersroar.png‎', 'Defensive Cooldown Toggle', 'Enable or Disable the Automatic Management of Defensive Cooldowns')
end)