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
  { "Desperate Prayer", { "talent(1, 1)", "player.health < 80" }, "player" },
  { "Power Word: Shield", { "player.health < 100", "!player.debuff(Weakened Soul)" }, "player" },
  --{ "Penance", "player.health < 80", "player" },
  --{ "Flash Heal", "player.health < 70", "player" },
  --{ "Heal", "player.health < 90", "player" },
  -- Prayer of Healing is your go-to AoE heal. To make optimal use of it, the members of your target's party must be significantly damaged.
  -- Holy Nova is another AoE heal that does a surprisingly good amount of healing. As an added bonus, this can be cast while moving.
  --{ "Holy Nova", { "!modifer.last", "@bbLib.NeedHealsAroundUnit('player', 3, 12, 90)" } },
  --{ "Flash Heal", { "lowest.exists", "lowest.health < 90", "player.buff(Surge of Light)" }, "lowest" },

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

  -- REZ
  { "Revive", { "target.exists", "target.dead", "!player.moving", "target.player" }, "target" },

  -- HEAL
  --{ "Flash Heal", { "lowest.exists", "lowest.health < 70" }, "lowest" },
  --{ "Heal", { "lowest.exists", "lowest.health < 100" }, "lowest" },

  -- REZ
  { "Resurrection", { "target.exists", "target.dead", "!player.moving", "target.player" }, "target" },
  { "Resurrection", { "party1.exists", "party1.dead", "!player.moving", "party1.range < 35" }, "party1" },
  { "Resurrection", { "party2.exists", "party2.dead", "!player.moving", "party2.range < 35" }, "party2" },
  { "Resurrection", { "party3.exists", "party3.dead", "!player.moving", "party3.range < 35" }, "party3" },
  { "Resurrection", { "party4.exists", "party4.dead", "!player.moving", "party4.range < 35" }, "party4" },

  -- FORMS
  -- Shadowform
  { "Shadowform", { "timeout(Shadowform, 5)", "!player.buff(Shadowform)" } },

  -- AUTO FOLLOW
  { "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "!focus.range < 3", "focus.range < 20" } }, -- TODO: NYI: isFollowing()

  { {
    { "Power Word: Fortitude", { "@bbLib.engaugeUnit('Gulp Frog', 40, true)" } },
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
