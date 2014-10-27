-- PossiblyEngine Rotation Packager
-- Frost Death Knight - WoD 6.0.2
-- Updated on Oct 25th 2014

-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Death and Decay - Left Shift,  Death Grip Mouseover - Left Alt, Anti-Magic Zone - Right Shift, Army of the Dead - Right Control

PossiblyEngine.condition.register('twohand', function(target)
  return IsEquippedItemType("Two-Hand")
end)

PossiblyEngine.condition.register('onehand', function(target)
  return IsEquippedItemType("One-Hand")
end)

PossiblyEngine.rotation.register_custom(251, "bbDeathKnight Frost", {
-- COMBAT ROTATION
  -- PAUSE
  { "pause", "modifier.lcontrol" },

  -- AUTO TARGET
  { "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
  { "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

  -- FROGGING
  { {
    { "Path of Frost", "@bbLib.engaugeUnit('Gulp Frog', 30, false)" },
  }, "toggle.frogs" },

  -- Blood Tap
  { {
    { "Blood Tap", "player.runes(unholy).count = 0" },
    { "Blood Tap", "player.runes(frost).count = 0" },
    { "Blood Tap", "player.runes(death).count = 0" },
  },{
    "player.buff(Blood Charge).count >= 5",
    "player.runes(death).count = 0"
  } },

  -- Survival
  { "Icebound Fortitude", "player.health <= 45" },
  { "Anti-Magic Shell", "player.health <= 45" },

  -- Interrupts
  { "Mind Freeze", "modifier.interrupts" },
  { "Strangualte", {  "modifier.interrupts", "!modifier.last(Mind Freeze)" } },

  { "Defile", "modifier.shift", "ground" },
  { "Chains of Ice", "modifier.control" },

  -- Cooldowns
  { "Pillar of Frost", "modifier.cooldowns" },
  { "Raise Dead", { "modifier.cooldowns", "player.buff(Pillar of Frost)" } },
  { "Empower Rune Weapon", { "modifier.cooldowns", "player.runicpower <= 70", "player.runes(unholy).count = 0", "player.runes(frost).count = 0", "player.runes(death).count = 0" } },

  -- Disease Control
  { "Unholy Blight", "player.enemies(10) > 3" },
  { {
    { {
      { "Plague Leech", "player.runes(unholy).count = 0" },
      { "Plague Leech", "player.runes(frost).count = 0" },
      { "Plague Leech", "player.runes(death).count = 0" },
    }, "player.spell(Outbreak).cooldown = 0" },
    { {
      { "Plague Leech", "player.runes(unholy).count = 0" },
      { "Plague Leech", "player.runes(frost).count = 0" },
      { "Plague Leech", "player.runes(death).count = 0" },
    }, "target.debuff(Blood Plague).duration < 6" },
  },{
    "target.debuff(Blood Plague)",
    "target.debuff(Frost Fever)"
  } },
  { "Outbreak", { "target.debuff(Frost Fever).duration < 3", "target.debuff(Blood Plague).duration < 3" }, "target" },
  { "Howling Blast", "target.debuff(Frost Fever).duration < 3" },
  { "Plague Strike", { "target.debuff(Blood Plague).duration < 3", "player.runes(unholy).count >= 1" } },
  --{ "Unholy Blight", (function() return UnitsAroundUnit('target', 10) >= 4 end) },
  { "Death and Decay", "modifier.shift", "target.ground" },

  -- DW Rotation
  { {
    -- AoE
    { {
      { "Pestilence", "modifier.last(Outbreak)" },
      { "Pestilence", "modifier.last(Plague Strike)" },
      { "Howling Blast" },
      { "Frost Strike", "player.runicpower >= 75" },
      { "Death and Decay", "target.ground" },
      { "Plague Strike", { "player.runes(unholy).count = 2", "player.spell(Death and Decay).cooldown" } },
      { "Frost Strike" },
    }, "modifier.multitarget" },

    -- Single Target
    { {
      { "Frost Strike", "player.buff(Killing Machine)" },
      { "Frost Strike", "player.runicpower > 88" },
      { "Howling Blast", "player.runes(death).count > 1" },
      { "Howling Blast", "player.runes(frost).count > 1" },
      --{ "Unholy Blight", "target.debuff(Frost Fever).duration < 3" },
      --{ "Unholy Blight", "target.debuff(Blood Plague).duration < 3" },
      { "Soul Reaper", "target.health < 35" },
      { "Howling Blast", "player.buff(Freezing Fog)" },
      { "Frost Strike", "player.runicpower > 76" },
      { "Death Strike", "player.buff(Dark Succor)" },
      { "Death Strike", "player.health <= 65" },
      { "Obliterate", { "player.runes(unholy).count > 0", "!player.buff(Killing Machine)" } },
      { "Howling Blast" },
      -- actions.single_target+=/frost_strike,if=talent.runic_empowerment.enabled&unholy=1
      -- actions.single_target+=/blood_tap,if=talent.blood_tap.enabled&(target.health.pct-3*(target.health.pct%target.time_to_die)>35|buff.blood_charge.stack>=8)
      { "Frost Strike", "player.runicpower >= 40" },
    }, "!modifier.multitarget" },
  }, "player.onehand" },


-- 2H Rotation
  { {
    -- AoE
    { {
      { "Blood Tap", { "player.buff(Blood Charge).count >= 5", "!player.runes(blood).count == 2", "!player.runes(frost).count == 2", "!player.runes(unholy).count == 2" } },
      { "Pestilence", { "target.debuff(Blood Plague) >= 28", "!modifier.last" } },
      { "Howling Blast" },
      { "Frost Strike", "player.runicpower >= 75" },
      { "Defile", "modifier.shift", "ground" },
      { "Plague Strike", { "player.runes(unholy).count = 2", "player.spell(Death and Decay).cooldown" } },
      { "Frost Strike" },
    }, "modifier.multitarget" },

    -- Single Target
    {{
      { "Soul Reaper", "target.health < 35" },
      { "Howling Blast", "player.buff(Freezing Fog)" },
      {{
        { "Death Strike", "player.buff(Killing Machine)" },
        { "Seath Strike", "player.runicpower <= 75" },
      }, "player.health <= 65"},
      {{
        { "Obliterate", "player.buff(Killing Machine)" },
        { "Obliterate", "player.runicpower <= 75" },
      }, "player.health > 65"},
      { "Blood Tap", "player.buff(Blood Charge).count >= 5" },
      { "Frost Strike", "!player.buff(Killing Machine)" },
      { "Frost Strike", "player.spell(Obliterate).cooldown >= 4" },
    }, "!modifier.multitarget" },

  }, "player.twohand" },

},{
-- OUT OF COMBAT ROTATION
  -- Buffs
  { "Frost Presence", "!player.buff(Frost Presence)" },
  { "Horn of Winter", "!player.buff(Horn of Winter).any" },
  { "Path of Frost", { "!player.buff(Path of Frost).any", "@bbLib.isMounted" } },

  -- Keybinds
  { "Army of the Dead", { "target.boss", "modifier.rshift" } },
  { "Death Grip", "modifier.lalt" },

  -- FROGGING
  { {
    { "Path of Frost", "@bbLib.engaugeUnit('Gulp Frog', 30, false)" },
    { "Death Grip", true, "target" },
    { "Mind Freeze", true, "target" },
    { "Chains of Ice", true, "target" },
  },{
    "toggle.frogs",
  } },

},
function ()
  PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
  PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
  PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
  PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
  PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
  PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
