-- PossiblyEngine Rotation Packager
-- Custom Protection Paladin Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(66, "bbProtectionPaladin", {
-- PLAYER CONTROLLED: Guardian of Ancient Kings, Divine Shield
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Light's Hammer - Left Alt

--talent: , "talent(6, 1)"
--enemies: (function() return UnitsAroundUnit('target', 10) > 2 end) 
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

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	--{ "pause", "@bbLib.bossMods" },
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Racials
	-- { "Stoneform", "player.health <= 65" },
	-- { "Every Man for Himself", "player.state.charm" },
	-- { "Every Man for Himself", "player.state.fear" },
	-- { "Every Man for Himself", "player.state.incapacitate" },
	-- { "Every Man for Himself", "player.state.sleep" },
	-- { "Every Man for Himself", "player.state.stun" },
  
	-- OFF GCD
	{ "Word of Glory", {"player.health < 70", "player.holypower > 4" } },
	{ "Word of Glory", {"player.health < 30", "player.holypower > 1" } },
	{ "Shield of the Righteous", { "target.spell(Crusader Strike).range", "player.holypower > 4" } },
	{ "Shield of the Righteous", { "target.spell(Crusader Strike).range", "player.buff(Divine Purpose)" } },
  
	-- Seals
	{ "Seal of Insight", { "player.seal != 3", "!modifier.last" } },

	-- Interrupts
	{ "Rebuke", "modifier.interrupt" }, --TODO: Interrupt at 50% cast
	
	-- Survivability
	{{
		{ "Ardent Defender", "player.health < 25" },
		{ "Lay on Hands", { "player.health < 25", "!player.buff(Ardent Defender)" } },
		{ "Holy Avenger", { "player.holypower < 2", "target.boss", "talent(5, 1)" } },
		{ "Divine Protection", { "player.health < 70", "target.casting.time > 0", "!player.buff(Ardent Defender)", "!player.buff(Guardian of Ancient Kings)" } },
		-- TODO: Use Survival Trinkets
	}, {
		"modifier.cooldowns",
	}},
	{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "!player.buff", "player.state.root" }, "player" },
	{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "!player.buff", "player.state.snare" }, "player" },
	{ "Eternal Flame", "player.buff(Eternal Flame).duration < 3", "talent(3, 2)" },
	{ "Sacred Shield", "player.buff(Sacred Shield).duration < 3", "talent(3, 3)" },
	{ "#5512", { "modifier.cooldowns", "player.health < 30" } }, -- Healthstone (5512)
	{ "Cleanse", { "!modifier.last", "player.dispellable(Cleanse)" }, "player" }, -- Cleanse Poison or Disease
	
	-- BossMods
	--{ "Reckoning", { "toggle.autotaunt", "@bbLib.bossTaunt" } }, -- TODO: Fix boss mods
	{ "Hand of Sacrifice", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.debuff(Assassin's Mark)" }, "mouseover" }, -- Off GCD now
	
	-- Raid Survivability
	{ "Hand of Protection", { "toggle.usehands", "lowest.exists", "lowest.alive", "lowest.friend", "lowest.isPlayer", "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health <= 15" }, "lowest" },
	--{ "Hand of Sacrifice", { "tank.exists", "tank.alive", "tank.friend", "tank.range <= 40", "tank.health < 75" }, "tank" }, --TODO: Only if tank is not the player.
	{ "Flash of Light", { "lowest.health < 50", "player.buff(Selfless Healer).count > 2" }, "lowest" }, -- T3
	{ "Flash of Light", { "player.health < 70", "player.buff(Selfless Healer).count > 2", "player.buff(Bastion of Glory)" }, "player" }, -- T3
	--{ "Hand of Purity", "talent(4, 1)", "player" }, -- TODO: Only if dots on player
	
	-- Mouseovers
	{{
		{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.root", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.snare", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Salvation", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "!mouseover.role(tank)", "@bbLib.highThreatOnPlayerTarget(mouseover)" }, "mouseover" },
		{ "Cleanse", { "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.dispellable(Cleanse)" }, "mouseover" },
	}, {
		"toggle.mouseovers",
		"player.health > 50",
	}},
	
	-- RANGE ROTATION
	{{
		{ "Judgment" },
		{ "Avenger's Shield" },
		{ "Holy Prism", "talent(6, 1)" },
		{ "Execution Sentence", { "player.health < 70", "talent(6, 3)" }, "player" },
		{ "Execution Sentence", { "player.health > 70", "talent(6, 3)" }, "target" },
		{ "Holy Prism", { "player.health < 71", "talent(6, 1)" }, "player" },
		{ "Holy Prism", { "player.health > 70", "talent(6, 1)" }, "target" },
	}, {
		"!target.spell(Crusader Strike).range",
	}},
	
	-- MELEE ROTATION
	{ "Avenger's Shield", "player.buff(Grand Crusader)" }, -- Check for single shield glyph
	-- Shield of the Righteous
	{ "Hammer of the Righteous", (function() return UnitsAroundUnit('target', 10) > 1 end) },
	{ "Crusader Strike", (function() return UnitsAroundUnit('target', 10) < 2 end) },
	{ "Holy Wrath", { "!toggle.limitaoe", "target.spell(Crusader Strike).range", "talent(5, 2)" } },
	{ "Judgment" },
	{ "Execution Sentence", { "player.health < 71", "talent(6, 3)" }, "player" },
	{ "Execution Sentence", { "player.health > 70", "talent(6, 3)" }, "target" },
	{ "Avenger's Shield" },
	{ "Hammer of Wrath", "!toggle.limitaoe" },
	{ "Light's Hammer", "talent(6, 2)", "target.ground" },
	{ "Holy Prism", { "player.health < 71", "talent(6, 1)" }, "player" },
	{ "Holy Prism", { "player.health > 70", "talent(6, 1)" }, "target" },
	{ "Consecration", { "!toggle.limitaoe", "target.spell(Crusader Strike).range" } },
	{ "Holy Wrath", { "!toggle.limitaoe", "target.spell(Crusader Strike).range" } },
	
	
	
	
},{
-- OUT OF COMBAT ROTATION

	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Blessings
	{ "Blessing of Might", "!player.buff(Blessing of Might).any" },
	{ "Blessing of Kings", { "!player.buff(Blessing of Kings).any", "!player.buff(Blessing of Might)" } },

	-- Stance
	{ "Righteous Fury", { "!player.buff(Righteous Fury)", "!modifier.last" } },
	{ "Seal of Insight", { "player.seal != 3", "!modifier.last" } },
  
},
function()
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Use Mouseovers', 'Automatically cast spells on mouseover targets.')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks.')
	PossiblyEngine.toggle.create('usehands', 'Interface\\Icons\\spell_holy_sealofprotection', 'Use Hands', 'Toggles usage of Hand spells such as Hand of Protection.')
end)
