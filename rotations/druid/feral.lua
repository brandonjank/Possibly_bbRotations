-- PossiblyEngine Rotation
-- Custom Feral Druid Rotation
-- Created on Oct 15th 2014
-- SUGGESTED TALENTS: 3002002
-- SUGGESTED GLYPHS: Savage Roar
-- CONTROLS:

PossiblyEngine.rotation.register_custom(103, "bbDruid Feral", {
-- COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },
	{ "pause", "target.buff(Reckless Provocation)" }, -- Iron Docks - Fleshrender
	{ "pause", "target.buff(Sanguine Sphere)" }, -- Iron Docks - Enforcers

	-- DPS ROTATION
	-- actions=cat_form
	{ "Cat Form", { "!player.form = 2", "!player.flying" } },
	-- actions+=/wild_charge
	-- actions+=/displacer_beast,if=movement.distance>10
	-- actions+=/dash,if=movement.distance&buff.displacer_beast.down&buff.wild_charge_movement.down
	{ "Rake", { "player.buff(Prowl)" } },
	{ "Rake", { "player.buff(Shadowmeld)" } },
	-- actions+=/auto_attack
	{ "Skull Bash", { "modifier.interrupt" } },
	{ "Force of Nature", { "player.spell(Force of Nature).charges > 2" } },
	{ "Force of Nature", { "target.deathin < 20" } },
	-- actions+=/force_of_nature,if=trinket.proc.all.react
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "player.hashero" } }, -- Draenic Agility Potion
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "target.deathin <= 40" } }, -- Draenic Agility Potion
	-- actions+=/use_item,slot=trinket2,sync=tigers_fury
	{ "Blood Fury", { "modifier.cooldowns", "player.buff(Tiger's Fury)" } },
	{ "Berserking", { "modifier.cooldowns", "player.buff(Tiger's Fury)" } },
	{ "Arcane Torrent", { "modifier.cooldowns", "player.buff(Tiger's Fury)" } },
	{ "Tiger's Fury", { "modifier.cooldowns", "!player.buff(Omen of Clarity)", "player.energy >= 60" } },
	{ "Tiger's Fury", { "modifier.cooldowns", "player.energy >= 80" } },
	{ "Incarnation: Son of Ursoc", { "modifier.cooldowns", "player.spell(Berserk).cooldown < 10", "player.timetomax > 1" } },
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "player.buff(Berserk)", "target.health < 25" } }, -- Draenic Agility Potion
	{ "Berserk", { "modifier.cooldowns", "player.buff(Tiger's Fury)" } },
	-- actions+=/shadowmeld,if=dot.rake.remains<4.5&energy>=35&dot.rake.pmultiplier<2&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>15)&!buff.king_of_the_jungle.up
	{ "Ferocious Bite", { "target.debuff(Rip)", "target.debuff(Rip).remains < 3", "target.health < 25" } },
	{ "Healing Touch", { "talent(7, 2)", "player.buff(Predatory Swiftness)", "player.combopoints >= 4" } },
	{ "Healing Touch", { "talent(7, 2)", "player.buff(Predatory Swiftness)", "player.buff(Predatory Swiftness).remains < 1.5" } },
	{ "Savage Roar", { "player.buff(Savage Roar).remains < 3" } },
	{ "Thrash", { "player.buff(Omen of Clarity)", "target.debuff(Thrash).remains < 4.5", "player.area(8).enemies > 1" } },
	{ "Thrash", { "!talent(7, 2)", "player.buff(Omen of Clarity)", "target.debuff(Thrash).remains < 4.5", "player.combopoints > 4" } },

	-- Pool resources for Thrash
	--{ "pause", { "player.energy < 50", "player.spell(Thrash).cooldown < 1", "target.debuff(Thrash).remains < 4.5", "player.area(8).enemies > 1" } },
	{ "Thrash", { "target.debuff(Thrash).remains < 4.5", "player.area(8).enemies > 1" } },

	-- FINISHERS
	{ {
		{ "Ferocious Bite", { "target.health < 25", "target.debuff(Rip)", "player.energy > 50" } },
		{ "Rip", { "target.debuff(Rip).remains < 3", "target.deathin > 18" } },
		-- actions.finisher+=/rip,cycle_targets=1,if=remains<7.2&persistent_multiplier>dot.rip.pmultiplier&target.time_to_die-remains>18
		--{ "Rip", { "target.debuff(Rip).remains < 7.2", "target.deathin > 18" } },
		{ "Savage Roar", { "player.buff(Savage Roar).remains < 12.6", "player.timetomax <= 1" } },
		{ "Savage Roar", { "player.buff(Savage Roar).remains < 12.6", "player.buff(Berserk)" } },
		{ "Savage Roar", { "player.buff(Savage Roar).remains < 12.6", "player.spell(Tiger's Fury).cooldown < 3" } },
		{ "Ferocious Bite", { "player.energy > 50", "player.timetomax <= 1" } },
		{ "Ferocious Bite", { "player.energy > 50", "player.buff(Berserk)" } },
		{ "Ferocious Bite", { "player.energy > 50", "player.spell(Tiger's Fury).cooldown < 3" } },
	},{
		"player.combopoints > 4",
	} },

	-- MAINTAIN DEBUFFS
	{ "Rake", { "!talent(7, 2)", "target.debuff(Rake).remains < 3", "player.combopoints < 5", "target.deathin > 3", "player.area(8).enemies < 3" } },
	{ "Rake", { "!talent(7, 2)", "target.debuff(Rake).remains < 3", "player.combopoints < 5", "target.deathin > 6" } },
	-- actions.maintain+=/rake,cycle_targets=1,if=!talent.bloodtalons.enabled&remains<4.5&combo_points<5&persistent_multiplier>dot.rake.pmultiplier&((target.time_to_die-remains>3&active_enemies<3)|target.time_to_die-remains>6)
	-- actions.maintain+=/rake,cycle_targets=1,if=talent.bloodtalons.enabled&remains<4.5&combo_points<5&(!buff.predatory_swiftness.up|buff.bloodtalons.up|persistent_multiplier>dot.rake.pmultiplier)&((target.time_to_die-remains>3&active_enemies<3)|target.time_to_die-remains>6)
	{ "Thrash", { "talent(7, 2)", "player.combopoints > 4", "target.debuff(Thrash).remains < 4.5", "player.buff(Omen of Clarity)" } },
	{ "Moonfire", { "player.combopoints < 5", "player.buff(Lunar Inspiration)", "target.debuff(Moonfire).remains < 4.2", "player.area(8).enemies < 6", "target.deathin > 10" } },
	-- actions.maintain+=/rake,cycle_targets=1,if=persistent_multiplier>dot.rake.pmultiplier&combo_points<5&active_enemies=1

	-- GENERATORS
	{ {
		{ "Swipe", "player.area(8).enemies >= 3" },
		{ "Shred", "player.area(8).enemies < 3" },
	},{
		"player.combopoints < 5",
	} },

},
{
-- OUT OF COMBAT ROTATION
	-- Pauses
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },

	-- Buffs
	{ "Mark of the Wild", "!player.buffs.stats" },

	-- Rez and Heal
	{ "Revive", { "target.exists", "target.dead", "target.player", "target.range < 40", "!player.moving" }, "target" },
	{ "Rejuvenation", { "!player.buff(Prowl)", "!player.casting", "player.alive", "!player.buff(Rejuvenation)", "player.health <= 70" }, "player" },

	-- Cleanse Debuffs
	{ "Remove Corruption", "player.dispellable(Remove Corruption)", "player" },

	-- AUTO FORMS
	{ {
		{ "pause", { "target.exists", "target.istheplayer" } },
		{ "/cancelform", { "target.isfriendlynpc", "!player.form = 0", "!player.ininstance", "target.range <= 2" } },
		{ "pause", { "target.isfriendlynpc", "target.range <= 2" } },
		{ "Travel Form", { "!player.form = 3", "!target.exists", "!player.ininstance", "player.moving", "player.outdoors" } },
		{ "Cat Form", { "!player.form = 2", "target.exists", "target.enemy", "target.range < 30" } },
	},{
		"toggle.forms", "!player.flying", "!player.buff(Dash)",
	} },

	-- Pre-Combat
	-- actions.precombat=flask,type=greater_draenic_agility_flask
	-- actions.precombat+=/food,type=blackrock_barbecue
	-- actions.precombat+=/mark_of_the_wild,if=!aura.str_agi_int.up
	-- actions.precombat+=/healing_touch,if=talent.bloodtalons.enabled
	-- actions.precombat+=/cat_form
	-- actions.precombat+=/prowl
	-- # Snapshot raid buffed stats before combat begins and pre-potting is done.
	-- actions.precombat+=/snapshot_stats
	-- actions.precombat+=/potion,name=draenic_agility

},
-- TOGGLE BUTTONS
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_nature_faeriefire', 'Use Mouseovers', 'Toggle usage of Moonfire/Sunfire on mouseover targets.')
	PossiblyEngine.toggle.create('forms', 'Interface\\Icons\\ability_druid_catform', 'Auto Form', 'Toggle usage of smart forms out of combat. Does not work with stag glyph!')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target un-tapped Gulp Frogs.')
end)
