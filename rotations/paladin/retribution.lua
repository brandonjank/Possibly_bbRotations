-- PossiblyEngine Rotation
-- Protection Paladin - WoD 6.0.2
-- Updated on Oct 25th 2013

-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS: Long Arm of the Law, Repentance, Selfless Healer, Unbreakable Spirit, Sanctified Wrath, Execution Sentence
-- SUGGESTED GLYPHS: Glyph of Judgment, Glyph of Templar's Verdict, Glyph of Divine Storm
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
    { "Arcane Torrent", "player.holypower < 5" },
    { "Seraphim" },
  },{
    "target.exists", "target.distance < 5",
  } },

  -- AOE 5+
  { {
    { "Seal of Righteousness", { "!talent(7, 1)", "!player.seal == 2" } },
    { "Divine Storm", { "player.holypower > 4", "!talent(7, 2)" } },
    { "Divine Storm", { "player.holypower > 4", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
    { "Exorcism", { "player.holypower < 3", "player.buff(Blazing Contempt)", "!player.buff(Holy Avenger)" } },
    { "Hammer of the Righteous" },
    --actions.aoe+=/judgment,if=talent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5
    { "Hammer of Wrath", true, "target" },
    { "Divine Storm", "!talent(7, 2)" },
    { "Divine Storm", { "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
    { "Exorcism", "player.glyph(122028)" },
    { "Judgment" },
    { "Exorcism" },
    { "Holy Prism", { "talent(6, 1)", "player.health < 71" }, "player" },
    { "Holy Prism", { "talent(6, 1)", "!toggle.limitaoe", "player.health > 70" }, "target" },
  },{
    "target.area(8).enemies > 4",
  } },

  -- CLEAVE 3+
  { {
    { "Seal of Righteousness", { "!talent(7, 1)", "!player.seal == 2" } },
    { "Final Verdict", { "player.holypower > 4", "!player.buff(Final Verdict)" } },
    { "Divine Storm", { "player.holypower > 4", "player.buff(Final Verdict)" } },
    { "Divine Storm", { "player.holypower > 4", "!talent(7, 3)", "!talent(7, 2)" } },
    { "Divine Storm", { "player.holypower > 4", "!talent(7, 3)", "talent(7, 2)", "player.spell(Seraphim).cooldown <= 4" } },
    { "Exorcism", { "player.holypower < 3", "player.buff(Blazing Contempt)", "!player.buff(Holy Avenger)" } },
    { "Hammer of Wrath", true, "target" },
    --actions.cleave+=/judgment,if=talent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5
    { "Divine Storm", { "!talent(7, 3)", "!talent(7, 2)" } },
    { "Divine Storm", { "!talent(7, 3)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
    { "Crusader Strike" },
    { "Divine Storm", "player.buff(Final Verdict)" },
    { "Judgment" },
    { "Exorcism" },
    { "Holy Prism", { "talent(6, 1)", "player.health < 71" }, "player" },
    { "Holy Prism", { "talent(6, 1)", "!toggle.limitaoe", "player.health > 70" }, "target" },
  },{
    "target.area(8).enemies > 2",
  } },

  -- SINGLE TARGET
  { "Seal of Truth", { "!talent(7, 1)", "!player.seal == 1" } },
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "player.buff(Final Verdict)" } },
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "!talent(7, 3)" } },
  { "Divine Storm", { "player.holypower > 4", "player.buff(Final Verdict)" } },
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Crusader)", "talent(7, 2)", "player.spell(Seraphim).cooldown <= 4" } },
  { "Templar's Verdict", { "player.holypower > 4" } },
  { "Templar's Verdict", { "player.holypower > 2", "player.buff(Holy Avenger)", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower > 2", "player.buff(Holy Avenger)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  { "Templar's Verdict", { "player.buff(Divine Purpose)", "player.buff(Divine Purpose).duration < 4" } },
  { "Final Verdict", "player.holypower > 4" },
  { "Final Verdict", { "player.holypower > 2", "player.buff(Holy Avenger)" } },
  { "Final Verdict", { "player.buff(Divine Purpose)", "player.buff(Divine Purpose).duration < 4" } },
  { "Hammer of Wrath", true, "target" },
-- judgment,if=talent.empowered_seals.enabled&((seal.truth&buff.maraads_truth.remains<cooldown.judgment.duration*2)|(seal.righteousness&buff.liadrins_righteousness.remains<cooldown.judgment.duration*2))
  { "Exorcism", { "player.holypower < 3", "player.buff(Blazing Contempt)", "!player.buff(Holy Avenger)" } },
-- seal_of_truth,if=talent.empowered_seals.enabled&buff.maraads_truth.remains<(cooldown.judgment.duration)&buff.maraads_truth.remains<=3
  { "Divine Storm", { "player.buff(Divine Crusader)", "player.buff(Final Verdict)" } },
  { "Final Verdict", "player.buff(Divine Purpose)" },
  { "Templar's Verdict", { "player.buff(Avenging Wrath)", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.buff(Avenging Wrath)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  { "Templar's Verdict", { "talent(5, 3)", "!talent(7, 2)" } },
  { "Templar's Verdict", { "talent(5, 3)", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  { "Divine Storm", { "talent(5, 3)", "player.buff(Divine Crusader)", "!talent(7, 3)" } },
  { "Crusader Strike" },
  { "Final Verdict" },
-- seal_of_righteousness,if=talent.empowered_seals.enabled&buff.liadrins_righteousness.remains<(cooldown.judgment.duration)&buff.liadrins_righteousness.remains<=3
  { "Judgment" },
  { "Divine Storm", { "player.buff(Divine Crusader)", "!talent(7, 3)" } },
  { "Templar's Verdict", { "player.holypower > 3", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower > 3", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
  { "Exorcism" },
  { "Templar's Verdict", { "player.holypower > 2", "!talent(7, 2)" } },
  { "Templar's Verdict", { "player.holypower > 2", "talent(7, 2)", "player.spell(Seraphim).cooldown > 4" } },
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
