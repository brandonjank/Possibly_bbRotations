-- PossiblyEngine Rotation
-- Restoration Druid - WoD 6.0.2
-- Updated on Oct 25th 2014

-- PLAYER CONTROLLED:
-- TALENTS: Feline Swiftness, Ysera's Gift, Typhoon, Incarnation: Tree of Life, Mighty Bash, Nature's Vigil
-- GLYPHS: Glyph of Rebirth, Glyph of Healing Touch, Glyph of Rejuvination, Glyph of Grace (minor)
-- CONTROLS: Pause - Left Control

-- TODO: Actually use talents, mouseover rez/rebirth, OOC rotation.

PossiblyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return PossiblyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
})

PossiblyEngine.rotation.register_custom(105, "bbDruid Restoration", {
-- COMBAT ROTATION
  -- Pause Rotation
  { "pause", "modifier.lalt" },
  { "pause", "player.seal = 1" }, -- Bear Form
  { "pause", "player.seal = 3" }, -- Cat Form

  -- BATTLE REZ
  { "Rebirth", { "target.friend", "target.dead" }, "target" },
  { "Rebirth", { "target.friend", "mouseover.dead" }, "mouseover" },

  -- DISPELLS
  { "Nature's Cure", { "toggle.dispel", "mouseover.debuff(Aqua Bomb)" }, "mouseover" }, -- Proving Grounds
  { "Nature's Cure", { "toggle.dispel", "mouseover.debuff(Shadow Word: Bane)" }, "mouseover" }, -- Fallen Protectors
  { "Nature's Cure", { "toggle.dispel", "mouseover.debuff(Lingering Corruption)" }, "mouseover" }, -- Norushen
  { "Nature's Cure", { "toggle.dispel", "mouseover.debuff(Mark of Arrogance)", "player.buff(144364)" }, "mouseover" }, -- Sha of Pride
  { "Nature's Cure", { "toggle.dispel", "mouseover.debuff(Corrosive Blood)" }, "mouseover" }, -- Thok

  -- MOUSEOVER HEALS
  { "Regrowth", { "toggle.mouseover", "!mouseover.buff(Regrowth)", "mouseover.health < 100", "!mouseover.range > 40" }, "mouseover" },
  { "Healing Touch", { "toggle.mouseover", "mouseover.buff(Regrowth)", "mouseover.health < 100", "!mouseover.range > 40" }, "mouseover" },

  -- HEALING COOLDOWNS
  { "Tranquility", "raid.health < 50" },
  { "Genesis", { "raid.health < 70", "lowest.buff(Rejuvination)", "player.spell(Swiftmend).cooldown > 0" }, "lowest" },
  { "Genesis", { "lowest.health < 40", "lowest.buff(Rejuvination)", "player.spell(Swiftmend).cooldown > 0" }, "lowest" },
  { "Ironbark", { "tank.exists", "tank.alive", "tank.health < 70" }, "tank" },
  { "Nature's Swiftness", "lowest.health < 80" },

  -- TANK HEALING
  { "Lifebloom", { "!tank.buff(Lifebloom)", "!focus.buff(Lifebloom)" }, "tank" },
  { "Rejuvination", { "!tank.buff(Rejuvination)" }, "tank" },
  { "Healing Touch", { "tank.exists", "tank.alive", "tank.health < 70" }, "tank" },
  { "Swiftmend", { "tank.health < 90", "lowest.buff(Rejuvination)" }, "tank" },
  { "Swiftmend", { "tank.health < 90", "lowest.buff(Regrowth)" }, "tank" },

  -- HEALING ROTATION
  { "Wild Mushroom", { "timeout(Wild Mushroom, 30)", "!lowest.moving", "@bbLib.NeedHealsAroundUnit('lowest', 3, 10, 90)" }, "lowest" }, -- If Glyph of the Sprouting Mushroom then use NeedHealsAroundUnit with lowest.ground target
  { "Wild Growth", { "timeout(Wild Growth, 8)", "@bbLib.NeedHealsAroundUnit('lowest', 2, 30, 90)" }, "lowest" },
  { "Regrowth", { "lowest.health < 90", "!lowest.buff(Regrowth)", "player.buff(Omen of Clarity)" }, "lowest" },
  { "Swiftmend", "lowest.health < 60", "lowest" },
  { "Swiftmend", { "lowest.health < 80", "lowest.buff(Rejuvination)" }, "lowest" },
  { "Swiftmend", { "lowest.health < 80", "lowest.buff(Regrowth)" }, "lowest" },
  { "Rejuvination", { "!lowest.buff(Rejuvination)", "player.mana > 80" }, "lowest" },
  { "Rejuvination", { "!lowest.buff(Rejuvination)", "lowest.health < 95" }, "lowest" },
  { "Regrowth", { "lowest.health < 60", "!lowest.buff(Regrowth)" }, "lowest" }, -- when no instant cast spells are available,  if Glyph of Regrowth, then replaces Healing Touch
  { "Healing Touch", "player.health < 60", "player" },
  { "Healing Touch", "lowest.health < 60", "lowest" },
  { {
    { "Swiftmend", true, "lowest"},
    { "Regrowth", true, "lowest"},
    { "Healing Touch", true, "lowest"},
  },{ "player.buff(Harmony) < 3", "!lowest.range > 40", } },

}, {
-- OUT OF COMBAT ROTATION
  -- PAUSE
  { "pause", "modifier.lalt" },

  -- BUFFS
  { "Mark of the Wild", { (function() return select(1,GetRaidBuffTrayAuraInfo(1)) == nil end), "lowest.distance <= 30", "player.form = 0" }, "lowest" },

},
function()
  PossiblyEngine.toggle.create('dispel', 'Interface\\Icons\\ability_shaman_cleansespirit', 'Dispel', 'Toggle Dispel')
  PossiblyEngine.toggle.create('mouseover', 'Interface\\Icons\\spell_nature_resistnature', 'Mouseover Regrowth', 'Toggle Mouseover Regrowth For SoO NPC Healing')
end)
