-- PossiblyEngine Rotation Packager
-- Custom Combat Rogue Rotation
-- Created on Dec 25th 2013 1:00 am
PossiblyEngine.rotation.register_custom(260, "bbCombatRogue", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- Racials
	{ "Will of the Forsaken", "player.state.fear" },
	{ "Will of the Forsaken", "player.state.charm" },
	{ "Will of the Forsaken", "player.state.sleep" },
	{ "Rocket Barrage", "player.moving" },
	{ "Quaking Palm", "modifier.interrupts" },
	
	-- TODO: flask=spring_blossoms

	-- TODO: food=sea_mist_rice_noodles

	{ "Deadly Poison", "!player.buff(Deadly Poison)" },

	{ "Leeching Poison", "!player.buff(Leeching Poison)" },

	{ "#5512", { "modifier.cooldowns", "player.health < 40" } }, -- Healthstone (5512)

	{ "#76097", { "modifier.cooldowns", "player.health < 40", "@bbLib.useHealthPot" } }, -- Master Healing Potion (76097)

	-- TODO: stealth

	{ "Marked for Death" },

	{ "Slice and Dice" },

	{ "#76089", { "modifier.cooldowns", "pet.exists", "target.exists", "@bbLib.useAgiPot" } }, -- Agility Potion (76089)

	{ "Kick", "modifier.interrupts" },

	{ "Preparation", { "!player.buff(Vanish)", "player.spell(Vanish).cooldown > 60" } },

	{ "#gloves", { "modifier.cooldowns", "player.buff(Shadow Blades)" } },

	{ "Blood Fury", { "modifier.cooldowns", "player.buff(Shadow Blades)" } },

	{ "Berserking", { "modifier.cooldowns", "player.buff(Shadow Blades)" } },

	{ "Arcane Torrent", "player.energy < 60" },

	{ "Blade Flurry", { "modifier.multitarget", "modifier.enemies >= 2", "!player.buff(Blade Flurry)" } },
	{ "Blade Flurry", { "!modifier.multitarget", "modifier.enemies < 2", "player.buff(Blade Flurry)" } },

	{ "Ambush" },
	
	-- TODO: VANISH
	--{ "Vanish", { "player.time > 10",
	--{ "player.combopoints < 3" OR { "player.spell(Anticipation).exists", "player.buff(Anticipation).count < 3" } OR { "!player.buff(Shadow Blades)", { "player.combopoints < 4" OR {  "player.spell(Anticipation).exists", "player.buff(Anticipation).count < 4" } } } },
	--{ { "player.spell(Shadow Focus).exists", "!player.buff(Adrenaline Rush)", "player.energy < 20" } OR { "player.spell(Subterfuge).exists", "player.energy >= 90" } OR { "!player.spell(Shadow Focus).exists", "!player.spell(Subterfuge).exists", "player.energy >= 60" } }
	--} },

	{ "Shadow Blades", "player.time > 5" },

	{ "Killing Spree", { "modifier.cooldowns", "player.energy < 45", "!player.buff(Adrenaline Rush)" } },

	{ "Adrenaline Rush", "player.energy < 35" },
	{ "Adrenaline Rush", "player.buff(Shadow Blades)" },

	{ "Slice and Dice", "player.buff(Slice and Dice).duration < 2" },
	{ "Slice and Dice", { "player.buff(Slice and Dice).duration < 15", "player.buff(Bandit's Guile).count > 10", "player.combopoints >= 4" } },

	{ "Marked for Death", { "player.combopoints = 0", "target.debuff(Revealing Strike)" } },

	{ "Fan of Knives", { "modifier.multitarget", "modifier.enemies >= 4", "player.combopoints < 5", "modifier.timeout(Fan of Knives, 5)" } },
	{ "Fan of Knives", { "modifier.multitarget", "modifier.enemies >= 4", "player.spell(Anticipation).exists", "player.buff(Anticipation).count <= 4", "!target.debuff(Revealing Strike)" } }, --TODO: player.spell(Fan of Knives).delay(5)

	{ "Revealing Strike", { "target.debuff(Revealing Strike).duration <= 2", "player.combopoints < 5" } },
	{ "Revealing Strike", { "player.spell(Anticipation).exists", "target.debuff(Revealing Strike).duration <= 2", "player.buff(Anticipation).count <= 4", "!target.debuff(Revealing Strike)" } },

	{ "Sinister Strike", "player.combopoints < 5" },
	{ "Sinister Strike", { "player.spell(Anticipation).exists", "player.buff(Anticipation).count <= 4", "!target.debuff(Revealing Strike)" } },

	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "modifier.enemies < 2", "!player.spell(Anticipation).exists" } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "!player.buff(Blade Flurry)", "!player.spell(Anticipation).exists" } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "modifier.enemies < 2", "player.buff(Deep Insight)" } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "!player.buff(Blade Flurry)", "player.buff(Deep Insight)" } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "modifier.enemies < 2", "player.spell(Shadow Blades).cooldown <= 11"  } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "!player.buff(Blade Flurry)", "player.spell(Shadow Blades).cooldown <= 11"  } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "modifier.enemies < 2", "player.buff(Anticipation).count >= 4" } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "!player.buff(Blade Flurry)", "player.buff(Anticipation).count >= 4" } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "modifier.enemies < 2", "player.buff(Shadow Blades)", "player.buff(Anticipation).count >= 3" } },
	{ "Rupture", { "target.debuff(Rupture).duration <= 2", "target.deathin > 25", "!player.buff(Blade Flurry)", "player.buff(Shadow Blades)", "player.buff(Anticipation).count >= 3" } },

	{ "Crimson Tempest", { "modifier.enemies >= 7", "target.debuff(Crimson Tempest).duration <= 2", "!player.spell(Anticipation).exists" } },
	{ "Crimson Tempest", { "modifier.enemies >= 7", "target.debuff(Crimson Tempest).duration <= 2", "player.buff(Deep Insight)" } },
	{ "Crimson Tempest", { "modifier.enemies >= 7", "target.debuff(Crimson Tempest).duration <= 2", "player.spell(Shadow Blades).cooldown <= 11" } },
	{ "Crimson Tempest", { "modifier.enemies >= 7", "target.debuff(Crimson Tempest).duration <= 2", "player.buff(Anticipation).count >= 4" } },
	{ "Crimson Tempest", { "modifier.enemies >= 7", "target.debuff(Crimson Tempest).duration <= 2", "player.buff(Shadow Blades)", "player.buff(Anticipation).count >= 3" } },

	{ "Eviscerate", "!player.spell(Anticipation).exists" },
	{ "Eviscerate", "player.buff(Deep Insight)" },
	{ "Eviscerate", "player.spell(Shadow Blades).cooldown <= 11" },
	{ "Eviscerate", "player.buff(Anticipation).count >= 4" },
	{ "Eviscerate", { "player.buff(Shadow Blades)", "player.buff(Anticipation).count >= 3" } },

	{ "Fan of Knives", { "modifier.multitarget", "modifier.enemies >= 4", "player.energy > 60" } }, --TODO: player.spell(Fan of Knives).delay(5)
	{ "Fan of Knives", { "modifier.multitarget", "modifier.enemies >= 4", "!player.buff(Deep Insight)" } }, --TODO: player.spell(Fan of Knives).delay(5)
	{ "Fan of Knives", { "modifier.multitarget", "modifier.enemies >= 4", "player.buff(Deep Insight).duration > 3" } }, --TODO: player.spell(Fan of Knives).delay(5) AND player.buff(Deep Insight).duration > 5 - player.combopoints
	
	{ "Revealing Strike", { "target.debuff(Revealing Strike).duration <= 2", "player.energy > 60" } },
	{ "Revealing Strike", { "target.debuff(Revealing Strike).duration <= 2", "!player.buff(Deep Insight)" } },
	{ "Revealing Strike", { "target.debuff(Revealing Strike).duration <= 2", "player.buff(Deep Insight).duration > 3" } }, --TODO: player.buff(Deep Insight).duration > 5 - player.combopoints
	
	{ "Sinister Strike", "player.energy > 60" },
	{ "Sinister Strike", "!player.buff(Deep Insight)" },
	{ "Sinister Strike", "player.buff(Deep Insight).duration > 3" }, --TODO: player.buff(Deep Insight).duration > 5 - player.combopoints

},{
-- OUT OF COMBAT
	-- Poisons
	{ "Deadly Poison", { "!player.moving", "!player.buff(Deadly Poison)" } },
	{ "Leeching Poison", { "!player.moving", "!player.buff(Leeching Poison)" } },

})
