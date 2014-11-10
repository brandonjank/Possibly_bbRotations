-- PossiblyEngine Rotation
-- Protection Paladin - WoD 6.0.2
-- Updated on Oct 25th 2013

-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS: Pursuit of Justice, Fist of Justice, Sacred Shield, Unbreakable Spirit, Sanctified Wrath, Execution Sentence
-- SUGGESTED GLYPHS: Glyph of Judgment, Glyph of Templar's Verdict, Glyph of Divine Storm
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(70, "bbPaladin Retribution", {
-- COMBAT ROTATION
  -- Rotation Utilities
  { "pause", "modifier.lcontrol" },

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
  { "Sacred Shield", { "talent(3, 3)", "!player.buff" } },
  { "#89640", { "modifier.cooldowns", "player.health < 40", "!player.buff(130649)", "target.boss" } }, -- Life Spirit (130649)
  { "#5512", { "modifier.cooldowns", "player.health < 40" } }, -- Healthstone (5512)
  { "#76097", { "modifier.cooldowns", "player.health < 15", "target.boss" } }, -- Master Healing Potion (76097)
  { "Cleanse", { "!modifier.last", "player.dispellable(Cleanse)" }, "player" }, -- Cleanse Poison or Disease

  -- BossMods
  { "Hand of Sacrifice", { "toggle.usehands", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.debuff(Assassin's Mark)" }, "mouseover" }, -- Off GCD now

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

  -- COOLDOWNS
  { "Speed of Light", { "player.moving", "target.distance > 5" } },
  { "Execution Sentence", { "talent(6, 3)", "player.health < 71" }, "player" },
  { "Execution Sentence", { "talent(6, 3)", "player.health > 70", "target.deathin > 8" }, "target" },
  { "Light's Hammer", "talent(6, 2)", "target.ground" },
  { {
    -- potion,name=mogu_power,if=(buff.bloodlust.react|buff.avenging_wrath.up|target.time_to_die<=40)
    -- auto_attack
    { "Holy Avenger", { "talent(7, 2)", "player.buff(Seraphim)" } },
    { "Holy Avenger", { "!talent(7, 2)", "player.holypower < 3" } },
    { "Avenging Wrath", { "talent(7, 2)", "player.buff(Seraphim)" } },
    { "Avenging Wrath", "!talent(7, 2)" },
    { "Blood Fury" },
    { "Berserking" },
    { "Arcane Torrent" },
    { "Seraphim" },
  },{
    "target.exists", "target.distance < 5",
  } },

  -- AOE 5+
  { {
    --actions.aoe=divine_storm,if=holy_power=5&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
    --actions.aoe+=/exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
    --actions.aoe+=/hammer_of_the_righteous
    --actions.aoe+=/judgment,if=talent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5
    --actions.aoe+=/hammer_of_wrath
    --actions.aoe+=/divine_storm,if=(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
    --actions.aoe+=/exorcism,if=glyph.mass_exorcism.enabled
    --actions.aoe+=/judgment
    --actions.aoe+=/exorcism
    --actions.aoe+=/holy_prism
  },{
    "target.area(8).enemies > 4",
  } },

  -- CLEAVE 3+
  { {
    --actions.cleave=final_verdict,if=buff.final_verdict.down&holy_power=5
    --actions.cleave+=/divine_storm,if=holy_power=5&buff.final_verdict.up
    --actions.cleave+=/divine_storm,if=holy_power=5&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)&!talent.final_verdict.enabled
    --actions.cleave+=/exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
    --actions.cleave+=/hammer_of_wrath
    --actions.cleave+=/judgment,if=talent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5
    --actions.cleave+=/divine_storm,if=(!talent.seraphim.enabled|cooldown.seraphim.remains>4)&!talent.final_verdict.enabled
    --actions.cleave+=/crusader_strike
    --actions.cleave+=/divine_storm,if=buff.final_verdict.up
    --actions.cleave+=/judgment
    --actions.cleave+=/exorcism
    --actions.cleave+=/holy_prism
  },{
    "target.area(8).enemies > 2",
  } },

  -- SINGLE TARGET
-- divine_storm,if=buff.divine_crusader.react&holy_power=5&buff.final_verdict.up
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "player.buff(Final Verdict)" } },
-- divine_storm,if=buff.divine_crusader.react&holy_power=5&active_enemies=2&!talent.final_verdict.enabled
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "!talent(7, 3)" } },
-- divine_storm,if=holy_power=5&active_enemies=2&buff.final_verdict.up
  { "Divine Storm", { "player.holypower > 4", "player.buff(Final Verdict)" } },
-- divine_storm,if=buff.divine_crusader.react&holy_power=5&(talent.seraphim.enabled&cooldown.seraphim.remains<=4)
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "talent(7, 2)", "player.spell(Seraphim).cooldown <= 4" } },
-- templars_verdict,if=holy_power=5|buff.holy_avenger.up&holy_power>=3&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
  { "Templar's Verdict", { "player.holypower > 4" } },
  { "Templar's Verdict", { "player.holypower > 2", "player.buff(Holy Avenger)", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower > 2", "player.buff(Holy Avenger)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
-- templars_verdict,if=buff.divine_purpose.react&buff.divine_purpose.remains<4
  { "Templar's Verdict", { "player.buff(Divine Purpose)", "player.buff(Divine Purpose).duration < 4" } },
-- final_verdict,if=holy_power=5|buff.holy_avenger.up&holy_power>=3
  { "Final Verdict", "player.holypower > 4" },
  { "Final Verdict", { "player.holypower > 2", "player.buff(Holy Avenger)" } },
-- final_verdict,if=buff.divine_purpose.react&buff.divine_purpose.remains<4
  { "Final Verdict", { "player.buff(Divine Purpose)", "player.buff(Divine Purpose).duration < 4" } },
-- hammer_of_wrath
  { "Hammer of Wrath", true, "target" },
-- judgment,if=talent.empowered_seals.enabled&((seal.truth&buff.maraads_truth.remains<cooldown.judgment.duration*2)|(seal.righteousness&buff.liadrins_righteousness.remains<cooldown.judgment.duration*2))
-- exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
  { "Exorcism", { "player.holypower < 3", "player.buff(Blazing Contempt)", "!player.buff(Holy Avenger)" } },
-- seal_of_truth,if=talent.empowered_seals.enabled&buff.maraads_truth.remains<(cooldown.judgment.duration)&buff.maraads_truth.remains<=3
-- divine_storm,if=buff.divine_crusader.react&buff.final_verdict.up
  { "Divine Storm", { "player.buff(Divine Crusader)", "player.buff(Final Verdict)" } },
-- final_verdict,if=buff.divine_purpose.react
  { "Final Verdict", { "player.buff(Divine Purpose)" } },
-- templars_verdict,if=(buff.avenging_wrath.up|talent.divine_purpose.enabled)&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
  { "Templar's Verdict", { "player.buff(Avenging Wrath)", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.buff(Avenging Wrath)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  { "Templar's Verdict", { "talent(5, 3)", "!talent(7, 2)" } },
  { "Templar's Verdict", { "talent(5, 3)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
-- divine_storm,if=talent.divine_purpose.enabled&buff.divine_crusader.react&!talent.final_verdict.enabled
  { "Divine Storm", { "talent(5, 3)", "player.buff(Divine Crusader)", "!talent(7, 3)" } },
-- crusader_strike
  { "Crusader Strike" },
-- final_verdict
  { "Final Verdict" },
-- seal_of_righteousness,if=talent.empowered_seals.enabled&buff.liadrins_righteousness.remains<(cooldown.judgment.duration)&buff.liadrins_righteousness.remains<=3
-- judgment
  { "Judgment" },
-- divine_storm,if=buff.divine_crusader.react&!talent.final_verdict.enabled
  { "Divine Storm", { "player.buff(Divine Crusader)", "!talent(7, 3)" } },
-- templars_verdict,if=holy_power>=4&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
  { "Templar's Verdict", { "player.holypower > 3", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower > 3", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
-- exorcism
  { "Exorcism" },
-- templars_verdict,if=holy_power>=3&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
  { "Templar's Verdict", { "player.holypower > 2", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower > 2", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
-- holy_prism
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
  --{ "Seal of Truth", { "!player.buff(Seal of Truth)", "!modifier.last" } },

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
