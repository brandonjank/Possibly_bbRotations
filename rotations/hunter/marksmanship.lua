-- PossiblyEngine Rotation
-- Marksmanship Hunter - WoD 6.0.2
-- Updated on Oct 25th 2014

-- PLAYER CONTROLLED:
-- TALENTS: Crouching Tiger, Binding Shot, Iron Hawk, Thrill of the Hunt, A Murder of Crows, and Barrage or Glaive Toss
-- GLYPHS: Major: Animal Bond, Deterrence, Disengage  Minor: Aspect of the Cheetah, Play Dead, Fetch
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control

-- TODO: Pet's Range to the target
-- TODO: How to check if target has incoming heal? UnitGetIncomingHeals()

PossiblyEngine.rotation.register_custom(254, "bbHunter Marksmanship", {
-- COMBAT
	-- PAUSE / UTILITIES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- FROGGING
	{ {
		{ "Flare", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		-- Ordon Candlekeeper, Ordon Fire-Watcher, Ordon Oathguard (Gotta strafe out of fire and ground crap)
	},{
		"toggle.frogs",
	} },

	-- PET MANAGEMENT
	{ "883", { "!pet.exists", "!pet.alive" } }, -- Call Pet 1
	{ "Heart of the Phoenix", { "!pet.exists", "!pet.alive" } },
	{ "Mend Pet", { "pet.health < 70", "pet.exists", "!pet.buff(Mend Pet)" } }, -- Mend Pet and Revive Pet on same button now , "pet.distance < 40"

	-- TRAPS
	{ {
		{ "Trap Launcher", "!player.buff(Trap Launcher)" },
		{ "Explosive Trap", true, "mouseover.ground" },
		{ "Ice Trap", true, "mouseover.ground" },
		{ "Freezing Trap", true, "mouseover.ground" },
	},{
		"modifier.lalt",
	} },

	-- PvP ABILITIES
	-- TODO: Automatic PvP mode isPlayer isPvP
	{ "Wyvern Sting", { "toggle.mouseovers", "talent(2, 2)", "mouseover.isPlayer", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root",
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" },
	{ "Wyvern Sting", { "modifier.rcontrol", "talent(2, 2)", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", --
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root",
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" },
	{ "Binding Shot", { "toggle.mouseovers", "talent(2, 1)", "mouseover.isPlayer", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root",
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover.ground" },
	{ "Binding Shot", { "modifier.rcontrol", "talent(2, 1)", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root",
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover.ground" },

	-- SURVIVAL COOLDOWNS
	{ "Feign Death", { "modifier.raid", "target.exists", "target.enemy", "target.boss", "target.agro", "target.distance < 30" } },
	{ "Feign Death", { "modifier.raid", "player.debuff(Aim)", "player.debuff(Aim).duration > 3" } }, --SoO: Paragons - Aim
	{ "Aspect of the Cheetah", { "player.moving", "!player.buff", "!player.buff(Aspect of the Pack)", "!player.buff(Aspect of the Fox)", "!modifier.last" } }, -- 10sec cd now unless glyphed
	{ "Exhilaration", { "modifier.cooldowns", "player.health < 40", "talent(3, 1)" } },
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)
	{ "Master's Call", "player.state.disorient" },
	{ "Master's Call", "player.state.stun" },
	{ "Master's Call", "player.state.root" },
	{ "Master's Call", "player.state.snare" },
	-- TODO: Proactive Deterrence
	{ "Deterrence", "player.health < 20" },

	-- MISDIRECTION ( focus -> tank -> pet )
	{ {
		{ "Misdirection", { "focus.exists", "focus.alive", "focus.distance < 100" }, "focus" },
		{ "Misdirection", { "tank.exists", "tank.alive", "!focus.exists", "tank.distance < 100" }, "tank" },
		{ "Misdirection", { "pet.exists", "pet.alive", "!focus.exists", "!tank.exists", "pet.distance < 100" }, "pet" },
	},{
		"!toggle.pvpmode", "!player.buff(Misdirection)", "target.threat > 30",
	} },

	-- Pre-DPS PAUSE
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- INTERRUPTS
	{ "Counter Shot", "modifier.interrupt" },

	-- DISPELLS
	{ "Tranquilizing Shot", "target.dispellable", "target" },
	{ "Tranquilizing Shot", "mouseover.dispellable", "mouseover" },

	-- DPS COOLDOWNS
	{ "#76089", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "player.hashero", "target.boss" } }, -- Agility Potion (76089) Virmen's Bite
	{ "Rapid Fire", { "modifier.cooldowns", "player.focus > 60" } },
	{ "Rapid Fire", { "modifier.cooldowns", "player.focus > 40", "player.buff(Thrill of the Hunt)" } },
	{ "Berserking", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero", "!player.buff(Rapid Fire)" } },

	-- DPS ROTATION -- Always want a minimum of 35 focus
	{ "Aspect of the Fox", { "target.enemy", "target.health > 1", "player.movingfor > 3", "player.buff(Sniper Training)" } },
	{ "A Murder of Crows" }, --, "talent(5, 1)"
	{ "Chimaera Shot" },
	{ "Kill Shot", "target.health <= 20" },
	{ "Aimed Shot", "player.buff(Thrill of the Hunt)" },
	{ "Glaive Toss", { "talent(6, 1)", "target.health < 80", "!player.buff(Rapid Fire)" } },
	{ "Glaive Toss", { "talent(6, 1)", "timeout(Glaive Toss, 10)", "target.area(10).enemies > 3" } },
	{ "Barrage", { "talent(6, 3)", "target.health < 80", "!player.buff(Rapid Fire)" } }, --  you can change where Barrage is directed by turning your character while channelling the spell. This allows you to hit more targets than those you were initially facing.
	{ "Barrage", { "talent(6, 3)", "timeout(Barrage, 10)", "target.area(10).enemies > 3" } },
	{ "Explosive Trap", { "!target.moving", "timeout(Explosive Trap, 10)", "target.area(10).enemies > 3" }, "target.ground" },
	{ {
		{ "Multi-Shot", "player.focus > 75" },
		{ "Multi-Shot", { "player.focus > 55", "player.buff(Thrill of the Hunt)" } },
		{ "Multi-Shot", { "player.focus > 50", "player.buff(Bombardment)" } },
	},{
		"target.health < 80", "!player.buff(Rapid Fire)", "timeout(Multi-Shot, 1)", "target.area(10).enemies > 3", -- Rate limited, lagging badly as of Oct 24th.
	} },
	{ {
		{ "Aimed Shot", "player.focus > 70" },
		{ "Aimed Shot", { "player.focus > 50", "player.buff(Thrill of the Hunt)" } },
	},{
		"timeout(Aimed Shot, 1)", "target.area(10).enemies < 4", -- Rate limited, lagging badly as of Oct 24th.
	} },
	{ "Aimed Shot", { "player.focus > 70", "player.buff(Rapid Fire)" } },
	{ "Aimed Shot", { "player.focus > 50", "player.buff(Rapid Fire)", "player.buff(Thrill of the Hunt)" } },
	{ "Aimed Shot", { "player.focus > 70", "target.health >= 80" } },
	{ "Aimed Shot", { "player.focus > 50", "target.health >= 80", "player.buff(Thrill of the Hunt)" } },
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff.any", "target.moving", "!target.immune.snare" } },
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff.any", "target.health > 20" } },
	{ "Steady Shot", "player.focus <= 75" },

},
{
	-- Pauses
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },

	-- Glyph of Fetch Autoloot!
	-- TODO: Engineer Loot-A-Rang
	{ "Fetch", { "!modifier.last", "!player.moving", "timeout(Fetch, 30)"} }, --/targetlasttarget /use [@target,exists,dead] Fetch

	-- Aspects
	{ "Aspect of the Cheetah", { "player.movingfor > 1", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } }, -- 10sec cd now unless glyphed
	{ "Camouflage", { "toggle.camomode", "!player.buff", "!player.debuff(Orb of Power)", "!modifier.last" } },

	-- Pet
	-- TODO: Use proper pet when raid does not provide buff. http://www.icy-veins.com/wow/survival-hunter-pve-dps-buffs-debuffs-useful-abilities
	{ "883", { "!player.moving", "!pet.exists", "!pet.alive" } }, -- Call Pet 1
	{ "Revive Pet", { "!player.moving", "!pet.alive" } },
	{ "Mend Pet", { "pet.exists", "pet.alive", "pet.health <= 90", "!pet.buff(Mend Pet)", "pet.distance < 45" } },

	-- Traps
	{ {
		{ "Trap Launcher", "!player.buff(Trap Launcher)" },
		{ "Explosive Trap", true, "mouseover.ground" },
		{ "Ice Trap", true, "mouseover.ground" },
		{ "Freezing Trap", true, "mouseover.ground" },
	},{
		"modifier.lalt",
	} },

	-- PRE COMBAT
	{ "#76089", { "toggle.consume", "target.exists", "target.boss", "@bbLib.prePot" } }, -- Agility Potion (76089) Virmen's Bite

	{ {
		{ "Flare", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "!Auto Shot", { "target.exists", "target.health > 1" } },
		{ "Glaive Toss", "talent(6, 1)" },
		{ "Chimaera Shot" },
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
