-- PossiblyEngine Rotation
-- Custom Feral Druid Rotation
-- Created on Oct 15th 2014
-- PLAYER CONTROLLED:
-- SUGGESTED BUILD:
-- CONTROLS:

PossiblyEngine.rotation.register_custom(103, "bbDruid Feral", {
-- COMBAT ROTATION

-----------------------------------------------------------------------------------------------------------------------------
-- Boss Functions -----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	{{
		-------------------------------
		-- Class Specific Activation --
		-------------------------------
		{"124974", {	
		"player.spell(143373).usable", 
		"player.spell(143373).cooldown < 1", 
		"player.buff(141857)", 
		"!player.buff(143373)" 
		}}, 
					
		{ "/click ExtraActionButton1", { 
		"player.spell(143373).usable", 
		"player.spell(143373).cooldown < 1", 
		"player.buff(141857)", 
		"!player.buff(143373)" 
		}},				
			
		{{
			{ "/click OverrideActionBarButton2", { 		-- Klaxxi, Swipe
			"player.spell(144275).usable", 				-- Klaxxi, Swipe: Ready	
			"player.spell(144275).cooldown < 0.2",
			"target.debuff(144276)"						-- Klaxxi, Swipe: Poisoned
			}},	
				
			{ "/click OverrideActionBarButton3", { 		-- Klaxxi, Swipe
			"player.spell(144276).usable", 				-- Klaxxi, Swipe: Ready	
			"player.spell(144276).cooldown < 0.2",
			"!target.debuff(144276)"					-- Klaxxi, Swipe: Poisoned
			}},	
				
			{ "/click OverrideActionBarButton1", { 		-- Klaxxi, Swipe
			"player.spell(144274).usable", 	
			"player.spell(144274).cooldown < 0.2", 						
			}},	
				
			{ "/click OverrideActionBarButton4", { 		
			"player.spell(144181).usable", 				
			"player.spell(144181).cooldown < 0.2", 
			}},	
			
		},"player.buff(143373)" },
	},{  "toggle.boss",
		(function() return Soapbox.IsBoss() end),
	}},
-----------------------------------------------------------------------------------------------------------------------------
-- Queued Spells ------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
		{ "!33786", (function() return Soapbox.checkQueue(33786) end), "mouseover" },
		
		{ "!339", (function() return Soapbox.checkQueue(339) end), "mouseover" },
		
		{ "!29166", (function() return Soapbox.checkQueue(29166) end), "mouseover" },
		
		{ "!16689", (function() return Soapbox.checkQueue(16689) end) },
		
		{ "!20484", { "mouseover.exists", "!mouseover.alive", "mouseover.friendly", (function() return Soapbox.checkQueue(20484) end) }, "mouseover" }, 
		
		{ "!77764", (function() return Soapbox.checkQueue(77764) end) },
		
		{ "!108292", (function() return Soapbox.checkQueue(740) end) },
		
		{ "!740", { 
		(function() return Soapbox.checkQueue(740) end), 
		"!player.moving" 
		}},
		
		{ "!99", (function() return Soapbox.checkQueue(99) end) },
		
		{ "!102793", (function() return Soapbox.checkQueue(102793) end), "ground" },

		{ "!5211", (function() return Soapbox.checkQueue(5211) end) },
		
		{ "!102280", (function() return Soapbox.checkQueue(102280) end) },
		
		{ "!102401", (function() return Soapbox.checkQueue(102401) end) },
-----------------------------------------------------------------------------------------------------------------------------
-- Off GCD ------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------		
	{{					
		{{
			{"106737", {	
			"player.buff(148903) > 0",
			"player.buff(148903) <= 1",
			}},
						
			{"106737", {	
			"player.buff(146310).count = 20",
			}},
						
			{"106737", {
			"player.buff(138756).duration < 5",
			"player.buff(138756).count = 10",
			}},
						
			{"106737", {
			"player.RuneOfReorigination > 0",
			"player.RuneOfReorigination < 1",
			}},
					
			{"106737", {	
			"target.ttd < 20",
			}},
		}, "player.spell(106737).charges > 0" },
					
		{"106737", {	
		"player.spell(106737).charges = 3",
		"!modifier.last",
		"player.RuneOfReorigination = 0",
		"!player.buff(138756)",
		"player.spell(106737).casted < 1",
		}},
	},{
	"modifier.cooldowns",
	"player.level >= 60",
	"player.spell(106737).cooldown = 0",	
	}}, 
-----------------------------------------------------------------------------------------------------------------------------
-- Rebuff -------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------			
	
	{"768", { 
	"!player.buff(768)",
	"target.exists", 
	"target.alive", 
	"target.enemy",
	"player.health > 20",
	"!modifier.last(768)"
	}},
-----------------------------------------------------------------------------------------------------------------------------
-- Utility Racials ----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------		
	--{ "20594", "player.health <= 70" }, (Dwarven)
	
	--{ "20589", "player.state.root" }, (Gnome)
	
	--{ "20589", "player.state.snare" }, (Gnome)
	
	--{ "59752", "player.state.charm" }, (Human)
	
	--{ "59752", "player.state.fear" }, (Human)
	
	--{ "59752", "player.state.incapacitate" }, (Human)
	
	--{ "59752", "player.state.sleep" }, (Human)
	
	--{ "59752", "player.state.stun" }, (Human)
	
	{ "Shadowmeld", "target.threat >= 80" }, -- Night Elf: Shadowmeld
	
	{ "Shadowmeld", "focus.threat >= 80"}, -- Night Elf: Shadowmeld
	
	--{ "7744", "player.state.fear" }, (Undead)
	
	--{ "7744", "player.state.charm" }, (Undead)
	
	--{ "7744", "player.state.sleep" }, (Undead)
	
	--{ "107079", "modifier.interrupts" }, (Pandaren)
-----------------------------------------------------------------------------------------------------------------------------
-- Interrupts ---------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	 {{	
		{{
			{"33786", {		
			"player.spell(33786).cooldown = 0",
			"player.level >= 78",
			}, "focus"},
			
			{"5211", { 	
			"player.spell(5211).cooldown = 0",	
			"target.range <= 8",
			"player.spell(80965).cooldown != 0",	
			"player.spell(80965).cooldown <= 14",	
			"player.level >= 75",
			}, "target"},
			
			{"80965", {	
			"player.spell(80965).cooldown = 0",	
			"player.level >= 64",
			}, "target"},	
			
			{"22570", {	
			"target.player",
			"player.spell(80965).cooldown != 0",	
			"player.combopoints > 0",
			"player.power >= 35",
			"player.level >= 82",
			}, "target"}, 
		}, "target.casting" },
	 }, "modifier.interrupts"},
-----------------------------------------------------------------------------------------------------------------------------
-- Inventory Items ----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------	
	{ "#5512", { 
	(function() return Soapbox.Healthstone() end), 
	"player.health < 20" 
	}},			
	
	{ "#89640", { 
	(function() return Soapbox.LifeSpirit() end), 
	"player.health < 40", 
	"!player.buff(130649)" 
	}},	
-----------------------------------------------------------------------------------------------------------------------------
-- Defensive Cooldowns ------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	 {{		
		{{
			{"22812", {	
			"player.health <= 50",
			"player.level >= 44",
			}}, 
			
			{"106922", {	
			"player.health <= 30",
			"player.level >= 72",
			}}, 
			
			{"61336", {		
			"player.health <= 25",
			"player.level >= 56",
			}},
			
			{"774", {		
			"player.form != 0",
			"!player.buff(774)",
			"!player.buff(108292)",
			"player.health <= 20",
			}},
			
			{"774", {
			"player.form = 0",
			"!player.buff(774)",
			"player.health <= 20",
			}},
			
			{"22842", {		
			"player.buff(106922)",
			"player.level >= 72",
			"player.spell(22842).casted < 1",
			}}, 
			
			{"/cancelform", { 
			"player.buff(5487)",
			"!player.buff(108292)",
			}},	
		},{
		"!player.buff(5215)",	
		"!player.buff(80169)",	
		"!player.buff(87959)",	
		"!player.casting",
		"player.alive",
		}}, 
	 }, "toggle.defensive" },
-----------------------------------------------------------------------------------------------------------------------------
-- AOE Rotation -------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	 {{		
		{"770", {		
		"player.level >= 28",
		"target.range <= 8",
		"target.health > 25",
		"player.spell(770).cooldown = 0", 
		"!target.debuff(113746)", 
		"!player.buff(5215)" 
		}, "target"},
		
		{{				
			{{			
				{"52610", {	
				"player.combopoints > 0",
				"!player.glyph(127540)"
				}}, 
				
				{"127538", "player.glyph(127540)" },
			},{
			"player.SavageRoar <= 1",
			"player.power >= 25"
			}},
		},{
		"!player.buff(108292)",
		"player.buff(768)",
		"target.enemy",
		"target.alive",
		"target.range < 10",
		"player.level >= 18"
		}},
		
		{"5217", {  	
		"player.buff(768)", 
		"player.spell(5217).cooldown = 0", 
		"target.range <= 8",
		"player.power < 35",
		"!player.buff(106951)", 
		"!player.buff(135700)" 
		}}, 
		
		{{				
			{"106832", "player.RuneOfReorigination > 0" },
			
			{"106832", "player.Thrash < 3" },
			
			{"106832", "player.buff(5217)" },
		},{
		"player.Thrash < 9",
		"player.power >= 50",
		"player.buff(768)",
		"player.level >= 28",
		"target.range <= 8"
		}},
		
		{"1079", {		
		"player.Rip < 2",
		"player.power >= 30",
		"target.ttd > 4",
		"player.combopoints >= 5",
		"player.buff(768)", 
		"player.SavageRoar > 0", 
		"!player.buff(135700)", 
		"target.range <= 8"
		}},
		
		{"1822", {		
		"player.RakeTime < 3",
		"player.power >= 35",
		"!player.buff(135700)",
		"player.SavageRoar > 0",
		"target.ttd >= 15",
		"target.enemy",
		"target.alive",
		"target.range < 8"
		}, "target"}, 
		
		{"62078", {		
		"player.SavageRoar > 0",
		"player.power >= 45",
		"target.enemy",
		"target.alive",
		"target.range < 8",
		"player.level >= 22"
		}},	
	 }, "modifier.multitarget"},
-----------------------------------------------------------------------------------------------------------------------------
-- Single Target Rotation ---------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	 {{		
		{"106832", {	
		"player.buff(135700)",
		"player.Thrash <= 3",
		"player.Rip > 3",
		"player.RakeTime > 3",
		"player.buff(768)",
		"player.level >= 28",
		"target.range < 8",
		"target.ttd >= 6",
		}},
		
		{"770", {		
		"player.level >= 28",
		"target.range <= 8",
		--"target.health > 25",
		"player.spell(770).cooldown = 0", 
		"!target.debuff(113746)", 
		"!player.buff(5215)" 
		}, "target"},
		
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
			},{ "player.spell(108373).exists", "player.RuneOfReorigination > 0" 
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
			},{ "!player.spell(108373).exists" 
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
			},{ "player.spell(108373).exists", "player.RuneOfReorigination = 0" 
			}},	
			
		
			{ "5217", { 
			"!player.buff(135700)",
			"player.power <= 35",
			(function() return not Soapbox.Rune() end),
			}},
			
		},{
		"!player.buff(106951)",
		"target.range <= 8",
		}},
	----------------------------------------------------------------------------------------------------------------------------
		{{
			{{
				{"Savage Roar", {
				"player.combopoints >= 3", 
				(function() return not Soapbox.FeralT164Pc() end),
				}},

				{"Savage Roar", {
				"player.combopoints > 4",
				"player.buff(5217)",
				}},
			}, "target.health > 24", },

			{{
				{"Savage Roar", {
				"player.combopoints >= 3",
				 (function() return not Soapbox.FeralT164Pc() end),
				}},

				{"Savage Roar", {
				"player.combopoints > 4", 
				"player.buff(5217)",
				}},
			}, "target.debuff(1079).duration > 7", },
			
			{{
				{"Savage Roar", {
				"player.combopoints >= 3",
				 (function() return not Soapbox.FeralT164Pc() end),
				}},

				{"Savage Roar", {
				"player.combopoints > 4", 
				"player.buff(5217)",
				}},
			}, "!target.debuff(1079)" },
			
			{{
				{"Savage Roar", {
				"player.combopoints >= 3", 
				 (function() return not Soapbox.FeralT164Pc() end),
				}},

				{"Savage Roar", {
				"player.combopoints > 4", 
				"player.buff(5217)",
				}},
			},{ "target.debuff(1079)", "target.debuff(1079).duration < 4", "player.power >84" }},
			
		},{ 
		"target.range <= 8",
		"player.ctime < 14", 
		--"player.power >= 25", 
		"player.SavageRoar < 11", 
		"player.RuneOfReorigination > 4", 
		"player.buff(768)", 
		"!player.buff(108292)", 
		"player.spell(108373).exists", 
		"!player.buff(69369)" 
		}},
	-------------------------------------------------------------------------------------------------------------------------------------
		{{				
			{{			
				{"52610"}, 
				
				{"127538"},
			},{
			"player.SavageRoar <= 1",
			"player.power >= 25"
			}},
			
			{{			
				{"52610"}, 
				
				{"127538"},
			},{
			"player.power >= 25",
			"player.SavageRipComparison <= 4",
			"player.SavageRoarTimeCalculator",
			"player.Rip < 10",
			"player.Rip > 0"
			}},
		},{
		"!player.buff(108292)",
		"player.buff(768)",
		"target.enemy",
		"target.alive",
		"target.range < 10",
		"player.level >= 18"
		}},
