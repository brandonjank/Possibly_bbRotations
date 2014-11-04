-- PossiblyEngine Rotation
-- Marksmanship Hunter - WoD 6.0.2
-- Updated on Nov 3rd 2014

-- PLAYER CONTROLLED:
-- TALENTS: Ice Floes, Alter Time, Frostjaw, Cauterize, Nether Tempest, Rune of Power
-- GLYPHS: Glyph of Arcane Power, Glyph of Arcane Explosion, Glyph of Cone of Cold, Minor: Glyph of Momentum
-- CONTROLS: Pause - Left Control

PossiblyEngine.rotation.register_custom(62, "bbMage Arcane", {
-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Evocation)" },

	-- AUTO TARGET
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- SURVIVAL COOLDOWNS
	--{ "Ice Block", { "modifier.cooldowns", "player.health <= 20" } },
	--{ "Cold Snap", { "modifier.cooldowns", "player.health <= 15", "player.spell(45438).cooldown" } },
	--{ "Ice Barrier", { "!player.buff(110909)", "!player.buff", "player.spell(11426).exists" }, "player" },

	-- Interrupts
	{ "Counterspell", "modifier.interrupt" },
	{ "Frostjaw", { "talent(3, 3)", "modifier.interrupts" } },
	-- TODO: Spellsteal

	-- Decurse
	-- TODO: Remove Curse

	-- DPS COOLDOWNS
	{ "Arcane Power", "player.buff(Arcane Charge).count > 3" },
	-- Presence of Mind is a minor DPS cooldown and you should use it on cooldown (in which case, use it for building Arcane Charges) or save it for when burst damage is needed.
	{ "Presence of Mind", "player.buff(Arcane Charge).count < 4" },
	-- If you chose Mirror Image Icon Mirror Image as your Tier 5 talent, then you should simply use it on cooldown.
	{ "Mirror Image", "talent(6, 1)" },
	-- TODO: Cold Snap can provide a small DPS boost, if you use it to reset the cooldown of Presence of Mind Icon Presence of Mind. This will provide you with a small burst of damage.


	-- MULTI TARGET
	{ {
		{ "Cone of Cold", "player.glyph(115705)" }, --  or 42746?
		{ "Nether Tempest", { "talent(5, 1)", "!target.debuff(Nether Tempest)", "player.buff(Arcane Charge).count > 3" } },
		{ "Nether Tempest", { "talent(5, 1)", "target.debuff(Nether Tempest)", "player.buff(Arcane Charge).count > 3", "target.debuff(Nether Tempest).duration < 3.6" } },
		{ "Arcane Blast", { "player.buff(Arcane Charge).count < 4", "!target.debuff(Nether Tempest)" } },
		{ "Arcane Explosion", "player.buff(Arcane Charge).count < 4" },
		{ "Arcane Barrage", "player.buff(Arcane Charge).count > 3" },
  },{
		"player.area(10).enemies > 4",
	} },

	-- SINGLE TARGET
	-- If you have to move for a long distance and that your stacks of Arcane Charge are about to drop, you can use Arcane Explosion to refresh them, if there is a target in range.
	{ "Arcane Explosion", { "player.buff(Arcane Charge)", "player.buff(Arcane Charge).duration < 2", "player.area(10).enemies > 0", } },
	-- Put your Rune of Power down and try to stay within 8 yards of it.
	{ "Rune of Power", { "talent(6, 2)", "!player.buff(Rune of Power)", "!modifier.last" } }, -- TODO: Track Rune distane from player
	--  apply it with 4 stacks of Arcane Charge or refresh it with 4 stacks of Arcane Charge before it drops (refreshing it with less than 3.6 seconds left will not cause you to waste ticks).
	{ "Nether Tempest", { "talent(5, 1)", "!target.debuff(Nether Tempest)", "player.buff(Arcane Charge).count > 3" } },
	{ "Nether Tempest", { "talent(5, 1)", "target.debuff(Nether Tempest)", "player.buff(Arcane Charge).count > 3", "target.debuff(Nether Tempest).duration < 3.6" } },
	-- If you chose Supernova as your Tier 5 talent, try to cast it on cooldown or
	{ "Supernova", { "talent(5, 3)", "player.spell(Arcane Power).cooldown > 25" } }, --TODO: let it recharge (2), so that you can cast it twice in a row for burst damage (preferably during a trinket proc).
	-- use Ice Floes Icon Ice Floes again to cast Arcane Blast or Arcane Missiles (do not cast Arcane Barrage Icon Arcane Barrage unless you meet the single-target rotation criteria that we listed above).
	{ "Ice Floes", "player.movingfor > 2" },
	-- Cast Arcane Missiles, if you have 4 stacks of Arcane Charge and 3 charges of Arcane Missiles.
	{ "Arcane Missiles", { "player.buff(Arcane Charge).count > 3", "player.buff(Arcane Missiles).count > 2" } },
	-- Cast Arcane Blast, if you are above 93% Mana before your start casting (or 91% with the Tier 16 2-piece bonus).
	{ "Arcane Blast", "player.mana > 92" }, -- TODO:93% Mana before your start casting (or 91% with the Tier 16 2-piece bonus).
	-- Cast Arcane Missiles Icon Arcane Missiles at 4 stacks of Arcane Charge Icon Arcane Charge.
	{ "Arcane Missiles", "player.buff(Arcane Charge).count > 3" },
	-- Cast Arcane Barrage Icon Arcane Barrage at 4 stacks of Arcane Charge Icon Arcane Charge.
	{ "Arcane Barrage", "player.buff(Arcane Charge).count > 3" },
	-- Cast Arcane Blast Icon Arcane Blast.
	{ "Arcane Blast" },


},{
	-- OUT OF COMBAT
	{ "Arcane Brilliance", { "!player.buffs.spellpower", "!modifer.last" } },

},
function()
	PossiblyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP Mode', 'Toggle the usage of PvP abilities.')
	PossiblyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	PossiblyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_mage_livingbomb', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
end)
