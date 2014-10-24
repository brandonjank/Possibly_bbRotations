-- PossiblyEngine Rotation
-- Custom Balance Druid Rotation
-- Updated on Oct 17th 2014
-- PLAYER CONTROLLED: 
-- SUGGESTED BUILD: 
-- SUGGESTED TALENTS: Feline Swiftness, Ysera's Gift, Typhoon, Incarnation: Chosen of Elune, Ursol's Vortex, Nature's Vigil, Euphoria
-- SUGGESTED GLYPHS: Astral Communion, Stampeding Roar, (Entangling Energy or Moonwarding or Guided Stars)
-- CONTROLS: Pause - Left Control

--enemies: (function() return UnitsAroundUnit('target', 10) > 2 end) 
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


PossiblyEngine.rotation.register_custom(102, "bbDruid Balance", {
-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
	}, "toggle.frogs" },
	
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
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)	
	
	-- Pre DPS Pause
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- UTILITY
	{ "Rebirth", { "target.friend", "!target.alive" } },
	-- Stampeding Roar: Giving the raid a movement boost is a unique  Druid ability that is very useful in a wide variety of raid situations. Always keep an eye out for when people can benefit from it.
	{ "Solar Beam", "modifier.interrupt" },
	{ "Barkskin", "player.health < 70" },
	-- Dash: limited in that it only lasts while you are in Cat form and cannot DPS, but has its uses in dangerous situations.
	-- Remove Corruption: In smaller groups, you may be without a healer who can dispel curses and/or poison, so keep this in mind.
	-- Soothe: Especially in smaller groups with no  Rogues or Hunters, you might be the only one who can do this.

	-- Forms
	{ "Moonkin Form", { "!player.buff(Moonkin Form)", "!player.buff(Swift Flight Form)", "!player.buff(Flight Form)" } }, -- Force Moonkin Form
	
	-- Mouseover Debuffing
	{ "Moonfire", { "toggle.mouseovers", "!mouseover.debuff(Moonfire)" }, "mouseover" },
	{ "Sunfire", { "toggle.mouseovers", "!mouseover.debuff(Sunfire)" }, "mouseover" },

	-- MOVEMENT
	-- Using one  Starsurge charge is usually good, but if you have to move for a longer period, generally all that you can do is spam  Moonfire or  Sunfire for minor damage.
	-- One option is use a couple seconds of  Astral Communion so that you emerge from the movement near an  Eclipse peak, but this is tricky.

	-- COOLDOWNS
	-- Celestial Alignment: During CA, keep DoTs on the target, and use  Starsurge and Starfire or Wrath (whichever is buffed by your Starsurge).
	-- Incarnation: Chosen of Elune (talent): Use with Celestial Alignment 
	-- Force of Nature (talent): Summons a pet that DPSes for 15 seconds. This is on the charge system, so it's okay to let 1 or 2 charges pool up at any time. You can slightly add to their damage by trying to dump charges while procs or temporary buffs are up.
	
	-- DPS ROTATION
	{ "Moonfire", { "player.balance.moon", "!target.debuff(Moonfire)", "!modifier.last" } }, -- Cast at lunar peak when buff is active. Multi-Target: Moonfire may not be worth it on very short-lived targets.
	{ "Moonfire", { "player.balance.moon", "player.buff(Lunar Peak)", "!modifier.last" } },
	-- Sunfire: TODO: Cast right as Solar phase begins
	{ "Sunfire", { "player.balance.sun", "player.buff(Solar Peak)", "!modifier.last" } }, 
	{ "Starfall", { "player.buff(Starsurge).count > 1", "target.area(40).enemies > 2" } }, -- TODO: favor spending during Lunar Eclipse when possible
	{ "Starsurge", { "player.buff(Lunar Empowerment).count < 1", "player.buff(Solar Empowerment).count < 2", "player.buff(Shooting Stars)" } },
	{ "Starsurge", { "player.buff(Lunar Empowerment).count < 1", "player.buff(Solar Empowerment).count < 2", "target.area(40).enemies < 3" } },
	-- At 0 or 1 charge, plan to  Starsurge shortly before your next Lunar or Solar peak.
	-- Stellar Flare (T7) cast it every time you cross the midpoint between Lunar and Solar.
	-- Astral Communion. Good to use while moving (with  Glyph of Astral Communion), to skip to the next peak, getting a little use out of your movement time. You can also use it to set up a peak for key moment of burst DPS, but you'd generally rather have Celestial Alignment for this if possible.
	{ "Astral Storm", { "player.balance.moon", "target.area(35).enemies > 4" }, "target.ground" },
	{ "Hurricane", { "player.balance.sun", "target.area(35).enemies > 4" }, "target.ground" },
	{ "Starfire", { "player.balance.moon", "target.area(35).enemies < 5" } },
	{ "Wrath", { "player.balance.sun", "target.area(35).enemies < 5" } }, 
	
	-- "Lunar Peak" "Solar Peak" Buff (2)
	
},
{
-- OUT OF COMBAT ROTATION
	-- Pauses
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	
	-- Buffs
	{ "Mark of the Wild", { (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil end), "lowest.distance <= 30", "player.form = 0" }, "lowest" },
	
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "Moonfire", "player.balance.moon" },
		{ "Sunfire", "player.balance.sun" },
	},{
		"toggle.frogs",
	} },
	
	-- TODO: Noodle Food / Flask
	-- TODO: PRE POT
},
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')	
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
