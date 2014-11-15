-- PossiblyEngine Rotation
-- Balance Druid - WoD 6.0.3
-- Updated on Nov 14th 2014

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

--[[
	-- FROGGING
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "Renewal", { "talent(2, 2)", "player.health < 79" }, "player" },
		{ "Rejuvenation", { "player.health < 99", "!player.buff(Rejuvenation)" }, "player" },
		{ "Healing Touch", { "player.health < 40" }, "player" },
		{ "Rejuvenation", { "party1.exists", "party1.health < 100", "!party1.buff(Rejuvenation)" }, "party1" },
		{ "Rejuvenation", { "party2.exists", "party2.health < 100", "!party2.buff(Rejuvenation)" }, "party2" },
		{ "Rejuvenation", { "party3.exists", "party3.health < 100", "!party3.buff(Rejuvenation)" }, "party3" },
		{ "Rejuvenation", { "party4.exists", "party4.health < 100", "!party4.buff(Rejuvenation)" }, "party4" },
	}, "toggle.frogs" },

	-- DEFENSIVE COOLDOWNS
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)


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
	{ "Hurricane", { "!toggle.frogs", "player.balance.sun", "target.area(35).enemies > 4" }, "target.ground" },
	{ "Wrath", { "player.balance.sun", "target.area(35).enemies < 5" } },
	{ "Starfire", { "player.balance.moon", "target.area(35).enemies < 5" } },
]]--

	-- Forms
	{ "Moonkin Form", { "!player.buff(Moonkin Form)", "!player.buff(Swift Flight Form)", "!player.buff(Flight Form)" } }, -- Force Moonkin Form

	-- UTILITY
	--{ "Rebirth", { "target.friend", "!target.alive" } },
	-- Stampeding Roar: Giving the raid a movement boost is a unique  Druid ability that is very useful in a wide variety of raid situations. Always keep an eye out for when people can benefit from it.
	{ "Solar Beam", "modifier.interrupt" },
	{ "Barkskin", "player.health < 70" },
	-- Dash: limited in that it only lasts while you are in Cat form and cannot DPS, but has its uses in dangerous situations.
	-- Remove Corruption: In smaller groups, you may be without a healer who can dispel curses and/or poison, so keep this in mind.
	-- Soothe: Especially in smaller groups with no  Rogues or Hunters, you might be the only one who can do this.

	-- Pre-DPS PAUSE
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- Mouseover Debuffing
	{ "Moonfire", { "toggle.mouseovers", "!mouseover.debuff(Moonfire)" }, "mouseover" },
	{ "Sunfire", { "toggle.mouseovers", "!mouseover.debuff(Sunfire)" }, "mouseover" },

	-- COOLDOWNS
	{ "Blood Fury", "player.buff(Celestial Alignment)" },
	{ "Berserking", "player.buff(Celestial Alignment)" },
	{ "Arcane Torrent", "player.buff(Celestial Alignment)" },
	-- actions+=/force_of_nature,if=trinket.stat.intellect.up
	{ "Force of Nature", "player.spell(Force of Nature).charges > 2" },
	{ "Force of Nature", "target.deathin < 21" },

	-- AOE
	--{ {
		-- actions.aoe=celestial_alignment,if=lunar_max<8|target.time_to_die<20
		-- actions.aoe+=/incarnation,if=buff.celestial_alignment.up
		-- actions.aoe+=/sunfire,if=remains<8
		-- actions.aoe+=/starfall
		-- actions.aoe+=/moonfire,cycle_targets=1,if=remains<12
		-- actions.aoe+=/stellar_flare,cycle_targets=1,if=remains<7
		-- actions.aoe+=/wrath,if=(eclipse_energy<=0&eclipse_change>cast_time)|(eclipse_energy>0&cast_time>eclipse_change)
		-- actions.aoe+=/starfire,if=(eclipse_energy>=0&eclipse_change>cast_time)|(eclipse_energy<0&cast_time>eclipse_change)
--	},{
--		"target.area(10).enemies > 1"
	--} },

	-- SINGLE TARGET
	-- actions.single_target=starsurge,if=buff.lunar_empowerment.down&eclipse_energy>20
	{ "Starsurge", { "!player.buff(Lunar Empowerment)", "player.balance.eclipse > 20" } },
	-- actions.single_target+=/starsurge,if=buff.solar_empowerment.down&eclipse_energy<-40
	{ "Starsurge", { "!player.buff(Solar Empowerment)", "player.balance.eclipse < -40" } },
	-- actions.single_target+=/starsurge,if=(charges=2&recharge_time<6)|charges=3
	{ "Starsurge", { "player.spell(Starsurge).charges > 2" } },
	{ "Starsurge", { "player.spell(Starsurge).charges > 1", "player.spell(Starsurge).recharge < 6" } },
	-- actions.single_target+=/celestial_alignment,if=eclipse_energy>40
	{ "Celestial Alignment", "player.balance.eclipse > 40" },
	-- actions.single_target+=/incarnation,if=eclipse_energy>0
	{ "Incarnation", "balance.eclipse > 0" },
	-- actions.single_target+=/sunfire,if=remains<7|buff.solar_peak.up
	{ "Sunfire", "player.buff(Solar Peak)" },
	{ "Sunfire", "target.debuff(Sunfire).duration < 7" },
	-- actions.single_target+=/stellar_flare,if=remains<7
	{ "Stellar Flare", "target.debuff(Stellar Flare).duration < 7" },
	-- actions.single_target+=/moonfire,if=buff.lunar_peak.up&remains<eclipse_change+20|remains<4|(buff.celestial_alignment.up&buff.celestial_alignment.remains<=2&remains<eclipse_change+20)
	{ "Moonfire", "player.buff(Lunar Peak)" },
	{ "Moonfire", "target.debuff(Moonfire).remains < 4" },
	{ "Moonfire", { "player.buff(Celestial Alignment)", "player.buff(Celestial Alignment).remains <= 2" } },
	-- actions.single_target+=/wrath,if=(eclipse_energy<=0&eclipse_change>cast_time)|(eclipse_energy>0&cast_time>eclipse_change)
	--{ "Wrath", { "player.balance.eclipse < -8" } }, -- , "player.balance.eclipsechangetime > player.spell(Wrath).castingtime"
	{ "Wrath", { "player.balance.eclipse > 8" } }, -- , "player.balance.eclipsechangetime < player.spell(Wrath).castingtime"
	{ "Wrath", { "player.balance.eclipse > 0", "player.balance.sun" } },
	-- actions.single_target+=/starfire,if=(eclipse_energy>=0&eclipse_change>cast_time)|(eclipse_energy<0&cast_time>eclipse_change)
	--{ "Starfire", { "player.balance.eclipse > 12" } }, -- , "player.balance.eclipsechangetime > player.spell(Starfire).castingtime"
	{ "Starfire", { "player.balance.eclipse < -12" } }, -- , "player.balance.eclipsechangetime < player.spell(Starfire).castingtime"
	{ "Starfire", { "player.balance.eclipse <= 0", "player.balance.moon" } },
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
	{ "Healing Touch", { "player.health < 70" }, "player" },

	--REZ Revive (50769)
	{ "Revive", { "target.exists", "target.player", "target.dead" }, "target" },
	--{ "50769", { "party1.exists", "party1.dead", "!player.moving", "party1.range < 35" }, "party1" },
	--{ "50769", { "party2.exists", "party2.dead", "!player.moving", "party2.range < 35" }, "party2" },
	--{ "50769", { "party3.exists", "party3.dead", "!player.moving", "party3.range < 35" }, "party3" },
	--{ "50769", { "party4.exists", "party4.dead", "!player.moving", "party4.range < 35" }, "party4" },
	--{ "Mass Resurrection", { "target.exists", "target.dead", "target.friend", "!player.moving", "target.range < 35", (function() return not UnitHasIncomingResurrection('target') end) } },

	-- FROGGING
	{ {
		{ "Mark of the Wild", { "player.health > 80", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" } },
		{ "Rejuvenation", { "party1.exists", "party1.health < 100", "!party1.buff(Rejuvenation)" }, "party1" },
		{ "Rejuvenation", { "party2.exists", "party2.health < 100", "!party2.buff(Rejuvenation)" }, "party2" },
		{ "Rejuvenation", { "party3.exists", "party3.health < 100", "!party3.buff(Rejuvenation)" }, "party3" },
		{ "Rejuvenation", { "party4.exists", "party4.health < 100", "!party4.buff(Rejuvenation)" }, "party4" },
		{ "Sunfire", "player.balance.sun", "target" },
		{ "Moonfire", "player.balance.moon", "target" },
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
