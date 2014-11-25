-- PossiblyEngine Rotation
-- Unholy Death Knight - WoW WoD 6.0.3
-- Updated on Nov 24th 2014

-- SUGGESTED TALENTS: 2003002
-- SUGGESTED GLYPHS:
-- CONTROLS: Pause - Left Control,

PossiblyEngine.rotation.register_custom(251, "bbDeathKnight Unholy", {
  -- COMBAT ROTATION
  -- PAUSES
  { "pause", "modifier.lcontrol" },
  { "pause", "@bbLib.bossMods" },

  -- AUTO TARGET
  { "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
  { "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

  -- FROGGING
  { {
    { "Path of Frost", "@bbLib.engaugeUnit('ANY', 30, false)" },
  }, "toggle.frogs" },


  -- Survival
  { "Icebound Fortitude", "player.health <= 45" },
  { "Anti-Magic Shell", "player.health <= 45" },

  -- Interrupts
  { "Mind Freeze", "modifier.interrupts" },
  { "Strangualte", {  "modifier.interrupts", "!modifier.last(Mind Freeze)" } },

  { "Defile", "modifier.shift", "ground" },
  { "Chains of Ice", "modifier.control" },


  -- actions=auto_attack
  -- actions+=/deaths_advance,if=movement.remains>2
  -- actions+=/antimagic_shell,damage=100000
  -- actions+=/blood_fury
  -- actions+=/berserking
  -- actions+=/arcane_torrent
  -- actions+=/potion,name=draenic_strength,if=buff.dark_transformation.up&target.time_to_die<=60
  -- actions+=/run_action_list,name=aoe,if=active_enemies>=2
  -- actions+=/run_action_list,name=single_target,if=active_enemies<2
  --
  -- actions.aoe=unholy_blight
  -- actions.aoe+=/run_action_list,name=spread,if=!dot.blood_plague.ticking|!dot.frost_fever.ticking
  -- actions.aoe+=/defile
  -- actions.aoe+=/breath_of_sindragosa,if=runic_power>75
  -- actions.aoe+=/run_action_list,name=bos_aoe,if=dot.breath_of_sindragosa.ticking
  -- actions.aoe+=/blood_boil,if=blood=2|(frost=2&death=2)
  -- actions.aoe+=/summon_gargoyle
  -- actions.aoe+=/dark_transformation
  -- actions.aoe+=/blood_tap,if=buff.shadow_infusion.stack=5
  -- actions.aoe+=/defile
  -- actions.aoe+=/death_and_decay,if=unholy=1
  -- actions.aoe+=/soul_reaper,if=target.health.pct-3*(target.health.pct%target.time_to_die)<=45
  -- actions.aoe+=/scourge_strike,if=unholy=2
  -- actions.aoe+=/blood_tap,if=buff.blood_charge.stack>10
  -- actions.aoe+=/death_coil,if=runic_power>90|buff.sudden_doom.react|(buff.dark_transformation.down&rune.unholy<=1)
  -- actions.aoe+=/blood_boil
  -- actions.aoe+=/icy_touch
  -- actions.aoe+=/scourge_strike,if=unholy=1
  -- actions.aoe+=/death_coil
  -- actions.aoe+=/blood_tap
  -- actions.aoe+=/plague_leech
  -- actions.aoe+=/empower_rune_weapon
  --
  -- actions.single_target=plague_leech,if=cooldown.outbreak.remains<1
  -- actions.single_target+=/plague_leech,if=!talent.necrotic_plague.enabled&(dot.blood_plague.remains<1&dot.frost_fever.remains<1)
  -- actions.single_target+=/plague_leech,if=talent.necrotic_plague.enabled&(dot.necrotic_plague.remains<1)
  -- actions.single_target+=/soul_reaper,if=target.health.pct-3*(target.health.pct%target.time_to_die)<=45
  -- actions.single_target+=/blood_tap,if=(target.health.pct-3*(target.health.pct%target.time_to_die)<=45&cooldown.soul_reaper.remains=0)
  -- actions.single_target+=/summon_gargoyle
  -- actions.single_target+=/death_coil,if=runic_power>90
  -- actions.single_target+=/defile
  -- actions.single_target+=/dark_transformation
  -- actions.single_target+=/unholy_blight,if=!talent.necrotic_plague.enabled&(dot.frost_fever.remains<3|dot.blood_plague.remains<3)
  -- actions.single_target+=/unholy_blight,if=talent.necrotic_plague.enabled&dot.necrotic_plague.remains<1
  -- actions.single_target+=/outbreak,if=!talent.necrotic_plague.enabled&(!dot.frost_fever.ticking|!dot.blood_plague.ticking)
  -- actions.single_target+=/outbreak,if=talent.necrotic_plague.enabled&!dot.necrotic_plague.ticking
  -- actions.single_target+=/plague_strike,if=!talent.necrotic_plague.enabled&(!dot.blood_plague.ticking|!dot.frost_fever.ticking)
  -- actions.single_target+=/plague_strike,if=talent.necrotic_plague.enabled&!dot.necrotic_plague.ticking
  -- actions.single_target+=/breath_of_sindragosa,if=runic_power>75
  -- actions.single_target+=/run_action_list,name=bos_st,if=dot.breath_of_sindragosa.ticking
  -- actions.single_target+=/death_and_decay,if=cooldown.breath_of_sindragosa.remains<7&runic_power<88&talent.breath_of_sindragosa.enabled
  -- actions.single_target+=/scourge_strike,if=cooldown.breath_of_sindragosa.remains<7&runic_power<88&talent.breath_of_sindragosa.enabled
  -- actions.single_target+=/festering_strike,if=cooldown.breath_of_sindragosa.remains<7&runic_power<76&talent.breath_of_sindragosa.enabled
  -- actions.single_target+=/death_and_decay,if=unholy=2
  -- actions.single_target+=/blood_tap,if=unholy=2&cooldown.death_and_decay.remains=0
  -- actions.single_target+=/scourge_strike,if=unholy=2
  -- actions.single_target+=/death_coil,if=runic_power>80
  -- actions.single_target+=/festering_strike,if=blood=2&frost=2
  -- actions.single_target+=/death_and_decay
  -- actions.single_target+=/blood_tap,if=cooldown.death_and_decay.remains=0
  -- actions.single_target+=/blood_tap,if=buff.blood_charge.stack>10&(buff.sudden_doom.react|(buff.dark_transformation.down&rune.unholy<=1))
  -- actions.single_target+=/death_coil,if=buff.sudden_doom.react|(buff.dark_transformation.down&rune.unholy<=1)
  -- actions.single_target+=/scourge_strike,if=!(target.health.pct-3*(target.health.pct%target.time_to_die)<=45)|(unholy>=1&death>=1)|(death>=2)
  -- actions.single_target+=/festering_strike
  -- actions.single_target+=/blood_tap,if=buff.blood_charge.stack>=10&runic_power>=30
  -- actions.single_target+=/death_coil
  -- actions.single_target+=/empower_rune_weapon
  --
  -- actions.bos_st=death_and_decay,if=runic_power<88
  -- actions.bos_st+=/festering_strike,if=runic_power<77
  -- actions.bos_st+=/scourge_strike,if=runic_power<88
  -- actions.bos_st+=/blood_tap,if=buff.blood_charge.stack>=5
  -- actions.bos_st+=/plague_leech
  -- actions.bos_st+=/empower_rune_weapon
  -- actions.bos_st+=/death_coil,if=buff.sudden_doom.react
  --
  -- actions.bos_aoe=death_and_decay,if=runic_power<88
  -- actions.bos_aoe+=/blood_boil,if=runic_power<88
  -- actions.bos_aoe+=/scourge_strike,if=runic_power<88&unholy=1
  -- actions.bos_aoe+=/icy_touch,if=runic_power<88
  -- actions.bos_aoe+=/blood_tap,if=buff.blood_charge.stack>=5
  -- actions.bos_aoe+=/plague_leech
  -- actions.bos_aoe+=/empower_rune_weapon
  -- actions.bos_aoe+=/death_coil,if=buff.sudden_doom.react
  --
  -- actions.spread=blood_boil,cycle_targets=1,if=dot.blood_plague.ticking|dot.frost_fever.ticking
  -- actions.spread+=/outbreak,if=!talent.necrotic_plague.enabled&(!dot.blood_plague.ticking|!dot.frost_fever.ticking)
  -- actions.spread+=/outbreak,if=talent.necrotic_plague.enabled&!dot.necrotic_plague.ticking
  -- actions.spread+=/plague_strike,if=!talent.necrotic_plague.enabled&(!dot.blood_plague.ticking|!dot.frost_fever.ticking)
  -- actions.spread+=/plague_strike,if=talent.necrotic_plague.enabled&!dot.necrotic_plague.ticking



  },{
-- OUT OF COMBAT ROTATION
  -- PAUSES
  { "pause", "modifier.lcontrol" },
  { "pause", "@bbLib.bossMods" },

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

  -- PRE COMBAT
  -- actions.precombat=flask,type=greater_draenic_strength_flask
  -- actions.precombat+=/food,type=calamari_crepes
  -- actions.precombat+=/horn_of_winter
  -- actions.precombat+=/unholy_presence
  -- # Snapshot raid buffed stats before combat begins and pre-potting is done.
  -- actions.precombat+=/snapshot_stats
  -- actions.precombat+=/army_of_the_dead
  -- actions.precombat+=/potion,name=draenic_strength
  -- actions.precombat+=/raise_dead

},
function ()
  PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
  PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
  PossiblyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
  PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
  PossiblyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
  PossiblyEngine.toggle.create('frogs', 'Interface\\Icons\\inv_misc_fish_33', 'Gulp Frog Mode', 'Automaticly target and follow Gulp Frogs.')
end)
