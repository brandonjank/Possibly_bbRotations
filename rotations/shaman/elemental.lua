-- PossiblyEngine Rotation
-- Custom Elemental Shaman Rotation
-- Updated on Oct 18th 2014
-- PLAYER CONTROLLED SPELLS: Earthgrab Totem, Totemic Projection, Bloodlust
-- SUGGESTED TALENTS: Astral Shift, Earthgrab Totem, Totemic Projection, Elemental Mastery, Ancestral Guidance, Unleashed Flame
-- SUGGESTED GLYPHS: Chain Lightning, Spiritwalker's Grace, (Your/Encounter Choice), Ghostly Speed(minor)
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(262, "bbShaman Elemental", {
-- COMBAT ROTATION
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!toggle.frogs", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!toggle.frogs", "target.exists", "target.dead" } },

	{ {
		{ "Water Walking", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "Thunderstorm", "target.distance < 5" },
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
	{ "Flame Shock", { "toggle.mouseovers", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(Flame Shock)", "mouseover.deathin > 20", }, "mouseover" },

	-- COMMON / COOLDOWNS
-- actions+=/potion,name=draenic_intellect,if=buff.ascendance.up|target.time_to_die<=30
	{ "#109218", { "modifier.cooldowns", "toggle.consume", "target.boss", "player.hashero" } }, -- Draenic Intellect Potion (109218)
	--{ "#109218", { "modifier.cooldowns", "toggle.consume", "target.boss", "player.buff(Ascendance)" } }, -- Draenic Intellect Potion (109218)
	--{ "#109218", { "modifier.cooldowns", "toggle.consume", "target.boss", "target.deathin <= 30" } }, -- Draenic Intellect Potion (109218)
-- actions+=/berserking,if=!buff.bloodlust.up&!buff.elemental_mastery.up&(set_bonus.tier15_4pc_caster=1|(buff.ascendance.cooldown_remains=0&(dot.flame_shock.remains>buff.ascendance.duration|level<87)))
	{ "Berserking", { "!player.hashero", "!player.buff(Elemental Mastery)" } },
	{ "Blood Fury", { "player.hashero" } },
	{ "Blood Fury", { "player.buff(Ascendance)" } },
	{ "Blood Fury", { "player.spell(Ascendance).cooldown > 10", "player.spell(Fire Elemental Totem).cooldown > 10" } },
	{ "Blood Fury", { "player.level < 87", "player.spell(Fire Elemental Totem).cooldown > 10" } },
	{ "Arcane Torrent" },
	{ "Elemental Mastery", "player.spell(Lava Burst).castingtime >= 1.2" },
	{ "Ancestral Swiftness", "!player.buff(Ascendance)" },
	{ "Storm Elemental Totem" },
	{ "Fire Elemental Totem", { "!player.totem(Fire Elemental Totem)" } },
-- actions+=/ascendance,if=active_enemies>1|(dot.flame_shock.remains>buff.ascendance.duration&(target.time_to_die<20|buff.bloodlust.up|time>=60)&cooldown.lava_burst.remains>0)
	{ "Ascendance", "target.area(8).enemies > 1" },
	{ "Ascendance", { "target.debuff(Flame Shock).duration > 15", "player.spell(Lava Burst).cooldown > 0", "target.deathin < 20" } },
	{ "Ascendance", { "target.debuff(Flame Shock).duration > 15", "player.spell(Lava Burst).cooldown > 0", "player.hashero" } },
	{ "Ascendance", { "target.debuff(Flame Shock).duration > 15", "player.spell(Lava Burst).cooldown > 0", "player.time >=60" } },
	{ "Liquid Magma", { "player.totem(Searing Totem).duration >= 15" } },
	{ "Liquid Magma", { "player.totem(Fire Elemental Totem).duration >= 15" } },

	-- AOE
	{ {
		{ "Earthquake", { "!player.moving", "!target.debuff(Earthquake)", "player.buff(Enhanced Chain Lightning)" }, "target.ground" },
		{ "Earthquake", { "!player.moving", "!target.debuff(Earthquake)", "player.level < 91" }, "target.ground" },
		{ "Lava Beam" },
		-- actions.aoe+=/earth_shock,if=buff.lightning_shield.react=buff.lightning_shield.max_stack
		{ "Earth Shock", "player.buff(Lightning Shield).count > 14" },
		{ "Thunderstorm", "player.area(10).enemies > 9" },
		{ "Searing Totem", { "!talent(7, 3)", "!player.totem(Searing Totem)", "!player.totem(Fire Elemental Totem)" } },
		{ "Searing Totem", { "talent(7, 3)", "player.totem(Searing Totem).duration <= 20", "!player.totem(Fire Elemental Totem)", "!player.buff(Liquid Magma)" } },
		{ "Chain Lightning", "!player.moving" },
		{ "Lightning Bolt" },
	},{
		"target.area(8).enemies > 1",
	} },

-- SINGLE TARGET
	{ "Unleash Flame", { "talent(6, 1)", "!player.buff(Ascendance)" } },
	{ "Spiritwalker's Grace", { "player.movingfor > 1", "player.buff(Ascendance)" } },
-- actions.single+=/earth_shock,if=buff.lightning_shield.react=buff.lightning_shield.max_stack
	{ "Earth Shock", { "player.level > 91", "player.buff(Lightning Shield).count > 9"} },
	{ "Earth Shock", { "player.level < 92", "player.buff(Lightning Shield).count > 4"} },
-- actions.single+=/lava_burst,if=dot.flame_shock.remains>cast_time&(buff.ascendance.up|cooldown_react)
	{ "Lava Burst", { "!player.moving", "target.debuff(Flame Shock).duration > 2" } },
	{ "Flame Shock", "target.debuff(Flame Shock).duration <= 9" },
-- actions.single+=/earth_shock,if=(set_bonus.tier17_4pc&buff.lightning_shield.react>=15&!buff.lava_surge.up)|(!set_bonus.tier17_4pc&buff.lightning_shield.react>15)
	{ "Earth Shock", { "player.buff(Lightning Shield).duration > 15"} },
-- actions.single+=/earthquake,if=!talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=(1.875+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&buff.elemental_mastery.down&buff.bloodlust.down
-- actions.single+=/earthquake,if=!talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=1.3*(1.875+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&(buff.elemental_mastery.up|buff.bloodlust.up)
-- actions.single+=/earthquake,if=!talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=(1.875+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&(buff.elemental_mastery.remains>=10|buff.bloodlust.remains>=10)
-- actions.single+=/earthquake,if=talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=((1.3*1.875)+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&buff.elemental_mastery.down&buff.bloodlust.down
-- actions.single+=/earthquake,if=talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=1.3*((1.3*1.875)+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&(buff.elemental_mastery.up|buff.bloodlust.up)
-- actions.single+=/earthquake,if=talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=((1.3*1.875)+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&(buff.elemental_mastery.remains>=10|buff.bloodlust.remains>=10)
	{ "Earthquake", { "!player.moving", "target.deathin > 10" } , "target.ground" },
	{ "Elemental Blast" },
	-- actions.single+=/flame_shock,if=time>60&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<duration
	--{ "Flame Shock", { "player.time > 60", "target.debuff(Flame Shock).duration <= 15" } },
	{ "Searing Totem", { "!talent(7, 3)", "!player.totem(Searing Totem)", "!player.totem(Fire Elemental Totem)" } },
	{ "Searing Totem", { "talent(7, 3)", "player.totem(Searing Totem).duration <= 20", "!player.totem(Fire Elemental Totem)", "!player.buff(Liquid Magma)" } },
	{ "Spiritwalker's Grace", { "player.movingfor > 1", "talent(6, 3)", "player.spell(Elemental Blast).cooldown = 0" } },
	{ "Spiritwalker's Grace", { "player.movingfor > 1", "player.spell(Lava Burst).cooldown = 0", "!player.buff(Lava Surge)" } },
	{ "Lightning Bolt" },

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
		{ "Water Walking", "@bbLib.engaugeUnit('Gulp Frog', 30, false)" },
		{ "Flame Shock", true, "target" },
		{ "Searing Totem", "!player.totem(Searing Totem)" },
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
