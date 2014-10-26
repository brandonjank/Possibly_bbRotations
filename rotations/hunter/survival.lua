-- PossiblyEngine Rotation
-- Custom Survival Hunter Rotation
-- Created on Dec 25th 2013 1:00 am
-- PLAYER CONTROLLED: Rabid MUST be on Auto-Cast for Stampede pets to use them :)
-- SUGGESTED BUILD: Troll Alchemist Enchanter w/ DB, AMoC, GT
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control
-- TODO: Explosive Trap timer cooldown OSD
-- TODO: Boss Functions + hold cooldowns
-- TODO: Energy Pooling Toggle
-- TODO: Pet's Range to the target
-- TODO: How to check if target has incoming heal? UnitGetIncomingHeals()

--IsBoss: (function() return IsEncounterInProgress() and SpecialUnit() end)
--LifeSpirit: (function() return GetItemCount(89640, false, false) > 0 and GetItemCooldown(89640) == 0 end)
--HealPot: (function() return GetItemCount(76097, false, false) > 0 and GetItemCooldown(76097) == 0 end)
--AgiPot: (function() return GetItemCount(76089, false, false) > 0 and GetItemCooldown(76089) == 0 end)
--HealthStone: (function() return GetItemCount(5512, false, true) > 0 and GetItemCooldown(5512) == 0 end)
--Stats (function() return select(1,GetRaidBuffTrayAuraInfo(1)) != nil end)
--Stamina (function() return select(1,GetRaidBuffTrayAuraInfo(2)) != nil end)
--AttackPower (function() return select(1,GetRaidBuffTrayAuraInfo(3)) != nil end)
--AttackSpeed (function() return select(1,GetRaidBuffTrayAuraInfo(4)) != nil end)
--SpellPower (function() return select(1,GetRaidBuffTrayAuraInfo(5)) != nil end)
--SpellHaste (function() return select(1,GetRaidBuffTrayAuraInfo(6)) != nil end)
--CritialStrike (function() return select(1,GetRaidBuffTrayAuraInfo(7)) != nil end)
--Mastery (function() return select(1,GetRaidBuffTrayAuraInfo(8)) != nil end)

--UnitsAroundUnit(unit, distance[, combat])
--Distance(unit, unit)
--FaceUnit(unit)
--IterateObjects(callback, filter)

--timeout(name, duration) -- Used to add a rate limit or stop double casting.


