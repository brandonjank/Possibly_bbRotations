-- PossiblyEngine Rotation Packager
-- Custom Protection Paladin Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(66, "bbProtectionPaladin", {
-- PLAYER CONTROLLED: Guardian of Ancient Kings, Divine Shield, Devotion Aura
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Light's Hammer - Left Alt

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	--{ "pause", "@bbLib.bossMods" },
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Racials
	{ "Stoneform", "player.health <= 65" },
	{ "Every Man for Himself", "player.state.charm" },
	{ "Every Man for Himself", "player.state.fear" },
	{ "Every Man for Himself", "player.state.incapacitate" },
	{ "Every Man for Himself", "player.state.sleep" },
	{ "Every Man for Himself", "player.state.stun" },
  
	-- OFF GCD
	{ "Word of Glory", {"player.health < 65", "player.holypower > 4" } },
	{ "Word of Glory", {"player.health < 30", "player.holypower > 1" } },
	{ "Shield of the Righteous", { "target.spell(Crusader Strike).range", "player.holypower > 4" } },
	{ "Shield of the Righteous", { "target.spell(Crusader Strike).range", "player.buff(Divine Purpose)" } },
  
	-- Seals
	{ "Seal of Insight", "player.seal != 3" },

	-- Interrupts
	{ "Avenger's Shield", "modifier.interrupts" }, 
	{ "Rebuke", "modifier.interrupt" }, --TODO: Interrupt at 50% cast
	
	--Cooldowns
	{{
		{ "Ardent Defender", "player.health < 25" },
		{ "Lay on Hands", { "player.health < 25", "!player.buff(Ardent Defender)" } },
		{ "Avenging Wrath", "target.boss" },
		{ "Holy Avenger", { "player.holypower < 2", "target.boss" } },  -- T5
		{ "Divine Protection", { "player.health < 70", "target.casting.time > 0", "!player.buff(Ardent Defender)", "!player.buff(Guardian of Ancient Kings)" } },
		-- TODO: Use Survival Trinkets
	}, {
		"modifier.cooldowns",
	}},
	
	-- Survivability
	{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "!player.buff", "player.state.root" }, "player" },
	{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "!player.buff", "player.state.snare" }, "player" },
	{ "Eternal Flame", "player.buff(Eternal Flame).duration < 3" }, -- T3
	{ "Sacred Shield", "player.buff(Sacred Shield).duration < 3" }, -- T3
	{ "#5512", { "modifier.cooldowns", "player.health < 30" } }, -- Healthstone (5512)
	{ "Cleanse", { "!modifier.last(Cleanse)", "player.dispellable(Cleanse)" }, "player" }, -- Cleanse Poison or Disease
	
	-- BossMods
	{ "Reckoning", { "toggle.autotaunt", "@bbLib.bossTaunt" } },
	{ "Hand of Sacrifice", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.debuff(Assassin's Mark)" }, "mouseover" },
	
	-- Raid Survivability
	{ "Hand of Protection", { "toggle.usehands", "lowest.exists", "lowest.alive", "lowest.friend", "lowest.isPlayer", "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health <= 15" }, "lowest" },
	--{ "Hand of Sacrifice", { "tank.exists", "tank.alive", "tank.friend", "tank.range <= 40", "tank.health < 75" }, "tank" }, --TODO: !tank.player
	{ "Flash of Light", { "lowest.health < 50", "player.buff(Selfless Healer).count > 2" }, "lowest" }, -- T3
	{ "Flash of Light", { "player.health < 70", "player.buff(Selfless Healer).count > 2", "player.buff(Bastion of Glory)" }, "player" }, -- T3
	
	-- Mouseovers
	{ "Light's Hammer", { "modifier.lalt" }, "ground" },
	{{
		{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.root", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.snare", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Salvation", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "!mouseover.role(tank)", "@bbLib.highThreatOnPlayerTarget(mouseover)" }, "mouseover" },
		{ "Cleanse", { "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.dispellable(Cleanse)" }, "mouseover" },
	}, {
		"toggle.mouseovers",
		"player.health > 50",
	}},
	
	-- Out of Melee
	{{
		{ "Judgment" },
		{ "Avenger's Shield" },
		{ "Holy Prism" }, --T6
		{ "Execution Sentence", "player.health < 70", "player" }, --T6
		{ "Execution Sentence", "player.health > 70", "target" }, --T6
	}, {
		"!target.spell(Crusader Strike).range",
	}},
	
	-- DPS Rotation
	{ "Avenger's Shield", { "modifier.multitarget", "modifier.enemies > 9" } },
	{ "Judgment", "player.spell(Sanctified Wrath).exists" },
	{ "Hammer of the Righteous", "modifier.multitarget" },
	{ "Crusader Strike", "!modifier.multitarget" },
	{ "Judgment" },
	{ "Consecration", { "modifier.multitarget", "target.spell(Crusader Strike).range", "!player.buff(Grand Crusader)" } },
	{ "Avenger's Shield" },
	{ "Holy Prism" }, --T6
	{ "Execution Sentence", "player.health < 70", "player" }, --T6
	{ "Execution Sentence", "player.health > 70", "target" }, --T6
	{ "Hand of Purity", true, "player" },  -- T4
	{ "Holy Wrath", { "target.spell(Crusader Strike).range", "!toggle.limitaoe" } },
	{ "Hammer of Wrath", "!toggle.limitaoe" },
	{ "Consecration", { "target.spell(Crusader Strike).range", "!toggle.limitaoe", "!player.moving" } },
	
},{
-- OUT OF COMBAT ROTATION

	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Blessings
	{ "Blessing of Might", "!player.buff(Blessing of Might).any" },
	{ "Blessing of Kings", { "!player.buff(Blessing of Kings).any", "!player.buff(Blessing of Might)" } },


	-- Stance
	{ "Righteous Fury", "!player.buff(Righteous Fury)" },
  
},
function()
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Use Mouseovers', 'Automatically cast spells on mouseover targets')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
	PossiblyEngine.toggle.create('usehands', 'Interface\\Icons\\spell_holy_sealofprotection', 'Use Hands', 'Toggles usage of Hand spells such as Hand of Protection.')
end)
