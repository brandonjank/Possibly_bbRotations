-- PossiblyEngine Rotation
-- Retribution Paladin - WoD 6.0.3
-- Updated on Nov 21st 2014

-- SUGGESTED TALENTS: 2112333
-- SUGGESTED GLYPHS: Glyph of Double Jeopardy, Glyph of Divine Protection, Glyph of Fire From the Heavens, Glyph of the Luminous Charger, Glyph of Righteous Retreat, Glyph of Hand of Sacrifice
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(70, "bbPaladin Retribution", {
-- COMBAT ROTATION
  -- PAUSE
  { "pause", "modifier.lcontrol" },
  { "pause", "player.buff(Food)" },
  { "pause", "modifier.looting" },
  { "pause", "target.buff(Reckless Provocation)" }, -- Iron Docks - Fleshrender
  { "pause", "target.buff(Sanguine Sphere)" }, -- Iron Docks - Enforcers

  -- AUTO TARGET
  { "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
  { "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

  -- FROGGING
  { {
    -- { "Divine Shield", "player.debuff(Gulp Frog Toxin).count > 7" }, -- Divine shield does not work!?
    { "Blessing of Kings", { "!target.friend", "@bbLib.engaugeUnit('Gulp Frog', 30, true)" } },
  },{
    "toggle.frogs",
  } },

  -- INTERRUPTS
  { "Arcane Torrent", { "modifier.interrupt", "target.distance < 8" } },
  { "Rebuke", "modifier.interrupt" }, --TODO: Interrupt at 50% cast

  -- DEFENSIVE COOLDOWNS
  { "Lay on Hands", "player.health < 25" },
  { "Divine Protection", { "player.health < 90", "target.casting.time > 0" } },
  { "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "!player.buff(Hand of Freedom)", "player.state.root" }, "player" },
  { "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "!player.buff(Hand of Freedom)", "player.state.snare" }, "player" },
  { "Sacred Shield", { "talent(3, 3)", "player.health < 100", "!player.buff" } },
  { "#89640", { "modifier.cooldowns", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
  { "#5512", { "modifier.cooldowns", "player.health < 40" } }, -- Healthstone (5512)
  { "#76097", { "modifier.cooldowns", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)
  { "Cleanse", { "!modifier.last", "player.dispellable(Cleanse)" }, "player" }, -- Cleanse Poison or Disease

  -- BossMods
  --{ "Hand of Sacrifice", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.debuff(Assassin's Mark)" }, "mouseover" }, -- Off GCD now

  -- Raid Survivability
  { "Hand of Protection", { "toggle.usehands", "lowest.exists", "lowest.alive", "lowest.friend", "lowest.isPlayer", "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health <= 15" }, "lowest" }, -- TODO: Don't cast on tanks.
  --{ "Hand of Sacrifice", { "tank.exists", "tank.alive", "tank.friend", "tank.range <= 40", "tank.health < 75" }, "tank" }, --TODO: Only if tank is not the player.
  { "Flash of Light", { "talent(3, 1)", "lowest.health < 50", "player.buff(Selfless Healer).count > 2" }, "lowest" },
  --{ "Flash of Light", { "player.health < 60", "!modifier.last" }, "player" },
  --{ "Hand of Purity", "talent(4, 1)", "player" }, -- TODO: Only if dots on player
  -- Hand of Salvation – Prevents a group/raid member from generating threat for a period of time or saves you the embarrassment of ripping aggro when offtanking. Useful for putting on healers when a group of adds spawns and is immediately drawn to them due to passive healing aggro.

  -- MOUSEOVERS
  {{
    { "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.root", "!mouseover.buff" }, "mouseover" },
    { "Hand of Freedom", { "toggle.usehands", "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.snare", "!mouseover.buff", "player.moving" }, "mouseover" },
    { "Hand of Salvation", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "!mouseover.role(tank)", "@bbLib.highThreatOnPlayerTarget(mouseover)" }, "mouseover" },
    { "Cleanse", { "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.dispellable(Cleanse)" }, "mouseover" },
  }, {
    "toggle.mouseovers", "player.health > 50",
  }},

  -- COOLDOWNS / COMMON
  -- actions+=/auto_attack
  -- actions+=/speed_of_light,if=movement.distance>5
  { "Speed of Light", { "player.moving", "target.exists", "target.distance > 5" } },
  -- actions+=/execution_sentence
  { "Execution Sentence", { "player.health <= 70" }, "player" },
  { "Execution Sentence", { "player.health > 70", "target.deathin > 8" }, "target" },
  -- actions+=/lights_hammer
  { "Light's Hammer", "talent(6, 2)", "target.ground" },
  { {
    -- actions+=/potion,name=draenic_strength,if=(buff.bloodlust.react|buff.avenging_wrath.up|target.time_to_die<=40)
    { "#109219", { "toggle.consume", "target.exists", "target.boss", "player.hashero" } }, -- Draenic Strength Potion
    { "#109219", { "toggle.consume", "target.exists", "target.boss", "player.buff(Avenging Wrath)" } }, -- Draenic Strength Potion
    { "#109219", { "toggle.consume", "target.exists", "target.boss", "target.deathin <= 40" } }, -- Draenic Strength Potion
    -- actions+=/holy_avenger,sync=seraphim,if=talent.seraphim.enabled
    { "Holy Avenger", { "talent(7, 2)", "player.buff(Seraphim)" } },
    -- actions+=/holy_avenger,if=holy_power<=2&!talent.seraphim.enabled
    { "Holy Avenger", { "!talent(7, 2)", "player.holypower <= 2" } },
    -- actions+=/avenging_wrath,sync=seraphim,if=talent.seraphim.enabled
    { "Avenging Wrath", { "talent(7, 2)", "player.buff(Seraphim)" } },
    -- actions+=/avenging_wrath,if=!talent.seraphim.enabled
    { "Avenging Wrath", "!talent(7, 2)" },
    -- actions+=/use_item,name=bonemaws_big_toe,if=buff.avenging_wrath.up
    -- actions+=/blood_fury
    { "Blood Fury" },
    -- actions+=/berserking
    { "Berserking" },
    -- actions+=/arcane_torrent
    { "Arcane Torrent", "player.holypower < 5" },
    -- actions+=/seraphim
    { "Seraphim" },
  },{
    "modifier.cooldowns", "target.exists", "target.distance < 5",
  } },

  -- AOE 5+
  { {
    { "Seal of Righteousness", { "!talent(7, 1)", "!player.seal == 2" } },
    -- actions.aoe=divine_storm,if=holy_power=5&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
    { "Divine Storm", { "player.holypower > 4", "!talent(7, 2)" } },
    { "Divine Storm", { "player.holypower > 4", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
    -- actions.aoe+=/exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
    { "Exorcism", { "player.holypower <= 2", "player.buff(Blazing Contempt)", "!player.buff(Holy Avenger)" } },
    -- actions.aoe+=/hammer_of_the_righteous
    { "Hammer of the Righteous" },
    -- actions.aoe+=/judgment,if=talent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5
    { "Judgment", { "talent(7, 1)", "player.buff(Seal of Righteousness)", "player.buff(Liadrin's Righteousness).remains <= 5" } },
    -- actions.aoe+=/hammer_of_wrath
    { "Hammer of Wrath", true, "target" },
    -- actions.aoe+=/divine_storm,if=(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
    { "Divine Storm", "!talent(7, 2)" },
    { "Divine Storm", { "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
    -- actions.aoe+=/exorcism,if=glyph.mass_exorcism.enabled
    { "Exorcism", "player.glyph(122028)" },
    -- actions.aoe+=/judgment
    { "Judgment" },
    -- actions.aoe+=/exorcism
    { "Exorcism" },
    -- actions.aoe+=/holy_prism
    { "Holy Prism", { "talent(6, 1)", "player.health < 70" }, "player" },
    { "Holy Prism", { "talent(6, 1)", "!toggle.limitaoe", "player.health >= 70" }, "target" },
  },{
    "player.area(10).enemies >= 5", "modifier.multitarget",
  } },

  -- CLEAVE 3+
  { {
    { "Seal of Righteousness", { "!talent(7, 1)", "!player.seal == 2" } },
    -- actions.cleave=final_verdict,if=buff.final_verdict.down&holy_power=5
    { "Final Verdict", { "player.holypower > 4", "!player.buff(Final Verdict)" } },
    -- actions.cleave+=/divine_storm,if=holy_power=5&buff.final_verdict.up
    { "Divine Storm", { "player.holypower > 4", "player.buff(Final Verdict)" } },
    -- actions.cleave+=/divine_storm,if=holy_power=5&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)&!talent.final_verdict.enabled
    { "Divine Storm", { "player.holypower > 4", "!talent(7, 3)", "!talent(7, 2)" } },
    { "Divine Storm", { "player.holypower > 4", "!talent(7, 3)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
    -- actions.cleave+=/exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
    { "Exorcism", { "player.holypower <= 2", "player.buff(Blazing Contempt)", "!player.buff(Holy Avenger)" } },
    -- actions.cleave+=/hammer_of_wrath
    { "Hammer of Wrath", true, "target" },
    -- actions.cleave+=/judgment,if=talent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5
    { "Judgment", { "talent(7, 1)", "player.buff(Seal of Righteousness)", "player.buff(Liadrin's Righteousness).remains <= 5" } },
    -- actions.cleave+=/divine_storm,if=(!talent.seraphim.enabled|cooldown.seraphim.remains>4)&!talent.final_verdict.enabled
    { "Divine Storm", { "!talent(7, 3)", "!talent(7, 2)" } },
    { "Divine Storm", { "!talent(7, 3)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
    -- actions.cleave+=/crusader_strike
    { "Crusader Strike" },
    -- actions.cleave+=/final_verdict,if=buff.final_verdict.down
    { "Final Verdict", "!player.buff(Final Verdict)" },
    -- actions.cleave+=/divine_storm,if=buff.final_verdict.up
    { "Divine Storm", "player.buff(Final Verdict)" },
    -- actions.cleave+=/judgment
    { "Judgment" }
    -- actions.cleave+=/exorcism
    { "Exorcism" },
    -- actions.cleave+=/holy_prism
    { "Holy Prism", { "talent(6, 1)", "player.health < 70" }, "player" },
    { "Holy Prism", { "talent(6, 1)", "!toggle.limitaoe", "player.health >= 70" }, "target" },
  },{
    "target.area(8).enemies >= 3", "modifier.multitarget",
  } },

  -- SINGLE TARGET
  { "Seal of Truth", { "!talent(7, 1)", "!player.seal == 1" } },
  -- actions.single=divine_storm,if=buff.divine_crusader.react&holy_power=5&buff.final_verdict.up
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "player.buff(Final Verdict)" } },
  -- actions.single+=/divine_storm,if=buff.divine_crusader.react&holy_power=5&active_enemies=2&!talent.final_verdict.enabled
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "!talent(7, 3)", "player.area(8).enemies = 2" } },
  -- actions.single+=/divine_storm,if=holy_power=5&active_enemies=2&buff.final_verdict.up
  { "Divine Storm", { "player.holypower > 4", "player.buff(Final Verdict)", "player.area(8).enemies = 2" } },
  -- actions.single+=/divine_storm,if=buff.divine_crusader.react&holy_power=5&(talent.seraphim.enabled&cooldown.seraphim.remains<=4)
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "talent(7, 2)", "player.spell(Seraphim).cooldown <= 4" } },
  -- actions.single+=/templars_verdict,if=holy_power=5|buff.holy_avenger.up&holy_power>=3&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
  { "Templar's Verdict", { "player.holypower > 4" } },
  { "Templar's Verdict", { "player.holypower >= 3", "player.buff(Holy Avenger)", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower >= 3", "player.buff(Holy Avenger)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  -- actions.single+=/templars_verdict,if=buff.divine_purpose.react&buff.divine_purpose.remains<4
  { "Templar's Verdict", { "player.buff(Divine Purpose)", "player.buff(Divine Purpose).remains < 4" } },
  -- actions.single+=/divine_storm,if=buff.divine_crusader.react&buff.divine_crusader.remains<4&!talent.final_verdict.enabled
  { "Divine Storm", { "player.buff(Divine Crusader)", "player.buff(Divine Crusader).remains < 4", "!talent(7, 3)" } },
  -- actions.single+=/final_verdict,if=holy_power=5|buff.holy_avenger.up&holy_power>=3
  { "Final Verdict", "player.holypower > 4" },
  { "Final Verdict", { "player.holypower >= 3", "player.buff(Holy Avenger)" } },
  -- actions.single+=/final_verdict,if=buff.divine_purpose.react&buff.divine_purpose.remains<4
  { "Final Verdict", { "player.buff(Divine Purpose)", "player.buff(Divine Purpose).remains < 4" } },
  -- actions.single+=/hammer_of_wrath
  { "Hammer of Wrath", true, "target" },
  -- actions.single+=/judgment,if=talent.empowered_seals.enabled&((seal.truth&buff.maraads_truth.remains<cooldown.judgment.duration*2)|(seal.righteousness&buff.liadrins_righteousness.remains<cooldown.judgment.duration*2))
  -- actions.single+=/exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
  { "Exorcism", { "player.holypower <= 2", "player.buff(Blazing Contempt)", "!player.buff(Holy Avenger)" } },
  -- actions.single+=/seal_of_truth,if=talent.empowered_seals.enabled&buff.maraads_truth.remains<(cooldown.judgment.duration)&buff.maraads_truth.remains<=3
  -- actions.single+=/divine_storm,if=buff.divine_crusader.react&buff.final_verdict.up&(buff.avenging_wrath.up|target.health.pct<35)
  { "Divine Storm", { "player.buff(Divine Crusader)", "player.buff(Final Verdict)", "player.buff(Avenging Wrath)" } },
  { "Divine Storm", { "player.buff(Divine Crusader)", "player.buff(Final Verdict)", "target.health < 35" } },
  -- actions.single+=/final_verdict,if=buff.divine_purpose.react|target.health.pct<35
  { "Final Verdict", "player.buff(Divine Purpose)" },
  { "Final Verdict", "target.health < 35" },
  -- actions.single+=/templars_verdict,if=buff.avenging_wrath.up|target.health.pct<35&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
  { "Templar's Verdict", "player.buff(Avenging Wrath)" },
  { "Templar's Verdict", { "player.buff(Avenging Wrath)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  { "Templar's Verdict", { "target.health < 35", "!talent(7, 2)" } },
  { "Templar's Verdict", { "target.health < 35", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  -- actions.single+=/crusader_strike
  { "Crusader Strike" },
  -- actions.single+=/divine_storm,if=buff.divine_crusader.react&(buff.avenging_wrath.up|target.health.pct<35)&!talent.final_verdict.enabled
  { "Divine Storm", { "!talent(7, 3)", "player.buff(Divine Crusader)", "player.buff(Avenging Wrath)" } },
  { "Divine Storm", { "!talent(7, 3)", "player.buff(Divine Crusader)", "target.health < 35" } },
  -- actions.single+=/divine_storm,if=buff.divine_crusader.react&buff.final_verdict.up
  { "Divine Storm", { "player.buff(Divine Crusader)", "player.buff(Final Verdict)" } },
  -- actions.single+=/final_verdict
  { "Final Verdict" },
  -- actions.single+=/seal_of_righteousness,if=talent.empowered_seals.enabled&buff.liadrins_righteousness.remains<(cooldown.judgment.duration)&buff.liadrins_righteousness.remains<=3
  -- actions.single+=/judgment
  { "Judgment" },
  -- actions.single+=/templars_verdict,if=buff.divine_purpose.react
  { "Templar's Verdict", "player.buff(Divine Purpose)" },
  -- actions.single+=/divine_storm,if=buff.divine_crusader.react&!talent.final_verdict.enabled
  { "Divine Storm", { "player.buff(Divine Crusader)", "!talent(7, 3)" } },
  -- actions.single+=/templars_verdict,if=holy_power>=4&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
  { "Templar's Verdict", { "player.holypower >= 4", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower >= 4", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  -- actions.single+=/exorcism
  { "Exorcism" },
  -- actions.single+=/templars_verdict,if=holy_power>=3&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
  { "Templar's Verdict", { "player.holypower >= 3", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower >= 3", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  -- actions.single+=/holy_prism
  { "Holy Prism", { "talent(6, 1)", "player.health < 71" }, "player" },
  { "Holy Prism", { "talent(6, 1)", "!toggle.limitaoe", "player.health > 70" }, "target" },

},{
-- OUT OF COMBAT ROTATION
  -- PAUSE
  { "pause", "modifier.lcontrol" },

  -- RAID BUFFS
  { "Blessing of Kings", { "!modifier.last", "!player.buffs.stats" } }, -- TODO: If no Monk or Druid in group.
  { "Blessing of Might", { "!modifier.last", "!player.buffs.mastery", "!player.buff(Blessing of Kings)" } },

  -- SEALS
  { "Seal of Truth", { "!player.seal == 1", "!modifier.last" } },

  { {
    { "Blessing of Kings", { "@bbLib.engaugeUnit('Gulp Frog', 30, true)" } },
    { "Judgment", true, "target" },
    { "Reckoning", true, "target" },
  },{
    "toggle.frogs"
  } },

},
function()
  PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Use Mouseovers', 'Automatically cast spells on mouseover targets.')
  PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
  PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to not use AoE spells to avoid breaking CC.')
  PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
  PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks.')
  PossiblyEngine.toggle.create('usehands', 'Interface\\Icons\\spell_holy_sealofprotection', 'Use Hands', 'Toggles usage of Hand spells such as Hand of Protection.')
  PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
