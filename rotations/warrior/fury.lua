-- PossiblyEngine Rotation
-- Fury Warrior - WoD 6.0.2
-- Updated on Oct 26th 2014
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- SUGGESTED GLYPHS:
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(72, "bbWarrior Fury", {
-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },

	-- AUTO TARGET
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- FROGGING
	{ {
		{ "Battle Shout", "@bbLib.engaugeUnit('Gulp Frog', 30, false)" },
	},{
		"toggle.frogs",
	} },

	-- DEFENSIVE COOLDOWNS
	{ "Victory Rush" },
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)
	-- { "Rallying Cry", "player.health < 10" }, -- Raidwide last stand
	-- Die by the Sword - Increases parry chance by 100% and reduces damage taken by 20% for 8 seconds

	-- INTERRUPTS
	{ "Pummel", "modifier.interrupt" },

	-- RANGED ROTATION
	{ "Charge", { "target.range > 8", "target.range < 25"  } },
	-- Heroic Leap
	{ "Heroic Throw", "target.range > 10" },

	-- DPS COOLDOWNS
	{ {
		{ "Avatar", "talent(6, 1)" },
		{ "Recklessness" }, -- Stack with Execute range and lust.
		-- Recklessness should be used as many times as possible throughout the encounter. It is ideal to stack it with any periods of increased damage, trinkets, or other important mechanics (especially with Heroism Icon Heroism/Bloodlust Icon Bloodlust/Time Warp Icon Time Warp), and it is
		-- Bloodbath should be used as often as possible, but you should make sure to align with Dragon Roar Icon Dragon Roar, and you should save up around 70 Rage before using it.
		-- Bladestorm, if chosen instead of Bloodbath, should also be used as often as possible, but only against 3 or more targets. You should stack it with any cooldowns or buffs that you can, and you should have at least 6 seconds of Enrage left when you cast it.
	},{ "target.range < 3" } },

	-- MULTI ROTATION > 1
	{ {
		{ "Execute", "talent(3, 2)" },
		{ "Bloodthirst", { "!player.buff(Enrage)" } },
		{ "Bloodthirst", { "player.buff(Raging Blow!).count < 2" } },
		-- Use Whirlwind to gain stacks of Meat Cleaver as necessary for the amount of current targets. Max 3
		{ "Raging Blow" },
		{ "Dragon Roar", "talent(4, 3)" },
		{ "Wild Strike", "player.buff(Bloodsurge)" },
		{ "Bloodthirst", "talent(3, 3)" },
	},{ "target.area(8).enemies > 1" },

	-- EXECUTE ROTATION
	{ {
		{ "Execute", "talent(3, 2)" },
		{ "Berserker Rage", "!player.buff(Enrage)" },
		{ "Berserker Rage", { "talent(3, 3)", "!player.buff(Raging Blow!)" } },
		{ "Execute", "player.rage > 90" },
		{ "Bloodthirst", { "talent(3, 3)", "!player.buff(Enrage)" } },
		{ "Bloodthirst", { "!talent(3, 3)", "!player.buff(Enrage)" } },
		{ "Bloodthirst", { "!talent(3, 3)", "player.rage < 80" } },
		{ "Execute" },
		{ "Raging Blow" },
		{ "Wild Strike", "player.buff(Bloodsurge)" },
		{ "Storm Bolt", "talent(4, 1)" },
		{ "Dragon Roar", "talent(4, 3)" },
		{ "Bloodthirst", "talent(3, 3)" },
	},{	"target.health <= 20" },

	-- SINGLE ROTATION
	{ "Execute", "talent(3, 2)" },
	{ "Berserker Rage", "!player.buff(Enrage)" },
	{ "Berserker Rage", { "talent(3, 3)", "!player.buff(Raging Blow!)" } },
	{ "Wild Strike", "player.rage > 90" },
	{ "Raging Blow", "player.buff(Raging Blow!).count > 1" },
	{ "Bloodthirst", { "talent(3, 3)", "!player.buff(Enrage)" } },
	{ "Bloodthirst", { "!talent(3, 3)", "!player.buff(Enrage)" } },
	{ "Bloodthirst", { "!talent(3, 3)", "player.rage < 80" } },
	{ "Raging Blow" },
	{ "Wild Strike" },
	{ "Storm Bolt", "talent(4, 1)" },
	{ "Dragon Roar", "talent(4, 3)" },
	{ "Bloodthirst", "talent(3, 3)" },

}, {
-- OUT OF COMBAT
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- BUFFS
	-- Battle Shout - Attack Power (priority)
	-- Commanding Shout - Stamina

	-- FROGGING
	{ {
		{ "Battle Shout", "@bbLib.engaugeUnit('Gulp Frog', 30, false)" },
		{ "Taunt" },
	},{
		"toggle.frogs",
	} },

}, function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
