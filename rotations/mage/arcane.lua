-- PossiblyEngine Rotation
-- Marksmanship Hunter - WoD 6.0.2
-- Updated on Nov 3rd 2014

-- PLAYER CONTROLLED:
-- TALENTS: Ice Floes, Alter Time, Frostjaw, Cauterize, Nether Tempest, Rune of Power
-- GLYPHS: Glyph of Arcane Power, Glyph of Arcane Explosion, Glyph of Cone of Cold, Minor: Glyph of Momentum
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(62, "bbMage Arcane", {
-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Evocation)" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- SURVIVAL COOLDOWNS
	--{ "Ice Block", { "modifier.cooldowns", "player.health <= 20" } },
	--{ "Cold Snap", { "modifier.cooldowns", "player.health <= 15", "player.spell(45438).cooldown" } },
	--{ "Ice Barrier", { "!player.buff(110909)", "!player.buff", "player.spell(11426).exists" }, "player" },

	-- Interrupts
	{ "Counterspell", "modifier.interrupt" },
	--{ "Frostjaw", { "talent(3, 3)", "modifier.interrupts" } },
	-- TODO: Spellsteal

	-- Decurse
	-- TODO: Remove Curse

	-- DPS COOLDOWNS
	{ "Arcane Power", "player.debuff(Arcane Charge).count > 3" },
	{ "Presence of Mind", "player.debuff(Arcane Charge).count < 4" },
	{ "Mirror Image" },
	{ "Cold Snap", { "!player.buff(Presence of Mind)", "player.spell(Presence of Mind).cooldown > 75" } },

	-- MULTI TARGET
	{ {
		{ "Cone of Cold", "player.glyph(115705)" },
		{ "Nether Tempest", { "talent(5, 1)", "!target.debuff(Nether Tempest)", "player.debuff(Arcane Charge).count > 3" } },
		{ "Nether Tempest", { "talent(5, 1)", "target.debuff(Nether Tempest)", "player.debuff(Arcane Charge).count > 3", "target.debuff(Nether Tempest).duration < 3.6" } },
		{ "Arcane Blast", { "player.debuff(Arcane Charge).count < 4", "!target.debuff(Nether Tempest)" } },
		{ "Arcane Explosion", "player.debuff(Arcane Charge).count < 4" },
		{ "Arcane Barrage", "player.debuff(Arcane Charge).count > 3" },
  },{
		"player.area(10).enemies > 4",
	} },

	-- SINGLE TARGET
	{ "Arcane Explosion", { "player.movingfor > 3", "player.debuff(Arcane Charge)", "player.debuff(Arcane Charge).duration < 2", "player.area(10).enemies > 0", } },
	{ "Rune of Power", { "talent(6, 2)", "!player.buff(Rune of Power)", "!modifier.last" } }, -- TODO: Track Rune distane from player
	{ "Nether Tempest", { "talent(5, 1)", "!target.debuff(Nether Tempest)", "player.debuff(Arcane Charge).count > 3" } },
	{ "Nether Tempest", { "talent(5, 1)", "target.debuff(Nether Tempest)", "player.debuff(Arcane Charge).count > 3", "target.debuff(Nether Tempest).duration < 3.6" } },
	{ "Supernova", { "talent(5, 3)", "player.spell(Arcane Power).cooldown > 25" } }, --TODO: let it recharge (2), so that you can cast it twice in a row for burst damage (preferably during a trinket proc).
	{ "Ice Floes", { "!player.buff(Ice Floes)", "player.movingfor > 2" } },
	{ "Arcane Missiles", { "player.debuff(Arcane Charge).count > 3", "player.buff(Arcane Missiles).count > 2" } },
	{ "Arcane Blast", "player.mana > 92" }, -- TODO:93% Mana before your start casting (or 91% with the Tier 16 2-piece bonus).
	{ "Arcane Missiles", "player.debuff(Arcane Charge).count > 3" },
	{ "Arcane Barrage", "player.debuff(Arcane Charge).count > 3" },
	{ "Arcane Blast" },

--[[
	-- COOLDOWNS
	-- actions=counterspell,if=target.debuff.casting.react
	-- actions+=/blink,if=movement.distance>10
	-- actions+=/blazing_speed,if=movement.remains>0
	-- actions+=/cold_snap,if=health.pct<30
	--{ "Cold Snap", "player.health < 30" },
	-- actions+=/time_warp,if=target.health.pct<25|time>5
	-- actions+=/ice_floes,if=buff.ice_floes.down&(raid_event.movement.distance>0|raid_event.movement.in<action.arcane_missiles.cast_time)
	--{ "Ice Floes", { "!player.buff(Ice Floes)", "player.movingfor > 2" } },
	-- actions+=/rune_of_power,if=buff.rune_of_power.remains<cast_time
	--{ "Rune of Power", { "talent(6, 2)", "!player.buff(Rune of Power)", "!modifier.last" } }, -- TODO: Track Rune distane from player
	-- actions+=/mirror_image
	--{ "Mirror Image" },
	-- actions+=/cold_snap,if=buff.presence_of_mind.down&cooldown.presence_of_mind.remains>75
	--{ "Cold Snap", { "!player.buff(Presence of Mind)", "player.spell(Presence of Mind).cooldown > 75" } },


-- COOLDOWN SEQUENCE
-- actions.cooldowns=arcane_power
-- actions.cooldowns+=/blood_fury
-- actions.cooldowns+=/berserking
-- actions.cooldowns+=/arcane_torrent
-- actions.cooldowns+=/potion,name=draenic_intellect,if=buff.arcane_power.up&(!talent.prismatic_crystal.enabled|pet.prismatic_crystal.active)
-- actions.cooldowns+=/use_item,slot=trinket1
-- actions.cooldowns+=/use_item,slot=trinket2


	-- INIT CRYSTAL
	{ {
		-- actions.init_crystal=call_action_list,name=conserve,if=buff.arcane_charge.stack<4
		-- actions.init_crystal+=/prismatic_crystal,if=buff.arcane_charge.stack=4&cooldown.arcane_power.remains<0.5
		-- actions.init_crystal+=/prismatic_crystal,if=glyph.arcane_power.enabled&buff.arcane_charge.stack=4&cooldown.arcane_power.remains>45
	},{
		-- actions+=/call_action_list,name=init_crystal,if=talent.prismatic_crystal.enabled&cooldown.prismatic_crystal.up
	} },


	-- CRYSTAL SEQUENCE
	{ {
		-- actions.crystal_sequence=call_action_list,name=cooldowns
		-- actions.crystal_sequence+=/nether_tempest,if=buff.arcane_charge.stack=4&!ticking&pet.prismatic_crystal.remains>8
		-- actions.crystal_sequence+=/call_action_list,name=burn
	},{
		-- actions+=/call_action_list,name=crystal_sequence,if=talent.prismatic_crystal.enabled&pet.prismatic_crystal.active
	} },


	-- AOE
	{ {
		-- actions.aoe=call_action_list,name=cooldowns
		-- actions.aoe+=/nether_tempest,cycle_targets=1,if=buff.arcane_charge.stack=4&(active_dot.nether_tempest=0|(ticking&remains<3.6))
		-- actions.aoe+=/supernova
		-- actions.aoe+=/arcane_barrage,if=buff.arcane_charge.stack=4
		-- actions.aoe+=/arcane_orb,if=buff.arcane_charge.stack<4
		-- actions.aoe+=/cone_of_cold,if=glyph.cone_of_cold.enabled
		-- actions.aoe+=/arcane_explosion
	},{
		-- actions+=/call_action_list,name=aoe,if=active_enemies>=5
	} },


	-- BURN
	{ {
		-- actions.burn=call_action_list,name=cooldowns
		-- actions.burn+=/arcane_missiles,if=buff.arcane_missiles.react=3
		-- actions.burn+=/arcane_missiles,if=set_bonus.tier17_4pc&buff.arcane_instability.react&buff.arcane_instability.remains<action.arcane_blast.execute_time
		-- actions.burn+=/supernova,if=time_to_die<8|charges=2
		-- actions.burn+=/nether_tempest,cycle_targets=1,if=target!=prismatic_crystal&buff.arcane_charge.stack=4&(active_dot.nether_tempest=0|(ticking&remains<3.6))
		-- actions.burn+=/arcane_orb,if=buff.arcane_charge.stack<4
		-- actions.burn+=/supernova,if=current_target=prismatic_crystal
		-- actions.burn+=/presence_of_mind,if=mana.pct>96
		-- actions.burn+=/arcane_blast,if=buff.arcane_charge.stack=4&mana.pct>93
		-- actions.burn+=/arcane_missiles,if=buff.arcane_charge.stack=4
		-- actions.burn+=/supernova,if=mana.pct<96
		-- # APL hack for evocation interrupt
		-- actions.burn+=/call_action_list,name=conserve,if=cooldown.evocation.duration-cooldown.evocation.remains<5
		-- actions.burn+=/evocation,interrupt_if=mana.pct>92,if=time_to_die>10&mana.pct<50
		-- actions.burn+=/presence_of_mind
		-- actions.burn+=/arcane_blast
	},{
		-- actions+=/call_action_list,name=burn,if=time_to_die<mana.pct*0.35*spell_haste|cooldown.evocation.remains<=(mana.pct-30)*0.3*spell_haste|(buff.arcane_power.up&cooldown.evocation.remains<=(mana.pct-30)*0.4*spell_haste)
	} },


	-- # Low mana usage, "Conserve" sequence
	-- actions.conserve=call_action_list,name=cooldowns,if=time_to_die<30|(buff.arcane_charge.stack=4&(!talent.prismatic_crystal.enabled|cooldown.prismatic_crystal.remains>15))
	-- actions.conserve+=/arcane_missiles,if=buff.arcane_missiles.react=3|(talent.overpowered.enabled&buff.arcane_power.up&buff.arcane_power.remains<action.arcane_blast.execute_time)
	-- actions.conserve+=/arcane_missiles,if=set_bonus.tier17_4pc&buff.arcane_instability.react&buff.arcane_instability.remains<action.arcane_blast.execute_time
	-- actions.conserve+=/nether_tempest,cycle_targets=1,if=target!=prismatic_crystal&buff.arcane_charge.stack=4&(active_dot.nether_tempest=0|(ticking&remains<3.6))
	-- actions.conserve+=/supernova,if=time_to_die<8|(charges=2&(buff.arcane_power.up|!cooldown.arcane_power.up)&(!talent.prismatic_crystal.enabled|cooldown.prismatic_crystal.remains>8))
	-- actions.conserve+=/arcane_orb,if=buff.arcane_charge.stack<2
	-- actions.conserve+=/presence_of_mind,if=mana.pct>96
	-- actions.conserve+=/arcane_blast,if=buff.arcane_charge.stack=4&mana.pct>93
	-- actions.conserve+=/arcane_missiles,if=buff.arcane_charge.stack=4&(!talent.overpowered.enabled|cooldown.arcane_power.remains>10*spell_haste)
	-- actions.conserve+=/supernova,if=mana.pct<96&(buff.arcane_missiles.stack<2|buff.arcane_charge.stack=4)&(buff.arcane_power.up|(charges=1&cooldown.arcane_power.remains>recharge_time))&(!talent.prismatic_crystal.enabled|current_target=prismatic_crystal|(charges=1&cooldown.prismatic_crystal.remains>recharge_time+8))
	-- actions.conserve+=/nether_tempest,cycle_targets=1,if=target!=prismatic_crystal&buff.arcane_charge.stack=4&(active_dot.nether_tempest=0|(ticking&remains<(10-3*talent.arcane_orb.enabled)*spell_haste))
	-- actions.conserve+=/arcane_barrage,if=buff.arcane_charge.stack=4
	-- actions.conserve+=/presence_of_mind,if=buff.arcane_charge.stack<2
	-- actions.conserve+=/arcane_blast
	-- actions.conserve+=/arcane_barrage,moving=1
]]--

},{
	-- OUT OF COMBAT
	{ "Arcane Brilliance", { "!player.buffs.spellpower", "!modifer.last" } },

},
function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP Mode', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_mage_livingbomb', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
end)
