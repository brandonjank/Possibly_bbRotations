-- PossiblyEngine Rotation
-- Custom Feral Druid Rotation
-- Created on Oct 15th 2014
-- PLAYER CONTROLLED:
-- SUGGESTED BUILD:
-- CONTROLS:

--TODO:  ttd, deathin, range -> distance, enemies

PossiblyEngine.rotation.register_custom(103, "bbDruid Feral", {
-- COMBAT ROTATION

-----------------------------------------------------------------------------------------------------------------------------
-- Boss Functions -----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	{{
		-------------------------------
		-- Class Specific Activation --
		-------------------------------
		{"Nature's Vigil", { "player.spell(Gene Splice).usable", "player.spell(Gene Splice).cooldown < 1", "player.buff(Mad Scientist)", "!player.buff(Gene Splice)" }}, 
		{ "/click ExtraActionButton1", { "player.spell(Gene Splice).usable", "player.spell(Gene Splice).cooldown < 1", "player.buff(Mad Scientist)", "!player.buff(Gene Splice)" }},				
			
		{{
			-- Klaxxi, Swipe
			{ "/click OverrideActionBarButton2", { "player.spell(Swipe).usable", "player.spell(Swipe).cooldown < 0.2", "target.debuff(Sting)" } },
			{ "/click OverrideActionBarButton3", { "player.spell(Sting).usable", "player.spell(Sting).cooldown < 0.2", "!target.debuff(Sting)" } },	
			{ "/click OverrideActionBarButton1", { "player.spell(Claw).usable", "player.spell(Claw).cooldown < 0.2" } },	
			{ "/click OverrideActionBarButton4", { "player.spell(Fiery Tail).usable", "player.spell(Fiery Tail).cooldown < 0.2" } },	
		},
			"player.buff(Gene Splice)" 
		},
	},{  
		"toggle.boss", (function() return Soapbox.IsBoss() end)
	}},
-----------------------------------------------------------------------------------------------------------------------------
-- Queued Spells ------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
	{ "!Cyclone", (function() return Soapbox.checkQueue(Cyclone) end), "mouseover" },
	{ "!Entangling Roots", (function() return Soapbox.checkQueue(Entangling Roots) end), "mouseover" },
	--{ "!29166", (function() return Soapbox.checkQueue(29166) end), "mouseover" }, -- DNE in WoD
	--{ "!16689", (function() return Soapbox.checkQueue(16689) end) }, -- DNE in WoD
	{ "!Rebirth", { "mouseover.exists", "!mouseover.alive", "mouseover.friendly", (function() return Soapbox.checkQueue(Rebirth) end) }, "mouseover" }, 
	{ "!Stampeding Roar", (function() return Soapbox.checkQueue(Stampeding Roar) end) },
	{ "!Heart of the Wild", (function() return Soapbox.checkQueue(Tranquility) end) },
	{ "!Tranquility", { (function() return Soapbox.checkQueue(Tranquility) end), "!player.moving" } },
	{ "!Incapacitating Roar", (function() return Soapbox.checkQueue(Incapacitating Roar) end) },
	{ "!Ursol's Vortex", (function() return Soapbox.checkQueue(Ursol's Vortex) end), "ground" },
	{ "!Mighty Bash", (function() return Soapbox.checkQueue(Mighty Bash) end) },
	{ "!Displacer Beast", (function() return Soapbox.checkQueue(Displacer Beast) end) },
	{ "!Wild Charge", (function() return Soapbox.checkQueue(Wild Charge) end) },
-----------------------------------------------------------------------------------------------------------------------------
-- Rebuff -------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------			
	{"Cat Form", { "!player.buff(Cat Form)", "target.exists", "target.alive", "target.enemy", "player.health > 20", "!modifier.last(Cat Form)"	} },
-----------------------------------------------------------------------------------------------------------------------------
-- Utility Racials ----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------		
	--{ "20594", "player.health <= 70" }, --Dwarven
	--{ "20589", "player.state.root" }, --Gnome
	--{ "20589", "player.state.snare" }, --Gnome
	--{ "59752", "player.state.charm" }, --Human
	--{ "59752", "player.state.fear" }, --Human
	--{ "59752", "player.state.incapacitate" }, --Human
	--{ "59752", "player.state.sleep" }, --Human
	--{ "59752", "player.state.stun" }, --Human
	--{ "Shadowmeld", "target.threat >= 80" }, -- Night Elf
	--{ "Shadowmeld", "focus.threat >= 80"}, -- Night Elf
	--{ "7744", "player.state.fear" }, --Undead
	--{ "7744", "player.state.charm" }, --Undead
	--{ "7744", "player.state.sleep" }, --Undead
	--{ "107079", "modifier.interrupts" }, --Pandaren
-----------------------------------------------------------------------------------------------------------------------------
-- Interrupts ---------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	{{
		{"Cyclone", { "player.spell(Cyclone).cooldown = 0", "player.level >= 78" }, "focus"},
		{"Mighty Bash", { "player.spell(Mighty Bash).cooldown = 0",	"target.range <= 8", "player.level >= 75" }, "target"},
		{"Maim", {	"target.player", "player.combopoints > 0", "player.power >= 35", "player.level >= 82" }, "target"}, 
	},{ 
		"modifier.interrupts", "target.casting" 
	} },
-----------------------------------------------------------------------------------------------------------------------------
-- Inventory Items ----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------	
	{ "#5512", { (function() return Soapbox.Healthstone() end), "player.health < 20" } },			
	{ "#89640", { (function() return Soapbox.LifeSpirit() end), "player.health < 40", "!player.buff(130649)" } },	
-----------------------------------------------------------------------------------------------------------------------------
-- Defensive Cooldowns ------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	{{
		{"22812", {	"player.health <= 50", "player.level >= 44" } }, 
		{"106922", { "player.health <= 30",	"player.level >= 72" } }, 
		{"61336", {	"player.health <= 25", "player.level >= 56" } },
		{"774", { "player.form != 0", "!player.buff(774)", "!player.buff(Heart of the Wild)", "player.health <= 20" } },
		{"774", { "player.form = 0", "!player.buff(774)", "player.health <= 20" } },
		{"22842", {	"player.buff(106922)", "player.level >= 72", "player.spell(22842).casted < 1" } }, 
		{"/cancelform", { "player.buff(5487)", "!player.buff(Heart of the Wild)" } },	
	},{
		"toggle.defensive", "!player.buff(5215)", "!player.buff(80169)", "!player.buff(87959)",	"!player.casting", "player.alive" 
	} }, 
-----------------------------------------------------------------------------------------------------------------------------
-- AOE Rotation -------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	 {{		
		{"770", { "player.level >= 28", "target.range <= 8", "target.health > 25", "player.spell(770).cooldown = 0", "!target.debuff(113746)", "!player.buff(5215)" }, "target"},
		{{				
			{{			
				{"52610", {	"player.combopoints > 0", "!player.glyph(127540)" } }, 
				{"127538", "player.glyph(127540)" },
			},{
				"player.SavageRoar <= 1", "player.power >= 25"
			}},
		},{
			"!player.buff(Heart of the Wild)", "player.buff(Cat Form)", "target.enemy", "target.alive", "target.range < 10", "player.level >= 18"
		}},
		{"5217", { "player.buff(Cat Form)", "player.spell(5217).cooldown = 0", "target.range <= 8", "player.power < 35", "!player.buff(106951)", "!player.buff(135700)" } }, 
		{{				
			{"106832", "player.RuneOfReorigination > 0" },	
			{"106832", "player.Thrash < 3" },
			{"106832", "player.buff(5217)" },
		},{
			"player.Thrash < 9", "player.power >= 50", "player.buff(Cat Form)",	"player.level >= 28", "target.range <= 8" 
		} },
		{"1079", { "player.Rip < 2", "player.power >= 30", "target.ttd > 4", "player.combopoints >= 5", "player.buff(Cat Form)", "player.SavageRoar > 0", "!player.buff(135700)", "target.range <= 8" } },
		{"1822", { "player.RakeTime < 3", "player.power >= 35", "!player.buff(135700)",	"player.SavageRoar > 0", "target.ttd >= 15", "target.enemy", "target.alive", "target.range < 8" }, "target" }, 	
		{"62078", { "player.SavageRoar > 0", "player.power >= 45", "target.enemy", "target.alive", "target.range < 8", "player.level >= 22" } },	
	 }, "modifier.multitarget"},
-----------------------------------------------------------------------------------------------------------------------------
-- Single Target Rotation ---------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	{{
		{"106832", { "player.buff(135700)", "player.Thrash <= 3", "player.Rip > 3", "player.RakeTime > 3", "player.buff(Cat Form)", "player.level >= 28", "target.range < 8", "target.ttd >= 6" } },
		{"770", { "player.level >= 28", 	"target.range <= 8", "player.spell(770).cooldown = 0", "!target.debuff(113746)", "!player.buff(5215)" }, "target"},
		{{
			{{
				{{
					{ "5217", "player.RuneOfReorigination <= 6" },
					{ "5217", "player.combopoints > 4" },
				}, "player.power <= 35" },
			
				{{
					{ "5217", "player.RuneOfReorigination <= 6" },
					{ "5217", "player.combopoints > 4" },
					{ "5217", "player.power < 25" },
				}, "!target.debuff(1079)" },
			},{ 
				"player.spell(108373).exists", "player.RuneOfReorigination > 0" 
			}},	
			{{
				{{
					{{
						{ "5217", "!player.buff(135700)" }, 
					}, "player.power <= 35" },
				
					{{
						{ "5217", "!player.buff(135700)" }, 
					}, "!target.debuff(1079)" },
				}, "player.ctime > 6" },
			},{ 
				"!player.spell(108373).exists" 
			}},
			{{
				{{
					{{
						{ "5217", "!player.buff(135700)" }, 
					}, "player.power <= 35" },
				
					{{
						{ "5217", "!player.buff(135700)" }, 
					}, "!target.debuff(1079)" },
				}, "player.ctime > 6" },
			},{ 
				"player.spell(108373).exists", "player.RuneOfReorigination = 0" 
			}},	
			{ "5217", { "!player.buff(135700)",	"player.power <= 35", (function() return not Soapbox.Rune() end) } },
		},{
			"!player.buff(106951)", "target.range <= 8",
		}},
	----------------------------------------------------------------------------------------------------------------------------
		{{
			{ "Savage Roar", { "target.health > 24", "player.combopoints >= 3", (function() return not Soapbox.FeralT164Pc() end) } },
			{ "Savage Roar", { "target.health > 24", "player.combopoints > 4", "player.buff(5217)" } },
			{ "Savage Roar", { "target.debuff(1079).duration > 7", "player.combopoints >= 3", (function() return not Soapbox.FeralT164Pc() end) } },
			{ "Savage Roar", { "target.debuff(1079).duration > 7", "player.combopoints > 4", "player.buff(5217)" } },
			{ "Savage Roar", { "!target.debuff(1079)", "player.combopoints >= 3", (function() return not Soapbox.FeralT164Pc() end) } },
			{ "Savage Roar", { "!target.debuff(1079)", "player.combopoints > 4", "player.buff(5217)"	} },
			{ "Savage Roar", { "target.debuff(1079)", "target.debuff(1079).duration < 4", "player.power >84", "player.combopoints >= 3", (function() return not Soapbox.FeralT164Pc() end) } },
			{ "Savage Roar", { "target.debuff(1079)", "target.debuff(1079).duration < 4", "player.power >84", "player.combopoints > 4", "player.buff(5217)" } },
			
		},{ 
			"target.range <= 8", "player.ctime < 14", "player.SavageRoar < 11", "player.RuneOfReorigination > 4", "player.buff(Cat Form)", "!player.buff(Heart of the Wild)", "player.spell(108373).exists", "!player.buff(69369)" 
		}},
	-------------------------------------------------------------------------------------------------------------------------------------
		{{					
			{ "52610", { "player.SavageRoar <= 1", "player.power >= 25" } }, 
			{ "127538", { "player.SavageRoar <= 1", "player.power >= 25" } },	
			{ "52610", { "player.power >= 25", "player.SavageRipComparison <= 4", "player.SavageRoarTimeCalculator", "player.Rip < 10", "player.Rip > 0"	} }, 
			{ "127538", { "player.power >= 25", "player.SavageRipComparison <= 4", "player.SavageRoarTimeCalculator", "player.Rip < 10", "player.Rip > 0" } },
		},{
			"!player.buff(Heart of the Wild)", "player.buff(Cat Form)",	"target.enemy", "target.alive", "target.range < 10", "player.level >= 18" 
		} },
-----------------------------------------------------------------------------------------------------------------------------
-- Cooldowns ----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
		{ {
			{ {
				{ "26297", "player.power >= 30" }, 
				{ "#gloves", { "player.power >= 30", "!player.buff(106951)" } }, 
				{ "106951", { "player.energy >= 30", "player.spell(5217).cooldown > 6", "target.ttd >= 18" } }, 
				{ "102543", { "target.ttd >= 15", "player.buff(106951)" } },
				{ "Nature's Vigil", { "target.ttd >= 15", "!player.buff(Mad Scientist)",	"player.power >= 30" } }, 
			},{
				"player.SavageRoar > 0", "player.buff(5217)"
			} },
		},{
			"modifier.cooldowns", "player.buff(Cat Form)", "!player.buff(5215)", "target.range <= 8"
		} },

		{ {				
			{ "106832", { "player.Thrash < 9", "player.RuneOfReorigination > 0", "player.RuneOfReorigination <= 1.5", "player.Rip > 4" } },
			{ "106832", { "player.Thrash <= 3", "player.Rip > 4", "player.RakeTime > 3" } },
		},{
			"!player.buff(135700)", "player.buff(Cat Form)", "player.level >= 28", "target.range < 8", "target.ttd >= 6"
		} },
			
		{ "5185", { "player.buff(69369)", "!player.buff(145152)", "player.buff(69369).duration < 1.5" }, "lowest"},
		{ "5185", { "player.buff(69369)", "!player.buff(145152)", "player.combopoints >= 4" }, "lowest"},
		{ "pause", { "player.combopoints >= 4", "player.buff(69369)", "!player.buff(145152)" } },
		{ {
			{ "5185", { "target.health <= 25", "target.ttd <= 4" } }, 
			{ "5185", { "target.health <= 25", "player.Rip > 0", "player.Rip <= 4" } },
		},{
			"player.buff(69369)", "!player.buff(145152)", "player.buff(Cat Form)", "player.power >= 25", "player.SavageRoar > 0", "target.enemy", "target.alive", "target.range < 8"
		} },
		
		{{					
			{ "22568", { "target.health <= 25", "target.ttd <= 4" } },
			{ "22568", { "target.health <= 25", "player.Rip > 0", "player.Rip <= 4"	} },
			{ "22568", { "player.RipDamagePercent < 108", "player.Rip > 6", "player.combopoints >= 5", "player.power >= 50" } },
		},{
			"player.buff(Cat Form)", "player.power >= 25", "player.SavageRoar > 0", "target.enemy", "target.alive",	"target.range < 8"
		}, "target"},
			
		
		{{				
			{ "1079", {	"player.combopoints = 4", "player.RipDamagePercent >= 95", "target.ttd > 30", "player.RuneOfReorigination > 0", "player.RuneOfReorigination <= 1.5" }, "target" },
			{{
				{"1079", "player.Rip = 0", "target"},
				{{
					{"1079", { "player.Rip < 6", "target.health > 25" }, "target"},
					{"1079", { "player.RipDamagePercent > 108", "player.rscbuff = 0" }, "target" },
					{"1079", { "player.RipDamagePercent > 108", "player.rscbuff >= 7" }, "target" },
				}, "target.ttd >= 15", },
			}, "player.combopoints >= 5" },
		},{
			"player.ctime > 5", "player.level >= 20", "player.SavageRoar > 1", "target.ttd > 4"
		}},
		
		{{			
			{"1822", { "player.RuneOfReorigination > 0.5", "player.RakeTime < 9", "player.RuneOfReorigination <= 1.5" }, "target" }, 
			{"1822", "player.RakeTime < 3", "target" },
			{"1822", { "player.Rake2", "player.rscbuff = 0" }, "target" },
			{"1822", { "player.Rake2", "player.rscbuff >= 9" }, "target" },
		},{
			"player.combopoints < 5", "target.range < 8", "player.SavageRoar > 1", "player.power >= 35"
		}},

		{{				
			{"102545", "player.buff(102543)" },
			{"102545", "player.buff(81022)" },
			{"1822", "player.Rake" },
			{{		
				{{	
					{"114236", "player.glyph(114234)" },
					{"5221", "!player.glyph(114234)" },
				}, "player.buff(106951)" },
				{{	
					{"114236", "player.glyph(114234)" },
					{"5221", "!player.glyph(114234)" },
				}, "player.buff(135700)" },
				
				{{	
					{"114236", "player.glyph(114234)" },
					{"5221", "!player.glyph(114234)" },
				}, "player.regen >= 15" },
			},{
				"player.Shred", "player.power >= 45", "!player.buff(102543)" 
			} },
			
			{"33876", { "player.power >= 35", "!player.buff(102543)" } },
		},{
			"player.buff(Cat Form)", "target.range < 8", "player.combopoints < 5", "target.enemy", "target.alive" }, "target" },
	 }, "!modifier.multitarget"},
},
{	
-- OUT OF COMBAT ROTATION
	{ "1126", (function() return Soapbox.Stats() end) }, 
	{ "1126", (function() return Soapbox.RaidStats() end), "member" }, 
	{ "1066", { "player.swimming", "!player.buff(1066)" }, "player" },
	{"50769", { "mouseover.exists", "mouseover.dead", "mouseover.isPlayer", "mouseover.range < 40", "player.level >= 12" }, "mouseover" },
	{"2782", "player.dispellable(2782)" },
	{"Cat Form", { "target.exists", "target.alive", "target.enemy", "!player.buff(Cat Form)", "player.health > 20", "!modifier.last(Cat Form)" } },
	{"774", { "!player.buff(5215)",	"!player.buff(80169)", "!player.buff(87959)", "!player.casting", "player.alive", "!player.buff(774)", "player.health <= 70"	} }, 
	{{				
		{"52610"}, 
		{"127538"},
	},{
		"player.SavageRoar <= 1", "player.buff(5215)", "!player.buff(Heart of the Wild)", "player.buff(Cat Form)", "target.enemy", "target.alive", "target.range < 10" 
	} },
	{"6785", { "target.behind", "player.buff(5215)", "player.SavageRoar > 1", "player.power > 98", "!target.player", "player.combopoints < 5", "player.power >= 45", "target.enemy", "target.alive", "target.range < 8" }, "target" },
	{"9005", { "player.buff(5215)", "target.player", "target.behind", "player.combopoints < 5", "player.power >= 50", "target.enemy", "target.alive", "target.range < 8" } },
	{{				
		{"5221", "target.behind", "target"},
		{"114236", { "player.buff(106951)", "player.glyph(114234)" }, "target" },
	},{
		"player.combopoints < 5", "player.power > 98", "target.enemy", "target.alive", "target.range < 8", "player.level >= 16"
	}},
	{"33876", { "player.combopoints < 5", "player.power > 98", "target.enemy", "target.alive", "target.range < 8" }, "target" }, 
	{"pause", "player.ctime > 9000"}, 
},
-- TOGGLE BUTTONS
function()
	PossiblyEngine.toggle.create( 'boss', 'Interface\\Icons\\Ability_Creature_Cursed_02.png‎', 'Boss Function Toggle', 'Enable or Disable Specific Boss Functions to Improve DPS')
	PossiblyEngine.toggle.create( 'defensive', 'Interface\\Icons\\ability_druid_tigersroar.png‎', 'Defensive Cooldown Toggle', 'Enable or Disable the Automatic Management of Defensive Cooldowns')
end)