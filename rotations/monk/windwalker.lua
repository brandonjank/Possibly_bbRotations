-- PossiblyEngine Rotation
-- Windwalker Monk - WoD 6.0.3
-- Updated on Nov 4th 2014

-- PLAYER CONTROLLED: Paralysis
-- TALENTS: Tiger's Lust, Chi Wave, Chi Brew, Leg Sweep, Diffuse Magic, Invoke Xuen, the White Tiger
-- GLYPHS: Major: Glyph of Touch of Karma, Glyph of Touch of Death, Glyph of Transcendence  Minor: Glyph of Flying Serpent Kick
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(269, "bbMonk Windwalker", {
-- COMBAT
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },
	{ "pause", "target.buff(Reckless Provocation)" }, -- Iron Docks - Fleshrender
	{ "pause", "target.buff(Sanguine Sphere)" }, -- Iron Docks - Enforcers

	-- AUTO TARGET
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },

	{ {
		{ "Legacy of the White Tiger", { "@bbLib.engaugeUnit('Gulp Frog', 40, true)" } },
	},{
		"toggle.frogs"
	} },

	-- Interrupts
	{ "Spear Hand Strike", "modifier.interrupt" },
	{ "Leg Sweep", { "talent(4, 3)", "modifier.interrupt", "target.range <= 5" } },

-- DEFENSIVE COOLDOWNS
	{ "Nimble Brew", "player.state.fear" },
	{ "Nimble Brew", "player.state.stun" },
	{ "Nimble Brew", "player.state.root" },
	{ "Nimble Brew", "player.state.horror" },
	{ "Touch of Karma", { "player.health < 50", "target.range < 2" } },
	{ "Fortifying Brew", "player.health < 30" },
	{ "Zen Meditation", { "player.health < 20", "target.range > 3" } },
	{ "Diffuse Magic", { "talent(5, 3)", "player.health < 90", (function() return UnitIsUnit('targettarget', 'player') end), "target.casting.time > 0" } },

-- DPS COOLDOWNS
	{ "Chi Brew", { "talent(3, 3)", "player.chi < 3", "player.spell(Chi Brew).charges == 1", "player.spell(Chi Brew).recharge <= 10" } },
	{ "Chi Brew", { "talent(3, 3)", "player.chi < 3", "player.spell(Chi Brew).charges == 2" } },
	{ "Chi Brew", { "talent(3, 3)", "player.chi < 3", "target.deathin < 15" } },
	{ "Invoke Xuen, the White Tiger", "talent(6, 2)" },
	{ "Energizing Brew", { "player.energy < 40", "player.timetomax > 6" } },
	{ "Tigereye Brew", "player.buff(Tigereye Brew).count > 9" },
	{ "Touch of Death", "player.buff(Death Note)" },

-- MULTI TARGET 4+
	{ {
		{ "Rising Sun Kick", "!target.debuff(Rising Sun Kick)" },
		{ "Rising Sun Kick", "target.debuff(Rising Sun Kick).duration < 3" },
		{ "Tiger Palm", "!player.buff(Tiger Power)" },
		{ "Tiger Palm", "player.buff(Tiger Power).duration <= 2" },
		{ "Fists of Fury", { "player.buff(Tiger Power).duration > 4", "target.debuff(Rising Sun Kick).duration > 4" } },
		{ "Spinning Crane Kick", "player.chi < 4" },
		-- TODO: To effectively use Storm, Earth, and Fire you need to be facing 2-3 targets with an equal DPS priority, expect the targets to live for 10 or more seconds, and be able to remain in range of the targets at all times.
	},{
		"modifier.multitarget", --"target.area(10).enemies >= 4"
	} },

-- SINGLE TARGET
	-- CHI BUILDERS
	{ "Expel Harm", { "player.chi < 4", "player.health < 80" } },
	{ "Jab", "player.chi < 4" },

	-- CHI FINISHERS
	{ "Tiger Palm", "!player.buff(Tiger Power)"  },
	{ "Tiger Palm", "player.buff(Tiger Power).duration <= 2" },
	{ "Rising Sun Kick", "!target.debuff(Rising Sun Kick)" },
	{ "Rising Sun Kick", "target.debuff(Rising Sun Kick).duration < 3" },
	{ "Fists of Fury", { "player.buff(Tiger Power).duration > 4", "target.debuff(Rising Sun Kick).duration > 4" } },
	{ "Blackout Kick", "player.buff(Combo Breaker: Blackout Kick)" },
	{ "Tiger Palm", "player.buff(Combo Breaker: Tiger Palm)" },
	{ "Chi Wave", { "talent(2, 1)", "player.timetomax > 2" } },
	{ "Blackout Kick" },

},{
-- OUT OF COMBAT
  -- PAUSE
	{ "pause", "modifier.lcontrol" },

	-- OOC HEAL
	{ "Surging Mist", "player.health < 80", "player" },

	-- Buffs
	{ "Legacy of the White Tiger", "!player.buffs.stats" },
	--{ "Legacy of the White Tiger", "!player.buffs.crit" },

	{ {
		{ "Legacy of the White Tiger", { "player.health > 80", "@bbLib.engaugeUnit('Gulp Frog', 40, true)" } },
		{ "Crackling Jade Lightning", true, "target" },
	},{
		"toggle.frogs"
	} },

},
function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
