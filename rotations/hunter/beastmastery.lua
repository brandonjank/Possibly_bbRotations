-- PossiblyEngine Rotation Packager
-- Beast Mastery Hunter - WoD 6.0.2
-- Updated on Dec 25th 2013

-- PLAYER CONTROLLED: Rabid MUST be on Auto-Cast for Stampede pets to use them :)
-- SUGGESTED BUILD: Troll Alchemist Enchanter w/ DB, AMoC, GT
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control

-- TODO: Explosive Trap timer cooldown OSD
-- TODO: Boss Functions + hold cooldowns
-- TODO: Energy Pooling Toggle
-- TODO: Pet's Range to the target
-- TODO: How to check if target has incoming heal? UnitGetIncomingHeals()

PossiblyEngine.rotation.register_custom(253, "bbHunter Beast Mastery", {
-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(food)" },
	--{ "pause", "player.buff(Drink).duration > 10" },
	--{ "pause", "player.buff(Food).duration > 10" },
	--{ "pause", "@bbLib.bossMods" },
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- Interrupts
	{ "Counter Shot", { "modifier.interruptAt(70)", "player.range < 40" } },

	-- Tranq Shot
	{ "Tranquilizing Shot", "target.dispellable", "target" },
	{ "Tranquilizing Shot", "mouseover.dispellable", "mouseover" },

	-- Pet
	{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	{ "Heart of the Phoenix", "!pet.alive" },
	{ "Mend Pet", { "pet.health <= 50", "pet.exists", "!pet.buff", "pet.range < 40" } },

	-- Traps
	{ "Trap Launcher", { "modifier.lalt", "!player.buff" } },
	{ "Explosive Trap", "modifier.lalt", "ground" },
	{ "Ice Trap", "modifier.lalt", "ground" },
	{ "Snake Trap", "modifier.lalt", "ground" },
	{ "Freezing Trap", "modifier.ralt", "ground" },

	-- Flare
	--{ "Flare", true, "target.ground" },

    -- Misdirect ( focus -> tank -> pet )
	{{
		{ "Misdirection", { "focus.exists", "focus.alive", "focus.range < 100"  }, "focus" },
		{ "Misdirection", { "tank.exists", "tank.alive", "!focus.exists", "tank.range < 100" }, "tank" },
		{ "Misdirection", { "pet.exists", "pet.alive", "!focus.exists", "!tank.exists", "pet.range < 100" }, "pet" },
	}, {
		"toggle.misdirect", "!toggle.pvpmode", "!target.isPlayer", "!player.buff(Misdirection)", "target.threat > 60"--, "@bbLib.canMisdirect"
	}},

	-- Stances
	{ "Aspect of the Iron Hawk", { "!player.buff(Aspect of the Hawk)", "!player.buff(Aspect of the Iron Hawk)", "!player.moving" } },
	{ "Aspect of the Hawk", { "!player.buff(Aspect of the Hawk)", "!player.buff(Aspect of the Iron Hawk)", "!player.moving" } },

	-- Defensive Cooldowns
	--{ "Exhilaration", { "modifier.cooldowns", "player.health < 40" } },
	--{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit
	--{ "#76097", { "toggle.consume", "player.health < 15", "@bbLib.useHealthPot", "target.boss" } }, -- Master Healing Potion (76097)
	{ "#5512", { "modifier.cooldowns", "player.health < 30" } }, -- Healthstone (5512)
	{ "Master's Call", "player.state.disorient" },
	{ "Master's Call", "player.state.stun" },
	{ "Master's Call", "player.state.root" },
	{ "Master's Call", "player.state.snare" },
	{ "Deterrence", "player.health < 20" },

	-- Pre DPS Pause
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- Offensive Racials
	{ "107079", "modifier.interrupts" },

	-- Offensive Cooldowns
	{ "#76089", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "player.hashero", "@bbLib.useAgiPot", "target.boss" } }, -- Agility Potion (76089) Virmen's Bite
	{ "Blood Fury", "modifier.cooldowns" },
	{ "#gloves", { "modifier.cooldowns", "pet.exists", "target.exists" } }, -- Synapse Springs
	{ "Berserking", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero", "!player.buff(Rapid Fire)" } },

	-- Multi Target
	{{
	{ "Multi-Shot" },
	{ "Glaive Toss" }, -- TIER 6 Talent
	{ "Explosive Trap", true, "target.ground" },
	{ "Black Arrow", { "!target.debuff", "target.deathin >= 15", "!target.state.charm" } },
	{ "Kill Shot", "target.health <= 20" },
	{ "Cobra Shot", "player.focus < 40" },
	}, {
		"modifier.multitarget"
	}},

	-- Single Target
	{ "Serpent Sting", { "!target.debuff(Serpent Sting)", "target.deathin >= 15" } },
	{ "Dire Beast" }, -- T4 Talent
	{ "Stampede", { "modifier.cooldowns", "pet.exists", "player.hashero" } },
	{ "Stampede", { "modifier.cooldowns", "pet.exists", "player.buff(Rapid Fire)" } },
	{ "Glaive Toss" }, -- T6 Talent
	{ "Bestial Wrath", { "modifier.cooldowns", "pet.exists", "target.exists" } },
	-- Kill Command < Save focus for this < wait up to 0.3sec for this
	{ "Kill Command" },
	-- Kill Shot < wait up to 0.3sec for this
	{ "Kill Shot" },
	{ "Focus Fire", "player.buff(Focus Fire).count > 4" },
	-- Rapid Fire
	{ "Rapid Fire", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero" } },

	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff.any", "target.moving", "!target.immune.snare" } },
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff.any", "target.health > 20" } },
	{ "Explosive Trap", { "toggle.cleavemode", "modifier.enemies > 2", "target.enemy" }, "target.ground" },
	{ "Multi-Shot", { "toggle.cleavemode", "player.focus >= 55", "modifier.enemies > 2" } },

	{ "Arcane Shot", "player.focus >= 55" },
	{ "Cobra Shot" },


},
{
	-- Pauses
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },

	-- Stances
	-- TODO: player.moving(seconds)
	{ "Aspect of the Cheetah", { "player.moving", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } },
	{ "Camouflage", { "toggle.camomode", "!player.buff", "!player.debuff(Orb of Power)", "!modifier.last" } },

	-- Pet
	{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	{ "Revive Pet", { "!player.moving", "!pet.alive" } },
	{ "Mend Pet", { "pet.health <= 90", "pet.exists", "pet.alive", "!pet.buff(Mend Pet)" } },

	-- Traps
	{ "Trap Launcher", { "modifier.lalt", "!player.buff" } },
	{ "Explosive Trap", "modifier.lalt", "ground" },
	{ "Ice Trap", "modifier.lalt", "ground" },
	{ "Snake Trap", "modifier.lalt", "ground" },
	{ "Freezing Trap", "modifier.ralt", "ground" },

	-- Mark
	{ "Hunter's Mark", { "target.exists", "target.alive", "!target.debuff(Hunter's Mark).any" }, "target" },

	-- Food / Flask
	-- TODO: flask of spring blossoms
	-- TODO: food mist rice noodles
	-- TODO: PRE POT: Virmen's Bite potion
},
function()
	PossiblyEngine.toggle.create('callpet', 'Interface\\Icons\\ability_hunter_beastcall', 'Call Pet 1', 'Toggle to keep the pet in your first pet slot out.')
	PossiblyEngine.toggle.create('misdirect', 'Interface\\Icons\\ability_hunter_misdirection', 'Auto Misdirect', 'Toggle to automatically misdirect to your Focus>Tank>Pet when high on threat.')
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')
	PossiblyEngine.toggle.create('cleavemode', 'Interface\\Icons\\ability_upgrademoonglaive', 'Cleave Mode', 'Toggle the automatic usage of AoE abilities for 3+ enemies.')
	PossiblyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Use Camouflage', 'Toggle the usage Camouflage when out of combat.')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
end)
