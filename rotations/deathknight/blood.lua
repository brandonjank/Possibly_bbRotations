-- PossiblyEngine Rotation
-- Blood Death Knight - WoD 6.0.3
-- Updated on Nov 4th 2014

-- PLAYER CONTROLLED:
-- TALENTS: Plague Leech, Anti-Magic Zone, Death's Advance, Blood Tap, Death Pact, Gorefiend's Grasp
-- GLYPHS: Glyph of Vampiric Blood, Glyph of Anti-Magic Shell, Glyph of Icebound Fortitude  Minor: Glyph of Path of Frost
-- CONTROLS: Pause - Left Control, Death and Decay - Left Shift,  Death Grip Mouseover - Left Alt, Anti-Magic Zone - Right Shift, Army of the Dead - Right Control

PossiblyEngine.rotation.register_custom(250, "bbDeathKnight Blood", {
-- COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- AUTO TAUNT
	{ "Dark Command", { "toggle.autotaunt", "@bbLib.bossTaunt" } },

	-- INTERRUPTS
	{ "Dark Simulacrum", { "target.casting", "@bbLib.canDarkSimulacrum(target)" } },
	{ "Mind Freeze", "modifier.interrupts" },
	{ "Strangulate", "modifier.interrupts" },

	-- Keybinds
	{ "Death and Decay", "modifier.lshift", "ground" },
	{ "Anti-Magic Zone", "modifier.rshift", "ground" },
	{ "Army of the Dead", "modifier.rcontrol" },
	{ "Death Grip", { "modifier.lalt", "mouseover.threat < 100", "!target.spell(Death Strike).range", "!target.boss" }, "mouseover" },
	{ "Chains of Ice", { "modifier.ralt", "!target.boss" }, "mouseover" },

	-- UTILITY / SURVIVAL
	{ "Death's Advance", { "talent(3, 1)", "player.state.snare" } },
	{ "Death's Advance", { "talent(3, 1)", "player.state.root" } },
	{ "Bone Shield", "!player.buff", "player" },
	{ "Anti-Magic Shell", { "player.health <= 70", (function() return UnitIsUnit('targettarget', 'player') end), "target.casting.time > 0" } },
	{ "Dancing Rune Weapon", "player.health <= 75" },
	{ "Vampiric Blood", "player.health <= 55" },
	{ "Icebound Fortitude", { "modifier.cooldowns", "player.health <= 50" } },
	{ "Rune Tap", "player.health < 30" },
	{ "Empower Rune Weapon", { "modifier.cooldowns", "player.health <= 40", "target.spell(Death Strike).range" } },
	{ "Death Pact", { "talent(5, 1)", "modifier.cooldowns", "player.health < 35" } },
	-- TODO: Raise Ally Use to resurrect key raid members.

	-- DPS COOLDOWNS
	{ "Plague Leech", { "talent(1, 2)", "target.debuff(Frost Fever)", "target.debuff(Blood Plague)", "target.debuff(Frost Fever).duration < 5", "target.debuff(Blood Plague).duration < 5", "player.runes(death).count < 1" } },

	-- THREAT ROTATION
	{ "Death and Decay", { "!player.moving", "cooldown(Death and Decay, 10)", "player.area(10).enemies > 1" } },
	{ "Outbreak", { "!target.debuff(Frost Fever)", "!target.debuff(Blood Plague)" } },
	{ "Blood Boil", { "cooldown(Blood Boil, 5)", "target.debuff(Frost Fever)", "target.debuff(Blood Plague)", "player.area(10).enemies > 1"} },
	{ "Icy Touch", "!target.debuff(Frost Fever)" },
	{ "Plague Strike", "!target.debuff(Blood Plague)" },
	{ "Icy Touch", "!target.debuff(Frost Fever).remaining < 5" },
	{ "Plague Strike", "!target.debuff(Blood Plague).remaining < 5" },
	{ "Death Strike" },
	{ "Soul Reaper", "target.health <= 35" },
	{ "Blood Boil", { "target.health > 35", "target.debuff(Frost Fever)", "target.debuff(Blood Plague)" } },
	{ "Blood Tap", { "player.buff(Blood Charge).count > 5", "player.runes(death).count < 2" } },
	{ "Death Coil", "player.runicpower > 95" },
	{ "Death Coil", { "player.runes(frost).count < 1", "player.runes(unholy).count < 1", "player.runes(blood).count < 1" } },

},{
-- OUT OF COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	{ "Blood Presence", "!player.buff(Blood Presence)" },
	{ "Horn of Winter", "!player.buffs.attackpower" },
	{ "Path of Frost", { "!player.buff(Path of Frost).any", (function() return IsMounted() end) } },
	{ "Bone Shield", "!player.buff", "player" },

	-- Keybinds
	{ "Army of the Dead", { "target.boss", "modifier.rshift" } },
	{ "Death Grip", "modifier.lalt" },

},
function ()
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
end)
