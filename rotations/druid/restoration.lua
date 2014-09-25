PossiblyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return PossiblyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(PossiblyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        PossiblyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

-- Custom Resto Druid Rotation v0.1
-- Updated on Nov 29th

PossiblyEngine.rotation.register_custom(105, "bbDruidRestoration", {

-- Pause Rotation
{ "pause", "modifier.lalt" },

-- Pause Rotation - Bear Form
{ "pause", "player.seal = 1" },

-- Pause Rotation - Cat Form
{ "pause", "player.seal = 3" },

-- Focus Macro
{ "!/focus [target=mouseover]", "modifier.lcontrol" },

-- Tranq Modifier
{ "740", "modifier.rshift" },

-- Incarnation Modifier
{ "106731", "modifier.rcontrol" },

-- Innervate
{ "29166", "player.mana < 80", "player" },

-- Dispel - Click Toggle To Enable - 5.4 Content
{ "88423", {
	"toggle.dispel",
	"@coreHealing.needsDispelled('Aqua Bomb')" -- Aqua Bomb (Proving Grounds)
}},
{ "88423", {
	"toggle.dispel",
	"@coreHealing.needsDispelled('Shadow Word: Bane')" -- Shadow Word: Bane (Fallen Protectors)
}},
{ "88423", {
	"toggle.dispel",
	"@coreHealing.needsDispelled('Lingering Corruption')" -- Lingering Corruption (Norushen)
}},
{ "88423", {
	"toggle.dispel",
	"player.buff(144364)",
	"@coreHealing.needsDispelled('Mark of Arrogance')" -- Mark of Arrogance (Sha of Pride)
}},
{ "88423", {
	"toggle.dispel",
	"@coreHealing.needsDispelled('Corrosive Blood')" -- Corrosive Blood (Thok)
}},

-- Mouse Over Healing For Blobs and Other SoO NPCs. Note This Will Healing Anything So Use The Toggle To Disable When Not Needed
{ "8936", { 
	"toggle.mouseover", 
	"!mouseover.buff(8936)", 
	"mouseover.health < 100",
	"!mouseover.range > 40"
}, "mouseover" },

{ "5185", { 
	"toggle.mouseover", 
	"mouseover.buff(8936)", 
	"mouseover.health < 100",
	"!mouseover.range > 40"
}, "mouseover" },

-- Incarnation Regrowth Clearcasting
{ "8936", { 
	"player.buff(33891)",
	"player.buff(16870)", 
	"!lowest.buff(8936)", 
	"lowest.health < 80",
	"!lowest.range > 40"
}, "lowest" },

-- Incarnation Wildgrowth
{ "48438", {
	"player.buff(33891)",
	"@coreHealing.needsHealing(85, 3)",
	"!lowest.range > 40"
}, "lowest" },

-- Incarnation Lifebloom Spam
{ "33763", { 
	"player.buff(33891)",
	"!lowest.buff(33763)",
	"lowest.health < 100",
	"!lowest.range > 40"
}, "lowest" },

-- Regrowth Clearcasting
{ "8936", { 
	"player.buff(16870)", 
	"!lowest.buff(8936)", 
	"lowest.health < 80",
	"!lowest.range > 40"
}, "lowest" },

-- Healing Touch Tier 2 Piece
{ "5185", { 
	"player.buff(144871).count = 5", 
	"lowest.health < 80",
	"!lowest.range > 40"
}, "lowest" },

-- Healing Touch Clearcasting
{ "5185", { 
	"player.buff(16870)",  
	"lowest.health < 80",
	"!lowest.range > 40"
}, "lowest" },

-- Nature's Swiftness
{ "132158", {
	"lowest.health < 30",
	"!lowest.range > 40"
}, "lowest" },

-- Lifebloom Tank
{ "33763", { 
	"tank.buff(33763).count < 3",
	"!tank.range > 40"
}, "tank" },

{ "33763", { 
	"tank.buff(33763).duration < 2",
	"!tank.range > 40"
}, "tank" },

-- Rejuvenation Tank
{ "774", { 
	"!tank.buff(774)",
	"!tank.range > 40"
}, "tank" },

-- Swiftmend Tank Rejuv
{ "18562", { 
	"tank.health < 90", 
	"tank.buff(774)",
	"!tank.range > 40"
}, "tank" },

-- Swiftmend Tank Regrowth
{ "18562", { 
	"tank.health < 90", 
	"tank.buff(8936)",
	"!tank.range > 40"
}, "tank" },

-- Swiftmend Lowest Rejuv
{ "18562", { 
	"lowest.health < 75", 
	"lowest.buff(774)",
	"!lowest.range > 40"
}, "lowest" },

-- Swiftmend Lowest Regrowth
{ "18562", { 
	"lowest.health < 75", 
	"lowest.buff(8936)",
	"!lowest.range > 40"
}, "lowest" },

-- Regrowth
{ "8936", { 
	"lowest.health < 50", 
	"!lowest.buff(8936)",
	"!lowest.range > 40"
}, "lowest" },

-- Wild Growth
{ "48438", { 
	"@coreHealing.needsHealing(85, 3)",
	"!lowest.range > 40"
}, "lowest" },

-- Genesis Single Target
{ "145518", { 
	"!player.spell(18562).cooldown = 0",
	"lowest.health < 40", 
	"lowest.buff(774)",
	"!lowest.range > 40"
}, "lowest" },

-- Genesis
{ "145518", { 
	"!player.spell(18562).cooldown = 0",
	"@coreHealing.needsHealing(70, 3)", 
	"lowest.buff(774)",
	"!lowest.range > 40"
}, "lowest" },

-- Rejuvenation
{ "774", { 
	"lowest.health < 95", 
	"!lowest.buff(774)",
	"!lowest.range > 40"
}, "lowest" },

-- Healing Touch
{ "5185", {
	"lowest.health < 40",
	"!lowest.range > 40"
}, "lowest" },


-- Nourish For Harmony
{ "50464", {
	"player.buff(100977).duration <= 2",
	"lowest.health < 99",
	"!lowest.range > 40"
}, "lowest" },

}, {
-- Focus Macro - Out Of Combat
{ "!/focus [target=mouseover]", "modifier.lcontrol" },

}, function()
PossiblyEngine.toggle.create('dispel', 'Interface\\Icons\\ability_shaman_cleansespirit', 'Dispel', 'Toggle Dispel')
PossiblyEngine.toggle.create('mouseover', 'Interface\\Icons\\spell_nature_resistnature', 'Mouseover Regrowth', 'Toggle Mouseover Regrowth For SoO NPC Healing')

end)