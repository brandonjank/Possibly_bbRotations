-- PossiblyEngine Rotation
-- Custom Elemental Shaman Rotation
-- Updated on Oct 18th 2014
-- PLAYER CONTROLLED SPELLS: Earthgrab Totem, Totemic Projection, Bloodlust
-- SUGGESTED TALENTS: Astral Shift, Earthgrab Totem, Totemic Projection, Elemental Mastery, Ancestral Guidance, Elemental Blast
-- SUGGESTED GLYPHS: Chain Lightning, Spiritwalker's Grace, (Your/Encounter Choice), Ghostly Speed(minor)
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(262, "bbShaman Elemental", {
-- COMBAT ROTATION
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	{ {
		{ "Water Walking", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
	},{
		"toggle.frogs",
	} },
	
	-- Interrupt
	{ "Wind Shear", "modifier.interrupt" },

	-- UTILITY
	-- Capacitor Totem: Handy to stun groups (8yd)
	-- Cleanse Spirit: Removes curses
	-- Earthbind Totem: Slows enemies within 10yds. Becomes Earthgrab Totem when talent(2, 2)
	-- Frost Shock: Not that useful for Elemental as it conflicts with Earth & Flame Shocks
	-- Ghost Wolf: Handy to cover distances quickly mid fight
	-- Grounding Totem: Redirects one single target spell to the totem.
	-- Purge removes 1 beneficial magic effect from the target enemy
	-- Tremor Totem: Removes Charm, Fear & Sleep effects from party. Cannot be used while you are under the effects of one of these, so use to dispel allies or drop it in advance.
	-- Thunderstorm: Handy for knocking enemies away, towards tanks or off cliffs.
	-- Water Walking: Allows the target to walk on water.
	
	-- Defensive Cooldowns
	{ "Astral Shift", { "player.health < 30", "talent(1, 3)" } },
	-- Shamanistic Rage: Reduces damage taken by 30% Usable when stunned
	
	-- Pre DPS Pause
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },
	
	-- Mouseovers
	{ "Flame Shock", { "toggle.mouseovers", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(Flame Shock)" }, "mouseover" }, -- "mouseover.deathin > 15",

	-- DPS Cooldowns
	{ "Stormlash Totem", { "modifier.cooldowns", "target.boss" } },
	{ "Fire Elemental Totem", { "modifier.cooldowns", "target.boss" } },
	{ "Earth Elemental Totem", { "modifier.cooldowns", "target.boss", "!player.totem(Fire Elemental Totem)" } },
	{ "Elemental Mastery", { "talent(4, 1)", "modifier.cooldowns", "target.boss" } },
	{ "Ascendance", { "modifier.cooldowns", "target.boss", "!player.buff(Ascendance)" } },
	{ "Spiritwalker's Grace", { "modifier.cooldowns", "player.moving", "player.buff(Ascendance)" } },
	
	-- DPS ROTATION
	{ "Flame Shock", "!target.debuff(Flame Shock)" },
	{ "Earthquake", { "!player.moving", (function() return UnitsAroundUnit('target', 10) > 2 end) }, "target.ground" },
	{ "Chain Lightning", { "!player.moving", "player.spell(Earthquake).cooldown > 1", (function() return UnitsAroundUnit('target', 10) > 2 end) } },
	
	{ "Unleash Flame", "talent(6, 1)" },
	{ "Lava Burst", "!player.moving" },
	{ "Elemental Blast", { "talent(6, 3)", "!player.moving" } },
	{ "Earth Shock", { "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count > 9", "target.debuff(Flame Shock).duration < 5" } },
	{ "Flame Shock", "target.debuff(Flame Shock).duration <= 9" },
	{ "Searing Totem", { "!player.moving", "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } }, -- TODO: If the totem will last for more than 12 seconds.
	
	-- Help Healers
	{ "Healing Stream", { "lowest.alive", "lowest.health < 50", "lowest.distance < 40" } },
	{ "Ancestral Guidance", { "talent(5, 2)", "lowest.alive", "lowest.health < 50", "lowest.distance < 20" } },
	-- Healing Rain: Can be used when your raid stacks, not usually necessary
	-- Healing Surge: Quick healing spell. Your first choice for self healing as it has a 100% bonus when used on yourself as Elemental
	
	-- DPS Racial
	{ "Rocket Barrage", "player.moving" },
	
	-- Filler
	{ "Chain Lightning", { "!player.moving", (function() return UnitsAroundUnit('target', 10) > 1 end) } },
	{ "Lightning Bolt" }, -- TODO: CHeck if glyphed for moving lightning bolts.
	
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	
	-- Buffs
	{ "Lightning Shield", "!player.buff(Lightning Shield)" },

	-- Heal
	{ "Healing Stream Totem", { "!player.moving", "player.health < 80" } },
	{ "Healing Surge", { "!player.moving", "player.health < 80" }, "player" },
	
	{ {
		{ "Water Walking", "@bbLib.engaugeUnit('Gulp Frog', 25, false)" },
		{ "Searing Totem", "!player.totem(Searing Totem)" },
		{ "Flame Shock" },
	},{
		"toggle.frogs",
	} },
	
},
function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
