-- PossiblyEngine Rotation Packager
-- Custom Restoration Shaman Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.library.register('coreHealing', {
	needsHealing = function(percent, count)
		return PossiblyEngine.raid.needsHealing(tonumber(percent)) >= count
	end,
	needsDispelled = function(spell)
		for _, unit in pairs(PossiblyEngine.raid.roster) do
			if UnitDebuff(unit.unit, spell) then
				PossiblyEngine.dsl.parsedTarget = unit.unit
				return true
			end
		end
	end,
})

PossiblyEngine.rotation.register_custom(264, "bbRestorationShaman", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Healing Rain - Left Shift
-- NOTE: Set Focus target to tank, for: Earth Shield, Riptide, Lightning Bolt

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Racials 
	{ "Stoneform", "player.health <= 65" },
	{ "Gift of the Naaru", "player.health <= 70", "player" },
	{ "Lifeblood", { "modifier.cooldowns", "player.spell(Lifeblood).cooldown < 1" }, "player" },
	
	-- PvP
	{ "Wind Walk Totem", "player.state.root" },
	{ "Wind Walk Totem", "player.state.snare" },
	{ "Tremor Totem", "player.state.fear" },
	{ "Tremor Totem", "player.state.charm" },
	{ "Tremor Totem", "player.state.sleep" },
	{ "Call of the Elements", { "player.state.root", "player.spell(Wind Walk Totem).cooldown > 1" } },
	{ "Call of the Elements", { "player.state.snare", "player.spell(Wind Walk Totem).cooldown > 1" } },
	{ "Call of the Elements", { "player.state.fear", "player.spell(Tremor Totem).cooldown > 1" } },
	{ "Call of the Elements", { "player.state.charm", "player.spell(Tremor Totem).cooldown > 1" } },
	{ "Call of the Elements", { "player.state.sleep", "player.spell(Tremor Totem).cooldown > 1" } },
	
	-- Healing Rain Mouseover
	{ "Unleash Elements", "modifier.lshift" },
	{ "Healing Rain", "modifier.lshift", "ground" },
	
	-- Buffs
	{ "Earthliving Weapon", "!player.enchant.mainhand" },
	{ "Water Shield", "!player.buff" },
	
	-- Cooldowns
	{ "Elemental Mastery", { "modifier.cooldowns", "focustarget.boss" } }, -- T4	
	{ "#gloves", { "modifier.cooldowns", "player.totem(Healing Tide Totem)" } },
	{ "#gloves", { "modifier.cooldowns", "player.totem(Spirit Link Totem)" } },
	{ "#gloves", { "modifier.cooldowns", "player.buff(Ascendance)" } },
	{ "Spirit Walker's Grace", { "modifier.cooldowns", "player.buff(Ascendance)", "player.moving" } },
	{ "Healing Stream Totem", { "!player.totem(Healing Tide Totem)", "!player.totem(Mana Tide Totem)" } },
	{ "Mana Tide Totem", { "modifier.cooldowns", "!player.totem(Healing Tide Totem)", "!player.totem(Healing Stream Totem)", "player.mana < 30" } },
	{ "Healing Tide Totem", { "modifier.cooldowns", "!player.totem(Mana Tide Totem)", "!player.totem(Spirit Link Totem)", "!player.buff(Ascendance)", "@coreHealing.needsHealing(50, 5)" } },
	{ "Spirit Link Totem", { "modifier.cooldowns", "!player.totem(Healing Tide Totem)", "!player.buff(Ascendance)", "@coreHealing.needsHealing(45, 4)" } },
	{ "Ascendance", { "modifier.cooldowns", "!player.totem(Spirit Link Totem)", "!player.totem(Healing Tide Totem)", "@coreHealing.needsHealing(40, 5)" } },
	
	-- Focus / Tank Healing
	{ "Earth Shield", "!focus.buff(Earth Shield).any", "focus" },
	{ "Earth Shield", { "!focus.buff(Earth Shield)", "!tank.buff(Earth Shield).any" }, "tank" },
	{ "Riptide", "!focus.buff(Riptide)", "focus" },
	{ "Riptide", "!tank.buff(Riptide)", "tank" },
	{ "Unleash Elements", "focus.health < 65" },
	{ "Greater Healing Wave", { "focus.health < 65", "player.buff(Unleash Life)" }, "focus" },
	{ "Unleash Elements", "tank.health < 65" },
	{ "Greater Healing Wave", { "tank.health < 65", "player.buff(Unleash Life)" }, "tank" },

	-- Dispel
	{ "Purify Spirit", "@coreHealing.needsDispelled('Aqua Bomb')" },
	
	-- Interrupt
	{ "Quaking Palm", "modifier.interrupts" }, -- Pandaren Racial
	{ "Wind Shear", "modifier.interrupt" },

	-- Riptide
	{ "Riptide", { "!lowest.buff(Riptide)", "lowest.health < 99" }, "lowest" },
	
	-- Healing Rotation
	{ "Ancestral Swiftness", "lowest.health < 25" },
	{ "Greater Healing Wave", { "lowest.health < 25", "player.buff(Ancestral Swiftness)" }, "lowest" },
	{ "Healing Surge", "lowest.health < 30", "lowest" }, -- only if you feel that the target will die before you have a chance to complete a Greater Healing Wave
	{ "Greater Healing Wave", "@coreHealing.needsDispelled(Chomp)" },
	{ "Greater Healing Wave", "lowest.health < 40", "lowest" },
	{ "Chain Heal", { "modifier.multitarget", "@coreHealing.needsHealing(80, 3)" }, "lowest" },
	{ "Greater Healing Wave", { "lowest.health < 65", "player.buff(Tidal Waves).count = 2" }, "lowest" },
	{ "Greater Healing Wave", { "tank.health < 80" }, "focus" },
	{ "Greater Healing Wave", { "tank.health < 80" }, "tank" },
	{ "Healing Wave", { "lowest.health > 65", "lowest.health < 99" }, "lowest" }, -- Do not use on tank, use greater

	-- DPS Rotation
	{ "Lightning Bolt", { "toggle.dpsmode", "focus.exists", "focustarget.exists", "focustarget.enemy", "focustarget.range < 40", "player.glyph(Glyph of Telluric Currents)", "!modifier.last(Lightning Bolt)" }, "focustarget" },
	{{
		{ "Wind Shear", { "focus.friend", "focustarget.casting", "focustarget.range <= 25" }, "focustarget" }, -- Interrupt focustarget
		{ "Fire Elemental Totem", { "modifier.cooldowns", "focustarget.boss", "focustarget.range < 40"  } },
		{ "Stormlash Totem", { "modifier.cooldowns", "player.hashero", "focustarget.boss", "focustarget.range < 40" } },
		{ "Searing Totem", { "!player.totem(Magma Totem)", "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
		{ "Flame Shock", { "focustarget.exists", "!focustarget.debuff(Flame Shock)", "focustarget.deathin > 20" }, "focustarget" },
		{ "Lava Burst", { "focustarget.exists", "focustarget.debuff(Flame Shock)" }, "focustarget" },
	}, {
		"toggle.dpsmode",
		"player.mana > 70",
	}},
	
	-- Auto Follow
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing()
	
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	{ "Earthliving Weapon", "!player.enchant.mainhand" },
	{ "Water Shield", "!player.buff" },
	
	-- Pull us into combat and out of Ghost Wolf
	{ "Riptide", { "focus.exists", "focus.friend", "!focus.buff(Riptide)", "focus.combat" }, "focus" },
	
	-- Heal
	{ "Healing Stream Totem", "player.health < 80" },
	--{ "Healing Wave", "@coreHealing.needsHealing(80, 1)", "lowest" },
	{ "Healing Wave", "lowest.health < 85", "lowest" },
	
	-- Ghost Wolf
	{ "Ghost Wolf", { "!player.buff(Ghost Wolf)", "player.moving", "!modifier.last(Ghost Wolf)" } },
	
	-- Auto Follow
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing()
	
},
function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('dpsmode', 'Interface\\Icons\\ability_dualwield', 'DPS Mode', 'Toggle the usage of damage dealing abilities.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autofollow', 'Interface\\Icons\\achievement_guildperk_everybodysfriend', 'Auto Follow', 'Automaticaly follows your focus target. Must be another player.')
end)
