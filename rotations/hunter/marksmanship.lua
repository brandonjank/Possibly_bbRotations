-- PossiblyEngine Rotation
-- Marksmanship Hunter - WoD 6.0.2
-- Updated on Nov 14th 2014

-- SUGGESTED TALENTS: Crouching Tiger, Binding Shot, Iron Hawk, Thrill of the Hunt, A Murder of Crows, and Barrage or Glaive Toss
-- SUGGESTED GLYPHS: Major: Animal Bond, Deterrence, Disengage  Minor: Aspect of the Cheetah, Play Dead, Fetch
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control

PossiblyEngine.rotation.register_custom(254, "bbHunter Marksmanship", {
-- COMBAT ROTATION
	-- PAUSES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!toggle.frogs", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "!toggle.frogs", "target.exists", "target.dead" } },

	-- FROGING
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
	{ "883", { "!talent(7, 3)", "!pet.exists", "!modifier.last" } }, -- Call Pet 1
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

--[[
	-- DPS COOLDOWNS
	{ "#76089", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "player.hashero", "target.boss" } }, -- Agility Potion (76089) Virmen's Bite
	{ "Rapid Fire", { "modifier.cooldowns", "player.focus > 60" } },
	{ "Rapid Fire", { "modifier.cooldowns", "player.focus > 40", "player.buff(Thrill of the Hunt)" } },
	{ "Berserking", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero", "!player.buff(Rapid Fire)" } },

	-- DPS ROTATION -- Always want a minimum of 35 focus
	{ "Aspect of the Fox", { "target.enemy", "target.health > 1", "player.movingfor > 2", "player.buff(Sniper Training)" } },
	{ "Chimaera Shot" },
	{ "Kill Shot", "target.health <= 20" },
	{ "A Murder of Crows", "talent(5, 1)" },
	{ "Stampede", "talent(5, 3)" },
	{ "Glaive Toss", "talent(6, 1)" },
	{ "Powershot", { "talent(6, 2)", "!player.moving" } },
	{ "Barrage", { "talent(6, 3)", "!player.moving" } }, --  you can change where Barrage is directed by turning your character while channelling the spell. This allows you to hit more targets than those you were initially facing.
	{ "Steady Shot", { "talent(4, 1)", "!player.buff(Steady Focus)", "player.focus < 80" } },
	{ {
		{ "Multi-Shot", "player.focus > 70" },
		{ "Multi-Shot", "player.buff(Thrill of the Hunt)" },
		{ "Multi-Shot", "player.buff(Bombardment)" },
		{ "Explosive Trap", "!target.moving", "target.ground" },
	},{
		"target.area(10).enemies > 3",
	} },
	{ {
		{ "Aimed Shot", "player.focus > 70" },
		{ "Aimed Shot", "player.buff(Thrill of the Hunt)" },
	},{
		"target.area(10).enemies < 4",
	} },
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff.any", "target.moving", "!target.immune.snare" } },
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff.any", "target.health > 20" } },
	{ "Steady Shot", "player.focus < 80" },
]] --

	-- COMMON / COOLDOWNS
	-- actions=auto_shot
	-- actions+=/use_item,name=gorashans_lodestone_spike (trinket) 109998
	{ "Arcane Torrent", "player.focus <= 70" },
	{ "Blood Fury", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive" } },
	{ "Berserking", { "modifier.cooldowns", "pet.exists", "target.enemy", "target.alive" } },
	-- actions+=/potion,name=draenic_agility,if=((buff.rapid_fire.up|buff.bloodlust.up)&(cooldown.stampede.remains<1))|target.time_to_die<=25
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "player.hashero", "player.spell(Stampede).cooldown < 1" } }, -- Draenic Agility Potion
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "player.buff(Rapid Fire)", "player.spell(Stampede).cooldown < 1" } }, -- Draenic Agility Potion
	--{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "target.deathin <= 25" } }, -- Draenic Agility Potion
	{ "Chimaera Shot" },
	{ "Kill Shot" },
	-- actions+=/rapid_fire
	{ "Rapid Fire", { "modifier.cooldowns", "player.focus > 40" } },
	{ "Rapid Fire", { "modifier.cooldowns", "player.focus > 20", "player.buff(Thrill of the Hunt)" } },
	{ "Stampede", { "modifier.cooldowns", "player.buff(Rapid Fire)" } },
	{ "Stampede", { "modifier.cooldowns", "player.hashero" } },
	{ "Stampede", { "modifier.cooldowns", "target.boss","target.deathin <= 25" } },
	{ "Call to Arms", { "target.exists", "target.enemy" } },

	-- CAREFUL AIM PHASE
	{ {
		{ "Glaive Toss", "target.area(10).enemies > 2" },
		-- actions.careful_aim+=/powershot,if=active_enemies>1&cast_regen<focus.deficit
		{ "Powershot", { "player.focus < 80", "target.area(10).enemies > 1" } },
		{ "Barrage", "target.area(10).enemies > 1" },
		{ "Aimed Shot" },
		-- actions.careful_aim+=/focusing_shot,if=50+cast_regen<focus.deficit
		{ "Focusing Shot", "player.focus < 25" },
		{ "Steady Shot", "player.focus < 90" },
	},{
		"target.health > 80",
	} },
	{ {
		{ "Glaive Toss", "target.area(10).enemies > 2" },
		-- actions.careful_aim+=/powershot,if=active_enemies>1&cast_regen<focus.deficit
		{ "Powershot", { "player.focus < 80", "target.area(10).enemies > 1" } },
		{ "Barrage", "target.area(10).enemies > 1" },
		{ "Aimed Shot" },
		-- actions.careful_aim+=/focusing_shot,if=50+cast_regen<focus.deficit
		{ "Focusing Shot", "player.focus < 25" },
		{ "Steady Shot", "player.focus < 90" },
	},{
		"player.buff(Rapid Fire)",
	} },

	{ "Explosive Trap", { "!target.moving", "target.area(8).enemies > 1" }, "target.ground" },
	{ "A Murder of Crows" },
	-- actions+=/dire_beast,if=cast_regen+action.aimed_shot.cast_regen<focus.deficit
	{ "Dire Beast", "player.focus < 80" },
	{ "Glaive Toss" },
	-- actions+=/powershot,if=cast_regen<focus.deficit
	{ "Powershot", "player.focus < 80" },
	{ "Barrage" },
	-- # Pool max focus for rapid fire so we can spam AimedShot with Careful Aim buff
	-- actions+=/steady_shot,if=focus.deficit*cast_time%(14+cast_regen)>cooldown.rapid_fire.remains
	-- actions+=/focusing_shot,if=focus.deficit*cast_time%(50+cast_regen)>cooldown.rapid_fire.remains&focus<100
	-- # Cast a second shot for steady focus if that won't cap us.
	-- actions+=/steady_shot,if=buff.pre_steady_focus.up&(14+cast_regen+action.aimed_shot.cast_regen)<=focus.deficit
	{ "Steady Shot", { "modifier.last", "!player.buff(Steady Focus)", "player.focus < 58" } },
	{ "Multi-Shot", "target.area(8).enemies > 6" },
	{ "Aimed Shot", "talent(7, 2)" },
	-- actions+=/aimed_shot,if=focus+cast_regen>=85
	{ "Aimed Shot", "player.focus > 70" },
	-- actions+=/aimed_shot,if=buff.thrill_of_the_hunt.react&focus+cast_regen>=65
	{ "Aimed Shot", { "player.focus > 50", "player.buff(Thrill of the Hunt)" } },
	-- # Allow FS to over-cap by 10 if we have nothing else to do
	-- actions+=/focusing_shot,if=50+cast_regen-10<focus.deficit
	{ "Focusing Shot", "player.focus < 50" },
	-- actions+=/steady_shot
	{ "Steady Shot", "player.focus < 88" },

},
{
-- OUT OF COMBAT ROTATION
	-- PAUSES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },

	-- AUTO LOOT
	{ "Fetch", { "timeout(Fetch, 9)", "player.ooctime < 30", "!player.moving", "!target.exists", "!player.busy" } }, --/targetlasttarget /use [@target,exists,dead] Fetch

	-- ASPECTS
	{ "Aspect of the Cheetah", { "player.movingfor > 1", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } }, -- 10sec cd now unless glyphed
	{ "Camouflage", { "toggle.camomode", "!player.buff", "player.lastmoved < 30", "!player.debuff(Orb of Power)", "!modifier.last" } },

	-- PET MANAGEMENT
	-- TODO: Use proper pet when raid does not provide buff. http://www.icy-veins.com/wow/survival-hunter-pve-dps-buffs-debuffs-useful-abilities
	{ "883", { "!talent(7, 3)", "!pet.exists", "!modifier.last" } }, -- Call Pet 1
	{ "Heart of the Phoenix", { "pet.exists", "pet.dead", "!modifier.last" } },
	{ "Mend Pet", { "pet.exists", "pet.alive", "pet.health < 70", "pet.distance < 45", "!pet.buff(Mend Pet)", "!modifier.last" } },
	{ "Revive Pet", { "pet.exists", "pet.dead", "!player.moving", "pet.distance < 45", "!modifier.last" } },

	-- TRAPS
	{ "Trap Launcher", { "modifier.lalt", "!player.buff(Trap Launcher)" } },
	{ "Explosive Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" }, -- mouseover.ground?
	{ "Ice Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" },
	{ "Freezing Trap", { "modifier.ralt", "player.buff(Trap Launcher)" }, "ground" },

	-- FROGING
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
	-- actions.precombat+=/aimed_shot

},
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')
	PossiblyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Use Camouflage', 'Toggle the usage Camouflage when out of combat.')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target un-tapped Gulp Frogs.')
end)
