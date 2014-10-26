-- PossiblyEngine Rotation
-- Guardian Druid - WoD 6.0.2
-- Updated on Oct 25th 2014

-- PLAYER CONTROLLED:
-- TALENTS: (Feline Swiftness or Wild Charge), Ysera's Gift, Typhoon, Soul of the Forest, Mighty Bash, Dream of Cenarius
-- GLYPHS: Glyph of Maul, Glyph of Rebirth, Glyph of Fae Silence, Glyph of Grace (minor)
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(104, "bbDruid Guardian", {
-- COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },

	-- BATTLE REZ
	{ "Rebirth", { "!player.buff(Bear Form)", "target.friend", "target.dead" }, "target" },
	{ "Rebirth", { "toggle.mouseovers", "!player.buff(Bear Form)", "mouseover.friend", "mouseover.dead" }, "mouseover" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead", "!target.friend" } },

	-- BEAR FORM
	{ "Bear Form", { "!player.buff(Bear Form)", "target.exists", "!target.agro" },

	{ {
		-- INTERRUPTS
		{ "Skull Bash", "target.interrupt" },
		{ "Mighty Bash", { "talent(5, 3)", "target.interrupt" } },

		-- BATTLE REZ
		{ "Rebirth", { "target.friend", "target.dead", "player.buff(Dream of Cenarius)" }, "target" },
		{ "Rebirth", { "toggle.mouseovers", "mouseover.friend", "mouseover.dead", "player.buff(Dream of Cenarius)" }, "mouseover" },

		-- DREAM PROCS
		{ {
			{ "Healing Touch", "player.health <= 90" },
			{ "Healing Touch", "targettarget.health <= 90", "targettarget" },
			{ "Healing Touch", "lowest.health <= 50", "lowest" },
		},{ "player.buff(Dream of Cenarius)" },

		-- RANGED PULLS
		{ "Faerie Fire", "target.distance > 5" },
		{ "Faerie Fire", { "toggle.mouseovers", "mouseover.exists", "mouseover.enemy", "!mouseover.dead", "mouseover.distance > 5" }, "mouseover" },

		-- DEFENSIVE CONSUMABLES
		{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
		{ "#5512", { "toggle.consume", "player.health < 35" } }, -- Healthstone (5512)
		{ "#76097", { "toggle.consume", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)

		-- DEFENSIVE COOLDOWNS
		{ "Frenzied Regeneration", { "!modifier.last", "target.agro", "!player.buff(Frenzied Regeneration)", "player.health < 60" } },
		{ "Survival Instincts", { "target.agro", "player.health < 60" } },
		{ "Savage Defense", { "target.agro", "target.distance <= 5", "!player.buff(Savage Defense)", "timeout(Savage Defense, 12)" } },
		{ "Barkskin", { "player.health <= 90" } },
		{ "Remove Corruption", { "!modifier.last", "player.dispellable" }, "player" },

		-- DPS COOLDOWNS
		{ "Berserking", { "!player.hashero", "target.distance <= 5" } },
		{ "Berserk", { "player.hashero", "!player.buff(Incarnation: Son of Ursoc)" } },
		{ "Berserk", { "target.boss", "!player.buff(Incarnation: Son of Ursoc)" } },

		-- THREAT ROTATION -- need a minimum for 60 range for savage defense
		{ "Mangle" },
		{ "Thrash", { "!target.debuff(Thrash)" } },
		{ "Thrash", { "target.debuff(Thrash)", "target.debuff(Thrash).remaining <= 1" } },
		{ "Maul", { "player.rage >= 80", "player.buff(Tooth and Claw)", "player.spell(Mangle).cooldown = > 0.5" } },
		{ "Maul", "player.rage >= 95" },
		{ "Lacerate", { "player.spell(Mangle).cooldown = > 0.5", "timeout(Lacerate, 1)", "target.area(8).enemies < 2" } },
		{ "Thrash", { "player.spell(Mangle).cooldown = > 0.5", "timeout(Thrash, 1)", "target.area(8).enemies > 2" } },

	}, "player.buff(Bear Form)" },

},{
-- OUT OF COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },

	-- RAID BUFFS
  { "Mark of the Wild", { (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil end), "lowest.distance <= 30", "player.form = 0" }, "lowest" }
},
-- TOGGLE BUTTONS
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
