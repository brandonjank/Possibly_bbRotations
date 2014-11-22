-- PossiblyEngine Rotation
-- Protection Gladiator Warrior - WoD 6.0.3
-- Updated on Nov 21st 2014

-- PLAYER CONTROLLED: Charge, Heroic Leap
-- SUGGESTED TALENTS: 2133323
-- SUGGESTED GLYPHS: Glyph of Unending Rage, Glyph of Enraged Speed, Glyph of the Blazing Trail, Glyph of Cleave
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(73, "bbWarrior Gladiator", {
-- COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },
	{ "pause", "target.buff(Reckless Provocation)" }, -- Iron Docks - Fleshrender
	{ "pause", "target.buff(Sanguine Sphere)" }, -- Iron Docks - Enforcers

	-- AUTO TARGET
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- AUTO TAUNT
	{ "Taunt", { "toggle.autotaunt", "@bbLib.bossTaunt" } },

	-- DEFENSIVE COOLDOWNS
	{ "Rallying Cry", { "player.health < 10", "modifier.cooldowns" } },
	{ "Last Stand", { "player.health < 20", "modifier.cooldowns" } },
	{ "Impending Victory", "player.health < 70" },
	{ "Enraged Regeneration", "player.buff(Enrage)" },
	{ "Victory Rush" },
	{ "Shield Block", { "!player.buff(Shield Block)", "toggle.shieldblock" } }, -- for heavy physical dmg
	{ "Shield Barrier", { "!player.buff(Shield Barrier)", "player.rage > 60", "toggle.shieldbarrier" } }, -- for magic/bleed/unblockable dmg
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)

	-- INTERRUPTS
	{ "Disrupting Shout", { "target.exists", "target.range < 10", "modifier.interrupt", "player.area(10).enemies > 1"  } },
	{ "Pummel", "modifier.interrupt" },

	-- actions=charge
	-- actions+=/auto_attack