PossiblyEngine.rotation.register_custom(255, "bbHunter Survival", {
-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },
	--{ "pause", "@bbLib.bossMods" },
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!toggle.frogs", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "!toggle.frogs", "target.exists", "target.dead" } },

	{ {
		{ "Flare", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		-- Ordon Candlekeeper, Ordon Fire-Watcher, Ordon Oathguard (Gotta strafe out of fire and ground crap)
	},{
		"toggle.frogs",
	} },

	-- Feign Death
	--{ "Feign Death", { "modifier.raid", "target.exists", "target.enemy", "target.boss", "target.agro", "target.distance < 30" } },
	--{ "Feign Death", { "modifier.raid", "player.debuff(Aim)", "player.debuff(Aim).duration > 3" } }, --SoO: Paragons - Aim

	-- Interrupts
	{ "Counter Shot", "modifier.interrupt" },

	-- Tranq Shot
	{ "Tranquilizing Shot", "target.dispellable", "target" },
	--{ "Tranquilizing Shot", "mouseover.dispellable", "mouseover" },

	-- Pet
	{ "883", { "!pet.exists", "!pet.alive" } }, -- Call Pet 1
	{ "Heart of the Phoenix", { "!pet.exists", "!pet.alive" } },
	--{ "Mend Pet", { "pet.health < 70", "pet.exists", "!pet.buff" } }, -- Mend Pet and Revive Pet on same button now , "pet.distance < 40"

	-- Traps
	{ "Trap Launcher", { "modifier.lalt", "!player.buff" } },
	{ "Explosive Trap", "modifier.lalt", "mouseover.ground" }, -- mouseover.ground?
	{ "Ice Trap", "modifier.lalt", "mouseover.ground" },
	{ "Freezing Trap", "modifier.ralt", "mouseover.ground" },

	-- PvP Abilities
	-- TODO: Automatic PvP mode isPlayer isPvP
	-- TODO: Proactive Deterrence
	--{ "Wyvern Sting", { "toggle.mouseovers", "talent(2, 2)", "mouseover.isPlayer", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
	--	"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root",
	--	"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" },
	--{ "Wyvern Sting", { "modifier.rcontrol", "talent(2, 2)", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", --
	--	"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root",
	--	"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" },
	--{ "Binding Shot", { "toggle.mouseovers", "talent(2, 1)", "mouseover.isPlayer", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
	--	"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root",
	--	"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover.ground" },
	--{ "Ice Trap", { "modifier.rcontrol", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "mouseover.status.disorient", -- Ice Trap on Scatter Shot targets
	--	"!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover.ground" },
	--{ "Binding Shot", { "modifier.rcontrol", "talent(2, 1)", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
	--"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root",
	--"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover.ground" },

	-- Misdirect ( focus -> tank -> pet )
	--{ {
	--	{ "Misdirection", { "focus.exists", "focus.alive", "focus.distance < 100"  }, "focus" },
	--	{ "Misdirection", { "tank.exists", "tank.alive", "!focus.exists", "tank.distance < 100" }, "tank" },
	--	{ "Misdirection", { "pet.exists", "pet.alive", "!focus.exists", "!tank.exists", "pet.distance < 100" }, "pet" },
	--},{
	--	"!toggle.pvpmode", "!target.isPlayer", "!player.buff(Misdirection)", "target.threat > 30",
	--} },

	-- Stances
	{ "Aspect of the Cheetah", { "player.movingfor > 1", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } }, -- 10sec cd now unless glyphed

	-- Defensive Racials
	--{ "20594", "player.health <= 70" },
	--{ "20589", "player.state.root" },
	--{ "20589", "player.state.snare" },
	--{ "59752", "player.state.charm" },
	--{ "59752", "player.state.fear" },
	--{ "59752", "player.state.incapacitate" },
	--{ "59752", "player.state.sleep" },
	--{ "59752", "player.state.stun" },
	--{ "58984", "target.threat >= 80" },
	--{ "58984", "focus.threat >= 80" },
	--{ "7744", "player.state.fear" },
	--{ "7744", "player.state.charm" },
	--{ "7744", "player.state.sleep" },

	-- Defensive Cooldowns
	--{ "Exhilaration", { "modifier.cooldowns", "player.health < 40", "talent(3, 1)" } },
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)
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
	--{ "107079",          "modifier.interrupts" },

	-- Offensive Cooldowns
	{ "#76089", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "player.hashero", "target.boss" } }, -- Agility Potion (76089) Virmen's Bite
	{ "Blood Fury", "modifier.cooldowns" },
	{ "Berserking", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero" } },

	-- DPS Rotation > 3 Enemies
	{ {
		{ "Multi-Shot" },
		{ "Explosive Trap", { "target.enemy", "!target.moving"  }, "target.ground" },
		{ "Black Arrow", "target.deathin > 10" },
		{ "Explosive Shot", "player.buff(Lock and Load)" },
		{ "Cobra Shot", "player.focus < 40" },
	},{
		"@bbLib.GCDOver('Multi-Shot')", "target.area(10).enemies > 3",
	} },


	-- DPS Rotation < 4 Enemies
	{ "Explosive Shot" },
	{ "Black Arrow", "target.deathin > 19" },
	{ "A Murder of Crows", "talent(5, 1)" },
	{ "Glaive Toss", "talent(6, 1)" },
	--{ "Barrage", "talent(6, 3)" },
	{ "Dire Beast", "talent(4, 2)" },
	--{ "Stampede", { "modifier.cooldowns", "pet.exists", "player.hashero", "talent(5, 3)" } },
	{ "Explosive Trap", { "target.enemy", "!target.moving", "timeout(Explosive Trap, 10)", "target.area(12).enemies > 1" }, "target.ground" },
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff.any", "target.movingfor > 1", "!target.immune.snare" } },
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff.any", "target.health > 20" } },
	{ "Multi-Shot", { "player.focus > 50", "timeout(Multi-Shot, 1)", "target.area(12).enemies > 1" } },
	{ "Arcane Shot", { "player.focus > 50", "timeout(Arcane Shot, 1)", "target.area(12).enemies < 2" } },
	{ "Cobra Shot", "player.focus < 50" },
	{ "Cobra Shot", "player.spell(Explosive Shot).cooldown > 1" },

},
{
	-- Pauses
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },

	-- Aspects
	{ "Aspect of the Cheetah", { "player.movingfor > 1", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } }, -- 10sec cd now unless glyphed
	{ "Camouflage", { "toggle.camomode", "!player.buff", "!player.debuff(Orb of Power)", "!modifier.last" } },

	-- Pet
	-- TODO: Use proper pet when raid does not provide buff. http://www.icy-veins.com/wow/survival-hunter-pve-dps-buffs-debuffs-useful-abilities
	{ "883", { "!player.moving", "!pet.exists", "!pet.alive" } }, -- Call Pet 1
	{ "Revive Pet", { "!player.moving", "!pet.alive" } },
	{ "Mend Pet", { "pet.exists", "pet.alive", "pet.health <= 90", "!pet.buff(Mend Pet)", "pet.distance < 45" } },

	-- Traps
	{ "Trap Launcher", { "modifier.lalt", "!player.buff(Trap Launcher)" } },
	{ "Explosive Trap", "modifier.lalt", "mouseover.ground" }, -- mouseover.ground?
	{ "Ice Trap", "modifier.lalt", "mouseover.ground" },
	{ "Freezing Trap", "modifier.ralt", "mouseover.ground" },

	{ {
		{ "Flare", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "!Auto Shot", { "target.exists", "target.health > 1" } },
		{ "Glaive Toss", "talent(6, 1)" },
		{ "Explosive Shot" },
		{ "Arcane Shot" },

	},{
		"toggle.frogs",
	} },

	-- Food / Flask
	-- TODO: flask of spring blossoms
	-- TODO: food mist rice noodles
	-- TODO: PRE POT: Virmen's Bite potion
},
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')
	PossiblyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Use Camouflage', 'Toggle the usage Camouflage when out of combat.')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
