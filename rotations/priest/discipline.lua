-- PossiblyEngine Rotation
-- Discipline Priest - WoD 6.0.3
-- Updated on Nov 4th 2014

-- PLAYER CONTROLLED (TODO): Leap of Faith, Levitate, Shackle Undead, Mass Dispel, Dispel Magic, Purify, Fear Ward
-- TALENTS: Desperate Prayer, Body and Soul, Surge of Light, Psychic Scream, Power Infusion, Cascade
-- GLYPHS: Glyph of Penance, Glyph of Weakened Soul, Glyph of Prayer of Mending or Glyph of Mass Dispel
-- CONTROLS: Pause - Left Control

-- TODO: Actually use talents, mouseover rez/rebirth, OOC rotation.

PossiblyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return PossiblyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
})

PossiblyEngine.rotation.register_custom(256, "bbPriest Discipline", {
-- COMBAT ROTATION
  -- Pause Rotation
  { "pause", "modifier.lalt" },
  { "pause", "player.buff(Food)" },

  -- DISPELLS
  { "Dispel", { "toggle.dispel", "mouseover.debuff(Aqua Bomb)" }, "mouseover" }, -- Proving Grounds
  { "Dispel", { "toggle.dispel", "mouseover.debuff(Shadow Word: Bane)" }, "mouseover" }, -- Fallen Protectors
  { "Dispel", { "toggle.dispel", "mouseover.debuff(Lingering Corruption)" }, "mouseover" }, -- Norushen
  { "Dispel", { "toggle.dispel", "mouseover.debuff(Mark of Arrogance)", "player.buff(Power of the Titans)" }, "mouseover" }, -- Sha of Pride
  { "Dispel", { "toggle.dispel", "mouseover.debuff(Corrosive Blood)" }, "mouseover" }, -- Thok

  -- DEFENSIVE COOLDOWNS
  { "Psychic Scream", { "talent(4, 2)", "player.area(8).enemies > 1" } },
  { "Fade", "player.state.stun" },
  { "Fade", "player.state.root" },
  { "Fade", "player.state.snare" },
  { "Fade", "player.area(1).enemies > 1" },

  -- HEALING COOLDOWNS
  -- Pain Suppression should be used on a tank, before a damage spike. Alternatively, it can be used on a raid member who is targeted by a very damaging ability.
  -- Power Word: Barrier should be used to mitigate intense AoE damage; it requires the raid to be stacked in one place.
  { "Power Infusion", { "talent(5, 2)", "@coreHealing.needsHealing(70, 5)" } },
  { "Cascade", { "talent(6, 1)", "lowest.health < 90", "@bbLib.NeedHealsAroundUnit" }, "lowest" },

  -- SELF HEALING
  { "Desperate Prayer", { "talent(1, 1)", "player.health < 80" }, "player" },
  { "Power Word: Shield", { "player.health < 100", "!player.debuff(Weakened Soul)" }, "player" },
  { "Penance", "player.health < 80", "player" },
  { "Flash Heal", "player.health < 70", "player" },
  { "Heal", "player.health < 90", "player" },

  -- RAID HEALING
  -- Prayer of Healing is your go-to AoE heal. To make optimal use of it, the members of your target's party must be significantly damaged.
  -- Holy Nova is another AoE heal that does a surprisingly good amount of healing. As an added bonus, this can be cast while moving.
  { "Holy Nova", { "!modifer.last", "@bbLib.NeedHealsAroundUnit('player', 3, 12, 90)" } },

  -- SURGE OF LIGHT
  { "Flash Heal", { "lowest.exists", "lowest.health < 90", "player.buff(Surge of Light)" }, "lowest" },

  -- PENANCE
  { "Penance", { "focus.exists", "focus.friend", "focus.health < 100" }, "focus" },
  { "Penance", { "tank.exists", "tank.friend", "tank.health < 100" }, "tank" },
  { "Penance", { "boss1target.exists", "boss1target.friend", "boss1target.health < 100" }, "boss1target" },
  { "Penance", { "boss2target.exists", "boss2target.friend", "boss1target.health < 100" }, "boss2target" },
  { "Penance", { "boss3target.exists", "boss3target.friend", "boss1target.health < 100" }, "boss3target" },
  { "Penance", { "boss4target.exists", "boss4target.friend", "boss1target.health < 100" }, "boss4target" },
  { "Penance", { "lowest.exists", "lowest.friend", "lowest.health < 100" }, "lowest" },

  -- PWS
  { "Power Word: Shield", { "focus.exists", "focus.friend", "!focus.debuff(Weakened Soul)" }, "focus" },
  { "Power Word: Shield", { "tank.exists", "tank.friend", "!tank.debuff(Weakened Soul)" }, "tank" },
  { "Power Word: Shield", { "boss1target.exists", "boss1target.friend", "!boss1target.debuff(Weakened Soul)" }, "boss1target" },
  { "Power Word: Shield", { "boss2target.exists", "boss2target.friend", "!boss2target.debuff(Weakened Soul)" }, "boss2target" },
  { "Power Word: Shield", { "boss3target.exists", "boss3target.friend", "!boss3target.debuff(Weakened Soul)" }, "boss3target" },
  { "Power Word: Shield", { "boss4target.exists", "boss4target.friend", "!boss4target.debuff(Weakened Soul)" }, "boss4target" },
  { "Power Word: Shield", { "target.exists", "target.friend", "!target.debuff(Weakened Soul)" }, "target" },
  { "Power Word: Shield", { "lowest.exists", "lowest.health < 100", "!lowest.debuff(Weakened Soul)" }, "lowest" },
  { "Power Word: Shield", { "mouseover.exists", "toggle.mouseover", "mouseover.friend", "!mouseover.debuff(Weakened Soul)" }, "mouseover" },

  -- PRAYER OF MENDING
  { "Prayer of Mending", { "focus.exists", "focus.friend", "!focus.buff(Prayer of Mending)" }, "focus" },
  { "Prayer of Mending", { "tank.exists", "tank.friend", "!tank.buff(Prayer of Mending)" }, "tank" },
  { "Prayer of Mending", { "boss1target.exists", "boss1target.friend", "!boss1target.buff(Prayer of Mending)", "timeout(Prayer of Mending, 30)" }, "boss1target" },
  { "Prayer of Mending", { "boss2target.exists", "boss2target.friend", "!boss2target.buff(Prayer of Mending)", "timeout(Prayer of Mending, 30)" }, "boss2target" },
  { "Prayer of Mending", { "boss3target.exists", "boss3target.friend", "!boss3target.buff(Prayer of Mending)", "timeout(Prayer of Mending, 30)" }, "boss3target" },
  { "Prayer of Mending", { "boss4target.exists", "boss4target.friend", "!boss4target.buff(Prayer of Mending)", "timeout(Prayer of Mending, 30)" }, "boss4target" },

  -- HEALING DUMP
  { "Flash Heal", { "lowest.exists", "lowest.health < 70" }, "lowest" },
  { "Heal", { "lowest.exists", "lowest.health < 100" }, "lowest" },

}, {
-- OUT OF COMBAT ROTATION
  -- PAUSE
  { "pause", "modifier.lalt" },
  { "pause", "player.buff(Food)" },

  -- BUFFS
  { "Power Word: Fortitude", { "!player.buffs.stamina", "lowest.distance < 40" }, "lowest" },

  -- REZ
  { "Resurrection", { "target.exists", "target.dead", "!player.moving", "target.player" }, "target" },
  { "Resurrection", { "party1.exists", "party1.dead", "!player.moving", "party1.range < 35" }, "party1" },
  { "Resurrection", { "party2.exists", "party2.dead", "!player.moving", "party2.range < 35" }, "party2" },
  { "Resurrection", { "party3.exists", "party3.dead", "!player.moving", "party3.range < 35" }, "party3" },
  { "Resurrection", { "party4.exists", "party4.dead", "!player.moving", "party4.range < 35" }, "party4" },

  -- HEAL
  { "Flash Heal", { "lowest.exists", "lowest.health < 70" }, "lowest" },
  { "Heal", { "lowest.exists", "lowest.health < 100" }, "lowest" },

  -- AUTO FOLLOW
  { "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "!focus.range < 3", "focus.range < 20" } }, -- TODO: NYI: isFollowing()

},
function()
  PossiblyEngine.toggle.create('dispel', 'Interface\\Icons\\ability_shaman_cleansespirit', 'Dispel', 'Toggle Dispel')
  PossiblyEngine.toggle.create('mouseover', 'Interface\\Icons\\spell_nature_resistnature', 'Mouseovers', 'Toggle usage of mouseover healing.')
  PossiblyEngine.toggle.create('autofollow', 'Interface\\Icons\\achievement_guildperk_everybodysfriend', 'Auto Follow', 'Automaticaly follows your focus target. Must be another player.')
end)