-- actions+=/call_action_list,name=movement,if=movement.distance>5 -- "target.spell(Heroic Strike).range"
	-- actions.movement=heroic_leap
	-- actions.movement+=/shield_charge
	-- actions.movement+=/storm_bolt
	-- actions.movement+=/heroic_throw

	-- OFFENSIVE COOLDOWNS / COMMON
	{ {
		-- actions+=/avatar
		{ "Avatar" },
		-- actions+=/bloodbath
		{ "Bloodbath" },
		-- actions+=/use_item,name=bonemaws_big_toe,if=buff.bloodbath.up|buff.avatar.up|buff.shield_charge.up|target.time_to_die<15 (#trinket1)
		-- actions+=/use_item,name=turbulent_emblem,if=buff.bloodbath.up|buff.avatar.up|buff.shield_charge.up|target.time_to_die<15 (#trinket2)
		-- actions+=/blood_fury,if=buff.bloodbath.up|buff.avatar.up|buff.shield_charge.up|target.time_to_die<10
		{ "Blood Fury", "player.buff(Bloodbath)" },
		{ "Blood Fury", "player.buff(Avatar)" },
		{ "Blood Fury", "player.buff(Shield Charge)" },
		{ "Blood Fury", { "target.boss", "target.deathin < 10"} },
		-- actions+=/berserking,if=buff.bloodbath.up|buff.avatar.up|buff.shield_charge.up|target.time_to_die<10
		{ "Berserking", "player.buff(Bloodbath)" },
		{ "Berserking", "player.buff(Avatar)" },
		{ "Berserking", "player.buff(Shield Charge)" },
		{ "Berserking", { "target.boss", "target.deathin < 10"} },
		-- actions+=/arcane_torrent,if=buff.bloodbath.up|buff.avatar.up|buff.shield_charge.up|target.time_to_die<10
		{ "Arcane Torrent", "player.buff(Bloodbath)" },
		{ "Arcane Torrent", "player.buff(Avatar)" },
		{ "Arcane Torrent", "player.buff(Shield Charge)" },
		{ "Arcane Torrent", { "target.boss", "target.deathin < 10"} },
		-- actions+=/potion,name=draenic_armor,if=buff.bloodbath.up|buff.avatar.up|buff.shield_charge.up
		{ "#109220", { "toggle.consume", "target.boss", "player.buff(Bloodbath)" } }, -- Draenic Armor Potion
		{ "#109220", { "toggle.consume", "target.boss", "player.buff(Avatar)" } }, -- Draenic Armor Potion
		{ "#109220", { "toggle.consume", "target.boss", "player.buff(Shield Charge)" } }, -- Draenic Armor Potion
		-- actions+=/shield_charge,if=(!buff.shield_charge.up&!cooldown.shield_slam.remains)|charges=2
		{ "Shield Charge", { "!player.buff(Shield Charge)", "player.spell(Shield Slam).cooldown = 0" } },
		{ "Shield Charge", "player.spell(Shield Charge).charges = 2" },
		-- actions+=/berserker_rage,if=buff.enrage.down
		{ "Berserker Rage", "!player.buff(Enrage)" }, -- Buff is Berserker Rage?
	},{
		"modifier.cooldowns", "target.exists", "target.distance < 5",
	} },
	-- actions+=/heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)|!raid_event.movement.exists
	-- actions+=/heroic_strike,if=((buff.shield_charge.up|buff.unyielding_strikes.up)&target.health.pct>20)|buff.ultimatum.up|rage>=100|buff.unyielding_strikes.stack>4|target.time_to_die<10
	{ "Heroic Strike", { "target.health > 20", "player.buff(Shield Charge)" } },
	{ "Heroic Strike", { "target.health > 20", "player.buff(Unyielding Strikes)" } },
	{ "Heroic Strike", "player.buff(Ultimatum)" },
	{ "Heroic Strike", "player.rage >= 100" },
	{ "Heroic Strike", "player.buff(Unyielding Strikes).count > 4" },
	{ "Heroic Strike", "target.deathin < 10" },

	-- AOE 2+
	{ {
		-- actions.aoe=revenge
		{ "Revenge" },
		-- actions.aoe+=/shield_slam
		{ "Shield Slam" },
		-- actions.aoe+=/dragon_roar,if=(buff.bloodbath.up|cooldown.bloodbath.remains>10)|!talent.bloodbath.enabled
		{ "Dragon Roar", "!talent(6, 2)" },
		{ "Dragon Roar", { "talent(6, 2)", "player.buff(Bloodbath)" } },
		{ "Dragon Roar", { "talent(6, 2)", "player.spell(Bloodbath).cooldown > 10" } },
		-- actions.aoe+=/storm_bolt,if=(buff.bloodbath.up|cooldown.bloodbath.remains>7)|!talent.bloodbath.enabled
		{ "Storm Bolt", "!talent(6, 2)" },
		{ "Storm Bolt", { "talent(6, 2)", "player.buff(Bloodbath)" } },
		{ "Storm Bolt", { "talent(6, 2)", "player.spell(Bloodbath).cooldown > 7" } },
		-- actions.aoe+=/thunder_clap,cycle_targets=1,if=dot.deep_wounds.remains<3&active_enemies>4
		{ "Thunder Clap", { "target.debuff(Deep Wounds).remains < 3", "player.area(8).enemies > 4" } },
		-- actions.aoe+=/bladestorm,if=buff.shield_charge.down
		{ "Bladestorm", "!player.buff(Shield Charge)" },
		-- actions.aoe+=/execute,if=buff.sudden_death.react
		{ "Execute", "player.buff(Sudden Death)" },
		-- actions.aoe+=/thunder_clap,if=active_enemies>6
		{ "Thunder Clap", "player.area(8).enemies > 6" },
		-- actions.aoe+=/devastate,cycle_targets=1,if=dot.deep_wounds.remains<5&cooldown.shield_slam.remains>execute_time*0.4
		{ "Devastate", { "mouseover.debuff(Deep Wounds).remains < 5", "player.spell(Shield Slam).cooldown > 0.6" }, "mouseover" },
		-- actions.aoe+=/devastate,if=cooldown.shield_slam.remains>execute_time*0.4
		{ "Devastate", "player.spell(Shield Slam).cooldown > 0.6" },
	},{
		"modifier.multitarget", "player.area(10).enemies >= 2",
	} },

	-- SINGLE TARGET
	-- actions.single=shield_slam
	{ "Shield Slam" },
	-- actions.single+=/revenge
	{ "Revenge" },
	-- actions.single+=/execute,if=buff.sudden_death.react
	{ "Execute", "player.buff(Sudden Death)" },
	-- actions.single+=/storm_bolt
	{ "Storm Bolt" },
	-- actions.single+=/dragon_roar
	{ "Dragon Roar" },
	-- actions.single+=/execute,if=rage>60&target.health.pct<20
	{ "Execute", "player.rage > 60" },
	-- actions.single+=/devastate
	{ "Devastate" },

}, {
-- OUT OF COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },

	-- PRE COMBAT
	-- actions.precombat=flask,type=greater_draenic_strength_flask
	-- actions.precombat+=/food,type=blackrock_barbecue
	-- actions.precombat+=/stance,choose=gladiator
	-- talent_override=bladestorm,if=raid_event.adds.count>5|desired_targets>5|(raid_event.adds.duration<10&raid_event.adds.exists)
	-- talent_override=dragon_roar,if=raid_event.adds.count>1|desired_targets>1
	-- # Snapshot raid buffed stats before combat begins and pre-potting is done.
	-- # Generic on-use trinket line if needed when swapping trinkets out.
	-- #actions+=/use_item,slot=trinket1,if=buff.bloodbath.up|buff.avatar.up|buff.shield_charge.up|target.time_to_die<10
	-- actions.precombat+=/snapshot_stats
	-- actions.precombat+=/potion,name=draenic_armor
},
function()
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
end)
