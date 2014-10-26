-- PossiblyEngine Rotation Packager
-- Custom Brewmaster Monk Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(268, "bbBrewmasterMonk", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", "player.buff(5384)" }, -- Feign Death
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- Racials
	{ "Stoneform", "player.health <= 65" },
	{ "Every Man for Himself", "player.state.charm" },
	{ "Every Man for Himself", "player.state.fear" },
	{ "Every Man for Himself", "player.state.incapacitate" },
	{ "Every Man for Himself", "player.state.sleep" },
	{ "Every Man for Himself", "player.state.stun" },

	-- Off GCD
	{ "Touch of Death", "player.buff(Death Note)" },
	{ "Provoke", { "toggle.autotaunt", "@bbLib.bossTaunt" } },

	-- Survival
	{ "Fortifying Brew", "player.health <= 50" },
	{ "Nimble Brew", "player.state.fear" },
	{ "Nimble Brew", "player.state.stun" },
	{ "Nimble Brew", "player.state.root" },
	{ "Nimble Brew", "player.state.horror" },
	{ "Dampen Harm", "player.health <= 60" },
	{ "Diffuse Magic", "player.health <= 60" },

	-- Keybinds
	{ "Dizzying Haze", "modifier.lshift", "ground" },
	{ "Summon Black Ox Statue", "modifier.lalt", "ground" },
	{ "Healing Sphere", "modifer.ralt", "ground" },
	{ "Spinning Crane Kick", "modifier.rshift" },

	-- Interrupts
	{ "Spear Hand Strike", "modifier.interrupts" },
	{ "Grapple Weapon", "modifier.interrupts" },
	{ "Leg Sweep", "modifier.interrupts", "target.range <= 10" },

	-- Talents
	{ "Chi Wave" }, --  heal or dps
	{ "Zen Sphere", "!player.buff(Zen Sphere)", "player" },
	{ "Chi Burst" },
	{ "Invoke Xuen, the White Tiger" },
	{ "Tiger's Lust", "target.range >= 15" },

	-- Threat Rotation
	{ "Tiger Palm", "!player.buff(Tiger Power)" },




	-- CHI BUILD
	{ "Keg Smash", "player.chi <= 2" },
	{ "Expel Harm", { "player.chi < 4", "player.health < 95" } },
	{ "Jab", "player.chi <= 2" },

	-- CHI DUMP
	{ "Blackout Kick" }, -- at least once every 6 seconds, to maintain high uptime on Shuffle



	-- Purifying Brew to remove your Stagger DoT when Yellow or Red.
	{ "Purifying Brew", "player.debuff(Moderate Stagger)" },
	{ "Purifying Brew", "player.debuff(Heavy Stagger)" },
	-- Elusive Brew if > 10 stacks. Delay up to 10-15 sec for anticipated damage.
	{ "Elusive Brew", "player.buff(Elusive Brew).count >= 10" },
	-- Guard on cooldown. Delay up to 10-15 sec for anticipated damage.
	{ "Guard", "player.buff(Power Guard)" },
	-- Blackout Kick as often as possible. Aim for ~80% uptime on Shuffle.

	-- Tiger Palm does not cost Chi, but is used like a finisher (see explanation).
	{ "Tiger Palm", "player.buff(Tiger Power).duration < 4" },

	-- Multitarget
	{ "Keg Smash", { "modifier.multitarget", "modifier.enemies > 2", "!target.debuff(Dizzying Haze)" } },
	{ "Breath of Fire", { "modifier.multitarget", "modifier.enemies > 2", "target.debuff(Dizzying Haze)", "!target.debuff(Breath of Fire)" } },
	{ "Rushing Jade Wind", { "modifier.multitarget", "!player.buff(Rushing Jade Wind)" } },
	{ "Spinning Crane Kick", { "modifier.multitarget", "modifier.enemies > 9" } },





  },{
-- OUT OF COMBAT
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	{ "Legacy of the Emperor", "!player.buff(Legacy of the Emperor).any" },

	-- Ground Stuff
	{ "Dizzying Haze", "modifier.lshift", "ground" },
	{ "Summon Black Ox Statue", "modifier.lalt", "ground" },

},
function()
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Use Mouseovers', 'Automatically cast spells on mouseover targets')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
end)
