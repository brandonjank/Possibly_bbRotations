-- PossiblyEngine Rotation Packager
-- Custom Protection Paladin Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(66, "bbPaladin Protection", {
-- PLAYER CONTROLLED: Guardian of Ancient Kings, Divine Shield
-- SUGGESTED TALENTS: Persuit of Justice, Fist of Justice, Sacred Shield, Unbreakable Spirit, Sactified Wrath, Light's Hammer, Empowered Seals
-- SUGGESTED GLYPHS: Alabaster Shield, Ardent Defender, Final Wrath,  Righteous Retreat
-- CONTROLS: Pause - Left Control

--talent: , "talent(6, 1)"
--enemies: (function() return UnitsAroundUnit('target', 10) > 2 end) 
--IsBoss: (function() return IsEncounterInProgress() and SpecialUnit() end)
--LifeSpirit: (function() return GetItemCount(89640, false, false) > 0 and GetItemCooldown(89640) == 0 end)
--HealPot: (function() return GetItemCount(76097, false, false) > 0 and GetItemCooldown(76097) == 0 end)
--AgiPot: (function() return GetItemCount(76089, false, false) > 0 and GetItemCooldown(76089) == 0 end)
--HealthStone: (function() return GetItemCount(5512, false, true) > 0 and GetItemCooldown(5512) == 0 end)
--Stats (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil end)
--Stamina (function() return select(1,GetRaidBuffTrayAuraInfo(2)) == nil end)
--AttackPower (function() return select(1,GetRaidBuffTrayAuraInfo(3)) == nil end)
--AttackSpeed (function() return select(1,GetRaidBuffTrayAuraInfo(4)) == nil end)
--SpellPower (function() return select(1,GetRaidBuffTrayAuraInfo(5)) == nil end)
--SpellHaste (function() return select(1,GetRaidBuffTrayAuraInfo(6)) == nil end)
--CritialStrike (function() return select(1,GetRaidBuffTrayAuraInfo(7)) == nil end)
--Mastery (function() return select(1,GetRaidBuffTrayAuraInfo(8)) == nil end)

-- COMBAT ROTATION
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
	
	{ {
		-- { "Divine Shield", "player.debuff(Gulp Frog Toxin).count > 7" }, -- Divine shield does not work!?
		{ "/cancelaura Divine Shield", "player.buff(Divine Shield)" },
		{ "Blessing of Kings", "@bbLib.engaugeUnit('Gulp Frog', 30, true)" },
	},{
		"toggle.frogs",
	} },
  
	-- OFF GCD
	{ "Eternal Flame", { "talent(3, 2)", "!player.buff", "player.buff(Bastion of Glory).count > 4" }, "player" },
	{ "Eternal Flame", { "talent(3, 2)", "!player.buff", "player.buff(Bastion of Glory).count > 2", "player.health < 80" }, "player" },
	{ "Word of Glory", { "player.health < 70", "player.holypower > 4", "!talent(3, 2)" }, "player" },
	{ "Word of Glory", { "player.health < 50", "player.holypower > 2", "!talent(3, 2)" }, "player" },
	{ "Shield of the Righteous", { "player.holypower > 4" } }, --"target.spell(Crusader Strike).range"
	{ "Shield of the Righteous", { "player.buff(Divine Purpose)" } }, --"target.spell(Crusader Strike).range"

	-- Interrupts
	{ "Rebuke", "modifier.interrupt" }, --TODO: Interrupt at 50% cast
	

	
	-- Survivability
	{{
		{ "Ardent Defender", "player.health < 25" },
		{ "Lay on Hands", { "player.health < 25", "!player.buff(Ardent Defender)" } },
		{ "Holy Avenger", { "player.holypower < 3", "talent(5, 1)" } },
		{ "Divine Protection", { "player.health < 90", "target.casting.time > 0", "!player.buff(Ardent Defender)", "!player.buff(Guardian of Ancient Kings)" } },
		-- TODO: Use Survival Trinkets
	}, {
		"modifier.cooldowns",
	}},
	{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "!player.buff", "player.state.root" }, "player" },
	{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "!player.buff", "player.state.snare" }, "player" },
	{ "Sacred Shield", { "talent(3, 3)", "!player.buff" } },
	{ "#5512", { "modifier.cooldowns", "player.health < 30" } }, -- Healthstone (5512)
	{ "Cleanse", { "!modifier.last", "player.dispellable(Cleanse)" }, "player" }, -- Cleanse Poison or Disease
	
	-- BossMods
	--{ "Reckoning", { "toggle.autotaunt", "@bbLib.bossTaunt" } }, -- TODO: Fix boss mods
	{ "Hand of Sacrifice", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.debuff(Assassin's Mark)" }, "mouseover" }, -- Off GCD now
	
	-- Raid Survivability
	{ "Hand of Protection", { "toggle.usehands", "lowest.exists", "lowest.alive", "lowest.friend", "lowest.isPlayer", "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health <= 15" }, "lowest" }, -- TODO: Don't cast on tanks.
	--{ "Hand of Sacrifice", { "tank.exists", "tank.alive", "tank.friend", "tank.range <= 40", "tank.health < 75" }, "tank" }, --TODO: Only if tank is not the player.
	{ "Flash of Light", { "talent(3, 1)", "lowest.health < 50", "player.buff(Selfless Healer).count > 2" }, "lowest" },
	--{ "Flash of Light", { "player.health < 60", "!modifier.last" }, "player" },
	--{ "Hand of Purity", "talent(4, 1)", "player" }, -- TODO: Only if dots on player
	-- Hand of Salvation – Prevents a group/raid member from generating threat for a period of time or saves you the embarrassment of ripping aggro when offtanking. Useful for putting on healers when a group of adds spawns and is immediately drawn to them due to passive healing aggro.
	
	-- Mouseovers
	{{
		{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.root", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.snare", "!mouseover.buff", "player.moving" }, "mouseover" },
		{ "Hand of Salvation", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "!mouseover.role(tank)", "@bbLib.highThreatOnPlayerTarget(mouseover)" }, "mouseover" },
		{ "Cleanse", { "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.dispellable(Cleanse)" }, "mouseover" },
	}, {
		"toggle.mouseovers", "player.health > 50",
	}},
	
	-- RANGE ROTATION
	{{
		{ "Judgment" },
		{ "Avenger's Shield" }, -- TODO: Check for single shield glyph
		--{ "Holy Prism", { "!toggle.limitaoe", "talent(6, 1)" } },
		--{ "Execution Sentence", { "player.health < 70", "talent(6, 3)" }, "player" },
		--{ "Execution Sentence", { "player.health > 70", "talent(6, 3)" }, "target" },
		--{ "Holy Prism", { "player.health < 71", "talent(6, 1)" }, "player" },
		--{ "Holy Prism", { "!toggle.limitaoe", "player.health > 70", "talent(6, 1)" }, "target" },
	}, {
		"target.distance > 5",
	}},
	
	-- MELEE ROTATION
	{ "Avenger's Shield", "player.buff(Grand Crusader)" }, -- TODO: Check for single shield glyph
	{ "Hammer of the Righteous", (function() return UnitsAroundUnit('target', 10) > 1 end) },
	{ "Crusader Strike", (function() return UnitsAroundUnit('target', 10) < 2 end) },
	{ "Holy Wrath", { "talent(5, 2)", "!toggle.limitaoe", "target.distance < 5" } },
	{ "Consecration", { "!toggle.limitaoe", "target.distance < 5", (function() return UnitsAroundUnit('target', 10) > 3 end) } }, -- TODO: use target.ground if glyphed
	{ "Judgment", true, "target" },
	--{ "Seal of Insight", { "!modifier.last", "!player.buff", "!player.buff(Seal of Truth)" } },
	--{ "Seal of Truth" { "talent(7, 1)", "!modifier.last", "!player.buff", "!player.buff(Seal of Righteousness)" } }, -- TODO: For T7 Talent Empowered Seals
	--{ "Seal of Righteousness" { "talent(7, 1)", "!modifier.last", "!player.buff", "!player.buff(Seal of Insight)" } }, -- TODO: For T7 Talent Empowered Seals
	--{ "Execution Sentence", { "talent(6, 3)", "player.health < 71" }, "player" },
	--{ "Execution Sentence", { "talent(6, 3)", "player.health > 70" }, "target" },
	{ "Avenger's Shield", true, "target" },
	{ "Consecration", { "!toggle.limitaoe", "target.distance < 5", (function() return UnitsAroundUnit('target', 10) > 2 end) } }, -- TODO: use target.ground if glyphed
	{ "Holy Wrath", { "talent(5, 2)", "!toggle.limitaoe", "target.distance < 5", (function() return UnitsAroundUnit('target', 10) < 3 end) } },
	{ "Hammer of Wrath", "target.health <= 20" },
	{ "Light's Hammer", "talent(6, 2)", "target.ground" },
	--{ "Holy Prism", { "talent(6, 1)", "player.health < 71" }, "player" },
	--{ "Holy Prism", { "talent(6, 1)", "!toggle.limitaoe", "player.health > 70" }, "target" },
	{ "Consecration", { "!toggle.limitaoe", "target.distance < 5" } }, -- TODO: use target.ground if glyphed
	{ "Holy Wrath", { "!toggle.limitaoe", "target.distance < 5" } },
	
},{
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Blessings
	{ "Blessing of Kings", { "!modifier.last", (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil and select(1,GetRaidBuffTrayAuraInfo(8)) == nil end) } }, -- TODO: If no Monk or Druid in group.
	{ "Blessing of Might", { "!modifier.last", (function() return select(1,GetRaidBuffTrayAuraInfo(8)) == nil end), "!player.buff(Blessing of Kings)", "!player.buff(Blessing of Might)" } },

	-- Stance
	{ "Righteous Fury", { "!player.buff(Righteous Fury)", "!modifier.last" } },
	{ "Seal of Insight", { "player.seal != 3", "!modifier.last" } },
	

	{ {
		{ "/cancelaura Divine Shield", "player.buff(Divine Shield)" },
		{ "Blessing of Kings", "@bbLib.engaugeUnit('Gulp Frog', 30, true)" },
		{ "Reckoning", true, "target" },
		{ "Avenger's Shield", true, "target" },
		{ "Judgment", true, "target" },
	},{
		"toggle.frogs"
	} },
	
  
},
function()
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Use Mouseovers', 'Automatically cast spells on mouseover targets.')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to not use AoE spells to avoid breaking CC.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks.')
	PossiblyEngine.toggle.create('usehands', 'Interface\\Icons\\spell_holy_sealofprotection', 'Use Hands', 'Toggles usage of Hand spells such as Hand of Protection.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
