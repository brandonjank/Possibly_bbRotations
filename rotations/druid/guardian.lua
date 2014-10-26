-- PossiblyEngine Rotation
-- Guardian Druid - WoD 6.0.2
-- Updated on Oct 25th 2014

-- PLAYER CONTROLLED:
-- TALENTS:
-- GLYPHS:
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(104, "bbDruid Guardian", {
	-- COMBAT ROTATION

	-- Bear Form
	{ "/cancelform\n/run CastShapeshiftForm(1)", { "!player.buff(Bear Form)", "!player.buff(Swift Flight Form)", "!player.buff(Flight Form)" } }, -- Force Bear Form

	-- Interrupts
	{{
		{ "Mighty Bash" , "target.interruptAt(35)" },

		-- Ress target-Instantly
		{ "Rebirth", { "target.dead", "player.buff(Dream of Cenarius)" }, "target" },
		{ "Rebirth", { "mouseover.dead", "player.buff(Dream of Cenarius)" }, "mouseover" },

		--Taunt
		{ "Growl", { "target.distance <= 30", "target.threat < 100", "!modifier.last(Growl)", "modifier.shift" } },

		-- Survival
		{{
			{ "Renewal", { "player.health <= 30" }},
			{ "Survival Instincts", { "player.health <= 40" }},
			{ "Barkskin", { "player.health <= 90" }},
			{ "#5512", { "player.health <= 50" }}, --Healthstone
		}, { "toggle.Survival" }},

		{ "Frenzied Regeneration", { "player.health <= 80", "!player.glyph(40896)", "!modifier.last" } },
		{ "Frenzied Regeneration", { "target.threat >= 100", "!player.buff", "player.glyph(40896)", "!modifier.last" } },
		{ "Savage Defense", { "target.threat >= 100", "target.distance <= 5", "!player.buff", "!modifier.last" } },
		{ "Healing Touch", { "player.health <= 85", "player.buff(Dream of Cenarius)" } },
		{ "Healing Touch", { "targettarget.health <= 85", "player.buff(Dream of Cenarius)" }, "targettarget" },
		{ "Healing Touch", { "lowest.health <= 65", "player.buff(Dream of Cenarius)" }, "lowest" },

		--AOE
		{ "Swipe", { "modifier.multitarget", "target.distance <= 5" } }, --779 DNE in WoD  Swipe?

		-- Cooldowns
		{{
		{ "Nature's Vigil", { "player.spell(Berserk).cooldown = 0" }},
		{ "Nature's Vigil", { "player.spell(Incarnation: Son of Ursoc).cooldown = 0" }},
		{ "Incarnation: Son of Ursoc", { "player.buff(Nature's Vigil)" }},
		{ "Berserk", { "player.time > 10", "!player.buff(Incarnation: Son of Ursoc)", "player.buff(Nature's Vigil).duration > 10" } },
		},{
			"!target.dead", "target.distance <= 5", "player.spell(Nature's Vigil).exists", "modifier.cooldowns", "target.deathin > 45"
		} }, --Nature's Vigil

		{{
		{ "Incarnation: Son of Ursoc" },
		{ "Berserk", { "player.time >= 90", "!player.buff(Incarnation: Son of Ursoc)" }},
		}, {
			"!target.dead", "target.distance <= 5", "!player.spell(Nature's Vigil).exists", "modifier.cooldowns", "target.deathin > 45"
		} }, --Nature's Vigil

		-- Mob Control
		--{ "5229", { "player.rage < 70" }}, --Enrage DNE WoD
		{ "Faerie Fire", { "!target.debuff(Faerie Fire)" } },
		{ "Thrash", { "target.distance <= 5", "target.debuff.duration < 3" } },
		{ "Mangle" },
		{ "Maul", { "player.buff(Tooth and Claw)", "!modifier.last" } },
		{ "Maul", { "player.rage >= 80", "!modifier.last" } },
		{ "Maul", { "target.threat < 100", "!modifier.last" } },
		{ "Lacerate", { "target.debuff.duration < 3" } },
		{ "Lacerate", { "!modifier.last" } },
		{ "Swipe", { "target.distance <= 5", "target.area(8).enemies > 3" } },
		{ "Thrash", { "target.distance <= 5" }},
		{ "Swipe", { "target.distance <= 5" }},
		{ "Faerie Fire" },
	}, {
		"player.buff(Bear Form)",
	}},
},{
-- OUT OF COMBAT ROTATION
  { "Mark of the Wild", { (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil end), "lowest.distance <= 30", "player.form = 0" }, "lowest" }
},
-- TOGGLE BUTTONS
function()
	PossiblyEngine.toggle.create('Survival', 'Interface\\Icons\\Ability_druid_tigersroar','Survivability','Enable or Disable the usage of Survivability Cooldowns')
end)
