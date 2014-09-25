-- PossiblyEngine Rotation Packager
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

	-- PvP Abilities
	-- TODO: Automatic PvP mode isPlayer isPvP
	-- TODO: Proactive Deterrence
	{ "Scatter Shot", { "toggle.mouseovers", "mouseover.isPlayer", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" },
	{ "Scatter Shot", { "modifier.rcontrol", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" },
	--{ "Wyvern Sting", { "toggle.mouseovers", "mouseover.isPlayer", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
	--	"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
	--	"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" },
	--{ "Wyvern Sting", { "modifier.rcontrol", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", -- 
	--	"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
	--	"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" },
	{ "Binding Shot", { "toggle.mouseovers", "mouseover.isPlayer", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover.ground" },
	{ "Binding Shot", { "modifier.rcontrol", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", -- 
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "ground" }, 
	{ "Ice Trap", { "modifier.rcontrol", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "mouseover.status.disorient", -- Ice Trap on Scatter Shot targets
		"!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover.ground" }, 
	{ "Scare Beast", { "toggle.mouseovers", "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(Scare Beast)", "mouseover.creatureType(Beast)" }, "mouseover" },
	--{ "Scare Beast", { "toggle.pvpmode", "target.exists", "target.enemy", "target.alive", "!target.debuff(Scare Beast)", "target.creatureType(Beast)" } },
	
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
	{ "#5512", { "modifier.cooldowns", "player.health < 30" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "@bbLib.useHealthPot", "target.boss" } }, -- Master Healing Potion (76097)	
	{ "Master's Call", "player.state.disorient" },
	{ "Master's Call", "player.state.stun" },
	{ "Master's Call", "player.state.root" },
	{ "Master's Call", "player.state.snare" },
	{ "Deterrence", "player.health < 30" }, -- Deterrence
	{ "Deterrence", { "player.debuff(Set to Blow)", "player.debuff(Set to Blow).duration < 2" } },
	
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

	-- Dual Use
	{ "Fervor", "player.focus <= 50" }, -- TIER 4 Talent
	
	-- Multi Target
	{{
	{ "Multi-Shot" },
	{ "Glaive Toss" }, -- TIER 6 Talent
	{ "Powershot" }, -- TIER 6 Talent
	{ "Barrage" }, -- TIER 6 Talent
	{ "Explosive Trap", true, "target.ground" },
	{ "Black Arrow", { "!target.debuff", "target.deathin >= 15", "!target.state.charm" } },
	{ "Explosive Shot", "player.buff(Lock and Load)" },
	{ "Kill Shot", "target.health <= 20" },
	{ "Cobra Shot", "player.focus < 40" },
	}, {
		"modifier.multitarget"
	}},
	
	-- Single Target -- 227.1k @ 120M || 238.4 @ 50M 3:31
	{ "Explosive Shot", "player.buff(Lock and Load)" },
	{ "Serpent Sting", { "!target.debuff(Serpent Sting)", "target.deathin >= 15", "!target.state.charm" } },
	{ "Black Arrow", { "!target.debuff", "target.deathin >= 15", "!target.state.charm" } },
	{ "Kill Shot" },
	{ "Explosive Shot" },
	--{ "pause", "player.spell(Kill Shot).cooldown <= 0.3" },
	--{ "pause", "player.spell(Explosive Shot).cooldown <= 0.3" },
	{ "Serpent Sting", { "!modifier.pvpmode", "toggle.mouseovers", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff", "!mouseover.state.charm", "mouseover.deathin >= 15" }, "mouseover" },
	{ "Glaive Toss" }, -- T6 Talent
	--{ "Powershot" }, -- T6 Talent
	--{ "Barrage" }, -- T6 Talent
	{ "A Murder of Crows" }, -- T5 Talent
	--{ "Lynx Rush" }, -- T5 Talent
	{ "Dire Beast" }, -- T4 Talent
	{ "Stampede", { "modifier.cooldowns", "pet.exists", "player.hashero" } },
	{ "Stampede", { "modifier.cooldowns", "pet.exists", "player.buff(Rapid Fire)" } },
	{ "Rapid Fire", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero" } },
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff.any", "target.moving", "!target.immune.snare" } },
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff.any", "target.health > 20" } },
	{ "Explosive Trap", { "toggle.cleavemode", "modifier.enemies > 2", "target.enemy" }, "target.ground" },
	{ "Multi-Shot", { "toggle.cleavemode", "player.focus >= 60", "modifier.enemies > 2" } },
	{ "Arcane Shot", "player.focus >= 60" },
	{ "Cobra Shot", "player.focus < 40" },
	{ "Cobra Shot", "player.spell(Explosive Shot).cooldown > 0.5" },
	
	-- Old Single Target -- 224.5k @ 120M || 232.0k @ 50M 3:36
	-- { "Explosive Shot", "player.buff(Lock and Load)" }, -- Explosive Shot, Lock and Load
	-- -- pause here if LnL proc, possibly energy check?
	-- { "Glaive Toss" }, -- T6 Talent
	-- { "Powershot" }, -- T6 Talent
	-- { "Barrage" }, -- T6 Talent
	-- { "Serpent Sting", { "!target.debuff(Serpent Sting)", "target.deathin >= 15", "!target.state.charm" } },
	-- { "Explosive Shot" },
	-- { "Kill Shot", "target.health <= 20" }, -- Kill Shot
	-- { "Concussive Shot", { "toggle.pvpmode", "!target.debuff.any", "target.moving", "!target.immune.snare" } },
	-- { "Widow Venom", { "toggle.pvpmode", "!target.debuff.any", "target.health > 20" } },
	-- { "Black Arrow", { "!target.debuff", "target.deathin >= 15", "!target.state.charm" } },
	-- { "Multi-Shot", { "player.buff(Thrill of the Hunt)", "target.debuff(Serpent Sting).duration < 2" } },
	-- { "Multi-Shot", { "toggle.cleavemode", "player.buff(Thrill of the Hunt)" } },
	-- { "Arcane Shot", "player.buff(Thrill of the Hunt)" },
	-- { "Rapid Fire", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero" } },
	-- { "A Murder of Crows" }, -- T5 Talent
	-- { "Lynx Rush" }, -- T5 Talent
	-- { "Dire Beast" }, -- T4 Talent
	-- { "Stampede", { "modifier.cooldowns", "pet.exists", "player.hashero" } },
	-- { "Stampede", { "modifier.cooldowns", "pet.exists", "player.buff(Rapid Fire)" } },
	-- { "Cobra Shot", "target.debuff(Serpent Sting).duration < 6" },
	-- { "Multi-Shot", { "toggle.cleavemode", "player.focus >= 67", "modifier.enemies > 2" } },
	-- { "Explosive Trap", { "toggle.cleavemode", "modifier.enemies > 2" }, "target.ground" },
	-- { "Arcane Shot", { "player.focus >= 67" } },
	-- { "Cobra Shot", "player.spell(Explosive Shot).cooldown > 1" },
	-- { "Cobra Shot", "player.focus < 40" },
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
