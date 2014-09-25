-- PossiblyEngine Rotation Packager
-- Custom Blood Death Knight Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(250, "bbDeathKnight Blood", {
-- PLAYER CONTROLLED: 
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Death and Decay - Left Shift,  Death Grip Mouseover - Left Alt, Anti-Magic Zone - Right Shift, Army of the Dead - Right Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- BossMods
	{ "Dark Command", { "toggle.autotaunt", "@bbLib.bossTaunt" } },
	
	-- Racials
	{ "Stoneform", "player.health < 65" },
	{ "Every Man for Himself", "player.state.charm" },
	{ "Every Man for Himself", "player.state.fear" },
	{ "Every Man for Himself", "player.state.incapacitate" },
	{ "Every Man for Himself", "player.state.sleep" },
	{ "Every Man for Himself", "player.state.stun" },
	{ "Gift of the Naaru", "player.health < 70", "player" },
	{ "Escape Artist", "player.state.root" },
	{ "Escape Artist", "player.state.snare" },
	{ "Will of the Forsaken", "player.state.fear" },
	{ "Will of the Forsaken", "player.state.charm" },
	{ "Will of the Forsaken", "player.state.sleep" },

	-- Interrupts
	{ "Mind Freeze", "modifier.interrupts" },
	{ "Strangulate", "modifier.interrupts" },
	{ "Dark Simulacrum", { "target.casting", "@bbLib.canDarkSimulacrum(target)" } },
	
	-- Off GCD
	{ "Death's Advance", "player.state.snare" },

	-- Buffs
	{ "49222", "!player.buff(49222)", "player" }, -- Bone Shield (49222)
	{ "Horn of Winter", "!player.buff(Horn of Winter).any" },
	
	-- Keybinds
	{ "Death and Decay", "modifier.lshift", "ground" },
	{ "Anti-Magic Zone", "modifier.rshift", "ground" },
	{ "Army of the Dead", "modifier.rcontrol" },
	{ "Death Grip", { "modifier.lalt", "mouseover.threat < 100", "!target.spell(Death Strike).range", "!target.boss" }, "mouseover" },
	{ "Chains of Ice", { "modifier.ralt", "!target.boss" }, "mouseover" },

	-- Survival
	{ "#5512", { "modifier.cooldowns", "player.health < 40" } }, -- Healthstone (5512)
	{ "Anti-Magic Shell", { "player.health <= 70", "target.casting" } },
	{ "Dancing Rune Weapon", "player.health <= 75" },
	{ "Conversion", "player.health <= 60" }, -- Nobody should ever use this talent, but just in case.
	{ "Death Siphon", "player.health < 60" },
	{ "Vampiric Blood", "player.health <= 55" },
	{ "Icebound Fortitude", { "modifier.cooldowns", "player.health <= 50" } },
	{ "Rune Tap", "player.health <= 40" },
	{ "Empower Rune Weapon", { "modifier.cooldowns", "player.health <= 40", "target.spell(Death Strike).range" } },
	{ "/cast Raise Dead\n/cast Death Pact", { "modifier.cooldowns", "player.health < 35", "player.spell(Death Pact).cooldown", "player.spell(Raise Dead).cooldown", "player.spell(Death Pact).usable" } },

	-- Diseases
	{ "Unholy Blight", { "!target.debuff(Frost Fever)", "target.spell(Death Strike).range" } },
	{ "Unholy Blight", { "!target.debuff(Blood Plague)", "target.spell(Death Strike).range" } },
	{ "Outbreak", "!target.debuff(Frost Fever)" },
	{ "Outbreak", "!target.debuff(Blood Plague)" },
	{ "Blood Boil", { "!modifier.last(Blood Boil)", "player.runes(blood).count > 0", "target.spell(Death Strike).range", "target.debuff(Blood Plague).duration < 5", "target.debuff(Blood Plague)"  } },
	{ "Blood Boil", { "!modifier.last(Blood Boil)", "player.runes(blood).count > 0", "target.spell(Death Strike).range", "target.debuff(Frost Fever).duration < 5", "target.debuff(Frost Fever)" } },
	{ "Icy Touch", "!target.debuff(Frost Fever)" },
	{ "Plague Strike", "!target.debuff(Blood Plague)" },
	
	-- AoE Rotation
	{{
		{ "Heart Strike", { "player.runes(blood).count > 0", "modifier.enemies < 4" } },
		--{ "Pestilence", { "target.debuff(Blood Plague)", "target.debuff(Frost Fever)", "modifier.timeout(Pestilence,30)", "modifier.enemies > 2", "!player.spell(Roiling Blood).exists" } }, -- TODO: error with timeout "has no time period"
		{ "Blood Boil", { "!modifier.last(Blood Boil)", "player.runes(blood).count > 0", "target.spell(Death Strike).range", "modifier.enemies > 3"  } },
		{ "Death Strike" },
		{ "Rune Strike", "player.runicpower > 95" },
		{ "Rune Strike", { "player.runes(frost).count < 1","player.runes(unholy).count < 1" } },
	}, {
		"modifier.multitarget",
	}},
	
	-- Rotation
	{ "Death Strike" },
	{ "Blood Boil", { "!modifier.last(Blood Boil)", "target.spell(Death Strike).range", "player.buff(Crimson Scourge)" } },
	{ "Soul Reaper", "target.health <= 35" },
	{ "Heart Strike", { "target.health > 35", "player.runes(blood).count > 0", "target.debuff(Frost Fever)", "target.debuff(Blood Plague)" } },
	{ "Rune Strike", "player.runicpower > 95" },
	{ "Rune Strike", { "player.runes(frost).count < 1","player.runes(unholy).count < 1" } },
	{ "Horn of Winter", "player.runicpower < 90" },
	{ "Plague Leech", { "target.debuff(Frost Fever)", "target.debuff(Blood Plague)", "target.debuff(Frost Fever).duration < 3", "target.debuff(Blood Plague).duration < 3", "player.runes(death).count < 1" } },
	{ "Blood Tap", { "player.buff(Blood Charge).count > 5", "player.runes(death).count < 2" } },
	{ "Blood Boil", { "!modifier.last(Blood Boil)", "!player.spell(Crimson Scourge)", "player.runes(blood).count > 0", "target.spell(Death Strike).range" } },
	
},{
-- OUT OF COMBAT ROTATION
	-- Buffs
	{ "Blood Presence", "!player.buff(Blood Presence)" },
	{ "Horn of Winter", "!player.buff(Horn of Winter).any" },
	{ "Path of Frost", { "!player.buff(Path of Frost).any", "@bbLib.isMounted" } },
	{ "49222", "!player.buff(49222)", "player" }, -- Bone Shield (49222)

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
