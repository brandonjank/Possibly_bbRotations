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

  -- OFF GCD
  { "Templar's Verdict", { "player.holypower > 4", "target.area(8).enemies < 2" } },
  { "Templar's Verdict", { "player.holypower > 4", "player.buff(Divine Purpose)", "target.area(8).enemies < 2" } },
  { "Divine Storm", { "player.holypower > 4", "target.area(8).enemies > 1" } },
  { "Divine Storm", { "player.holypower > 4", "player.buff(Divine Purpose)", "target.area(8).enemies > 1" } },

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

  -- DPS COOLDOWNS
  { "Avenging Wrath", { "target.exists", "target.distance < 5" } },
  { "Holy Avenger", { "talent(5, 1)" , "player.buff(Avenging Wrath)" } },

  -- DPS ROTATION
  -- TODO: 4+ targets replace Seal of Truth with Seal of Righteousness
  { "Hammer of Wrath", "target.health <= 20", "target" },
  { "Hammer of Wrath", "player.buff(Avenging Wrath)", "target" },
  { "Crusader Strike", "target.area(10).enemies < 5" },
  { "Hammer of the Righteous", "target.area(10).enemies > 4" },
  { "Judgment" },
  { "Divine Storm", "player.buff(Divine Storm)" }, --4-Part Tier 16 Set Bonus, and you have a Divine Storm proc from it.
  { "Exorcism" }, -- If have 2set bonus cast if not buff Warrior of the Light
  { "Execution Sentence", { "talent(6, 3)", "player.health < 71" }, "player" },
  { "Execution Sentence", { "talent(6, 3)", "player.health > 70", "target.deathin > 8" }, "target" },
  { "Light's Hammer", "talent(6, 2)", "target.ground" },
  { "Holy Prism", { "talent(6, 1)", "player.health < 71" }, "player" },
  { "Holy Prism", { "talent(6, 1)", "!toggle.limitaoe", "player.health > 70" }, "target" },

},{
-- OUT OF COMBAT ROTATION
  -- PAUSE
  { "pause", "modifier.lcontrol" },

  -- RAID BUFFS
  { "Blessing of Kings", { "!modifier.last", (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil and select(1,GetRaidBuffTrayAuraInfo(8)) == nil end) } }, -- TODO: If no Monk or Druid in group.
  { "Blessing of Might", { "!modifier.last", (function() return select(1,GetRaidBuffTrayAuraInfo(8)) == nil end), "!player.buff(Blessing of Kings)", "!player.buff(Blessing of Might)" } },

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
