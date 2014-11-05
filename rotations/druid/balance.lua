-- PossiblyEngine Rotation
-- Balance Druid - WoD 6.0.2
-- Updated on Oct 25th 2014

-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS: Feline Swiftness, Ysera's Gift, Typhoon, Incarnation: Chosen of Elune, Ursol's Vortex, Nature's Vigil, Euphoria
-- SUGGESTED GLYPHS: Astral Communion, Stampeding Roar, (Entangling Energy or Moonwarding or Guided Stars)
-- CONTROLS: Pause - Left Control


PossiblyEngine.rotation.register_custom(102, "bbDruid Balance", {
-- COMBAT
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- FROGGING
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "Renewal", { "talent(2, 2)", "player.health < 80" }, "player" },
		{ "Rejuvenation", { "player.health < 99", "!player.buff(Rejuvenation)" }, "player" },
		{ "Healing Touch", { "player.health < 70" }, "player" },
	}, "toggle.frogs" },

	-- DEFENSIVE COOLDOWNS
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)

	-- Pre-DPS PAUSE
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
	{ "Starsurge", { "!player.buff(Lunar Empowerment)", (function() return UnitPower("player", 8) > 20 end) } },
	{ "Starsurge", { "!player.buff(Solar Empowerment)", (function() return UnitPower("player", 8) > 20 end) } },
	{ "Starsurge", "player.buff(Solar Empowerment).count > 2" },
	{ "Starsurge", "player.buff(Shooting Stars)" },
	{ "Sunfire", "player.buff(Solar Peak)" },
	{ "Sunfire", "!target.debuff(Sunfire)" },
	{ "Moonfire", "player.buff(Lunar Peak)" },
	{ "Moonfire", "!target.debuff(Moonfire)" },
	{ "Starfall", { "player.buff(Starsurge).count > 1", "target.area(40).enemies > 2" } },
	{ "Astral Storm", { "player.balance.moon", "target.area(35).enemies > 4" }, "target.ground" },
	{ "Hurricane", { "player.balance.sun", "target.area(35).enemies > 4" }, "target.ground" },
	{ "Wrath", { "player.balance.sun", "target.area(35).enemies < 5" } },
	{ "Starfire", { "player.balance.moon", "target.area(35).enemies < 5" } },

},
{
-- OUT OF COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },

	-- BUFFS
	{ "Mark of the Wild", { (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil end), "lowest.distance <= 30", "player.form = 0" }, "lowest" },
	{ "Moonkin Form", { "!player.buff(Moonkin Form)", "!player.buff(Swift Flight Form)", "!player.buff(Flight Form)" } }, -- Force Moonkin Form

	-- HEALING
	{ "Renewal", { "talent(2, 2)", "player.health < 80" }, "player" },
	{ "Rejuvenation", { "player.health < 99", "!player.buff(Rejuvenation)" }, "player" },
	{ "Rejuvenation", { "lowest.health < 90", "!lowest.buff(Rejuvenation)" }, "lowest" },
	{ "Healing Touch", { "player.health < 70" }, "player" },

	--REZ
	{ "Revive", { "target.exists", "target.player", "target.dead" }, "target" },
	{ "Revive", { "party1.exists", "party1.dead", "!player.moving", "party1.range < 35" }, "party1" },
	{ "Revive", { "party2.exists", "party2.dead", "!player.moving", "party2.range < 35" }, "party2" },
	{ "Revive", { "party3.exists", "party3.dead", "!player.moving", "party3.range < 35" }, "party3" },
	{ "Revive", { "party4.exists", "party4.dead", "!player.moving", "party4.range < 35" }, "party4" },

	-- FROGGING
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "Sunfire", "player.balance.sun", "target" },
		{ "Moonfire", "player.balance.moon", "target" },
		{ "Wrath", "player.balance.sun", "target" },
		{ "Starfire", "player.balance.moon", "target" },
		{ "Soothe", true, "target" },
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
