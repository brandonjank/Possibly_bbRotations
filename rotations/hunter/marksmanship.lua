-- PossiblyEngine Rotation
-- Marksmanship Hunter - WoD 6.0.2
-- Updated on Nov 14th 2014

-- SUGGESTED TALENTS: Crouching Tiger, Binding Shot, Iron Hawk, Thrill of the Hunt, A Murder of Crows, and Barrage or Glaive Toss
-- SUGGESTED GLYPHS: Major: Animal Bond, Deterrence, Disengage  Minor: Aspect of the Cheetah, Play Dead, Fetch
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control

-- Grimrail - Rocketspark -- Borka's  Slam will now also interrupt spell casting, locking the player out of the affected spell school for a brief period. Casters and healers should target or focus Borka to watch for his Slam cast and avoid using cast-time spells as it finishes.
-- Grimrail - Nitrogg -- Use Blackrock Grenade on CD target.ground (Special Action Button)

PossiblyEngine.rotation.register_custom(254, "bbHunter Marksmanship", {
-- COMBAT ROTATION
	-- PAUSES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Camouflage)" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!toggle.frogs", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "!toggle.frogs", "target.exists", "target.dead" } },

	-- FROGING
	{ {
		{ "Flare", "@bbLib.engaugeUnit('Grom', 40, false)" },
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
	{ "Heart of the Phoenix", { "!talent(7, 3)", "pet.exists", "pet.dead", "!modifier.last" } },
	{ "Mend Pet", { "!talent(7, 3)", "pet.exists", "pet.alive", "pet.health < 70", "pet.distance < 45", "!pet.buff(Mend Pet)", "!modifier.last" } },
	{ "Revive Pet", { "!talent(7, 3)", "pet.exists", "pet.dead", "!player.moving", "pet.distance < 45", "!modifier.last" } },

	-- TRAPS
	{ "Trap Launcher", { "!modifier.last", "!player.buff(Trap Launcher)" } },
	{ "Explosive Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" }, -- mouseover.ground?
	{ "Ice Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" },
	{ "Freezing Trap", { "modifier.ralt", "player.buff(Trap Launcher)" }, "ground" },

	-- MISDIRECTION ( focus -> tank -> pet )
	{ {
		{ "Misdirection", { "focus.exists", "focus.alive", "focus.distance < 100"  }, "focus" },
		--{ "Misdirection", { "modifier.raid", "tank.exists", "tank.alive", "tank.distance < 100" }, "tank" },
		{ "Misdirection", { "!talent(7, 3)", "pet.exists", "pet.alive", "pet.distance < 100" }, "pet" },
	},{
		"!toggle.pvpmode", "!target.isPlayer", "!player.buff(Misdirection)", "target.threat > 30",
	} },

	-- DEFENSIVE COOLDOWNS
	{ "Exhilaration", "player.health < 40" },
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)
	{ "Master's Call", { "!talent(7, 3)", "player.state.disorient" }, "player" },
	{ "Master's Call", { "!talent(7, 3)", "player.state.stun" }, "player" },
	{ "Master's Call", { "!talent(7, 3)", "player.state.root" }, "player" },
	{ "Master's Call", { "!talent(7, 3)", "player.state.snare" }, "player" },
	{ "Deterrence", "player.health < 20" },

	-- Pre-DPS PAUSE
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- COMMON / COOLDOWNS
	{ "161060", { "target.exists", "player.debuff(Blackrock Grenades)" }, "target.ground" }, -- Blackrock Grenade /click ExtraActionButton1
	-- actions=auto_shot
	-- actions+=/use_item,name=gorashans_lodestone_spike
	{ "#trinket1", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive", "player.buff(Rapid Fire)" } },
	{ "#trinket1", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive", "player.hashero" } },
	-- actions+=/arcane_torrent,if=focus.deficit>=30
	{ "Arcane Torrent", { "modifier.cooldowns", "player.focus <= 70" } },
	-- actions+=/blood_fury
	{ "Blood Fury", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive" } },
	-- actions+=/berserking
	{ "Berserking", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive" } },
	-- actions+=/potion,name=draenic_agility,if=((buff.rapid_fire.up|buff.bloodlust.up)&(cooldown.stampede.remains<1))|target.time_to_die<=25
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "player.hashero" } }, -- Draenic Agility Potion
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "player.buff(Rapid Fire)" } }, -- Draenic Agility Potion
	{ "#109217", { "modifier.cooldowns", "toggle.consume", "target.exists", "target.boss", "target.deathin <= 25" } }, -- Draenic Agility Potion
	-- actions+=/chimaera_shot
	{ "Chimaera Shot" },
	-- actions+=/kill_shot
	{ "Kill Shot" },
	-- actions+=/rapid_fire
	{ "Rapid Fire", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive" } }, -- Only cast if boss target is under 80% to maximize CA?
	-- actions+=/stampede,if=buff.rapid_fire.up|buff.bloodlust.up|target.time_to_die<=25
	{ "Stampede", { "modifier.cooldowns", "player.buff(Rapid Fire)" } },
	{ "Stampede", { "modifier.cooldowns", "player.hashero" } },
	{ "Stampede", { "modifier.cooldowns", "target.boss","target.deathin <= 25" } },

	-- CAREFUL AIM
	{ {
	  -- actions.careful_aim=glaive_toss,if=active_enemies>2
	  { "Glaive Toss", "target.area(10).enemies > 2" },
	  -- actions.careful_aim+=/powershot,if=active_enemies>1&cast_regen<focus.deficit
	  { "Powershot", { "target.area(10).enemies > 1", "player.spell(Powershot).wontcap" } },
	  -- actions.careful_aim+=/barrage,if=active_enemies>1
	  { "Barrage", "target.area(10).enemies > 1" },
	  -- actions.careful_aim+=/aimed_shot
	  { "Aimed Shot" },
	  -- actions.careful_aim+=/focusing_shot,if=50+cast_regen<focus.deficit
	  { "Focusing Shot", { "player.focus < 32",  } },
	  -- actions.careful_aim+=/steady_shot
		{ "Steady Shot" },
	},{
		"target.health > 80",
	} },
	{ {
	  -- actions.careful_aim=glaive_toss,if=active_enemies>2
	  { "Glaive Toss", "target.area(10).enemies > 2" },
	  -- actions.careful_aim+=/powershot,if=active_enemies>1&cast_regen<focus.deficit
	  { "Powershot", { "target.area(10).enemies > 1", "player.spell(Powershot).wontcap" } },
	  -- actions.careful_aim+=/barrage,if=active_enemies>1
	  { "Barrage", "target.area(10).enemies > 1" },
	  -- actions.careful_aim+=/aimed_shot
	  { "Aimed Shot" },
	  -- actions.careful_aim+=/focusing_shot,if=50+cast_regen<focus.deficit
	  { "Focusing Shot", { "player.focus < 32",  } },
	  -- actions.careful_aim+=/steady_shot
	  { "Steady Shot" },
	},{
		"player.buff(Rapid Fire)",
	} },

	-- DPS ROTATION
	-- actions+=/explosive_trap,if=active_enemies>1
	{ "Explosive Trap", { "!target.moving", "target.area(8).enemies > 1" }, "target.ground" },
	-- actions+=/a_murder_of_crows
	{ "A Murder of Crows" },
	-- actions+=/dire_beast,if=cast_regen+action.aimed_shot.cast_regen<focus.deficit
	{ "Dire Beast", "@bbLib.canDireBeast" },
	-- actions+=/glaive_toss
	{ "Glaive Toss" },
	-- actions+=/powershot,if=cast_regen<focus.deficit
	{ "Powershot", "player.spell(Powershot).wontcap" },
	-- actions+=/barrage
	{ "Barrage" },
	-- # Pool max focus for rapid fire so we can spam AimedShot with Careful Aim buff
	-- actions+=/steady_shot,if=focus.deficit*cast_time%(14+cast_regen)>cooldown.rapid_fire.remains
	{ "Steady Shot", "@bbLib.poolSteady" },
	-- actions+=/focusing_shot,if=focus.deficit*cast_time%(50+cast_regen)>cooldown.rapid_fire.remains&focus<100
	{ "Focusing Shot", { "@bbLib.poolFocusing", "player.focus < 100" } },
	-- # Cast a second shot for steady focus if that won't cap us.
	-- actions+=/steady_shot,if=buff.pre_steady_focus.up&(14+cast_regen+action.aimed_shot.cast_regen)<=focus.deficit
	{ "Steady Shot", { "talent(4, 1)", "modifier.last(Steady Shot)", "!player.buff(Steady Focus)", "@bbLib.steadyFocus" } },
	-- actions+=/multishot,if=active_enemies>6
	{ "Multi-Shot", "target.area(8).enemies > 6" },
	-- actions+=/aimed_shot,if=talent.focusing_shot.enabled
	{ "Aimed Shot", "talent(7, 2)" },
	-- actions+=/aimed_shot,if=focus+cast_regen>=85
	-- actions+=/aimed_shot,if=buff.thrill_of_the_hunt.react&focus+cast_regen>=65
	{ "Aimed Shot", "@bbLib.aimedShot" },
	-- Cheetah!
	{ "Aspect of the Cheetah", { "player.movingfor > 1", "!player.buff", "!modifier.last" } },
	-- # Allow FS to over-cap by 10 if we have nothing else to do
	-- actions+=/focusing_shot,if=50+cast_regen-10<focus.deficit
	{ "Focusing Shot", "@bbLib.focusingShot" },
	-- actions+=/steady_shot
	{ "Steady Shot" },

},
{
-- OUT OF COMBAT ROTATION
	-- PAUSES
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", "player.buff(Camouflage)" },

	--{ "/stopcasting", "player.casting(Aimed Shot)" }

	-- AUTO LOOT
	{ "Fetch", { "!talent(7, 3)", "timeout(Fetch, 9)", "player.ooctime < 30", "!player.moving", "!target.exists", "!player.busy" } }, --/targetlasttarget /use [@target,exists,dead] Fetch

	-- PET MANAGEMENT
	-- TODO: Use proper pet when raid does not provide buff. http://www.icy-veins.com/wow/survival-hunter-pve-dps-buffs-debuffs-useful-abilities
	{ "883", { "!talent(7, 3)", "!pet.exists", "!modifier.last" } }, -- Call Pet 1
	{ "Heart of the Phoenix", { "!talent(7, 3)", "pet.exists", "pet.dead", "!modifier.last" } },
	{ "Mend Pet", { "!talent(7, 3)", "pet.exists", "pet.alive", "pet.health < 70", "pet.distance < 45", "!pet.buff(Mend Pet)", "!modifier.last" } },
	{ "Revive Pet", { "!talent(7, 3)", "pet.exists", "pet.dead", "!player.moving", "pet.distance < 45", "!modifier.last" } },

	-- TRAPS
	{ "Trap Launcher", { "!modifier.last", "!player.buff(Trap Launcher)" } },
	{ "Explosive Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" }, -- mouseover.ground?
	{ "Ice Trap", { "modifier.lalt", "player.buff(Trap Launcher)" }, "ground" },
	{ "Freezing Trap", { "modifier.ralt", "player.buff(Trap Launcher)" }, "ground" },

	-- ASPECTS
	{ "Aspect of the Cheetah", { "player.movingfor > 1", "!player.buff", "!player.buff(Aspect of the Pack)", "!modifier.last" } }, -- 10sec cd now unless glyphed
	{ "Camouflage", { "toggle.camomode", "!player.buff", "player.health < 95", "!player.debuff(Orb of Power)", "!modifier.last" } },
	{ "Camouflage", { "toggle.camomode", "!player.buff", "player.focus < 100", "!player.debuff(Orb of Power)", "!modifier.last" } },

	-- FROGING
	{ {
		{ "Flare", "@bbLib.engaugeUnit('Grom', 40, false)" },
		{ "!Auto Shot", { "target.exists", "target.health > 1" } },
		{ "Chimaera Shot", "target.exists" },
		{ "Glaive Toss", "target.exists" },
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
