-- PossiblyEngine Rotation
-- Survival Hunter - WoD v6.0.3
-- Updated on Nov 14th 2014

-- SUGGESTED TALENTS:
-- SUGGESTED GLYPHS:
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control

-- TODO: Explosive Trap timer cooldown OSD
-- TODO: Boss Functions + hold cooldowns
-- TODO: Energy Pooling Toggle
-- TODO: Pet's Range to the target
-- TODO: How to check if target has incoming heal? UnitGetIncomingHeals()

PossiblyEngine.rotation.register_custom(255, "bbHunter Survival", {
-- COMBAT ROTATION
	-- PAUSES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!toggle.frogs", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "!toggle.frogs", "target.exists", "target.dead" } },

	-- FROGGING
	{ {
		{ "Flare", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		-- Ordon Candlekeeper, Ordon Fire-Watcher, Ordon Oathguard (Gotta strafe out of fire and ground crap)
	},{
		"toggle.frogs",
	} },

	-- BOSS MODS
	--{ "Feign Death", { "modifier.raid", "target.exists", "target.enemy", "target.boss", "target.agro", "target.distance < 30" } },
	--{ "Feign Death", { "modifier.raid", "player.debuff(Aim)", "player.debuff(Aim).duration > 3" } }, --SoO: Paragons - Aim

	-- INTERRUPTS / DISPELLS
	{ "Counter Shot", "modifier.interrupt" },
	{ "Tranquilizing Shot", "target.dispellable", "target" },

	-- PET MANAGEMENT
	-- TODO: Use proper pet when raid does not provide buff. http://www.icy-veins.com/wow/survival-hunter-pve-dps-buffs-debuffs-useful-abilities
	{ "883", { "!pet.exists", "!modifier.last" } }, -- Call Pet 1
	{ "Heart of the Phoenix", { "pet.exists", "pet.dead", "!modifier.last" } },
	{ "Mend Pet", { "pet.exists", "pet.alive", "pet.health < 70", "pet.distance < 45", "!pet.buff(Mend Pet)", "!modifier.last" } },
	{ "Revive Pet", { "pet.exists", "pet.dead", "!player.moving", "pet.distance < 45", "!modifier.last" } },

	-- TRAPS
	{ "Trap Launcher", { "modifier.lalt", "!player.buff(Trap Launcher)" } },
	{ "Explosive Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" }, -- mouseover.ground?
	{ "Ice Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" },
	{ "Freezing Trap", { "modifier.ralt", "player.buff(Trap Launcher)" }, "ground" },

	-- MISDIRECTION ( focus -> tank -> pet )
	{ {
		{ "Misdirection", { "focus.exists", "focus.alive", "focus.distance < 100"  }, "focus" },
		{ "Misdirection", { "modifier.raid", "tank.exists", "tank.alive", "tank.distance < 100" }, "tank" },
		{ "Misdirection", { "pet.exists", "pet.alive", "pet.distance < 100" }, "pet" },
	},{
		"!toggle.pvpmode", "!target.isPlayer", "!player.buff(Misdirection)", "target.threat > 30",
	} },

	-- DEFENSIVE COOLDOWNS
	{ "Exhilaration", "player.health < 40" },
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)
	{ "Master's Call", "player.state.disorient", "player" },
	{ "Master's Call", "player.state.stun", "player" },
	{ "Master's Call", "player.state.root", "player" },
	{ "Master's Call", "player.state.snare", "player" },
	{ "Deterrence", "player.health < 20" },

	-- Pre-DPS PAUSE
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- COMMON / COOLDOWNS
	-- actions=auto_shot
	-- actions+=/use_item,name=gorashans_lodestone_spike (trinket) 109998
	{ "Arcane Torrent", "player.focus <= 70" },
	{ "Blood Fury", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive" } },
	{ "Berserking", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive" } },
	-- actions+=/potion,name=draenic_agility,if=(((cooldown.stampede.remains<1)&(cooldown.a_murder_of_crows.remains<1))&(trinket.stat.any.up|buff.archmages_greater_incandescence_agi.up))|target.time_to_die<=25
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.enemy", "target.boss", "target.deathin <= 25" } }, -- Draenic Agility Potion
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.enemy", "target.boss", "player.hashero", "player.spell(Stampede).cooldown < 1", "player.spell(A Murder of Crows).cooldown < 1" } }, -- Draenic Agility Potion

	-- AOE ROTATION
	{ {
		-- actions.aoe=stampede,if=buff.potion.up|(cooldown.potion.remains&(buff.archmages_greater_incandescence_agi.up|trinket.stat.any.up|buff.archmages_incandescence_agi.up))
		{ "Stampede", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive", "player.buff(Draenic Agility Potion)" } },
		{ "Stampede", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive", "player.hashero" } },
		{ "Stampede", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive", "!modifer.raid" } },
		{ "Explosive Shot", { "!talent(6, 3)", "player.buff(Lock and Load)" } },
		{ "Explosive Shot", { "player.spell(Barrage).cooldown > 0", "player.buff(Lock and Load)" } },
		{ "Barrage" },
		{ "Explosive Shot", "target.area(8).enemies < 5" },
		{ "Black Arrow", "!target.debuff" },
		{ "Trap Launcher", { "!player.buff(Trap Launcher)", "!modifier.last" } },
		{ "Explosive Trap", { "target.enemy", "!target.moving", "player.buff(Trap Launcher)", "target.debuff(Explosive Trap).remains <= 3" }, "target.ground" },
		{ "A Murder of Crows" },
		{ "Dire Beast" },
		-- actions.aoe+=/multishot,if=buff.thrill_of_the_hunt.react&focus>50&cast_regen<=focus.deficit|dot.serpent_sting.remains<=5|target.time_to_die<4.5
		{ "Multi-Shot", { "player.buff(Thrill of the Hunt)", "player.focus > 50", "player.focus <= 90" } },
		{ "Multi-Shot", "target.debuff(Serpent Sting).remains <= 5" },
		{ "Multi-Shot", "target.deathin < 4.5" },
		{ "Glaive Toss" },
		{ "Powershot" },
		-- actions.aoe+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&focus+14+cast_regen<80
		{ "Cobra Shot", { "talent(4, 1)", "modifier.last", "player.buff(Steady Focus).remains < 5", "player.focus < 55" } },
		{ "Multi-Shot", "player.focus >= 70" },
		{ "Multi-Shot", "talent(7, 2)" },
		{ "Focusing Shot" },
		{ "Cobra Shot" },
	},{
		"modifier.multitarget", "target.area(8).enemies > 1",
	} },

	-- SINGLE TARGET ROTATION
	-- actions+=/stampede,if=buff.potion.up|(cooldown.potion.remains&(buff.archmages_greater_incandescence_agi.up|trinket.stat.any.up))|target.time_to_die<=25
	{ "Stampede", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive", "player.buff(Draenic Agility Potion)" } },
	{ "Stampede", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive", "player.hashero" } },
	{ "Stampede", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive", "!modifer.raid" } },
	{ "Stampede", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive", "modifer.raid", "target.boss", "target.deathin <= 25" } },
	{ "Explosive Shot" },
	{ "Black Arrow", "!target.debuff" },
	{ "A Murder of Crows" },
	{ "Dire Beast" },
	-- actions+=/arcane_shot,if=buff.thrill_of_the_hunt.react&focus>35&cast_regen<=focus.deficit|dot.serpent_sting.remains<=5|target.time_to_die<4.5
	{ "Arcane Shot", { "player.buff(Thrill of the Hunt)", "player.focus > 35", "player.focus <= 90" } },
	{ "Arcane Shot", "target.debuff(Serpent Sting).remains <= 5" },
	{ "Arcane Shot", "target.deathin < 4.5" },
	{ "Glaive Toss" },
	{ "Powershot" },
	{ "Barrage" },
	{ "Cobra Shot", { "talent(4, 1)", "modifier.last", "player.buff(Steady Focus).remains < 5", "player.focus < 75" } },
	{ "Aspect of the Cheetah", { "player.glyph()", "player.movingfor > 1", "!player.buff", "!player.buff(Aspect of the Pack).any", "!modifier.last" } }, -- 10sec cd now unless glyphed
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff.any", "target.movingfor > 1", "!target.immune.snare" } },
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff.any", "target.health > 20" } },
	{ "Arcane Shot", "player.focus >= 70" },
	{ "Arcane Shot", "talent(7, 2)" },
	{ "Focusing Shot" },
	{ "Cobra Shot" },

},
{
-- OUT OF COMBAT ROTATION
	-- PAUSES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },

	-- ASPECTS
	{ "Aspect of the Cheetah", { "player.movingfor > 1", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } }, -- 10sec cd now unless glyphed
	{ "Camouflage", { "toggle.camomode", "!player.buff", "!player.debuff(Orb of Power)", "!modifier.last" } },

	-- PET MANAGEMENT
	-- TODO: Use proper pet when raid does not provide buff. http://www.icy-veins.com/wow/survival-hunter-pve-dps-buffs-debuffs-useful-abilities
	{ "883", { "!pet.exists", "!modifier.last" } }, -- Call Pet 1
	{ "Heart of the Phoenix", { "pet.exists", "pet.dead", "!modifier.last" } },
	{ "Mend Pet", { "pet.exists", "pet.alive", "pet.health < 70", "pet.distance < 45", "!pet.buff(Mend Pet)", "!modifier.last" } },
	{ "Revive Pet", { "pet.exists", "pet.dead", "!player.moving", "pet.distance < 45", "!modifier.last" } },

	-- TRAPS
	{ "Trap Launcher", { "modifier.lalt", "!player.buff(Trap Launcher)" } },
	{ "Explosive Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" }, -- mouseover.ground?
	{ "Ice Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" },
	{ "Freezing Trap", { "modifier.ralt", "player.buff(Trap Launcher)" }, "ground" },

	-- FROGGGING
	{ {
		{ "Flare", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "!Auto Shot", { "target.exists", "target.health > 1" } },
		{ "Glaive Toss", "talent(6, 1)" },
		{ "Explosive Shot" },
		{ "Arcane Shot" },
	},{
		"toggle.frogs",
	} },

	-- PRE COMBAT
	-- actions.precombat=flask,type=greater_draenic_agility_flask
	-- actions.precombat+=/food,type=blackrock_barbecue
	-- actions.precombat+=/summon_pet
	-- # Snapshot raid buffed stats before combat begins and pre-potting is done.
	-- actions.precombat+=/snapshot_stats
	-- actions.precombat+=/exotic_munitions,ammo_type=poisoned,if=active_enemies<3
	-- actions.precombat+=/exotic_munitions,ammo_type=incendiary,if=active_enemies>=3
	-- actions.precombat+=/potion,name=draenic_agility
	--{ "#76089", { "toggle.consume", "target.exists", "target.boss", "@bbLib.prePot" } }, -- Agility Potion (76089) Virmen's Bite

},
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')
	PossiblyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Use Camouflage', 'Toggle the usage Camouflage when out of combat.')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target un-tapped Gulp Frogs.')
end)