-----------------------------------------------------------------------------------------------------------------------------
-- Cooldowns ----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
		 {{		
			{{
				{{
					{"26297", "player.power >= 30" }, 
					
					{"#gloves", {	
					"player.power >= 30",
					"!player.buff(106951)",	
					}}, 
					
					{"106951", {		
					"player.energy >= 30",
					"player.spell(5217).cooldown > 6",
					"target.ttd >= 18",
					--"target.boss"
					}}, 
					
					{"102543", {			
					"target.ttd >= 15",
					"player.buff(106951)",	
					}},
					
					{"124974", {	
					"target.ttd >= 15",
					"!player.buff(141857)",
					"player.power >= 30",
					}}, 
				},{
				"player.SavageRoar > 0",			
				"player.buff(5217)",			
				}},
			},{
			"player.buff(768)",				
			"!player.buff(5215)",			
			"target.range <= 8"
			}}	
		 }, "modifier.cooldowns"},

		{{				
			{"106832", {	
			"player.Thrash < 9",
			"player.RuneOfReorigination > 0",
			"player.RuneOfReorigination <= 1.5",
			"player.Rip > 4",
			}},
			
			{"106832", {	
			"player.Thrash <= 3",
			"player.Rip > 4",
			"player.RakeTime > 3",
			}},
		},{
		"!player.buff(135700)",
		"player.buff(768)",
		"player.level >= 28",
		--"player.power >= 50",
		"target.range < 8",
		"target.ttd >= 6",
		}},
	
		{{				
			{"5185", "player.buff(69369).duration < 1.5", "lowest"},
			
			{"5185", "player.combopoints >= 4", "lowest"},
		},{
		"player.buff(69369)",	
		"!player.buff(145152)",	
	--	"player.level >= 26"
		}},
		
		{ "pause", {
		"player.combopoints >= 4", 
		"player.buff(69369)", 
		"!player.buff(145152)", 
	--	"player.level >= 26"
		}},
		
		{{					
			{{
				{"5185", "target.ttd <= 4" },
				
				{"5185", {
				"player.Rip > 0",
				"player.Rip <= 4"
				}},
			}, "target.health <= 25" },
			
		},{
		"player.buff(69369)",	
		"!player.buff(145152)",
		"player.buff(768)",
		"player.power >= 25",
		--"player.RuneOfReorigination = 0",
		"player.SavageRoar > 0",
		"target.enemy",
		"target.alive",
		"target.range < 8"
		}},
		
		{{					
			{{
				{"22568", "target.ttd <= 4" },
				
				{"22568", {
				"player.Rip > 0",
				"player.Rip <= 4"
				}},
			}, "target.health <= 25" },
			
			{"22568", {
			"player.RipDamagePercent < 108",
			"player.Rip > 6",
			"player.combopoints >= 5",
			"player.power >= 50"
			}},
		},{
		"player.buff(768)",
		"player.power >= 25",
		--"player.RuneOfReorigination = 0",
		"player.SavageRoar > 0",
		"target.enemy",
		"target.alive",
		"target.range < 8"
		}, "target"},
			
		
		{{				
			{"1079", {	
			"player.combopoints = 4", 
			"player.RipDamagePercent >= 95",
			"target.ttd > 30",
			"player.RuneOfReorigination > 0",
			"player.RuneOfReorigination <= 1.5",
			}, "target"},
			
			{{
				{"1079", "player.Rip = 0", "target"},
				
				{{
					{"1079", {	
					"player.Rip < 6",
					"target.health > 25",
					}, "target"},
					
					{"1079", {	
					"player.RipDamagePercent > 108",
					"player.rscbuff = 0",
					}, "target"},
					
					{"1079", {	
					"player.RipDamagePercent > 108",
					"player.rscbuff >= 7",
					}, "target"},
				}, "target.ttd >= 15", },
			}, "player.combopoints >= 5" },
		},{
		"player.ctime > 5",
		"player.level >= 20",
		"player.SavageRoar > 1",
		"target.ttd > 4",
		}},
		
		{{			
			{"1822", {		
			"player.RuneOfReorigination > 0.5",
			"player.RakeTime < 9",
			"player.RuneOfReorigination <= 1.5",
			}, "target"}, 
			
			{"1822", "player.RakeTime < 3", "target"},
			
			{"1822", {		
			"player.Rake2",
			"player.rscbuff = 0",
			}, "target"},
			
			{"1822", {	
			"player.Rake2",
			"player.rscbuff >= 9",
			}, "target"},
			
		},{
		"player.combopoints < 5",
		"target.range < 8",
		"player.SavageRoar > 1",
		"player.power >= 35",
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
			"player.Shred",
			"player.power >= 45",
			"!player.buff(102543)",
			}},
			
			{"33876", {		
			"player.power >= 35",
			"!player.buff(102543)",
			}},
		},{
		"player.buff(768)",
		"target.range < 8",
		"player.combopoints < 5",
		"target.enemy",
		"target.alive",
		}, "target"},
	 }, "!modifier.multitarget"},
 
 },
