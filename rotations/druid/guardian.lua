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
	{ "pause", "@bbLib.bossMods" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead", "!target.friend" } },

	-- FROGGING
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('Gulp Frog', 30, false)" },
	},{
		"toggle.frogs",
	} },

	-- BEAR FORM
	{ "Bear Form", { "!player.form = 1", "!player.flying", "!player.buff(Dash)" } },

	-- INTERRUPTS
	{ "Skull Bash", "modifier.interrupt" },
	{ "Faerie Fire", { "modifier.interrupt", "player.glyph(114237)" } }, -- Glyph of Fae Silence (114237)
	{ "Mighty Bash", { "talent(5, 3)", "modifier.interrupt" } },
	{ "War Stomp", "modifier.interrupt" }, -- Stun -- War Stomp if player is Tauren race if Interrupts is toggled

	-- DREAM PROCS
	{ {
		--{ "Remove Corruption", { "!modifier.last", "player.dispellable" }, "player" },
		{ "Rebirth", { "target.exists", "target.friend", "target.dead" }, "target" },
	},{
		"player.buff(Dream of Cenarius)",
	} },

	-- RANGED PULLS
	{ "Faerie Fire", { "target.exists", "target.distance > 5" } },
	{ "Faerie Fire", { "toggle.mouseovers", "mouseover.alive", "mouseover.enemy", "mouseover.distance > 5" }, "mouseover" },

	-- DEFENSIVE COOLDOWNS
	{ "#89640", { "toggle.consume", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
	{ "#5512", { "toggle.consume", "player.health < 40" } }, -- Healthstone (5512)
	{ "#76097", { "toggle.consume", "player.health < 20", "target.boss" } }, -- Master Healing Potion (76097)
	{ "Survival Instincts", { "target.enemy", "target.alive", "player.health < 50" } },
	{ "Survival Instincts", { "target.enemy", "target.alive", "player.health < 80", "player.spell(Survival Instincts).charges > 1" } },

	-- THREAT ROTATION
	{ "Savage Defense", { "modifier.cooldowns", "player.rage >= 60", "target.distance < 5", "!player.buff(Savage Defense)", "player.health <= 80" } },
	{ "Blood Fury", { "modifier.cooldowns", "target.enemy", "target.alive" } },
	{ "Berserking", { "modifier.cooldowns", "target.enemy", "target.alive" } },
	{ "Arcane Torrent", "player.rage <= 75" },
	{ "#trinket1", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive" } },
	{ "#trinket2", { "modifier.cooldowns", "target.exists", "target.enemy", "target.alive" } },
	{ "Barkskin", { "player.health < 90", "target.distance < 5" } },
	{ "Maul", { "player.rage > 79", "player.buff(Tooth and Claw)", "player.spell(Mangle).cooldown > 0.5" } },
	{ "Maul", "player.rage > 94" },
	{ "Berserk", { "modifier.cooldowns", "player.buff(Pulverize).remains > 10" } },
	{ "Frenzied Regeneration", { "player.rage >= 80", "!modifier.last", "player.health < 60" } },
	{ "Cenarion Ward" },
	{ "Renewal", "player.health < 30" },
	{ "Heart of the Wild", { "modifier.cooldowns", "player.health < 95", "target.distance < 5" } },
	{ "Rejuvenation", { "player.buff(Heart of the Wild)", "player.buff(Heart of the Wild).remains <= 4" } },
	{ "Nature's Vigil", { "modifier.cooldowns", "player.health < 95", "target.distance < 5" } },
	{ "Healing Touch", { "player.buff(Dream of Cenarius)", "player.health < 60" }, "player" },
	{ "Pulverize", "player.buff(Pulverize).remains < 0.5" },
	-- actions+=/lacerate,if=talent.pulverize.enabled&buff.pulverize.remains<=(3-dot.lacerate.stack)*gcd&buff.berserk.down
	{ "Incarnation: Son of Ursoc", { "modifier.cooldowns", "player.health < 70", "target.distance < 5" } },
	{ "Lacerate", "target.debuff(Lacerate).remains <= 3" },
	{ "Thrash", { "modifier.multitarget", "!target.debuff(Thrash)" } },
	{ "Mangle" },
	{ "Thrash", { "modifier.multitarget", "target.debuff(Thrash)", "target.debuff(Thrash).duration <= 1" } },
	{ "Lacerate" },


},{
-- OUT OF COMBAT ROTATION
	-- PAUSE
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },

	-- BUFFS
	{ "Mark of the Wild", "!player.buffs.stats" },

	-- REZ
	{ "Revive", { "target.exists", "target.dead", "target.player", "!player.moving" }, "target" },

	-- AUTO FORMS
	{ {
		{ "pause", { "target.exists", "target.istheplayer" } },
		{ "/cancelform", { "target.isfriendlynpc", "!player.form = 0", "!player.ininstance", "target.range <= 2" } },
		{ "pause", { "target.isfriendlynpc", "target.range <= 2" } },
		{ "Travel Form", { "!player.form = 3", "!target.exists", "!player.ininstance", "player.moving", "player.outdoors" } },
		{ "Cat Form", { "!player.form = 2", "!player.form = 3", "!target.exists", "player.moving" } },
		{ "Bear Form", { "!player.form = 1", "target.exists", "target.enemy", "target.distance < 30" } },
	},{
		"toggle.forms", "!player.flying", "!player.buff(Dash)",
	} },

	-- FROGGING
	{ {
		{ "Mark of the Wild", "@bbLib.engaugeUnit('ANY', 30, true)" },
		{ "Soothe", true, "target" },
	},{
		"toggle.frogs",
	} },

},
-- TOGGLE BUTTONS
function()
	PossiblyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_nature_faeriefire', 'Use Mouseovers', 'Toggle usage of Faerie Fire on mouseover targets.')
	PossiblyEngine.toggle.create('forms', 'Interface\\Icons\\ability_racial_bearform', 'Auto Form', 'Toggle usage of smart forms out of combat. Does not work with stag glyph!')
	PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Auto Engauge', 'Automaticly target and attack units in range.')
end)
