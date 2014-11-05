-- PossiblyEngine Rotation
-- Shadow Priest - WoD 6.0.3
-- Updated on Nov 4th 2014

-- PLAYER CONTROLLED (TODO): Levitate, Shackle Undead, Mass Dispel, Dispel Magic, Purify, Fear Ward, Void Tendrils
-- TALENTS: Desperate Prayer, Body and Soul, Mindbender, Void Tendrils, Power Infusion, Halo
-- GLYPHS: Glyph of Fade, Glyph of Mind Flay, Glyph of Dispersion
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(258, "bbPriest Shadow", {
-- COMBAT ROTATION
  -- Pause Rotation
  { "pause", "modifier.lalt" },
  { "pause", "player.buff(Food)" },

  -- FORMS
  { "Shadowform", { "timeout(Shadowform, 5)", "!player.buff(Shadowform)" } },

  -- DISPELLS
  { "Dispel", { "toggle.dispel", "player.debuff(Aqua Bomb)" }, "player" }, -- Proving Grounds
  { "Dispel", { "toggle.dispel", "player.debuff(Shadow Word: Bane)" }, "player" }, -- Fallen Protectors
  { "Dispel", { "toggle.dispel", "player.debuff(Lingering Corruption)" }, "player" }, -- Norushen
  { "Dispel", { "toggle.dispel", "player.debuff(Mark of Arrogance)", "player.buff(Power of the Titans)" }, "player" }, -- Sha of Pride
  { "Dispel", { "toggle.dispel", "player.debuff(Corrosive Blood)" }, "player" }, -- Thok

  -- DEFENSIVE COOLDOWNS
  { "Psychic Scream", { "talent(4, 2)", "player.area(8).enemies > 1" } },
  { "Fade", "player.state.stun" },
  { "Fade", "player.state.root" },
  { "Fade", "player.state.snare" },
  { "Fade", "player.area(1).enemies > 1" },

  -- HEALING
  { "Desperate Prayer", { "talent(1, 1)", "player.health < 78" }, "player" },
  { "Prayer of Mending", { "!player.moving", "player.health < 90", "!player.buff(Prayer of Mending)" }, "player" },
  { "Power Word: Shield", { "!player.debuff(Weakened Soul)" }, "player" },
  { "Flash Heal", { "!player.moving", "player.health < 50" }, "player" },

  -- FROGGING
  { {
    { "Power Word: Fortitude", { "@bbLib.engaugeUnit('Gulp Frog', 40, true)" } },
  },{
    "toggle.frogs"
  } },

  -- DPS COOLDOWNS
  { "Shadowfiend", "!talent(3, 2)" },
  { "Mindbender", "talent(3, 2)" },
  { "Power Infusion", { "!player.moving", "talent(5, 2)" } },
  -- Vampiric Embrace Use at the discretion of your party/raid leader for group healing.

  -- DPS ROATATION
  { "Mind Sear", { "!player.moving", "target.area(10).enemies > 4" } },
  { "Devouring Plague", "player.shadoworbs > 2" },
  { "Mind Blast", "player.shadoworbs <= 5" },
  { "Shadow Word: Death", { "target.health < 20", "player.shadoworbs <= 5" } },
  { "Mind Flay", { "!player.moving", "target.debuff(Devouring Plague)" } },
  { "Shadow Word: Pain", "!target.debuff(Shadow Word: Pain)" },
  { "Shadow Word: Pain", "target.debuff(Shadow Word: Pain).duration <= 5" },
  { "Vampiric Touch", { "!player.moving", "!target.debuff(Vampiric Touch)" } },
  { "Vampiric Touch", { "!player.moving", "target.debuff(Vampiric Touch).duration <= 4" } },
  { "Halo", { "talent(6, 3)", "target.exists", "target.range < 30" } },
  { "Mind Sear", { "!player.moving", "target.debuff(Vampiric Touch)", "target.debuff(Vampiric Touch).duration > 5", "target.debuff(Shadow Word: Pain)", "target.debuff(Shadow Word: Pain).duration > 4", "target.area(10).enemies > 1" } },
  { "Mind Flay", { "!player.moving", "target.debuff(Vampiric Touch)", "target.debuff(Vampiric Touch).duration > 5", "target.debuff(Shadow Word: Pain)", "target.debuff(Shadow Word: Pain).duration > 4", "target.area(10).enemies < 2" } },

}, {
-- OUT OF COMBAT ROTATION
  -- PAUSE
  { "pause", "modifier.lalt" },
  { "pause", "player.buff(Food)" },

  -- BUFFS
  { "Power Word: Fortitude", { "!player.buffs.stamina", "lowest.distance < 40" }, "lowest" },

  -- HEAL
  { "Desperate Prayer", { "talent(1, 1)", "player.health < 78" }, "player" },
  { "Prayer of Mending", { "!player.moving", "player.health < 90", "!player.buff(Prayer of Mending)" }, "player" },
  { "Power Word: Shield", { "player.moving", "!player.debuff(Weakened Soul)" }, "player" },
  { "Flash Heal", { "!player.moving", "player.health < 50" }, "player" },
  { "Heal", { "!player.moving", "player.health < 100" }, "player" },

  -- REZ
  -- Mass Resurrection
  { "Resurrection", { "target.exists", "target.dead", "!player.moving", "target.player" }, "target" },

  -- FORMS
  -- Shadowform
  { "Shadowform", { "timeout(Shadowform, 5)", "!player.buff(Shadowform)" } },

  -- AUTO FOLLOW
  { "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "!focus.range < 3", "focus.range < 20" } }, -- TODO: NYI: isFollowing()

  { {
    { "Power Word: Fortitude", { "player.health > 80", "@bbLib.engaugeUnit('Gulp Frog', 40, true)" } },
    { "Devouring Plague", "player.shadoworbs > 2", "target" },
    { "Halo", { "talent(6, 3)", "target.exists", "target.range > 24", "target.range < 30" } },
    { "Shadow Word: Pain", { "target.exists", "!target.debuff(Shadow Word: Pain)" }, "target" },
    { "Shadowfiend", { "target.exists", "!talent(3, 2)" }, "target"  },
    { "Mindbender", { "target.exists", "talent(3, 2)" }, "target"  },
  },{
    "toggle.frogs"
  } },

},
function()
  PossiblyEngine.toggle.create('dispel', 'Interface\\Icons\\ability_shaman_cleansespirit', 'Dispel', 'Toggle Dispel')
  PossiblyEngine.toggle.create('mouseover', 'Interface\\Icons\\spell_nature_resistnature', 'Mouseovers', 'Toggle usage of Mouseover dotting.')
  PossiblyEngine.toggle.create('autofollow', 'Interface\\Icons\\achievement_guildperk_everybodysfriend', 'Auto Follow', 'Automaticaly follows your focus target. Must be another player.')
  PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target un-tapped Gulp Frogs.')
end)
