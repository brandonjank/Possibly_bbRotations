-- PossiblyEngine Rotation Packager
-- Custom Protection Warrior Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(269, "bbWindwalkerMonk", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- Racials
	{ "Will of the Forsaken", "player.state.fear" },
	{ "Will of the Forsaken", "player.state.charm" },
	{ "Will of the Forsaken", "player.state.sleep" },
	{ "Quaking Palm", "modifier.interrupts" },

	-- Off GCD
	{ "Touch of Death", "player.buff(Death Note)" },

	-- Interrupts
	{ "Spear Hand Strike", "modifier.interrupts" },
	{ "Grapple Weapon", "modifier.interrupts" },
	{ "Leg Sweep", "modifier.interrupts", "target.range <= 5" },

	-- Survival
	{ "Fortifying Brew", "player.health <= 30" },
	{ "Touch of Karma", "player.health <= 50" },
	{ "Nimble Brew", "player.state.fear" },
	{ "Nimble Brew", "player.state.stun" },
	{ "Nimble Brew", "player.state.root" },
	{ "Nimble Brew", "player.state.horror" },
	{ "Dampen Harm", "player.health <= 45" },
	{ "Diffuse Magic", "player.health <= 45" },

	-- Keybinds
	{ "Paralysis", "modifier.shift", "mouseover" },
	{ "Healing Sphere", "modifier.alt", "ground" },
	{ "Crackling Jade Lightning", "modifier.control", "target" },



	{ "Tiger's Lust", "target.range >= 15" },

-- Chi Builders
	{ "Expel Harm", "player.health < 80" },
-- actions+=/rushing_jade_wind,if=talent.rushing_jade_wind.enabled
	{ "Rushing Jade Wind", "modifier.multitarget" },


-- PRE COMBAT
-- flask,type=spring_blossoms
-- food,type=sea_mist_rice_noodles
-- stance,choose=fierce_tiger
-- snapshot_stats
-- virmens_bite_potion

-- COMBAT
-- auto_attack
-- chi_sphere,if=talent.power_strikes.enabled&buff.chi_sphere.react&chi<4
	{ "Chi Sphere", { "player.spell(Power Strikes).exists", "player.buff(Chi Sphere)", "player.chi < 4" } },
-- virmens_bite_potion,if=buff.bloodlust.react|target.time_to_die<=60
	{ "#76089", { "target.exists", "target.deathin > 15", "@bbLib.useAgiPot" } }, -- Agility Potion (76089)
-- use_item,name=gloves_of_the_golden_protector
-- berserking
	{ "Berserking", { "modifier.cooldowns", "!@bbLib.playerHasted" } },
-- chi_brew,if=talent.chi_brew.enabled&chi<=2&(trinket.proc.agility.react|(charges=1&recharge_time<=10)|charges=2|target.time_to_die<charges*10)
	--{ "Chi Brew", { "player.chi < 3", } }, -- TODO: trinket.proc.agility.react
	{ "Chi Brew", { "player.chi < 3", "player.spell(Chi Brew).charges == 1", "player.spell(Chi Brew).recharge <= 10" } },
	{ "Chi Brew", { "player.chi < 3", "player.spell(Chi Brew).charges == 2" } },
	{ "Chi Brew", { "player.chi < 3", "target.deathin < 15" } },
-- tiger_palm,if=buff.tiger_power.remains<=3
	{ "Tiger Palm", "player.buff(Tiger Power).duration <= 3" },
-- tigereye_brew,if=buff.tigereye_brew_use.down&buff.tigereye_brew.stack=20
	{ "Tigereye Brew", "player.buff(Tigereye Brew).count == 20" },
-- tigereye_brew,if=buff.tigereye_brew_use.down&trinket.proc.agility.react
-- tigereye_brew,if=buff.tigereye_brew_use.down&chi>=2&(trinket.proc.agility.react|trinket.proc.strength.react|buff.tigereye_brew.stack>=15|target.time_to_die<40)&debuff.rising_sun_kick.up&buff.tiger_power.up
-- energizing_brew,if=energy.time_to_max>5
	{ "Energizing Brew", "player.timetomax > 5" },
-- rising_sun_kick,if=debuff.rising_sun_kick.down
	{ "Rising Sun Kick", "target.debuff(Rising Sun Kick).duration <= 3" },
-- tiger_palm,if=buff.tiger_power.down&debuff.rising_sun_kick.remains>1&energy.time_to_max>1
	{ "Tiger Palm", { "player.buff(Tiger Power).count < 3", "target.debuff(Rising Sun Kick).duration > 1", "player.timetomax > 1" } },
-- invoke_xuen,if=talent.invoke_xuen.enabled
	{ "Invoke Xuen: The White Tiger", "modifier.cooldowns" },

-- MULTI
-- actions.aoe=rising_sun_kick,if=chi=4
	{ "Rising Sun Kick", { "modifier.multitarget", "player.chi > 3" } },
-- actions.aoe+=/spinning_crane_kick
	{ "Spinning Crane Kick", "modifier.multitarget" },

-- SINGLE
-- rising_sun_kick
	{ "Rising Sun Kick" },
-- fists_of_fury,if=buff.energizing_brew.down&energy.time_to_max>4&buff.tiger_power.remains>4
	{ "Fists of Fury", { "!player.buff(Energizing Brew)", "player.timetomax > 4", "player.buff(Tiger Power).duration > 4" } },
-- chi_wave,if=talent.chi_wave.enabled&energy.time_to_max>2
	{ "Chi Wave", "player.timetomax > 2" },
-- chi_burst,if=talent.chi_burst.enabled&energy.time_to_max>2
	{ "Chi Burst", "player.timetomax > 2" },
-- zen_sphere,cycle_targets=1,if=talent.zen_sphere.enabled&energy.time_to_max>2&!dot.zen_sphere.ticking
	{ "Zen Sphere", { "!target.debuff(Zen Sphere)", "player.timetomax > 2" }, "target" },
-- blackout_kick,if=buff.combo_breaker_bok.react
	{ "Blackout Kick", "player.buff(Combo Breaker: Blackout Kick)" },
-- tiger_palm,if=buff.combo_breaker_tp.react&(buff.combo_breaker_tp.remains<=2|energy.time_to_max>=2)
	{ "Tiger Palm", { "player.buff(Combo Breaker: Tiger Palm)", "player.buff(Combo Breaker: Tiger Palm).duration <= 2" } },
	{ "Tiger Palm", { "player.buff(Combo Breaker: Tiger Palm)", "player.timetomax >= 2" } },
-- jab,if=chi.max-chi>=2
	{ "Jab", "player.chi <= 3" }, --TODO: chi.max-chi>=2
-- blackout_kick,if=energy+energy.regen*cooldown.rising_sun_kick.remains>=40
	{ "Blackout Kick", { "player.chi >= 2", "target.debuff(Rising Sun Kick)", "player.buff(Tiger Power)"} },


},{
-- OUT OF COMBAT
  	-- Pause
	{ "pause", "modifier.lcontrol" },

	{ "Expel Harm", "player.health < 80" },
	{ "Fortifying Brew", "player.health <= 30" },
	{ "Touch of Karma", "player.health <= 50" },

	-- Keybinds
	{ "Paralysis", "modifier.shift", "mouseover" },
	{ "Healing Sphere", "modifier.alt", "ground" },
	{ "Crackling Jade Lightning", "modifier.control", "target" },

	-- Buffs
	{ "Legacy of the White Tiger", "!player.buff(Legacy of the White Tiger)" },
	{ "Legacy of the Emperor", "!player.buff(Legacy of the Emperor)" },

},
function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
end)
