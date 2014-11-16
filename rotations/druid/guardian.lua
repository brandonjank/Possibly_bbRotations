-- PossiblyEngine Rotation
-- Guardian Druid - WoD 6.0.2
-- Updated on Oct 25th 2014

-- PLAYER CONTROLLED:
-- TALENTS: (Feline Swiftness or Wild Charge), Ysera's Gift, Typhoon, Soul of the Forest, Mighty Bash, Dream of Cenarius
-- GLYPHS: Glyph of Maul, Glyph of Rebirth, Glyph of Fae Silence, Glyph of Grace (minor)
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(104, "|cFFFF0000bb|cFF0000FFRotations |cFFFF9966Druid Guardian", {
-- COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead", "!target.friend" } },

	-- FROGGING
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 30, false)" },
	},{
		"toggle.frogs",
	} },

	-- BATTLE REZ
	{ "Rebirth", { "target.friend", "target.dead", "!player.form = 1" }, "target" },

	-- BEAR FORM
	{ "Bear Form", "!player.form = 1" }, -- force in raid only

	-- INTERRUPTS
	{ "Skull Bash", "modifier.interrupt" },
	{ "Faerie Fire", { "modifier.interrupt", "player.glyph(114237)" } }, -- Glyph of Fae Silence (114237)
	{ "Mighty Bash", { "talent(5, 3)", "modifier.interrupt" } },
	{ "War Stomp", "modifier.interrupt" }, -- Stun -- War Stomp if player is Tauren race if Interrupts is toggled

	-- DREAM PROCS
	{ {
		{ "Remove Corruption", { "!modifier.last", "player.dispellable" }, "player" },
		{ "Rebirth", { "target.friend", "target.dead" }, "target" },
		{ "Healing Touch", "player.health < 90", "player" },
		{ "Healing Touch", "targettarget.health < 90", "targettarget" },
		{ "Healing Touch", "lowest.health < 60", "lowest" },
	},{
		"player.buff(Dream of Cenarius)",
	} },

	-- RANGED PULLS
	{ "Faerie Fire", { "target.exists", "target.distance > 5" } },
	{ "Faerie Fire", { "toggle.mouseovers", "mouseover.alive", "mouseover.enemy", "mouseover.distance > 5" }, "mouseover" },

	-- DEFENSIVE CONSUMABLES
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 40" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 20", "target.boss" } }, -- Master Healing Potion (76097)

	-- DEFENSIVE COOLDOWNS
	{ "Frenzied Regeneration", { "player.level >= 68", "!modifier.last", "player.health < 60" } },
	{ "Survival Instincts", { "player.level >= 56", "player.health < 50" } },
	{ "Savage Defense", { "player.rage >= 60", "target.distance < 5", "!player.buff(Savage Defense)", "player.health <= 80" } }, --"timeout(Savage Defense, 12)"
	{ "Barkskin", { "player.health < 90", "target.distance < 5" } },

	-- DPS COOLDOWNS
	{ "Berserking", { "!player.hashero", "target.distance < 5" } },
	{ "Berserk", { "player.hashero", "!player.buff(Incarnation: Son of Ursoc)" } },
	{ "Berserk", { "target.boss", "!player.buff(Incarnation: Son of Ursoc)" } },

	-- THREAT ROTATION -- need a minimum for 60 range for savage defense
	{ "Mangle" },
	{ "Thrash", "!target.debuff(Thrash)" },
	{ "Thrash", { "target.debuff(Thrash)", "target.debuff(Thrash).duration <= 1" } },
	{ "Lacerate", "!target.debuff(Lacerate)" },
	{ "Lacerate", "target.debuff(Lacerate).duration <= 3" },
	{ "Lacerate", "target.debuff(Lacerate).count < 3" },
	{ "Maul", { "player.rage > 79", "player.buff(Tooth and Claw)", "player.spell(Mangle).cooldown > 0.5" } },
	{ "Maul", "player.rage > 94" },
	{ "Thrash", { "player.spell(Mangle).cooldown > 0.5", "timeout(Thrash, 1)", "target.area(8).enemies > 2" } },

},{
-- OUT OF COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Food)" },
	{ "pause", "modifier.looting" },

	-- BUFFS
	{ "Mark of the Wild", { "!player.buffs.stats", "lowest.distance <= 30" }, "lowest" },

	-- REZ
	{ "Revive", { "target.exists", "target.dead", "!player.moving", "target.player" }, "target" },

	-- HEAL
	{ "Rejuvenation", { "!player.ininstance", "player.health < 70", "!player.buff(Rejuvenation)" }, "player" },
	{ "Healing Touch", { "!player.ininstance", "player.health < 50", "!player.moving)" }, "player" },

	-- FROGGING
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 40, false)" },
		{ "Soothe", true, "target" },
	},{
		"toggle.frogs",
	} },

	{ "Bear Form", { "player.ininstance", "!player.form = 1"} },

	-- PAUSE FORM
	--{ "/cancelform", { "!player.ininstance", "target.exists", "target.friend", "!player.form = 0", "target.range < 1" } },
	--{ "pause", { "!player.ininstance", "target.exists", "target.friend", "target.range < 1", "@bbLib.isNPC('target')" } },

	-- AUTO FORM
	--{ "Travel Form", { "!player.ininstance", "!player.buff(Travel Form)", "player.moving", "!target.enemy", (function() return not IsIndoors() end) } },
	--{ "Cat Form", { "!player.ininstance", "!player.form = 2", "!player.buff(Travel Form)", "player.moving", "!target.enemy" } },

},
-- TOGGLE BUTTONS
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
