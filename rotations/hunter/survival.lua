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

PossiblyEngine.rotation.register_custom(255, "bbHunter Survival", {
-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "player.buff(Obsidian Nightwing)" }, -- Trying to cast when mounted!
	--{ "pause", "@bbLib.bossMods" },
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- SoO: Paragons - Aim
	{ "Feign Death", { "player.debuff(Aim)", "player.debuff(Aim).duration > 3" } },

	-- Interrupts
	{ "Counter Shot", "modifier.interrupt" },

	-- Tranq Shot
	{ "Tranquilizing Shot", "target.dispellable", "target" },
	{ "Tranquilizing Shot", "mouseover.dispellable", "mouseover" },

	-- Pet
	{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	{ "Heart of the Phoenix", "!pet.alive" },
	{ "Mend Pet", { "pet.health <= 50", "pet.exists", "!pet.buff" } }, -- Mend Pet and Revive Pet on same button now , "pet.distance < 40"
	
	-- Traps
	{ "Trap Launcher", { "modifier.lalt", "!player.buff" } },
	{ "Explosive Trap", "modifier.lalt", "ground" },
	{ "Ice Trap", "modifier.lalt", "ground" },
	{ "Snake Trap", "modifier.lalt", "ground" },
	{ "Freezing Trap", "modifier.ralt", "ground" },

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
	{ "Binding Shot", { "modifier.rcontrol", "talent(2, 1)", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", 
	"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
	"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover.ground" }, 
	
	-- Flare
	--{ "Flare", true, "target.ground" },
	
    -- Misdirect ( focus -> tank -> pet )
	{{
		{ "Misdirection", { "focus.exists", "focus.alive", "focus.distance < 100"  }, "focus" },
		--{ "Misdirection", { "tank.exists", "tank.alive", "!focus.exists", "tank.distance < 100" }, "tank" },
		{ "Misdirection", { "pet.exists", "pet.alive", "!focus.exists", "!tank.exists", "pet.distance < 100" }, "pet" },
	}, {
		"!toggle.pvpmode", "!target.isPlayer", "!player.buff(Misdirection)", "target.threat > 60" -- "@bbLib.canMisdirect",  
	}},

	-- Stances
	{ "Aspect of the Cheetah", { "player.moving", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } }, -- 10sec cd now unless glyphed
	
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
	--{ "Exhilaration", { "modifier.cooldowns", "player.health < 40" } },
	--{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit
	{ "#5512", { "modifier.cooldowns", "player.health < 35" } }, -- Healthstone (5512)
	--{ "#76097", { "toggle.consume", "player.health < 15", "@bbLib.useHealthPot", "target.boss" } }, -- Master Healing Potion (76097)	
	{ "Master's Call", "player.state.disorient" },
	{ "Master's Call", "player.state.stun" },
	{ "Master's Call", "player.state.root" },
	{ "Master's Call", "player.state.snare" },
	{ "Deterrence", "player.health < 20" }, -- Deterrence
	
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
	{ "#76089",          { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "player.hashero", "target.boss" } }, -- Agility Potion (76089) Virmen's Bite
	--{ "Blood Fury",      "modifier.cooldowns" },
	{ "#gloves",         { "modifier.cooldowns", "pet.exists", "target.exists" } }, -- Synapse Springs
	{ "Berserking",      { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero" } },

	-- Rotation
	{ "Explosive Shot" },
	{ "Black Arrow" },
	{ "Glaive Toss", "talent(6, 1)" },
	--{ "Barrage", "talent(6, 3)" },
	{ "A Murder of Crows", "talent(5, 1)" },
	--{ "Stampede",        { "modifier.cooldowns", "pet.exists", "player.hashero", "talent(5, 3)" } },
	{ "Dire Beast", "talent(4, 2)" },
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff.any", "target.moving", "!target.immune.snare" } },
	{ "Widow Venom",     { "toggle.pvpmode", "!target.debuff.any", "target.health > 20" } },
	{ "Explosive Trap",  { "toggle.cleavemode", "target.enemy", (function() return UnitsAroundUnit('target', 8) > 3 end) }, "target.ground" }, -- UAU only counts neutral/hostile, no good for healing.
	{ "Multi-Shot",      { "toggle.cleavemode", "player.focus >= 60", (function() return UnitsAroundUnit('target', 10) > 2 end) } }, --Applies Serpent Sting Now
	{ "Arcane Shot",     { "player.focus >= 60", (function() return UnitsAroundUnit('target', 10) < 3 end) } }, --Applies Serpent Sting Now
	{ "Cobra Shot",      "player.focus < 40" },
	{ "Cobra Shot",      "player.spell(Explosive Shot).cooldown > 0.5" },
	
},
{
	-- Pauses
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	--{ "pause", "player.buff(Obsidian Nightwing)" }, -- Trying to cast when mounted!
	
	-- Stances
	-- TODO: player.moving(seconds)
	{ "Aspect of the Cheetah", { "player.moving", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } }, -- 10sec cd now unless glyphed
	{ "Camouflage", { "toggle.camomode", "!player.buff", "!player.debuff(Orb of Power)", "!modifier.last" } },

	-- Pet
	{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	{ "Revive Pet", { "!player.moving", "!pet.alive" } }, -- Mend Pet and Revive Pet on same button now
	{ "Mend Pet", { "pet.exists", "pet.alive", "pet.health <= 90", "!pet.buff(Mend Pet)" } }, -- OOC only -- "pet.distance < 45"

	-- Traps
	{ "Trap Launcher", { "modifier.lalt", "!player.buff" } },
	{ "Explosive Trap", "modifier.lalt", "ground" },
	{ "Ice Trap", "modifier.lalt", "ground" },
	{ "Snake Trap", "modifier.lalt", "ground" },
	{ "Freezing Trap", "modifier.ralt", "ground" },

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
