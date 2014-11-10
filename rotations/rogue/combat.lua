-- PossiblyEngine Rotation Packager
-- Custom Combat Rogue Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(260, "bbCombatRogue", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- PAUSE / UTILITIES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists", "!target.friend" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead", "!target.friend" } },

	-- AMBUSH
	{ "Ambush", { "target.enemy", "target.range < 1" } },

	-- INTERRUPT
	{ "Kick", "modifier.interrupt" },

	-- POISONS
	{ "Deadly Poison", { "!player.moving", "!player.buff(Deadly Poison)" } },
	{ "Crippling Poison", { "!player.moving", "!player.buff(Crippling Poison)" } },

	-- DEFENSIVE COOLDOWNS
	{ "Combat Readiness", { "talent(2, 3)", "player.health < 100", "target.agro", "target.range < 1" } },
	{ "Evasion", { "!player.buff(Combat Readiness)", "player.health < 100", "target.agro", "target.range < 1" } },
	{ "Feint", { "!player.buff(Feint)", "player.health < 100", "target.agro" } },
	{ "#5512", { "modifier.cooldowns", "player.health < 35" } }, -- Healthstone (5512)
	--{ "#76097", { "modifier.cooldowns", "player.health < 40", "@bbLib.useHealthPot" } }, -- Master Healing Potion (76097)
	{ "Sprint", "player.movingfor > 2" },
	{ "Recuperate", { "player.health < 50", "!player.buff(Recuperate)" } },

	-- AOE
	{ "Blade Flurry", { "!player.buff(Blade Flurry)", "player.area(10).enemies > 1" } },
	{ "/cancelaura Blade Flurry", { "player.buff(Blade Flurry)", "player.area(10).enemies < 2" } },

	-- OFFENSIVE COOLDOWNS
	{ {
		{ "#76089", "@bbLib.useAgiPot" }, -- Agility Potion (76089)
		{ "Preparation", { "!player.buff(Vanish)", "player.spell(Vanish).cooldown > 60" } },
		{ "Blood Fury" },
		{ "Berserking" },

		-- Blade Flurry

		{ "Shadow Reflection", { "talent(7, 2)", "player.combopoints > 3", "player.spell(Killing Spree).cooldown < 10" } },
		{ "Shadow Reflection", { "talent(7, 2)", "player.buff(Adrenaline Rush)" } },

		-- Ambush

		{ {
			{ "Vanish", { "player.combopoints < 3", "talent(1, 3)", "!player.buff(Adrenaline Rush)", "player.energy < 20" } },
			{ "Vanish", { "player.combopoints < 3", "talent(1, 2)", "player.energy > 90" } },
			{ "Vanish", { "player.combopoints < 3", "!talent(1, 3)", "!talent(1, 2)", "player.energy > 60" } },
			{ "Vanish", { "talent(6, 3)", "player.buff(Anticipation).count < 3", "talent(1, 3)", "!player.buff(Adrenaline Rush)", "player.energy < 20" } },
			{ "Vanish", { "talent(6, 3)", "player.buff(Anticipation).count < 3", "talent(1, 2)", "player.energy > 90" } },
			{ "Vanish", { "talent(6, 3)", "player.buff(Anticipation).count < 3", "!talent(1, 3)", "!talent(1, 2)", "player.energy > 60" } },
			{ "Vanish", { "player.combopoints < 4", "talent(6, 3)", "player.buff(Anticipation).count < 4", "talent(1, 3)", "!player.buff(Adrenaline Rush)", "player.energy < 20" } },
			{ "Vanish", { "player.combopoints < 4", "talent(6, 3)", "player.buff(Anticipation).count < 4", "talent(1, 2)", "player.energy > 90" } },
			{ "Vanish", { "player.combopoints < 4", "talent(6, 3)", "player.buff(Anticipation).count < 4", "!talent(1, 3)", "!talent(1, 2)", "player.energy > 60" } },
		},{
			"player.time > 10", "!player.buff(Stealth)", "target.boss",
		} },

		{ "Killing Spree", { "player.energy < 50", "!talent(7, 2)" } },
		{ "Killing Spree", { "player.energy < 50", "talent(7, 2)", "player.spell(Shadow Reflection).cooldown > 30" } },
		{ "Killing Spree", { "player.energy < 50", "talent(7, 2)", "player.buff(Shadow Reflection).duration > 3" } },
		{ "Adrenaline Rush", "player.energy < 35" },
	},{
		"modifier.cooldowns", "target.exists", "target.range < 1",
	} },

	-- DPS ROTATION
	{ "Slice and Dice", "player.buff(Slice and Dice).duration < 2" },
	{ "Slice and Dice", { "player.combopoints > 3", "player.buff(Slice and Dice).duration < 15", "player.buff(Bandit's Guile).count > 10" } },

	{ "Marked for Death", { "player.combopoints < 2", "target.debuff(Revealing Strike)", "!talent(7, 2)" } },
	{ "Marked for Death", { "player.combopoints < 2", "target.debuff(Revealing Strike)", "player.buff(Shadow Reflection)" } },
	{ "Marked for Death", { "player.combopoints < 2", "target.debuff(Revealing Strike)", "player.spell(Shadow Reflection).cooldown > 30" } },

	{ "Revealing Strike", { "player.combopoints < 5", "target.debuff(Revealing Strike).duration < 2" } },
	{ "Revealing Strike", { "talent(6, 3)", "target.debuff(Revealing Strike).duration < 2", "player.buff(Anticipation).count < 5", "!player.buff(Deep Insight)" } },

	{ "Sinister Strike", "player.combopoints < 5" },
	{ "Sinister Strike", { "talent(6, 3)", "player.buff(Anticipation).count < 5", "!player.buff(Deep Insight)" } },

	{ {
		{ "Crimson Tempest", { "target.debuff(Crimson Tempest).duration <= 1", "player.buff(Deep Insight)", "player.area(10).enemies > 5" } },
		{ "Crimson Tempest", { "target.debuff(Crimson Tempest).duration <= 1", "!talent(6, 3)", "player.area(10).enemies > 5" } },
		{ "Crimson Tempest", { "target.debuff(Crimson Tempest).duration <= 1", "talent(6, 3)", "player.buff(Anticipation).count > 3", "player.area(10).enemies > 5" } },

		{ "Eviscerate", "player.buff(Deep Insight)" },
		{ "Eviscerate", "!talent(6, 3)" },
		{ "Eviscerate", { "talent(6, 3)", "player.buff(Anticipation).count > 3" } },
	},{
		"player.combopoints > 4",
	} },

},{
-- OUT OF COMBAT
	-- PAUSE / UTILITIES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },

	-- POISONS
	{ "Deadly Poison", { "!player.moving", "!player.buff(Deadly Poison)" } },
	{ "Crippling Poison", { "!player.moving", "!player.buff(Crippling Poison)" } },

	-- STEALTH
	{ "Stealth", "!player.buff(Stealth)" },

	-- AMBUSH OOC
	{ "Ambush", { "target.enemy", "target.range < 1" }, "target" },

},
function()
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
end)