-----------------------------------------------------------------------------------------------------------------------------
-- Out of Combat ------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
 {	

	{ "1126", (function() return Soapbox.Stats() end) }, 
	
	{ "1126", (function() return Soapbox.RaidStats() end), "member" }, 
		
	{"1066", { 
	"player.swimming", 
	"!player.buff(1066)" 
	}, "player"},

	{"50769", {
	"mouseover.exists",
	"mouseover.dead",
	"mouseover.isPlayer",
	"mouseover.range < 40",
	"player.level >= 12"
	}, "mouseover"},
				
	{"2782", "player.dispellable(2782)" },
 
			
	{"768", {
	"target.exists", 
	"target.alive", 
	"target.enemy",
	"!player.buff(768)",
	"player.health > 20",
	"!modifier.last(768)"
	}},
 
	{"774", {
	"!player.buff(5215)",	
	"!player.buff(80169)",	
	"!player.buff(87959)",	
	"!player.casting",
	"player.alive",
	"!player.buff(774)",
	"player.health <= 70"
	--"player.level < 26"
	}}, 

	{{				
		{"52610"}, 
		
		{"127538"},
	},{
	"player.SavageRoar <= 1",
	"player.buff(5215)",
	"!player.buff(108292)",
	"player.buff(768)",
	"target.enemy",
	"target.alive",
	"target.range < 10",
	}},
	
--[[	{"5215", {		
	"!player.buff(5215)",
	"target.enemy",
	"target.alive",
	"target.range < 20"
	}}, ]]--
	
	{"6785", {		
	"target.behind",
	"player.buff(5215)",
	"player.SavageRoar > 1",
	"player.power > 98",
	"!target.player",
	"player.combopoints < 5",
	"player.power >= 45",
	"target.enemy",
	"target.alive",
	"target.range < 8",
	}, "target"},
	
	{"9005", {		
	"player.buff(5215)",
	"target.player",
	"target.behind",
	"player.combopoints < 5",
	"player.power >= 50",
	"target.enemy",
	"target.alive",
	"target.range < 8"
	}},
	
	{{				
		{"5221", "target.behind", "target"},
		
		{"114236", {		
		"player.buff(106951)",
		"player.glyph(114234)"
		}, "target"},
	},{
	"player.combopoints < 5",
	"player.power > 98",
	"target.enemy",
	"target.alive",
	"target.range < 8",
	"player.level >= 16"
	}},
			
	{"33876", { 	
	"player.combopoints < 5",
	"player.power > 98",
	"target.enemy",
	"target.alive",
	"target.range < 8"
	}, "target"}, 
	
	{"pause", "player.ctime > 9000"}, 
 },
function()
PossiblyEngine.toggle.create(
    'boss',
    'Interface\\Icons\\Ability_Creature_Cursed_02.png‎',
    'Boss Function Toggle',
	'Enable or Disable Specific Boss Functions to Improve DPS')
PossiblyEngine.toggle.create(
    'defensive',
    'Interface\\Icons\\ability_druid_tigersroar.png‎',
    'Defensive Cooldown Toggle',
	'Enable or Disable the Automatic Management of Defensive Cooldowns')
end)