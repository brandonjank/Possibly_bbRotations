-- PossiblyEngine Rotation
-- Balance Druid - WoD 6.0.3
-- Updated on Nov 14th 2014
-- T: 0101001
-- SUGGESTED TALENTS: Feline Swiftness, Ysera's Gift, Typhoon, Incarnation: Chosen of Elune, Ursol's Vortex, Nature's Vigil, Euphoria
-- SUGGESTED GLYPHS: Astral Communion, Stampeding Roar, (Entangling Energy or Moonwarding or Guided Stars)
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(102, "bbDruid Balance", {
-- COMBAT
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- FROGGING
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "Renewal", { "talent(2, 2)", "player.health < 79" }, "player" },
		{ "Rejuvenation", { "player.health < 99", "!player.buff(Rejuvenation)" }, "player" },
		{ "Healing Touch", { "player.health < 40" }, "player" },
		{ "Rejuvenation", { "party1.exists", "party1.health < 100", "!party1.buff(Rejuvenation)" }, "party1" },
		{ "Rejuvenation", { "party2.exists", "party2.health < 100", "!party2.buff(Rejuvenation)" }, "party2" },
		{ "Rejuvenation", { "party3.exists", "party3.health < 100", "!party3.buff(Rejuvenation)" }, "party3" },
		{ "Rejuvenation", { "party4.exists", "party4.health < 100", "!party4.buff(Rejuvenation)" }, "party4" },
	}, "toggle.frogs" },

	-- Forms
	{ "Moonkin Form", { "!player.form = 4", "!player.buff(Dash)", "!player.flying" } },

	-- DEFENSIVES / UTILITY
	--{ "Rebirth", { "target.friend", "!target.alive" } },
	-- Stampeding Roar: Giving the raid a movement boost is a unique  Druid ability that is very useful in a wide variety of raid situations. Always keep an eye out for when people can benefit from it.
	{ "Solar Beam", "modifier.interrupt" },
	{ "Renewal", { "talent(2, 2)", "player.health < 80" }, "player" },
	{ "Barkskin", "player.health < 70" },
	-- Dash: limited in that it only lasts while you are in Cat form and cannot DPS, but has its uses in dangerous situations.
	-- Remove Corruption: In smaller groups, you may be without a healer who can dispel curses and/or poison, so keep this in mind.
	-- Soothe: Especially in smaller groups with no  Rogues or Hunters, you might be the only one who can do this.

	-- Pre-DPS PAUSE
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- Mouseover Debuffing
	{ "Moonfire", { "toggle.mouseovers", "mouseover.exists", "mouseover.enemy", "!mouseover.debuff(Moonfire)" }, "mouseover" },
	{ "Sunfire", { "toggle.mouseovers", "mouseover.exists", "mouseover.enemy", "!mouseover.debuff(Sunfire)" }, "mouseover" },

	-- OFFENSIVE COOLDOWNS
	-- actions=potion,name=draenic_intellect,if=buff.celestial_alignment.up
	{ "#109218", { "toggle.consume", "target.exists", "target.boss", "player.buff(Celestial Alignment)" } }, -- Draenic Intellect Potion
	-- actions+=/blood_fury,if=buff.celestial_alignment.up
	{ "Blood Fury", "player.buff(Celestial Alignment)" },
	-- actions+=/berserking,if=buff.celestial_alignment.up
	{ "Berserking", "player.buff(Celestial Alignment)" },
	-- actions+=/arcane_torrent,if=buff.celestial_alignment.up
	{ "Arcane Torrent", "player.buff(Celestial Alignment)" },
	-- actions+=/use_item,slot=trinket1
	{ "#trinket1", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive" } },
	-- actions+=/use_item,slot=trinket2
	{ "#trinket2", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive" } },
	-- actions+=/force_of_nature,if=trinket.stat.intellect.up|charges=3|target.time_to_die<21
	--{ "Force of Nature", "player.trinketproc(Intellect)" },
	{ "Force of Nature", "player.spell(Force of Nature).charges > 2" },
	{ "Force of Nature", { "target.boss", "target.deathin < 21" } },

	-- AOE
	{ {
		-- actions.aoe=celestial_alignment,if=lunar_max<8|target.time_to_die<20
		{ "Celestial Alignment", { "modifier.cooldowns", "target.exists", "target.boss", "target.deathin < 20" } },
		{ "Celestial Alignment", { "modifier.cooldowns", "target.exists", "player.balance.lunarmax < 8" } },
		-- actions.aoe+=/incarnation,if=buff.celestial_alignment.up
		{ "Incarnation: Chosen of Elune", "player.buff(Celestial Alignment)" },
		-- actions.aoe+=/sunfire,if=remains<8
		{ "Sunfire", "target.debuff(Sunfire).remains < 8" },
		-- actions.aoe+=/starfall,if=!buff.starfall.up
		{ "Starfall", "!player.buff(Starfall)" },
		-- actions.aoe+=/moonfire,cycle_targets=1,if=remains<12
		{ "Moonfire", "target.debuff(Moonfire).remains < 12" },
		-- actions.aoe+=/stellar_flare,cycle_targets=1,if=remains<7
		{ "Stellar Flare", "target.debuff(Stellar Flare).remains < 7" },
		-- actions.aoe+=/starsurge,if=(charges=2&recharge_time<6)|charges=3
		{ "Starsurge", { "player.spell(Starsurge).charges > 2" } },
		{ "Starsurge", { "player.spell(Starsurge).charges > 1", "player.spell(Starsurge).recharge < 6" } },
		-- actions.aoe+=/wrath,if=(eclipse_energy<=0&eclipse_change>cast_time)|(eclipse_energy>0&cast_time>eclipse_change)
		{ "Wrath", { "player.balance(Wrath).eclipsechange" } },
		-- actions.aoe+=/starfire,if=(eclipse_energy>=0&eclipse_change>cast_time)|(eclipse_energy<0&cast_time>eclipse_change)
		{ "Starfire", { "player.balance(Starfire).eclipsechange" } },
	},{
		"modifier.multitarget", "target.area(10).enemies > 2",
	} },

	-- SINGLE TARGET
	-- actions.single_target=starsurge,if=buff.lunar_empowerment.down&eclipse_energy>20
	{ "Starsurge", { "!player.buff(Lunar Empowerment)", "player.balance.moon", "player.balance.eclipse < -40" } },
	-- actions.single_target+=/starsurge,if=buff.solar_empowerment.down&eclipse_energy<-40
	{ "Starsurge", { "!player.buff(Solar Empowerment)", "player.balance.sun", "player.balance.eclipse > 20" } },
	-- actions.single_target+=/starsurge,if=(charges=2&recharge_time<6)|charges=3
	{ "Starsurge", { "player.spell(Starsurge).charges > 2" } },
	{ "Starsurge", { "player.spell(Starsurge).charges > 1", "player.spell(Starsurge).recharge < 6" } },
	-- actions.single_target+=/celestial_alignment,if=eclipse_energy>40
	{ "Celestial Alignment", { "modifier.cooldowns", "player.balance.eclipse > 40" } },
	-- actions.single_target+=/incarnation,if=eclipse_energy>0
	{ "Incarnation: Chosen of Elune", "balance.eclipse > 0" },
	-- actions.single_target+=/sunfire,if=remains<7|buff.solar_peak.up
	{ "Sunfire", "player.buff(Solar Peak)" },
	{ "Sunfire", "target.debuff(Sunfire).remains < 7" },
	-- actions.single_target+=/stellar_flare,if=remains<7
	{ "Stellar Flare", "target.debuff(Stellar Flare).remains < 7" },
	-- actions.single_target+=/moonfire,if=buff.lunar_peak.up&remains<eclipse_change+20|remains<4|(buff.celestial_alignment.up&buff.celestial_alignment.remains<=2&remains<eclipse_change+20)
	{ "Moonfire", { "player.buff(Lunar Peak)", "target.debuff(Moonfire).remains < 24" } }, -- remains<eclipse_change+20
	{ "Moonfire", { "target.debuff(Moonfire).remains < 4" } },
	{ "Moonfire", { "player.buff(Celestial Alignment)", "player.buff(Celestial Alignment).remains <= 2", "target.debuff(Moonfire).remains < 24" } }, -- remains<eclipse_change+20
	-- actions.single_target+=/wrath,if=(eclipse_energy<=0&eclipse_change>cast_time)|(eclipse_energy>0&cast_time>eclipse_change)
	{ "Wrath", { "player.balance(Wrath).eclipsechange" } },
	-- actions.single_target+=/starfire,if=(eclipse_energy>=0&eclipse_change>cast_time)|(eclipse_energy<0&cast_time>eclipse_change)
	{ "Starfire", { "player.balance(Starfire).eclipsechange" } },

},
{
-- OUT OF COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },

	-- BUFFS
	{ "Mark of the Wild", "!player.buffs.stats" },

	-- HEALING
	{ "Renewal", { "talent(2, 2)", "player.health < 80" }, "player" },
	{ "Rejuvenation", { "player.health < 90", "!player.buff(Rejuvenation)" }, "player" },
	{ "Healing Touch", { "player.health < 70" }, "player" },

	--REZ Revive (50769)
	{ "Revive", { "target.exists", "target.player", "target.dead", "!player.moving"  }, "target" },

	-- Cleanse Debuffs
	{ "Remove Corruption", "player.dispellable(Remove Corruption)", "player" },

	-- AUTO FORMS
	{ {
		{ "pause", { "target.exists", "target.istheplayer" } },
		{ "/cancelform", { "target.isfriendlynpc", "!player.form = 0", "!player.ininstance", "target.range <= 2" } },
		{ "pause", { "target.isfriendlynpc", "target.range <= 2" } },
		{ "Travel Form", { "!player.form = 3", "!target.exists", "!player.ininstance", "player.moving", "player.outdoors" } },
		{ "Cat Form", { "!player.form = 2", "!player.form = 3", "!target.exists", "player.moving" } },
		{ "Moonkin Form", { "!player.form = 4", "target.exists", "target.enemy", "target.range < 30" } },
	},{
		"toggle.forms", "!player.flying", "!player.buff(Dash)",
	} },

	-- FROGGING
	{ {
		{ "Mark of the Wild", { "player.health > 80", "@bbLib.engaugeUnit('ANY', 40, false)" } },
		{ "Rejuvenation", { "party1.exists", "party1.health < 100", "!party1.buff(Rejuvenation)" }, "party1" },
		{ "Rejuvenation", { "party2.exists", "party2.health < 100", "!party2.buff(Rejuvenation)" }, "party2" },
		{ "Rejuvenation", { "party3.exists", "party3.health < 100", "!party3.buff(Rejuvenation)" }, "party3" },
		{ "Rejuvenation", { "party4.exists", "party4.health < 100", "!party4.buff(Rejuvenation)" }, "party4" },
		{ "Sunfire", "player.balance.sun", "target" },
		{ "Moonfire", "player.balance.moon", "target" },
	},{
		"toggle.frogs",
	} },

	-- PRE-COMBAT
	-- actions.precombat=flask,type=greater_draenic_intellect_flask
	-- actions.precombat+=/food,type=sleeper_surprise
	-- actions.precombat+=/mark_of_the_wild,if=!aura.str_agi_int.up
	-- actions.precombat+=/moonkin_form
	-- actions.precombat+=/potion,name=draenic_intellect
	-- actions.precombat+=/stellar_flare

},
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_nature_faeriefire', 'Use Mouseovers', 'Toggle usage of Moonfire/Sunfire on mouseover targets.')
	PossiblyEngine.toggle.create('forms', 'Interface\\Icons\\spell_nature_forceofnature', 'Auto Form', 'Toggle usage of smart forms out of combat. Does not work with stag glyph!')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Auto Engauge', 'Automaticly target and attack units in range.')
end)
