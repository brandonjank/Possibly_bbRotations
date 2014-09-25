-- PossiblyEngine Rotation Packager
-- Custom Protection Warrior Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(73, "bbWarriorProtection", {
-- PLAYER CONTROLLED: Banners, Charge, Rallying Cry,
-- SUGGESTED TALENTS: (1) Double Time , (2) Enraged Regeneration, (3) Disrupting Shout, (4) Dragon Roar, (5) Vigilance, (6) Avatar
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- OFF GCD
	{ "Cleave", { "player.rage >= 90", "modifier.multitarget" } },
	{ "Cleave", { "player.buff(Incite)", "modifier.multitarget" } },
	{ "Cleave", { "player.buff(Ultimatum)", "modifier.multitarget" } },
	{ "Heroic Strike", { "player.rage >= 90", "!modifier.multitarget" } },
	{ "Heroic Strike", { "player.buff(Incite)", "!modifier.multitarget" } },
	{ "Heroic Strike", { "player.buff(Ultimatum)", "!modifier.multitarget" } },
	{ "Demoralizing Shout", { "target.spell(Heroic Strike).range", "target.threat > 99" } },

	-- Survival CDs
	{ "Rallying Cry", { "player.health < 10", "modifier.cooldowns" } },
	{ "Last Stand", { "player.health < 20", "modifier.cooldowns" } },
	{ "Shield Wall", { "player.health < 50", "modifier.cooldowns" } },
	{ "Impending Victory", "player.health < 70" },
	{ "Enraged Regeneration", "player.buff(Enrage)" },
	{ "Victory Rush" },
	
	-- BossMods
	{ "Taunt", { "toggle.autotaunt", "@bbLib.bossTaunt" } },

	-- Survival Buffs
	{ "Shield Block", { "!player.buff(Shield Block)", "toggle.shieldblock" } }, -- for heavy physical dmg
	{ "Shield Barrier", { "!player.buff(Shield Barrier)", "player.rage > 60", "toggle.shieldbarrier" } }, -- for magic/bleed/unblockable dmg
	{ "#5512", { "modifier.cooldowns", "player.health < 30" } }, -- Healthstone (5512)
	
	-- Kicks
	{{
		{ "Pummel" },
		{ "Disrupting Shout" },
	}, "modifier.interrupts" },

	-- Spell Reflection
	-- FIX ME

	-- Vigilance
	-- FIX ME

	-- Ranged
	{ "Heroic Throw", "target.range >= 10" },
	{ "Throw", { "target.range >= 10", "!player.moving" } },
	-- Shattering Throw?

	-- Cooldowns
	{ "Berserker Rage", "player.rage <= 90" },
	{{
		{ "Avatar" },
		{ "Recklessness" },
		{ "Blood Fury" },
		{ "Berserker Rage" },
	}, { "modifier.cooldowns", "player.buff(Skull Banner)" } },

	-- Rotation
	{ "Thunder Clap", { "modifier.multitarget", "target.spell(Heroic Strike).range" } },
	{ "Shield Slam" },
	{ "Revenge", "player.rage <= 80" },
	{ "Devastate", "!target.debuff(Deep Wounds)" },
	{ "Devastate", "target.debuff(Weakened Armor).count < 3" },
	{ "Dragon Roar", "target.spell(Heroic Strike).range" },
	{ "Sunder Armor", { "player.level < 26", "target.debuff(Weakened Armor).count < 3" } },
	{ "Thunder Clap", { "!target.debuff(Weakened Blows).any", "target.spell(Heroic Strike).range" } },
	{ "Battle Shout", { "toggle.shout", "player.rage <= 80" } },
	{ "Commanding Shout", { "!toggle.shout", "player.rage <= 80" } },
	{ "Devastate" },

}, {
-- OUT OF COMBAT
	-- Pause
	{ "pause", "modifier.lcontrol" },
}, function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('shout', 'Interface\\ICONS\\ability_warrior_battleshout', 'Battle Shout', 'Toggle usage of Battle Shout vs Commanding Shout')
	PossiblyEngine.toggle.create('shieldblock', 'Interface\\ICONS\\ability_defend', 'Shield Block', 'Toggle usage of Shield Block for Physical Damage')
	PossiblyEngine.toggle.create('shieldbarrier', 'Interface\\ICONS\\inv_shield_07', 'Shield Barrier', 'Toggle usage of Shield Barrier for Magic/Bleed Damage')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
end)
