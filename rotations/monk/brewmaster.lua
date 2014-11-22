-- PossiblyEngine Rotation
-- Brewmaster Monk - WoD 6.0.2
-- Updated on Oct 25th 2014

-- PLAYER CONTROLLED:
-- TALENTS: 0130223
-- GLYPHS: fortifying_brew,expel_harm,fortuitous_spheres
-- CONTROLS: Pause - Left Control;  Black Ox Statue - Left Alt;  Dizzying Haze - Left Shift;  Healing Sphere - Right Alt

PossiblyEngine.rotation.register_custom(268, "bbMonk Brewmaster (2H Serenity)", {
-- COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },
	{ "pause", "target.buff(Reckless Provocation)" }, -- Iron Docks - Fleshrender
	{ "pause", "target.buff(Sanguine Sphere)" }, -- Iron Docks - Enforcers

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- Off GCD
	{ "Touch of Death", "player.buff(Death Note)" },
	{ "Provoke", { "toggle.autotaunt", "@bbLib.bossTaunt" } },

	-- Survival
	{ "Nimble Brew", "player.state.fear" },
	{ "Nimble Brew", "player.state.stun" },
	{ "Nimble Brew", "player.state.root" },
	{ "Nimble Brew", "player.state.horror" },

	-- Keybinds
	{ "Dizzying Haze", "modifier.lshift", "ground" },
	{ "Summon Black Ox Statue", "modifier.lalt", "ground" },
	{ "Healing Sphere", "modifer.ralt", "ground" },
	{ "Spinning Crane Kick", "modifier.rshift" },

	-- Interrupts
	{ "Spear Hand Strike", "modifier.interrupts" },
	{ "Grapple Weapon", "modifier.interrupts" },
	{ "Leg Sweep", "modifier.interrupts", "target.range <= 10" },

	-- COOLDOWNS / COMMON
	-- actions=auto_attack
	-- actions+=/blood_fury,if=energy<=40
	{ "Blood Fury", "player.energy <= 40" },
	-- actions+=/berserking,if=energy<=40
	{ "Berserking", "player.energy <= 40" },
	-- actions+=/arcane_torrent,if=energy<=40
	{ "Arcane Torrent", "player.energy <= 40" },
	-- actions+=/chi_brew,if=talent.chi_brew.enabled&chi.max-chi>=2&buff.elusive_brew_stacks.stack<=10
	{ "Chi Brew", { "talent(3, 3)", "player.chimaxchi >= 2", "player.buff(128939).count <= 10" } },
	-- actions+=/diffuse_magic,if=incoming_damage_1500ms&buff.fortifying_brew.down
	{ "Diffuse Magic", { "player.health < 100", "target.exists", "target.enemy", "target.agro", "target.casting.percent > 50", "targettarget.istheplayer", "!player.buff(Fortifying Brew)" } },
	-- actions+=/dampen_harm,if=incoming_damage_1500ms&buff.fortifying_brew.down&buff.elusive_brew_activated.down
	{ "Dampen Harm", { "player.health < 100", "target.exists", "target.enemy", "target.agro", "targettarget.istheplayer", "!player.buff(Fortifying Brew)", "!player.buff(115308)" } },
	-- actions+=/fortifying_brew,if=incoming_damage_1500ms&(buff.dampen_harm.down|buff.diffuse_magic.down)&buff.elusive_brew_activated.down
	{ "Fortifying Brew", { "player.health < 100", "target.exists", "target.enemy", "target.agro", "targettarget.istheplayer", "!player.buff(115308)", "!player.buff(Dampen Harm)" } },
	{ "Fortifying Brew", { "player.health < 100", "target.exists", "target.enemy", "target.agro", "targettarget.istheplayer", "!player.buff(115308)", "!player.buff(Diffuse Magic)" } },
	-- actions+=/elusive_brew,if=buff.elusive_brew_stacks.react>=9&(buff.dampen_harm.down|buff.diffuse_magic.down)&buff.elusive_brew_activated.down
	{ "Elusive Brew", { "target.exists", "target.enemy", "target.agro", "targettarget.istheplayer", "player.buff(Elusive Brew).count >= 9", "!player.buff(115308)", "!player.buff(Dampen Harm)" } },
	{ "Elusive Brew", { "target.exists", "target.enemy", "target.agro", "targettarget.istheplayer", "player.buff(Elusive Brew).count >= 9", "!player.buff(115308)", "!player.buff(Diffuse Magic)" } },
	-- actions+=/invoke_xuen,if=talent.invoke_xuen.enabled&time>5
	{ "Invoke Xuen, the White Tiger", { "modifier.cooldowns", "player.time > 5" } },
	-- actions+=/serenity,if=talent.serenity.enabled&energy<=40
	{ "Serenity", "player.energy <= 40" },


	{ {
		-- actions.aoe=guard
		{ "Guard", "!player.buff(Guard)" },
		-- actions.aoe+=/breath_of_fire,if=chi>=3&buff.shuffle.remains>=6&dot.breath_of_fire.remains<=gcd
		{ "Breath of Fire", { "player.chi >= 3", "player.buff(Shuffle).remains >= 6", "target.debuff(Breath of Fire).remains <= 1" } },
		-- actions.aoe+=/chi_explosion,if=chi>=4
		{ "Chi Explosion", "player.chi >= 4" },
		-- actions.aoe+=/rushing_jade_wind,if=chi.max-chi>=1&talent.rushing_jade_wind.enabled
		{ "Rushing Jade Wind", "player.chimaxchi >= 1" },
		-- actions.aoe+=/purifying_brew,if=!talent.chi_explosion.enabled&stagger.heavy
		{ "Purifying Brew", { "!talent(7, 2)", "player.debuff(Heavy Stagger)" } },
		-- actions.aoe+=/guard
		{ "Guard", "!player.buff(Guard)" },
		-- actions.aoe+=/keg_smash,if=chi.max-chi>=2&!buff.serenity.remains
		{ "Keg Smash", { "player.chimaxchi >= 2", "!player.buff(Serenity)" } },
		-- actions.aoe+=/chi_burst,if=talent.chi_burst.enabled&energy.time_to_max>3
		{ "Chi Burst", { "talent(2, 3)", "player.timetomax > 3" } },
		-- actions.aoe+=/chi_wave,if=talent.chi_wave.enabled&energy.time_to_max>3
		{ "Chi Wave", { "talent(2, 1)", "player.timetomax > 3" } },
		-- actions.aoe+=/zen_sphere,cycle_targets=1,if=talent.zen_sphere.enabled&!dot.zen_sphere.ticking
		{ "Zen Sphere", "!player.buff(Zen Sphere)", "player" },
		-- actions.aoe+=/blackout_kick,if=talent.rushing_jade_wind.enabled&buff.shuffle.remains<=3&cooldown.keg_smash.remains>=gcd
		{ "Blackout Kick", { "talent(6, 1)", "player.buff(Shuffle).remains <= 3", "player.spell(Keg Smash).cooldown >= 1" } },
		-- actions.aoe+=/blackout_kick,if=talent.rushing_jade_wind.enabled&buff.serenity.up
		{ "Blackout Kick", { "talent(6, 1)", "player.buff(Serenity)" } },
		-- actions.aoe+=/blackout_kick,if=talent.rushing_jade_wind.enabled&chi>=4
		{ "Blackout Kick", { "talent(6, 1)", "player.chi >= 4" } },
		-- actions.aoe+=/expel_harm,if=chi.max-chi>=1&cooldown.keg_smash.remains>=gcd&(energy+(energy.regen*(cooldown.keg_smash.remains)))>=40
		{ "Expel Harm", { "player.chimaxchi >= 1", "player.spell(Keg Smash).cooldown >= 1", (function() local start, duration, enabled = GetSpellCooldown('Keg Smash') return ((UnitPower('player', SPELL_POWER_ENERGY)+(select(2, GetPowerRegen('player'))*(start + duration - GetTime())))>=40) end) } },
		-- actions.aoe+=/spinning_crane_kick,if=chi.max-chi>=1&!talent.rushing_jade_wind.enabled
		{ "Spinning Crane Kick", { "player.chimaxchi >= 1", "!talent(6, 1)" } },
		-- actions.aoe+=/jab,if=talent.rushing_jade_wind.enabled&chi.max-chi>=1&cooldown.keg_smash.remains>=gcd&cooldown.expel_harm.remains>=gcd
		{ "Jab", { "player.chimaxchi >= 1", "talent(6, 1)", "player.spell(Keg Smash).cooldown >= 1.5", "player.spell(Expel Harm).cooldown >= 1" } },
		-- actions.aoe+=/purifying_brew,if=!talent.chi_explosion.enabled&talent.rushing_jade_wind.enabled&stagger.moderate&buff.shuffle.remains>=6
		{ "Purifying Brew", { "!talent(7, 2)", "talent(6, 1)", "player.debuff(Moderate Stagger)", "player.buff(Shuffle).remains >= 6" } },
		-- actions.aoe+=/tiger_palm,if=talent.rushing_jade_wind.enabled&(energy+(energy.regen*(cooldown.keg_smash.remains)))>=40
		{ "Tiger Palm", { "talent(6, 1)", (function() local start, duration, enabled = GetSpellCooldown('Keg Smash') return ((UnitPower('player', SPELL_POWER_ENERGY)+(select(2, GetPowerRegen('player'))*(start + duration - GetTime())))>=40) end) } },
		-- actions.aoe+=/tiger_palm,if=talent.rushing_jade_wind.enabled&cooldown.keg_smash.remains>=gcd
		{ "Tiger Palm", { "talent(6, 1)", "player.spell(Keg Smash).cooldown >= 1" } },
	},{
		"modifier.multitarget", "player.area(10).enemies >= 3",
	} },


	-- actions+=/call_action_list,name=st,if=active_enemies<3
	-- actions.st=blackout_kick,if=buff.shuffle.down
	{ "Blackout Kick", "!player.buff(Shuffle)" },
	-- actions.st+=/purifying_brew,if=!talent.chi_explosion.enabled&stagger.heavy
	{ "Purifying Brew", { "!talent(7, 2)", "player.debuff(Heavy Stagger)" } },
	-- actions.st+=/purifying_brew,if=buff.serenity.up
	{ "Purifying Brew", "player.debuff(Serenity)" },
	-- actions.st+=/guard
	{ "Guard", "!player.buff(Guard)" },
	-- actions.st+=/keg_smash,if=chi.max-chi>=2&!buff.serenity.remains
	{ "Keg Smash", { "player.chimaxchi >= 2", "!player.buff(Serenity)" } },
	-- actions.st+=/chi_burst,if=talent.chi_burst.enabled&energy.time_to_max>3
	{ "Chi Burst", { "talent(2, 3)", "player.timetomax > 3" } },
	-- actions.st+=/chi_wave,if=talent.chi_wave.enabled&energy.time_to_max>3
	{ "Chi Wave", { "talent(2, 1)", "player.timetomax > 3" } },
	-- actions.st+=/zen_sphere,cycle_targets=1,if=talent.zen_sphere.enabled&!dot.zen_sphere.ticking
	{ "Zen Sphere", "!player.buff(Zen Sphere)", "player" },
	-- actions.st+=/chi_explosion,if=chi>=3
	{ "Chi Explosion", "player.chi >= 3" },
	-- actions.st+=/blackout_kick,if=buff.shuffle.remains<=3&cooldown.keg_smash.remains>=gcd
	{ "Blackout Kick", { "player.buff(Shuffle).remains <= 3", "player.spell(Keg Smash).cooldown >= 1" } },
	-- actions.st+=/blackout_kick,if=buff.serenity.up
	{ "Blackout Kick", "player.buff(Serenity)" },
	-- actions.st+=/blackout_kick,if=chi>=4
	{ "Blackout Kick", "player.chi >= 4" },
	-- actions.st+=/expel_harm,if=chi.max-chi>=1&cooldown.keg_smash.remains>=gcd
	{ "Expel Harm", { "player.chimaxchi >= 1", "player.spell(Keg Smash).cooldown >= 1.5" } },
	-- actions.st+=/jab,if=chi.max-chi>=1&cooldown.keg_smash.remains>=gcd&cooldown.expel_harm.remains>=gcd
	{ "Jab", { "player.chimaxchi >= 1", "player.spell(Keg Smash).cooldown >= 1.5", "player.spell(Expel Harm).cooldown >= 1.5" } },
	-- actions.st+=/purifying_brew,if=!talent.chi_explosion.enabled&stagger.moderate&buff.shuffle.remains>=6
	{ "Purifying Brew", { "!talent(7, 2)", "player.debuff(Moderate Stagger)", "player.buff(Shuffle).remains >= 6" } },
	-- actions.st+=/tiger_palm,if=(energy+(energy.regen*(cooldown.keg_smash.remains)))>=40
	{ "Tiger Palm", (function() local start, duration, enabled = GetSpellCooldown('Keg Smash') return ((UnitPower('player', SPELL_POWER_ENERGY)+(select(2, GetPowerRegen('player'))*(start + duration - GetTime())))>=40) end) },
	-- actions.st+=/tiger_palm,if=cooldown.keg_smash.remains>=gcd
	{ "Tiger Palm", "player.spell(Keg Smash).cooldown >= 1" },


},{
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	{ "Legacy of the Emperor", "!player.buff(Legacy of the Emperor).any" },

	-- Ground Stuff
	{ "Dizzying Haze", "modifier.lshift", "ground" },
	{ "Summon Black Ox Statue", "modifier.lalt", "ground" },

-- actions.precombat=flask,type=greater_draenic_stamina_flask
-- actions.precombat+=//food,type=sleeper_surprise
-- actions.precombat+=/stance,choose=sturdy_ox
-- # Snapshot raid buffed stats before combat begins and pre-potting is done.
-- actions.precombat+=/snapshot_stats
-- actions.precombat+=/potion,name=draenic_agility
-- actions.precombat+=/dampen_harm

},
function()
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Use Mouseovers', 'Automatically cast spells on mouseover targets')
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
end)
