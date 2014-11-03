-- SPEC ID 63
PossiblyEngine.rotation.register_custom(63, "bbFireMage", {
-- PLAYER CONTROLLED: Temporal Shield, Blizzard, Blink, Frost Bomb
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "pause", "player.buff(Evocation)" },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- Racials
	{ "Stoneform", "player.health <= 65" },
	{ "Every Man for Himself", "player.state.charm" },
	{ "Every Man for Himself", "player.state.fear" },
	{ "Every Man for Himself", "player.state.incapacitate" },
	{ "Every Man for Himself", "player.state.sleep" },
	{ "Every Man for Himself", "player.state.stun" },
	{ "Gift of the Naaru", "player.health <= 70", "player" },
	{ "Escape Artist", "player.state.root" },
	{ "Escape Artist", "player.state.snare" },
	{ "Shadowmeld", "target.threat >= 80" },
	{ "Shadowmeld", "focus.threat >= 80"},
	{ "Will of the Forsaken", "player.state.fear" },
	{ "Will of the Forsaken", "player.state.charm" },
	{ "Will of the Forsaken", "player.state.sleep" },
	{ "Quaking Palm", "modifier.interrupts" },

	-- Survival
	{ "Ice Block", { "modifier.cooldowns", "player.health <= 20" } },
	{ "Cold Snap", { "modifier.cooldowns", "player.health <= 15", "player.spell(45438).cooldown" } },
	{ "Ice Barrier", { "!player.buff(110909)", "!player.buff", "player.spell(11426).exists" }, "player" },
	{ "Frost Nova", { "!target.boss", "target.threat > 80", "target.range <= 9" } },

	-- Interrupts
	{ "Counterspell", "modifier.interrupts" },
	{ "Frostjaw", "modifier.interrupts" },

	-- Pre DPS Cooldowns
	{ "#36799", { "@bbLib.useManaGem", "player.mana < 70" } }, -- Mana Gem
	{ "Dragon's Breath", { "target.enemy", "target.range <= 5" } },

	--  DPS Rotation
	{ "Time Warp", { "modifier.cooldowns", "target.boss", "target.health < 25", "player.time > 5" } },
	{ "Evocation", { "player.spell(Invocation).exists", "!player.buff(Invoker's Energy)", "target.debuff(Living Bomb).duration > 3" } },
	{ "Berserking", { "modifier.cooldowns", "target.exists", "target.boss", "!player.buff(Alter Time)", "target.deathin < 18" } },
	{ "#114757", { "modifier.cooldowns", "@bbLib.useIntPot", "player.hashero", "target.exists", "!player.buff(Alter Time)", "target.deathin < 45" } }, -- Jade Serpent Potion
	{ "Mirror Image", { "modifier.cooldowns", "target.boss" } },
	{ "Combustion",  { "modifier.cooldowns", "target.boss", "target.deathin < 22" } },
	--{ "11129",  "target.debuff(12654)" }, -- Combustion
	-- combustion,if=dot.ignite.tick_dmg>=((3*action.pyroblast.crit_damage)*mastery_value*0.5)
	-- combustion,if=dot.ignite.tick_dmg>=((action.fireball.crit_damage+action.inferno_blast.crit_damage+action.pyroblast.hit_damage)*mastery_value*0.5)&dot.pyroblast.ticking&buff.alter_time.down&buff.pyroblast.down&buff.presence_of_mind.down
	{ "Berserking", { "modifier.cooldowns", "target.exists", "!player.buff(Alter Time)", "player.spell(Alter Time).cooldown == 0" } },
	{ "Presence of Mind", { "target.exists", "!player.buff(Alter Time)", "player.spell(Alter Time).cooldown == 0" } },
	{ "#114757", { "modifier.cooldowns", "@bbLib.useIntPot", "target.exists", "target.boss", "!player.buff(Alter Time)", "player.spell(Alter Time).cooldown == 0" } }, -- Jade Serpent Potion
	{ "#gloves", { "modifier.cooldowns", "target.exists", "target.boss", "player.spell(Alter Time).cooldown == 0" } },
	{ "Alter Time", { "modifier.cooldowns", "player.spell(Mirror Image).cooldown <= 180", "!player.buff(Alter Time)", "player.buff(48108)" } }, -- if > 180sec till lust at 25%
	{ "#gloves", { "modifier.cooldowns", "target.exists", "target.boss", "player.spell(Alter Time).cooldown > 40" } },
	{ "#gloves", { "modifier.cooldowns", "target.exists", "target.boss", "target.deathin < 12" } },
	{ "Presence of Mind", { "target.exists", "player.spell(Alter Time).cooldown > 60" } },
	{ "Presence of Mind", { "target.exists", "target.deathin < 5" } },
	{ "Flamestrike", { "modifier.multitarget", "modifier.enemies > 4" }, "ground" }, -- AOE
	{ "Inferno Blast", { "target.debuff(Combustion)", "modifier.enemies > 1" } }, --AOE
	{ "Pyroblast", "player.buff(48108)" },
	{ "Pyroblast", "player.buff(Presence of Mind)" },
	{ "Inferno Blast", { "player.buff(Heating Up)", "!player.buff(48108)" } },
	{ "Living Bomb", "target.debuff(Living Bomb).duration < 3" }, -- TODO: CYCLE TARGETS
	{ "Living Bomb", { "toggle.mouseovers", "!mouseover.debuff(Living Bomb)" }, "mouseover" },
	{ "Nether Tempest", "target.debuff(Nether Tempest).duration < 3" }, -- TODO: CYCLE TARGETS
	{ "Nether Tempest", { "toggle.mouseovers", "!mouseover.debuff(Nether Tempest)", "mouseover.deathin > 9" }, "mouseover" },
	{ "Scorch", "player.moving" },
	{ "Fireball", "!player.moving" },

	-- PRE COMBAT
	-- flask,type=warm_sun
  -- food,type=mogu_fish_stew
  -- arcane_brilliance
  -- snapshot_stats
  -- rune_of_power
  -- mirror_image
  -- potion,name=jade_serpent
  -- pyroblast

	-- COMBUST_SEQUENCE
	-- stop_pyro_chain,if=cooldown.combustion.duration-cooldown.combustion.remains<15
	-- prismatic_crystal
	-- blood_fury
	-- berserking
	-- arcane_torrent
	-- potion,name=jade_serpent
	-- meteor
	-- pyroblast,if=set_bonus.tier17_4pc&buff.pyromaniac.up
	-- inferno_blast,if=set_bonus.tier16_4pc_caster&(buff.pyroblast.up^buff.heating_up.up)
	-- fireball,if=!dot.ignite.ticking&!in_flight
	-- pyroblast,if=buff.pyroblast.up
	-- inferno_blast,if=talent.meteor.enabled&cooldown.meteor.duration-cooldown.meteor.remains<gcd.max*3
  -- combustion

	-- INIT_COMBUST
	-- start_pyro_chain,if=talent.meteor.enabled&cooldown.meteor.up&((cooldown.combustion.remains<gcd.max*3&buff.pyroblast.up&(buff.heating_up.up^action.fireball.in_flight))|(buff.pyromaniac.up&(cooldown.combustion.remains<ceil(buff.pyromaniac.remains%gcd.max)*gcd.max)))
	-- start_pyro_chain,if=talent.prismatic_crystal.enabled&cooldown.prismatic_crystal.up&((cooldown.combustion.remains<gcd.max*2&buff.pyroblast.up&(buff.heating_up.up^action.fireball.in_flight))|(buff.pyromaniac.up&(cooldown.combustion.remains<ceil(buff.pyromaniac.remains%gcd.max)*gcd.max)))
	-- start_pyro_chain,if=talent.prismatic_crystal.enabled&!glyph.combustion.enabled&cooldown.prismatic_crystal.remains>20&((cooldown.combustion.remains<gcd.max*2&buff.pyroblast.up&buff.heating_up.up&action.fireball.in_flight)|(buff.pyromaniac.up&(cooldown.combustion.remains<ceil(buff.pyromaniac.remains%gcd.max)*gcd.max)))
	-- start_pyro_chain,if=!talent.prismatic_crystal.enabled&!talent.meteor.enabled&((cooldown.combustion.remains<gcd.max*4&buff.pyroblast.up&buff.heating_up.up&action.fireball.in_flight)|(buff.pyromaniac.up&cooldown.combustion.remains<ceil(buff.pyromaniac.remains%gcd.max)*(gcd.max+talent.kindling.enabled)))

	-- SINGLE_TARGET
	-- inferno_blast,if=(dot.combustion.ticking&active_dot.combustion<active_enemies)|(dot.living_bomb.ticking&active_dot.living_bomb<active_enemies)
	-- pyroblast,if=buff.pyroblast.up&buff.pyroblast.remains<action.fireball.execute_time
	-- pyroblast,if=set_bonus.tier16_2pc_caster&buff.pyroblast.up&buff.potent_flames.up&buff.potent_flames.remains<gcd.max
	-- pyroblast,if=set_bonus.tier17_4pc&buff.pyromaniac.react
	-- pyroblast,if=buff.pyroblast.up&buff.heating_up.up&action.fireball.in_flight
	-- inferno_blast,if=buff.pyroblast.down&buff.heating_up.up
	-- call_action_list,name=active_talents
	-- inferno_blast,if=buff.pyroblast.up&buff.heating_up.down&!action.fireball.in_flight
	-- fireball
	-- scorch,moving=1

},{
	-- OUT OF COMBAT
	{ "Arcane Brilliance", "!player.buff" },
	{ "Molten Armor", "!player.buff" },
	{ "Conjure Mana Gem", { "!player.moving", "@bbLib.conjureManaGem" } },

	-- TODO: Opener Toggle
	-- flask,type=warm_sun
	-- food,type=mogu_fish_stew
	-- arcane_brilliance
	-- molten_armor
	-- rune_of_power
	-- jade_serpent_potion
	-- mirror_image
	-- evocation
},
function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP Mode', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_mage_livingbomb', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
end)
