-- PossiblyEngine Rotation Packager
-- Custom Restoration Shaman Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.library.register('coreHealing', {
	needsHealing = function(percent, count)
		return PossiblyEngine.raid.needsHealing(tonumber(percent)) >= count
	end,
	--needsDispelled = function(spell)
	--	for _, unit in pairs(PossiblyEngine.raid.roster) do
	--		if UnitDebuff(unit.unit, spell) then
	--			PossiblyEngine.dsl.parsedTarget = unit.unit
	--			return true
	--		end
	--	end
	--end,
})

PossiblyEngine.rotation.register_custom(264, "bbRestorationShaman", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Healing Rain - Left Shift
-- NOTE: Set Focus target to tank, for: Earth Shield, Riptide, Lightning Bolt

--TODO: Echo of the Elements, causing their next short-cooldown spell or ability to not trigger a cooldown. Restoration: It may be used on Unleash Life, Purify Spirit, or Riptide.
--TODO: Elemental Blast now also grants increased Spirit for Restoration Shaman, in addition to the random secondary stat. Spirit amount granted is equal to double the random secondary stat amount.
--TODO: Earthliving Weapon now increases healing done by 5% (instead of increasing healing Spell Power by a flat amount).

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
	{ "Healing Rain", "modifier.lshift", "ground" },
	
	-- Buffs
	{ "Water Shield", "!player.buff" },
	
	-- Defensive Cooldowns
	{ "Astral Shift", "player.health < 30" },
	
	-- Cooldowns
	--{ "Elemental Mastery", { "modifier.cooldowns", "focustarget.boss" } }, -- T4	
	{ "#gloves", { "modifier.cooldowns", "player.totem(Healing Tide Totem)" } },
	{ "#gloves", { "modifier.cooldowns", "player.totem(Spirit Link Totem)" } },
	{ "#gloves", { "modifier.cooldowns", "player.buff(Ascendance)" } },
	{ "Spirit Walker's Grace", { "modifier.cooldowns", "player.buff(Ascendance)", "player.moving" } },
	

	--Use  Healing Tide Totem,  Spirit Link Totem, or Ascendance during heavy raid damage.  Healing Tide Totem is particularly good when players are spread out, while Ascendance and  Spirit Link Totem benefit from a stacked raid.
	{ "Healing Tide Totem", { "modifier.cooldowns", "!player.totem(Spirit Link Totem)", "!player.buff(Ascendance)", "@coreHealing.needsHealing(50, 5)" } }, -- heals raid now no range requirement
	{ "Spirit Link Totem", { "modifier.cooldowns", "!player.totem(Healing Tide Totem)", "!player.buff(Ascendance)", "@coreHealing.needsHealing(45, 4)" } },
	{ "Ascendance", { "modifier.cooldowns", "!player.totem(Spirit Link Totem)", "!player.totem(Healing Tide Totem)", "@coreHealing.needsHealing(40, 5)" } },
	
	--Keep Earth Shield on the active tank.
	{ "Earth Shield", "!focus.buff(Earth Shield)", "focus" },
	{ "Earth Shield", { "!focus.buff(Earth Shield)", "!tank.buff(Earth Shield)" }, "tank" },
	
	--Use  Healing Stream Totem on CD.
	{ "Healing Stream Totem" },
	
	--Use  Unleash Life to empower Chain Heals (particularly if taking the  High Tide talent), Riptides, or Healing Surges.
	{ "Unleash Life", "lowest.health < 65" },
	
	--Keep Riptide on 3 players at all times.
	{ "Riptide", "!focus.buff(Riptide)", "focus" },
	{ "Riptide", "!tank.buff(Riptide)", "tank" },
	{ "Riptide", { "!lowest.buff(Riptide)", "lowest.health < 99" }, "lowest" },
	
	--Cast Healing Rain on a clump of injured players when AoE healing is needed.
	
	
	--Cast Chain Heal on  Riptided targets for additional AoE healing.
	{ "Chain Heal", { "lowest.buff(Riptide)", "@coreHealing.needsHealing(80, 3)" }, "lowest" },
	
	--Unleashed Fury is excellent for tank healing.
	{ "Unleashed Fury", "tank.health < 65" },
	{ "Unleashed Fury", "focus.health < 65" },
	
	--Spend Tidal Waves procs on Healing Surges for tank healing.
	{ "Healing Surge", { "focus.health < 95", "player.buff(Tidal Waves)" }, "focus" },
	{ "Healing Surge", { "tank.health < 95", "player.buff(Tidal Waves)" }, "tank" },
	
	-- Quick Healing Surge
	{ "Healing Surge", "lowest.health < 65", "lowest" }, -- only if you feel that the target will die before you have a chance to complete a Greater Healing Wave
	
	-- Dispel
	--{ "Purify Spirit", "@coreHealing.needsDispelled('Aqua Bomb')" },
	
	-- Interrupt
	{ "Quaking Palm", "modifier.interrupts" }, -- Pandaren Racial
	{ "Wind Shear", "modifier.interrupt" },
	
	--Cast  Healing Wave on injured targets during periods of low damage.
	{ "Healing Wave", { "focus.health < 80" }, "focus" },
	{ "Healing Wave", { "tank.health < 80" }, "tank" },
	{ "Healing Wave", { "lowest.health < 100" }, "lowest" }, -- Do not use on tank, use greater

	-- DPS Rotation
	{ "Lightning Bolt", { "toggle.dpsmode", "focus.exists", "focustarget.exists", "focustarget.enemy", "focustarget.range < 40", "player.glyph(Glyph of Telluric Currents)", "!modifier.last(Lightning Bolt)" }, "focustarget" },
	{{
		{ "Wind Shear", { "focus.friend", "focustarget.casting", "focustarget.range <= 25" }, "focustarget" }, -- Interrupt focustarget
		{ "Fire Elemental Totem", { "modifier.cooldowns", "focustarget.boss", "focustarget.range < 40"  } },
		{ "Flame Shock", { "focustarget.exists", "!focustarget.debuff(Flame Shock)", "focustarget.deathin > 20" }, "focustarget" },
		{ "Lava Burst", { "focustarget.exists", "focustarget.debuff(Flame Shock)" }, "focustarget" },
	}, {
		"toggle.dpsmode",
		"player.mana > 70",
	}},
	
	-- Auto Follow
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing() -- Primal Strike was replaced by Lava Burst.
	
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	{ "Water Shield", "!player.buff" },
	
	-- Pull us into combat and out of Ghost Wolf
	{ "Riptide", { "focus.exists", "focus.friend", "!focus.buff(Riptide)", "focus.combat" }, "focus" },
	
	-- Heal
	{ "Healing Stream Totem", "player.health < 80" },
	{ "Healing Wave", "lowest.health < 85", "lowest" },
	
	-- Ghost Wolf
	{ "Ghost Wolf", { "!player.buff(Ghost Wolf)", "player.moving", "!modifier.last(Ghost Wolf)" } },
	
	-- Auto Follow
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing() -- Primal strike was replaced withLava Burst
	
},
function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('dpsmode', 'Interface\\Icons\\ability_dualwield', 'DPS Mode', 'Toggle the usage of damage dealing abilities.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autofollow', 'Interface\\Icons\\achievement_guildperk_everybodysfriend', 'Auto Follow', 'Automaticaly follows your focus target. Must be another player.')
end)
