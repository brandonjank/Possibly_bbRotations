-- Many many many thanks to CodeMyLife for creating this!
-- Hopefully I can do his work justice by making it work with any unlocker and WoD.

if PQR_InterruptStarted == true then
	PQR_InterruptStarted = false
	health1 = 69
	health2 = 69
	health3 = 69
	maxhealth1 = 100
	maxhealth2 = 100
	maxhealth3 = 100
	PetHP = 69	
	Pet1HP = 69
	Pet2HP = 69
	Pet3HP = 69	
	MoyHPP = 69
	MoyHP = 69		
	activePetSlot = 1
	activePetHP =  69
	PetID = 1
	Pet1ID = 1
	Pet2ID = 2
	Pet3ID = 3
	PetPercent = 69	
	numAuras = 1
	numNmeAuras = 1	
	NmeactivePetSlot = 1
	NmeactivePetHP = 1
	NmePetID = 1
	NmePetPercent = 1
	nmePetHP = 69	
	modifier = 1
	myspeed = 69
	nmespeed = 69
	quality = 69
	PetAbilitiesTable = {{ A1 = 1 , A2 = 1 , A3 = 1 }, { A1 = 1 , A2 = 1 , A3 = 1 }, { A1 = 1 , A2 = 1 , A3 = 1 }}
		-- Static Vars --
	--	RarityColorsTable[1]
	RarityColorsTable = {
		{ Type = "Useless", 	Color = "999999" },
		{ Type = "Common", 		Color = "FFFFFF" },
		{ Type = "Uncommon", 	Color = "33FF33" },
		{ Type = "Rare", 		Color = "00AAFF" },
	}
	--	TypeWeaknessTable[1].Color
	TypeWeaknessTable = {
		{	Num = 1, 	Type = "Humanoid",	Weak = 8,	Strong = 2, Resist = 5,	Color = "00AAFF"	},
		{	Num = 2, 	Type = "Dragonkin",	Weak = 4,	Strong = 6, Resist = 3,	Color = "33FF33"	},
		{	Num = 3, 	Type = "Flying",	Weak = 2,	Strong = 9, Resist = 8,	Color = "FFFF66"	},
		{	Num = 4, 	Type = "Undead",	Weak = 9,	Strong = 1, Resist = 2,	Color = "663366"	},
		{	Num = 5, 	Type = "Critter",	Weak = 1,	Strong = 4, Resist = 7,	Color = "AA7744"	},
		{	Num = 6, 	Type = "Magic",		Weak = 10,	Strong = 3, Resist = 9,	Color = "CC44DD"	},
		{	Num = 7, 	Type = "Elemental",	Weak = 5,	Strong = 10,Resist = 10,Color = "FF9933"	},
		{	Num = 8, 	Type = "Beast",		Weak = 3,	Strong = 5, Resist = 1,	Color = "DD2200"	},
		{	Num = 9, 	Type = "Aquatic",	Weak = 6,	Strong = 7, Resist = 4,	Color = "33CCFF"	},
		{	Num = 10, 	Type = "Mechanical",Weak = 7,	Strong = 8, Resist = 6,	Color = "999999"	},
	}
end
-- In Battle timer
if sTimer == nil then sTimer = 0 end
if inBattle then
	if sTimer == 0 then 
		sTimer = GetTime()
	end
elseif sTimer ~= 0 then
	xrn:message("\124cFF9999FFBattle Ended "..GetBattleTime().." Min. "..select(2,GetBattleTime()).." Secs.")
	sTimer = 0
end
-- Out of Battle timer
if zTimer == nil then zsTimer = 0 end
if not inBattle then
	if zTimer == 0 then 
		zTimer = GetTime()
	end
elseif zTimer ~= 0 then
	zTimer = 0
end

-------------------------
-- Battle State & Vars --
-------------------------

inBattle = C_PetBattles.IsInBattle()
inWildBattle = C_PetBattles.IsWildBattle()
inPvPBattle = C_PetBattles.GetTurnTimeInfo()
if inBattle then
	activePetSlot = C_PetBattles.GetActivePet(1)
	CanSwapOut = C_PetBattles.CanActivePetSwapOut()
	-- Number of Abilities the actual pet is using.
	ActivePetlevel = C_PetBattles.GetLevel(1, activePetSlot)
	if ActivePetlevel >= 4 then 
		numofAbilities = 3
	elseif ActivePetlevel >= 2 then
		numofAbilities = 2
	else
		numofAbilities = 3
	end
	




	-- PetAbilitiesTable[1].A1
	PetAbilitiesTable = {
		-- Pet 1
		{
			A1 = C_PetBattles.GetAbilityInfo(1, 1, 1),
			A2 = C_PetBattles.GetAbilityInfo(1, 1, 2),
			A3 = C_PetBattles.GetAbilityInfo(1, 1, 3),
		},
		-- Pet 2
		{
			A1 = C_PetBattles.GetAbilityInfo(1, 2, 1),
			A2 = C_PetBattles.GetAbilityInfo(1, 2, 2),
			A3 = C_PetBattles.GetAbilityInfo(1, 2, 3),
		},
		-- Pet 3
		{
			A1 = C_PetBattles.GetAbilityInfo(1, 3, 1),
			A2 = C_PetBattles.GetAbilityInfo(1, 3, 2),
			A3 = C_PetBattles.GetAbilityInfo(1, 3, 3),
		}
	}

	
	AvailableAbilities = { 	PetAbilitiesTable[activePetSlot].A1, PetAbilitiesTable[activePetSlot].A2 ,PetAbilitiesTable[activePetSlot].A3 	}

	-- MY HP	
	activePetHP = (100 * C_PetBattles.GetHealth(1, activePetSlot) / C_PetBattles.GetMaxHealth(1, activePetSlot))
	
	health1 = C_PetBattles.GetHealth(1, 1)
	maxhealth1 = C_PetBattles.GetMaxHealth(1, 1)
	
	health2 = C_PetBattles.GetHealth(1, 2)
	maxhealth2 = C_PetBattles.GetMaxHealth(1, 2)
	
	health3 = C_PetBattles.GetHealth(1, 3)
	maxhealth3 = C_PetBattles.GetMaxHealth(1, 3)
	
	PetID = C_PetBattles.GetDisplayID(1, activePetSlot)
	Pet1ID = C_PetBattles.GetDisplayID(1, 1)
	Pet2ID = C_PetBattles.GetDisplayID(1, 2)
	Pet3ID = C_PetBattles.GetDisplayID(1, 3)
	ActivepetGUID, ability1, ability2, ability3, locked = C_PetJournal.GetPetLoadOutInfo(activePetSlot)
	PetPercent = floor(activePetHP)
	-- Nme HP
	NmeactivePetSlot = C_PetBattles.GetActivePet(2)
	NmeactivePetHP = (100 * C_PetBattles.GetHealth(2, NmeactivePetSlot) / C_PetBattles.GetMaxHealth(2, NmeactivePetSlot))
	NmePetID = C_PetBattles.GetDisplayID(1, NmeactivePetSlot)
	NmePetPercent = floor(NmeactivePetHP)
	-- Other vars
	usabletrap = C_PetBattles.IsTrapAvailable()
	-- My HP
	PetHP = (100 * C_PetBattles.GetHealth(1, activePetSlot) / C_PetBattles.GetMaxHealth(1, activePetSlot))
	PetExactHP = C_PetBattles.GetHealth(1, activePetSlot)
	Pet1ExactHP = C_PetBattles.GetHealth(1, 1)
	Pet2ExactHP = C_PetBattles.GetHealth(1, 2)
	Pet3ExactHP = C_PetBattles.GetHealth(1, 3)
	Pet1HP = floor((100 * health1 / maxhealth1))
	Pet2HP = floor((100 * health2 / maxhealth2))
	Pet3HP = floor((100 * health3 / maxhealth3))
	PetHPTable = { Pet1HP, Pet2HP, Pet3HP }
		
	MoyHPP = ((Pet1HP + Pet2HP + Pet3HP) / 3)
	MoyHP = floor(MoyHPP)

	-- Types
	PetType = C_PetBattles.GetPetType(1, activePetSlot)
	Pet1Type = C_PetBattles.GetPetType(1, 1)
	Pet2Type = C_PetBattles.GetPetType(1, 2)
	Pet3Type = C_PetBattles.GetPetType(1, 3)
	NmePetType = C_PetBattles.GetPetType(2, NmeactivePetSlot)	
	NmePet1Type = C_PetBattles.GetPetType(2, 1)
	NmePet2Type = C_PetBattles.GetPetType(2, 2)
	NmePet3Type = C_PetBattles.GetPetType(2, 3)
	
	-- Buffs
	numAuras = C_PetBattles.GetNumAuras(1, activePetSlot)
	numNmeAuras = C_PetBattles.GetNumAuras(2, NmeactivePetSlot)
	
	WeatherID = C_PetBattles.GetAuraInfo(0, 0, 1)
	
	-- NME HP
	NMEPetHP = (100 * C_PetBattles.GetHealth(2, enemyPetSlot) / C_PetBattles.GetMaxHealth(2, enemyPetSlot))
	
	-- Active Ennemi Pet Check
	enemyPetSlot = C_PetBattles.GetActivePet(2)
	nmePetHP = (100 * C_PetBattles.GetHealth(2, enemyPetSlot) / C_PetBattles.GetMaxHealth(2, enemyPetSlot))

	-- Modifier Check
	mypetType = C_PetBattles.GetPetType(1, activePetSlot)
	nmepetType = C_PetBattles.GetPetType(2, nmePetSlot)
--	modifier = C_PetBattles.GetAttackModifier(mypetType, nmepetType)

	-- Speed Check
	myspeed = C_PetBattles.GetSpeed(1, activePetSlot)
	nmespeed = C_PetBattles.GetSpeed(2, NmeactivePetSlot)
	
	-- Player active pet GUID
	ActivepetGUID, ability1, ability2, ability3, locked = C_PetJournal.GetPetLoadOutInfo(activePetSlot)

	
--	PQR_Event("PQR_Text" , "Pet: "..PetID.." HP: "..PetPercent.."% NmeHP:"..NmePetPercent.."%"  , nil, "0698FF")
end

-----------------
-- Revive Pets --
-----------------
if ReviveBattlePetsCheck == nil then return true end

if not inBattle 
  and ReviveBattlePetsCheck then
	local Start ,CD = GetSpellCooldown(125439)
	HealCD = floor(Start + CD - GetTime())
	HealMinuts = floor(HealCD/60)
	HealSeconds = (HealCD - (HealMinuts * 60))
	
	if MoyHP ~= nil then
		if PQR_SpellAvailable(125439) then
  			Pet1HP = 100
			Pet2HP = 100
			Pet3HP = 100
			MoyHP = 100
			CastSpellByName(GetSpellInfo(125439),"player")
		end
--		PQR_Event("PQR_Text" , "PokeRotation - "..MoyHP.."% // Heal "..HealMinuts.."m "..HealSeconds.."s" , nil, "0698FF")	
	end	
end

--------------------
-- Slash Commands --
--------------------
if PokeMacros == nil then
	PokeMacros = true
	SLASH_BUFFS1 = "/buffs"
	SLASH_BUFFS2 = "/buff"
	function SlashCmdList.BUFFS(msg, editbox)
		BuffSpam()
	end
end



------ SWITCHER 
if PvPSlotValue == nil then return false end
if PvPCheck then
	if C_PetBattles.GetPVPMatchmakingInfo() == nil and C_PetBattles.IsPlayerNPC(2) == nil then
		C_PetBattles.StartPVPMatchmaking()
	end
	if C_PetBattles.GetPVPMatchmakingInfo() == "proposal" and C_PetBattles.IsPlayerNPC(2) == nil then
		C_PetBattles.AcceptQueuedPVPMatch()
	end
	if C_PetBattles.GetPVPMatchmakingInfo() == nil and C_PetBattles.IsPlayerNPC(2) == false then
		C_PetBattles.ChangePet(PvPSlotValue)
	end
end

-- Switcher
if SwapOutHealthValue == nil then return false end
if not inBattle then return false end
---------------------------
-- Pet Leveling Strategy --
---------------------------
PetLevelFunction = nil
function PetLevelFunction()
	if PetLevelingCheck 
	  and PetLevel(1) < PetLevelingValue then
		-- If we are trying to level pets.
		if activePetSlot == 1 then
		  	
		  	-- Get out as soon as we get a poison debuff on us.
		  	if IsMultiBuffed(SwapoutDebuffList, 1) then
		  		C_PetBattles.ChangePet(2)
		  	end
			
			-- Swap Pet
			if (PetHP < 75 or NMEPetHP < 100 or NmeactivePetSlot ~= 1) then
				C_PetBattles.ChangePet(2)
			end
			
			-- Swap Pet
			if select(2,GetBattleTime()) > 3 then
				C_PetBattles.ChangePet(2)
			end
			
			
		
		  	SimpleHighPunch(1)
			SimplePunch(1)
			PetLeveling(1)
			SimpleHighPunch(2)
			SimplePunch(2)
			PetLeveling(2)
			SimpleHighPunch(3)
			SimplePunch(3)
			PetLeveling(3)
			C_PetBattles.UseAbility(1)
			C_PetBattles.UseAbility(2)
			C_PetBattles.UseAbility(3)
		end
	end
end


---- NORMAL ROTATION
if inBattle and not ( PauseKey and PauseKeyCheck ) and ObjectiveValue == 1 then
	PetLevelFunction()
	Switch()
	CapturePet()
	PassTurn()
	Deflect()
	Execute()
	Kamikaze()
	LastStand()
	ShieldBuff()
	LifeExchange()
	SimpleHealing()
	DelayFifteenTurn()
	DelayThreeTurn()
	DelayOneTurn()
	TeamHealBuffs()
	HoTBuff()
	HighDamageIfBuffed()
	SelfBuff()
	DamageBuff()
	SpeedDeBuff()
	AoEPunch()
	ThreeTurnHighDamage()
	SimpleHighPunch(1)
	SimplePunch(1)
	SimpleHighPunch(2)
	DeBuff()
	Soothe()
	Stun()
	TeamDebuff()
	Turrets(1)
	Turrets(2)
	SpeedBuff()
	QuickPunch()
	Comeback()
	SimplePunch(2)
	Turrets(3)
	SimpleHighPunch(3)
	SimplePunch(3)
	
	C_PetBattles.UseAbility(1) -- Attack 1
	C_PetBattles.UseAbility(2) -- Attack 2
	C_PetBattles.UseAbility(3) -- Attack 3
	C_PetBattles.SkipTurn() -- skip turn.
end

_------ ABILITIES
if not AttackFunctions then
	AttackFunctions = true

	-- AoE Attacks to be used only while there are 3 ennemies.
	AoEPunch = nil
	function AoEPunch()
		if nmePetSlot == 1 or 2 then
			AbilityCast(AoEPunchList)
		end
	end
	
	-- Abilities that are stronger if the enemy have more health than us.
	Comeback = nil
	function Comeback()
		if PetHP < NmePetPercent 
		  and not Immunity() then
			AbilityCast(ComebackList)
		end
	end
	
	-- Damage Buffs that we want to cast on us.
	DamageBuff = nil
	function DamageBuff()
		if not IsMultiBuffed(DamageBuffList, 1, 485) then		
			AbilityCast(DamageBuffList)	
		end
	end
	
	-- Debuff to cast on ennemy.
	DeBuff = nil
	function DeBuff()		
		if NmePetPercent >= 45 
		  and not Immunity() then
			for i = 1, #DeBuffList do
				if not IsBuffed(DeBuffList[i], 2) then
					AbilitySpam(DeBuffList[i])
				end
			end
			for i = 1, #SpecialDebuffsList do
				if not IsBuffed(nil, 2, SpecialDebuffsList[i].Debuff) then
					AbilitySpam(SpecialDebuffsList[i].Ability)
				end
			end
		end
	end	
	
	-- HighDamageIfBuffed to cast on ennemy.
	HighDamageIfBuffed = nil
	function HighDamageIfBuffed()
		if not Immunity() then	
			for i = 1, #HighDamageIfBuffedList do
				if IsBuffed(nil, 2, HighDamageIfBuffedList[i].Debuff) then
					AbilitySpam(HighDamageIfBuffedList[i].Ability)
				end
			end
		end
	end
	
	-- Abilities to shield ourself to avoid an ability.
	Deflect = nil
	function Deflect()
		if IsMultiBuffed(ToDeflectList, 2) then		
			AbilityCast(DeflectorList)
		end
	end
	
	-- Apocalypse
	DelayFifteenTurn = nil
	function DelayFifteenTurn()
		if NmeactivePetSlot == 1 then 
			AbilityCast(FifteenTurnList)
		end
	end
	
	-- Damage in three turn
	DelayThreeTurn = nil
	function DelayThreeTurn()
		if NmeactivePetSlot ~= 3 then
			AbilityCast(ThreeTurnList)	
		end
	end
	
	-- Damage in one turn.
	DelayOneTurn = nil
	function DelayOneTurn()
		if not ( NmeactivePetSlot == 3 and NmeactivePetHP <= 30 ) then
			AbilityCast(OneTurnList)
		end
	end
	
	-- Execute if enemi pet is under 30%.
	Execute = nil
	function Execute()
		if NmePetPercent <= 60 
		  and not Immunity() then
			AbilityCast(ExecuteList)
		end
	end
	
	-- Buffs that heal us.
	HoTBuff = nil
	function HoTBuff()
		if PetHP < ( PetHealValue + 10 )
		  and not ( nmePetHP < 40 and enemyPetSlot == 3 ) then
			for i = 1, #HoTList do
				for j = 1, #HoTBuffList do
					local Poke_Ability = HoTBuffList[j]			
					if not IsBuffed(Poke_Ability, 2) then		
						AbilitySpam(Poke_Ability)
					end
				end	
			end
		end
	end
	
	-- Suicide if under 20% Health.
	Kamikaze = nil
	function Kamikaze()
		if PetHP < 20 
		  and not Immunity() then
			AbilityCast(KamikazeList)
		end
	end
	
	LastStand = nil
	function LastStand()
		if PetHP < 25 then
			AbilityCast(LastStandList)
		end
	end
	
	LifeExchange = nil
	function LifeExchange()
		if PetHP < 35
		  and nmePetHP > 70 then
			AbilityCast(LifeExchangeList)	
		end
	end
	
	PassTurn = nil
	function PassTurn()
		if IsMultiBuffed(StunnedDebuffs, 1) then -- if we are stunned
			C_PetBattles.SkipTurn() -- skip turn
		end
	end
	
	-- Abilities for leveling.
	PetLeveling = nil
	function PetLeveling(HighDmgCheck)
		AbilityCast(PetLevelingList, HighDmgCheck)
	end	
	
	-- Attack that are stronger if we are quicker.
	QuickPunch = nil
	function QuickPunch() 
	  	if myspeed > nmespeed 
	  	  and not Immunity() then
			AbilityCast(QuickList)
		end
	end
	
	-- List of Buffs that we want to cast on us.
	SelfBuff = nil
	function SelfBuff()
		if activePetHP > 15
		  and not ( NmePetPercent <= 40 and NmeactivePetSlot == 3 ) then
			if not IsMultiBuffed(SelfBuffList, 1) then		
				AbilityCast(SelfBuffList)
			end
			for i = 1, #SpecialSelfBuffList do
				if not IsBuffed(nil, 1, SpecialSelfBuffList[i].Buff) then
					AbilitySpam(SpecialSelfBuffList[i].Ability)
				end
			end			
		end
	end
	
	
	-- Direct Healing
	SimpleHealing = nil
	function SimpleHealing()
		if PetPercent < PetHealValue
  		  and PetHealCheck then
			AbilityCast(HealingList)
		end	
	end
	
	SimpleHighPunch = nil
	function SimpleHighPunch(HighDmgCheck)
		if not Immunity() then
			AbilityCast(HighDMGList, HighDmgCheck)
		end
	end
	
	-- Basic Attacks.
	SimplePunch = nil
	function SimplePunch(HighDmgCheck)
		if not Immunity() then
			if HighDmgCheck ~= nil then
				AbilityCast(PunchList, HighDmgCheck)
			else
				AbilityCast(PunchList)
			end
		end
	end	
	
	ShieldBuff = nil
	function ShieldBuff()
		if not ( NmePetPercent <= 30 
		  and NmeactivePetSlot == 3 ) then
		  	if not IsMultiBuffed(ShieldBuffList, 1) then		
				AbilityCast(ShieldBuffList)
			end
		end
	end
	
	SlowPunch = nil
	function SlowPunch()
		if not Immunity() then
			AbilityCast(SlowPunchList)
		end
	end	
	
	SpeedBuff = nil
	function SpeedBuff()
		if myspeed < nmespeed then
			for i = 1, #SpeedBuffList do
				if not IsBuffed(SpeedBuffList[i], 1) then		
					AbilitySpam(SpeedBuffList[i])
				end
			end
		end
	end
	
	SpeedDeBuff = nil
	function SpeedDeBuff()		
		if NmePetPercent >= 45 
		  and myspeed < nmespeed 
		  and myspeed > ( 3 * nmespeed / 4 ) then
			for i = 1, #SpeedDeBuffList do
				if not IsBuffed(SpeedDeBuffList[i], 2) then
					AbilitySpam(SpeedDeBuffList[i])
				end
			end
		end
	end	
	
	Stun = nil
	function Stun()
		if not Immunity() then
			AbilityCast(StunList)
		end
	end	
	
	Soothe = nil
	function Soothe()
		AbilityCast(SootheList)
	end	
	
	TeamDebuff = nil
	function TeamDebuff()
		if not ( NmeactivePetSlot == 3
		  and NmePetPercent <= 55 ) then
			for i = 1, #TeamDebuffList do
				local found = false		
			
		   			for j = 1, ( C_PetBattles.GetNumAuras(2, 0) or 0 ) do
			   			local auraID = C_PetBattles.GetAuraInfo(2, 0, j)
			   			if auraID == ( TeamDebuffList[i] - 1 ) then   
			 	   			found = true     
			   			end
			 		end	
				
				if not found then		
					AbilitySpam(TeamDebuffList[i])
				end
				
				--for i = 1, #SpecialTeamDebuffsList do
				--	if not IsBuffed(nil, 2, SpecialTeamDebuffsList[i].Debuff) then
				--		AbilitySpam(SpecialTeamDebuffsList[i].Ability)
				--	end
				--end
				
			end
		end
	end

	TeamHealBuffs = nil
	function TeamHealBuffs()
		if PetHP < PetHealValue
		  and not ( nmePetHP < 40 and enemyPetSlot == 3 ) then
			for i = 1, #TeamHealBuffsAbilities do
		
				local found = false		
				for j = 1, #TeamHealBuffsList do
					
				
					for k = 1, ( C_PetBattles.GetNumAuras(1,0) or 0 ) do
					
			   			local auraID = C_PetBattles.GetAuraInfo(1, 0, k)
			   			if auraID == TeamHealBuffsList[j] then   
		 	   				found = true       
			   			end
			 		end
				end
	
				if not found then		
					AbilitySpam(TeamHealBuffsAbilities[i])
				end		
			end
		end
	end
	
	-- Abilities that last three turns that does high damage.
	ThreeTurnHighDamage = nil
	function ThreeTurnHighDamage()
		if PetHP > 60 then
			AbilityCast(ThreeTurnHighDamageList)
		end
	end
	
	-- Robot Turrets
	Turrets = nil
	function Turrets(HighDmgCheck)
		if WeatherID ~= 454 
		  and not ( NmeactivePetSlot == 3
	  	  and NmePetPercent <= 55 ) then
			AbilityCast(TurretsList, HighDmgCheck)
		end
	end
end


----- FUNCTIONS
if PetHealValue == nil then return true end
if CaptureValue == nil then return true end
if not PetFunctions then
	PetFunctions = true
	
	-- AbilitySpam(Ability) - Cast this single ability with checks.
	-- AbilityTest(Ability) - Use this to test if pet is strong or weak.
	-- AbilityCast(CastList, DmgCheck) - Cast this Ability List. DmgCheck - 1 = Strong  2 = Normal  3 = Weak  4 = all
	-- Buff Report - Spam the Chat with Pet Informations
	-- CapturePet() - Test for targets to trap.
	-- Immunity() - Test if the ennemy pet is Immune.
	-- IsBuffed(Ability, BuffTarget, ForceID) - Test if Ability - 1 is in List. Can test additional IDs.

	
	-- AbilitySpam(Ability) - Cast this single ability with checks.	
	AbilitySpam = nil
	function AbilitySpam(Ability)
		if PetAbilitiesTable[activePetSlot].A1 == Ability then
			C_PetBattles.UseAbility(1)		   
		end
		if PetAbilitiesTable[activePetSlot].A2 == Ability then
			C_PetBattles.UseAbility(2)
		end
		if PetAbilitiesTable[activePetSlot].A3 == Ability then
			C_PetBattles.UseAbility(3)
		end
	end	
				
	-- Call to check ability vs enemy pet type.
	AbilityTest = nil
	function AbilityTest(Poke_Ability)
		if TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(Poke_Ability))].Strong == NmePetType then IsStrongAbility = true else IsStrongAbility = false end
		if TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(Poke_Ability))].Weak == NmePetType then IsWeakAbility = true else IsWeakAbility = false end
		if IsStrongAbility then return 3 end
		if not IsWeakAbility and not IsStrongAbility then return 2 end
		if IsWeakAbility then return 1 end
	end
		
	-- AbilityCast(CastList, DmgCheck) - Cast this Ability List. DmgCheck - 1 = Strong  2 = Normal  3 = Weak  4 = all
	AbilityCast = nil
	function AbilityCast(CastList, DmgCheck)
		for i = 1, #CastList do
			if DmgCheck == nil then
				Poke_Ability = CastList[i]
				AbilitySpam(Poke_Ability)
			end
			if DmgCheck ~= nil then
				Poke_Ability = CastList[i]
				if TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(Poke_Ability))].Strong == NmePetType then IsStrongAbility = true else IsStrongAbility = false end
				if TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(Poke_Ability))].Weak == NmePetType then IsWeakAbility = true else IsWeakAbility = false end
				if DmgCheck == 1 
				  and IsStrongAbility then
					AbilitySpam(Poke_Ability)
				end
				if DmgCheck == 2
				  and not IsStrongAbility 
				  and not IsWeakAbility then
					AbilitySpam(Poke_Ability)
				end
				if DmgCheck == 3
				  and IsWeakAbility then
					AbilitySpam(Poke_Ability)
				end
				if DmgCheck == 4 then
					AbilitySpam(Poke_Ability)
				end
			end
		end
	end
	
	-- Buff Report - Spam the Chat with Pet Informations
	BuffSpam = nil
	function BuffSpam()
		print("Realoading Functions")
		for i = 1, 3 do
			local LoadoutTable = { C_PetJournal.GetPetLoadOutInfo(activePetSlot) }
			local j = i + 1
			local ability = LoadoutTable[j]
			local id, name, _, _, _, numTurns, petType = C_PetBattles.GetAbilityInfoByID(ability)
			if TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(ability))].Strong == NmePetType then IsStrongAbility = "true" else IsStrongAbility = "false" end
			print("Ability "..i.." |cff"..(TypeWeaknessTable[petType].Color).." "..id.." "..name.." Turns= "..numTurns.." Type= "..petType.." Strong= "..IsStrongAbility)
		end
		if not C_PetBattles.IsInBattle() then
			print("Not in Battle.")
			return false
		end
		for i = 1, 3, 1 do
			local PetLoadout = C_PetBattles.GetPetType(1, i)
			local petGUID, ability1, ability2, ability3, locked = C_PetJournal.GetPetLoadOutInfo(i)
	    	local _, _, _, _, _, _, _, customName = C_PetJournal.GetPetInfoByPetID(petGUID)
	    	print("Pet "..i.." |cff"..(TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(ability1))].Color).."A1= "..ability1.." |cff"..(TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(ability2))].Color).." A2= "..ability2.." |cff"..(TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(ability3))].Color).." A3= "..ability3.." |cff"..(TypeWeaknessTable[PetLoadout].Color).." "..(TypeWeaknessTable[PetLoadout].Type).." "..customName)
	   	end
	   	-- Team Buffs
   		for i = 1, C_PetBattles.GetNumAuras(1, 0) do
   			local auraID = C_PetBattles.GetAuraInfo(1, 0, i)
   			if auraID ~= nil then   
 	   			print(i.." - Team Buff Allie - "..auraID)      
   			end
 		end	
	   	-- Pet Buffs
		for i = 1, C_PetBattles.GetNumAuras(1, activePetSlot), 1 do -- Generate Debuffs
	   		local auraID = C_PetBattles.GetAuraInfo(1, activePetSlot, i)
	   		if auraID ~= nil then
	   			print(i.." - Buff Allie - "..auraID)
	   		end
	   	end
	   	-- Ennemy Team Buffs
	   	for i = 1, C_PetBattles.GetNumAuras(2, 0) do
   			local auraID = C_PetBattles.GetAuraInfo(2, 0, i)
   			if auraID ~= nil then   
 	   			print(i.." - Nme Team Buff - "..auraID)      
   			end
 		end	
	 	-- Ennemy Pet Buffs
		for i = 1, C_PetBattles.GetNumAuras(2, NmeactivePetSlot), 1 do -- Generate Ennemy Debuffs 
	   		local NmeauraID = C_PetBattles.GetAuraInfo(2, NmeactivePetSlot, i)
	   		if NmeauraID ~= nil then
	   			print(i.." - Nme Buff - "..NmeauraID)
	   		end
	   	end
	   	-- My buffs
	   	if numAuras == 0 then
	   		print("No Buffs ")
	   	end
	   	-- Ennemy Buffs
	   	if numNmeAuras == 0 then
	   		print("No Nme Buffs ")
	   	end
	   	-- Wheater ID
	   	if WeatherID ~= nil then
	   		print("Weather= "..WeatherID)
	   	end
	end
	
	-- CapturePet() - Test for targets to trap.
	CapturePet = nil
	function CapturePet()
	  	if inBattle 
	  	  and C_PetBattles.GetBreedQuality(2, NmeactivePetSlot) >= CaptureValue 
	  	  and C_PetJournal.GetNumCollectedInfo(C_PetBattles.GetPetSpeciesID(2,NmeactivePetSlot)) < NumberOfPetsValue
	  	  and CaptureCheck then
		  	if NmeactivePetHP <= 35 
		  	  and C_PetBattles.IsTrapAvailable() then
		  	  	if SimpleHealing ~= nil then SimpleHealing() end
				C_PetBattles.UseTrap()
				xrn:message("\124cFFFFFFFFTrapping pet")
			elseif NmeactivePetHP <= 65 then
				if SimpleHealing ~= nil then SimpleHealing() end
				if Stun ~= nil then Stun() end 
				if SimplePunch ~= nil then SimplePunch(3) end 
				if SimplePunch ~= nil then SimplePunch(2) end 
				if SimplePunch ~= nil then SimplePunch(1) end 
			else
				if SimpleHealing ~= nil then SimpleHealing() end
				if Stun ~= nil then Stun() end 
				if SimplePunch ~= nil then SimplePunch(1) end 
				if SimplePunch ~= nil then SimplePunch(2) end 
				if SimplePunch ~= nil then SimplePunch(3) end 
			end
		end
	end
	
	-- Return Time in minuts/seconds of the battle.
	GetBattleTime = nil
	function GetBattleTime()
		if sTimer == nil then return 0 end
		if sTimer ~= 0 then
			cTimermin =  floor((GetTime() - sTimer)/60)
			cTimersec =  floor((GetTime() - sTimer)) - (60 * cTimermin)
			return cTimermin, cTimersec 
		else
			return 0 
		end
	end
	
	-- Return distance and high between us and our target.
	CML_GetDistance = nil
	function CML_GetDistance(T1,T2)
		T1X, T1Y, T1Z = PQR_UnitInfo(T1) 
		T2X, T2Y, T2Z = PQR_UnitInfo(T2) 
		if T1X == nil or T2X == nil then return 0 end
		XDist = abs(T1X - T2X)
		YDist = abs(T1Y - T2Y)
		High = abs(T1Z - T2Z)
		Distance = XDist + YDist
		return Distance, High
	end	
	
	-- Return Time in minuts/seconds of the battle.
	GetBattleTime = nil
	function GetBattleTime()
		if sTimer ~= 0 then
			cTimermin =  floor((GetTime() - sTimer)/60)
			cTimersec =  floor((GetTime() - sTimer)) - (60 * cTimermin)
			return cTimermin, cTimersec 
		else
			return 0, 0
		end
	end
	
	-- Return the number of abilities the pet have according to his level.
	GetNumofPetAbilities = nil
	function GetNumofPetAbilities(PetSlot)
		local 	Petlevel = C_PetBattles.GetLevel(1, PetSlot)
		if Petlevel >= 4 then 
			return 3
		elseif Petlevel >= 2 then
			return 2
		else
			return 1
		end
	end
	
	-- Call to see pet strenghts based on IsPetAttack() lists.
	GetPetStrenght = nil
	function GetPetStrenght(PetSlot)
		if PetHPTable[PetSlot] ~= 0 then
			local IsPetStrenght = 0
			
			local petGUID, ability1, ability2, ability3, locked = C_PetJournal.GetPetLoadOutInfo(PetSlot)
			local Abilities = { ability1, ability2, ability3 }
			for i = 1, GetNumofPetAbilities(PetSlot) do
	
				if AbilityTest(Abilities[i]) == 3 
				  and IsPetAttack(Abilities[i]) then
					IsPetStrenght = ( IsPetStrenght + 1 )
				end
				if AbilityTest(Abilities[i]) == 1 
				  and IsPetAttack(Abilities[i]) then
					IsPetStrenght = ( IsPetStrenght - 1 )
				end
			end
			return IsPetStrenght
		else
			return 0
		end
	end
	
	-- Immunity() - Test if the ennemy pet is Immune.	
	Immunity = nil
	function Immunity()
		for i = 1, #ImmunityList do
			local Poke_Ability = ImmunityList[i]
			if IsBuffed(Poke_Ability,2,Poke_Ability) then -- Si Aura = Buff 
				return true     
			end
		end
		if NmePetPercent <= 40 then
			for i = 1, #CantDieList do
				local Poke_Ability = CantDieList[i]
				if IsBuffed(Poke_Ability,2,Poke_Ability) then -- Si Aura = Buff 
					return true     
				end
			end
		end
		return false
	end
	
	-- IsBuffed(Ability, BuffTarget, ForceID) - Test if Ability - 1 is in List. Can test additional IDs.
	IsBuffed = nil
	function IsBuffed(Ability, BuffTarget, ForceID)
		if inBattle then
			found = false
			for i = 1, C_PetBattles.GetNumAuras(BuffTarget, C_PetBattles.GetActivePet(BuffTarget)) do
				local auraID = C_PetBattles.GetAuraInfo(BuffTarget, C_PetBattles.GetActivePet(BuffTarget), i)
				if Ability ~= nil then
			  		if auraID == ( Ability - 1 ) then     
			 	   		found = true       
			 		end
			 	end
		 		if ForceID ~= nil then
		 			if auraID == ForceID then
		 				found = true
		 			end
		 		end
			end
			if found then 
				return true
			else 
				return false
			end
		end
	end
	
	-- IsBuffed(Ability, BuffTarget, ForceID) - Test if Ability - 1 is in List. Can test additional IDs.
	IsMultiBuffed = nil
	function IsMultiBuffed(Ability, BuffTarget, ForceID)
		if inBattle then
			if ForceID ~= nil then
				if IsBuffed(ForceID, BuffTarget) then
					return true
				end
			end
			for i = 1, #Ability do
				if IsBuffed(Ability[i], BuffTarget) then
					return true
				end
			end
		end
	end
	
		-- Return true if the attack is in one of these attacks.
	IsPetAttack = nil
	function IsPetAttack(PokeAbility)
		ToQuerryLists = { PunchList, HighDMGList, ThreeTurnHighDamageList }
		for i = 1, #ToQuerryLists do
			ThisList = ToQuerryLists[i]
			for j = 1 , #ThisList do
				if ThisList[j] == PokeAbility then 
					return true
				end
			end
		end
		return false
	end	
	
	-- Health from journal
	JournalHealth = nil
	function JournalHealth(PetSlot)
		PetHealth = 100 * (select(1,C_PetJournal.GetPetStats(C_PetJournal.GetPetLoadOutInfo(PetSlot))) / select(2,C_PetJournal.GetPetStats(C_PetJournal.GetPetLoadOutInfo(PetSlot))) )
		if PetHealth == nil then
			return 0
		else
			return PetHealth
		end
	end
	
	-- Health from journal by GUID
	JournalHealthGUID = nil
	function JournalHealthGUID(PetGUID)
		PetHealth = 100 * (select(1,C_PetJournal.GetPetStats(PetGUID)) / select(2,C_PetJournal.GetPetStats(PetGUID)) )
		if PetHealth == nil then
			return 0
		else
			return PetHealth
		end
	end
	
	-- PetLevel
	PetLevel = nil
	function PetLevel(PetSlot)
		if inBattle then
			local MyPetLevel = C_PetBattles.GetLevel(1, PetSlot)
			return MyPetLevel
		end
		if not inBattle then
			MyPetLevel = select(3, C_PetJournal.GetPetInfoByPetID(C_PetJournal.GetPetLoadOutInfo(PetSlot)))
			return MyPetLevel
		end
	end	

	-- Switch Pet
	Switch = nil
	function Switch()
		AbilityCast(SuicideList)
		-- Make sure we are not rooted.
	  	if CanSwapOut then
			if PetHP <= SwapOutHealthValue 
			  and SwapOutHealthCheck
			  or PetLevelingCheck and activePetSlot == 1 then
				if activePetSlot == 1 
				  and Pet1HP <= SwapOutHealthValue 
				  or NMEPetHP < 100 then
					if GetPetStrenght(2) > GetPetStrenght(3) 
					  and Pet2HP >= SwapInHealthValue then
						C_PetBattles.ChangePet(2)
					elseif Pet3HP >= SwapInHealthValue 
					  or Pet1HP == 0 then
						C_PetBattles.ChangePet(3)
					end
				end
				if activePetSlot == 2 then
					if GetPetStrenght(1) > GetPetStrenght(3)
					  and Pet1HP >= SwapInHealthValue 
					  and not ( PetLevelingCheck and PetLevelingValue > C_PetBattles.GetLevel(1, 1) ) then
						C_PetBattles.ChangePet(1)
					elseif Pet3HP >= SwapInHealthValue or Pet2HP == 0 then
						C_PetBattles.ChangePet(3)
					end
				end
				if activePetSlot == 3 then
					if GetPetStrenght(1) > GetPetStrenght(2) 
					  and Pet1HP >= SwapInHealthValue 
					  and not ( PetLevelingCheck and PetLevelingValue > C_PetBattles.GetLevel(1, 1) ) then
						C_PetBattles.ChangePet(1)
					elseif Pet2HP >= SwapInHealthValue or Pet3HP == 0 then
						C_PetBattles.ChangePet(2)
					elseif Pet2HP == 0 and Pet3HP == 0 then
						C_PetBattles.ChangePet(1)
					end
				end
			end
		end
	end	
	
	
	-- xrn Chat Overlay 
	local function onUpdate(self,elapsed) 
	  if self.time < GetTime() - 1 then
	    if self:GetAlpha() == 0 then self:Hide() else self:SetAlpha(self:GetAlpha() - .05) end
	  end
	end
	xrn = CreateFrame("Frame",nil,ChatFrame1) 
	xrn:SetSize(ChatFrame1:GetWidth(),30)
	xrn:Hide()
	xrn:SetScript("OnUpdate",onUpdate)
	xrn:SetPoint("TOP",0,0)
	xrn.text = xrn:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
	xrn.text:SetAllPoints()
	xrn.texture = xrn:CreateTexture()
	xrn.texture:SetAllPoints()
	xrn.texture:SetTexture(0,0,0,.50) 
	xrn.time = 0
	function xrn:message(message) 
	  self.text:SetText(message)
	  self:SetAlpha(1)
	  self.time = GetTime() 
	  self:Show() 
	end
	
	-- z1 = target z2 = player
	-- if player is lower than target then ascend until target -1
	-- if 
	-- Fonction to Walk to target.
	-- z1 = target z2 = player
	-- if player is lower than target then ascend until target -1
	-- if 
	-- Fonction to Walk to target.
	function Walk(x1,y1,x2,y2,r2,z1,z2)
--		if x1 or y1 or x2 or y2 or r2 or z1 or z2 == nil then return false end
	 	local angle = math.atan2(y1-y2,x2-x1) + r2 - math.pi 
	 	
	 	if CML_GetDistance("player","target") > 25 then
	 		OptimalHigh = 25
	 	elseif CML_GetDistance("player","target") > 10 then
	 		OptimalHigh = CML_GetDistance("player","target")
	 	else
	 		OptimalHigh = 0
	 	end
	 	
	 	if IsFlying() ~= nil then
		 	if z2 < z1 - 3 + ( 75 * OptimalHigh / 100 ) then
		 		DescendStop() JumpOrAscendStart()	
		 	elseif z2 > z1 + OptimalHigh then
		 		AscendStop() SitStandOrDescendStart()
		 	else
		 		DescendStop()
		 		AscendStop()
		 	end
		end
		
	  	if ( angle < -0.5 
	  	  and angle > -math.pi ) 
	  	  or angle >= math.pi then 
	    	TurnRightStop() TurnLeftStart() 
	  	elseif ( angle > 0.5 
	  	  and angle < math.pi ) 
	  	  or angle < -math.pi then
	    	TurnLeftStop() TurnRightStart()
	  	else
	    	TurnRightStop() TurnLeftStop()
	  	end
	  	
		if sqrt( (x1-x2)^2 + (y1-y2)^2 ) > FollowDistance
	 	  and angle < math.pi/2 
	 	  and angle > -math.pi/2 then 
	 	  	MoveForwardStart() 
	 	else 
	 		MoveForwardStop() 
	 	end 
	 	
	end
	
	xrn:message("\124cFF9999FF...CodeMyLife's PokeRotation...")
end

------- CONFIG
if PQR_LoadLua("PQR_PQI.lua") == nil then
	return false 
end

if CODEMYLIFE_POKEROTATION == nil then
	PQIconfig = {
		name	= "PokeRotation",
		author	= "CodeMyLife",
		abilities = {
		
			{	name = "Objective",
				enable = true,
				tooltip = "|cffFFFFFFWhat's your primary objective.",
				widget = { type = 'select',
					values = {"Pet Leveling","PvP","Beasts of Fables","Masters"},
					value = 1,
					tooltip = "|cffFFFFFFSelect one!",
					width  = 110,
				},
			},
			
			---- Pet Healing  ----
			{ 	name	= "Pet Heal",
				enable	= true,
				tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFMinimum pet |cffFFFFFFHealth Value |cff33CCFFto use their |cffFFFFFFhealing Abilities|cff33CCFF.",
				widget	= { type = "numBox",
					value	= 70,
					step	= 5,
					tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFMinimum pet |cffFFFFFFHealth Value |cff33CCFFto use their |cffFFFFFFhealing Abilities|cff33CCFF.",
				},
			},
				
			----  Swap Out Treshold  ----
			{ 	name	= "Swap Out Health",
				enable	= true,
				tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFMinimum pet |cffFFFFFFHealth Value |cff33CCFFto |cffFFFFFFSwap-out pet 1 and 2|cff33CCFF. |cffFFFFFFPet 3 will always fight until death|cff33CCFF.",
				widget	= { type = "numBox",
					value	= 25,
					step	= 5,
					tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFMinimum pet |cffFFFFFFHealth Value |cff33CCFFto |cffFFFFFFSwap-Out Pets|cff33CCFF.",
				},
			},
			
			----  Swap In Treshold  ----
			{ 	name	= "Swap In Health",
				enable	= true,
				tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFCheck to |cffFFFFFFActivate Pet Switching|cff33CCFF.",
				widget	= { type = "numBox",
					value	= 35,
					step	= 5,
					tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFMinimum |cffFFFFFFHealth to |cffFFFFFFSwap Pets In|cff33CCFF.",
				},
			},
			
			----  Capture Treshold  ----
			{ 	name	= "Capture",
				enable	= true,
				tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFMinimum pet rarity to Capture: |cff"..(RarityColorsTable[1].Color).."1-Poor |cff"..(RarityColorsTable[2].Color).."2-Common |cff"..(RarityColorsTable[3].Color).."3-Uncommon |cff"..(RarityColorsTable[4].Color).."4-Rare.",
				widget = { type = 'select',
					values = {"|cff"..(RarityColorsTable[1].Color).."Poor","|cff"..(RarityColorsTable[2].Color).."Common","|cff"..(RarityColorsTable[3].Color).."Uncommun","|cff"..(RarityColorsTable[4].Color).."Rare"},
					value = 4,
					tooltip = "|cffFFFFFFIn Battle - |cff33CCFFMinimum pet rarity to Capture: |cff"..(RarityColorsTable[1].Color).."1-Poor |cff"..(RarityColorsTable[2].Color).."2-Common |cff"..(RarityColorsTable[3].Color).."3-Uncommon |cff"..(RarityColorsTable[4].Color).."4-Rare.",
					width  = 80,
					
				},
				newSection = true,	
			},
			
			----  Number of Pets to Capture  ----
			{ 	name	= "Number Of Pets",
				enable	= true,
				tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFCheck to |cffFFFFFFManage How Many Pets of Each Kind |cff33CCFFyou want to |cffFFFFFFCapture|cff33CCFF.",
				widget	= { type = "numBox",
					min		= 1,
					max		= 3,
					value	= 1,
					step	= 1,
					tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFHow Many |cffFFFFFFPets of Each Kind do you want to |cffFFFFFFCapture|cff33CCFF.",
				},
			},
			
			----  Revive Battle Pets ----
			{ 	name	= "Revive Battle Pets",
				enable	= true,
				tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFCheck to |cffFFFFFFActivate Revive Battle Pets|cff33CCFF..",
				widget	= { type = "numBox",
					value	= 70,
					step	= 5,
					tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFMinimum |cffFFFFFFTeam Health Value |cff33CCFFto use |cffFFFFFFRevive Battle Pets|cff33CCFF.",
				},
				newSection = true,
			},
			
			----  Pet Leveling  ----		    
		    { 	name	= "Pet Leveling",
				tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFCheck this to |cffFFFFFFMake your Pet in Slot 1 Level Quick. It will interact only once |cff33CCFFand hide behind other pets.",
				enable	= true,
				widget	= { type = "numBox",
					min		= 1,
					max		= 25,
					value	= 25,
					step	= 1,
					tooltip	= "|cffFFFFFFIn Battle - |cff33CCFFSet this value to the |cffFFFFFFlevel |cff33CCFFyou want |cffFFFFFFto consider the pet high level enough to fight|cffFF0000(cancels Pet Leveling).",
				},
			},
			
			----  Leveling Priority  ----
			{ 	name	= "Leveling Priority",
				enable	= true,
				tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFChoose the desired Table sorting for Pet Leveling",
				widget = { type = 'select',
					values = {"|cff"..(RarityColorsTable[3].Color).."Low Level","|cffFF0000High Level","|cffFFFFFFNon-Wilds|cff33CCFF/|cff"..(RarityColorsTable[3].Color).."Low Level","|cffFFFFFFNon-Wilds|cff33CCFF/|cffFF0000HighLevel"},
					value = 3,
					tooltip = "|cff"..(RarityColorsTable[3].Color).."Low Level |cff33CCFFwill add priority to |cff"..(RarityColorsTable[3].Color).."Low Level Pets. |cffFFFFFFNon-Wild |cff33CCFFwill add priority to |cffFFFFFFNon-Wild Pets. |cffFFFFFFFavorite |cff33CCFFis |cffFFFFFFTop Priority |cff33CCFFby |cffFFFFFFDefault.",
					width  = 120,
					
				},	
			},
			
			----  Leveling Rarity  ----
			{ 	name	= "Leveling Rarity",
				enable	= true,
				tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFMinimum pet rarity to Level: |cff"..(RarityColorsTable[1].Color).."1-Poor |cff"..(RarityColorsTable[2].Color).."2-Common |cff"..(RarityColorsTable[3].Color).."3-Uncommon |cff"..(RarityColorsTable[4].Color).."4-Rare.",
				widget = { type = 'select',
					values = {"|cff"..(RarityColorsTable[1].Color).."Poor","|cff"..(RarityColorsTable[2].Color).."Common","|cff"..(RarityColorsTable[3].Color).."Uncommun","|cff"..(RarityColorsTable[4].Color).."Rare"},
					value = 4,
					tooltip = "|cffFFFFFFIn Battle - |cff33CCFFMinimum pet rarity to Level: |cff"..(RarityColorsTable[1].Color).."1-Poor |cff"..(RarityColorsTable[2].Color).."2-Common |cff"..(RarityColorsTable[3].Color).."3-Uncommon |cff"..(RarityColorsTable[4].Color).."4-Rare.",
					width  = 80,
					
				},	
			},
			
			----  Pet Swapper  ----
			{ 	name	= "Pet Swap Max",
				enable	= true,
				tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFCheck to |cffFFFFFFActivate Pet Swapper|cff33CCFF.",
				widget	= { type = "numBox",
					min		= 2,
					max		= 25,
					value	= 25,
					step	= 1,
					tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFDesired |cffFFFFFFMaximum Slot 1 Level|cff33CCFF.",
				},
			},
			{ 	name	= "Pet Swap Min",
				enable	= true,
				tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFCheck to |cffFFFFFFActivate Pet Swapper|cff33CCFF.",
				widget	= { type = "numBox",
					min		= 1,
					max		= 25,
					value	= 1,
					step	= 1,
					tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFDesired |cffFFFFFFMinimum Slot 1 Level|cff33CCFF.",
				},
			},
			
			----  Auto Clicker  ----
			{ 	name = "Auto Clicker",
				enable = false,
				tooltip = "|cffFFFFFFOut of Battle - |cff33CCFFChase Pets!",
			 	widget = { type = 'txtbox', 
			    	value = '"Pet Name"', 
			   		width = 80,
					tooltip = "|cffFFFFFFOut of Battle - |cff33CCFFEnter the |cffFFFFFFExact Pet Name |cff33CCFFyou want |cffFFFFFFTo Chase|cff33CCFF.",
				},
				newSection = true,
			 },
			 
			 ----  Follower Distance  ----
			{ 	name = "Follower Distance",
				enable = false,
				tooltip = "|cffFFFFFFOut of Battle - |cff33CCFFActivate |cffFFFFFFFollower Max Distance|cff33CCFF.",
				widget	= { type = "numBox",
					min		= 10,
					max		= 300,
					value	= 30,
					step	= 10,
					tooltip	= "|cffFFFFFFOut of Battle - |cff33CCFFSet this value to the |cffFFFFFFRange |cff33CCFFyou want to |cffFFFFFF consider the pet close enough to follow it|cff33CCFF.",
				},
			},
			
			----  PvP  ----
			{ 	name	= "PvP",
				enable	= false,
				tooltip	= "|cffFFFFFFQueue for PvP Match|cff33CCFF.",
				widget	= { type = "numBox",
					min		= 1,
					max		= 3,
					value	= 1,
					step	= 1,
					tooltip	= "|cffFFFFFFPet Slot |cff33CCFFto use on |cffFFFFFFPvP Match Start|cff33CCFF.",
				},
				newSection = true,
			},
		},		
		
		----  Pause  ----
		hotkeys = {
			{	name	= "Pause",
				enable	= true,
				hotkeys	= {'la'},
				tooltip	= "|cff33CCFFAssign |cffFFFFFFPause |cff33CCFFKeybind.",
			},
		},
	}
	CODEMYLIFE_POKEROTATION = PQI:AddRotation(PQIconfig)
end
	
-- OPTIONS -- 
ObjectiveCheck				= PQI_CodeMyLifePokeRotation_Objective_enable
ObjectiveValue				= PQI_CodeMyLifePokeRotation_Objective_value
PetLevelingCheck			= PQI_CodeMyLifePokeRotation_PetLeveling_enable
PetLevelingValue			= PQI_CodeMyLifePokeRotation_PetLeveling_value
ReviveBattlePetsCheck 		= PQI_CodeMyLifePokeRotation_ReviveBattlePets_enable
ReviveBattlePetsValue		= PQI_CodeMyLifePokeRotation_ReviveBattlePets_value
PetHealValue				= PQI_CodeMyLifePokeRotation_PetHeal_value
PetHealCheck				= PQI_CodeMyLifePokeRotation_PetHeal_enable
CaptureValue				= PQI_CodeMyLifePokeRotation_Capture_value
CaptureCheck				= PQI_CodeMyLifePokeRotation_Capture_enable
NumberOfPetsValue			= PQI_CodeMyLifePokeRotation_NumberOfPets_value
AutoClickerValue			= PQI_CodeMyLifePokeRotation_AutoClicker_value
AutoClickerCheck			= PQI_CodeMyLifePokeRotation_AutoClicker_enable
FollowerDistanceValue		= PQI_CodeMyLifePokeRotation_FollowerDistance_value
FollowerDistanceCheck		= PQI_CodeMyLifePokeRotation_FollowerDistance_enable

LevelingPriorityValue 		= PQI_CodeMyLifePokeRotation_LevelingPriority_value
LevelingPriorityCheck		= PQI_CodeMyLifePokeRotation_LevelingPriority_enable
LevelingRarityValue 		= PQI_CodeMyLifePokeRotation_LevelingRarity_value
LevelingRarityCheck			= PQI_CodeMyLifePokeRotation_LevelingRarity_enable
SwapInHealthValue			= PQI_CodeMyLifePokeRotation_SwapInHealth_value
SwapInHealthCheck			= PQI_CodeMyLifePokeRotation_SwapInHealth_enable
SwapOutHealthValue			= PQI_CodeMyLifePokeRotation_SwapOutHealth_value
SwapOutHealthCheck			= PQI_CodeMyLifePokeRotation_SwapOutHealth_enable
-- PvP Queue
PvPCheck					= PQI_CodeMyLifePokeRotation_PvP_enable
PvPSlotValue				= PQI_CodeMyLifePokeRotation_PvP_value
-- Pet Swapper
PetSwapCheck				= PQI_CodeMyLifePokeRotation_PetSwapMax_enable
PetSwapValue				= PQI_CodeMyLifePokeRotation_PetSwapMax_value
PetSwapMinCheck				= PQI_CodeMyLifePokeRotation_PetSwapMin_enable
PetSwapMinValue				= PQI_CodeMyLifePokeRotation_PetSwapMin_value
-- Pause
PauseKey					= PQI:IsHotkeys(PQI_CodeMyLifePokeRotation_Pause_key)
PauseKeyCheck				= PQI_CodeMyLifePokeRotation_Pause_enable

if PauseKeyCheck == nil then return true end

-------- New Pets
-- Alpine Chipmunk
-- Arcane Eye
-- Arctic Hare
-- Bandicoon
-- Black Lamb
-- Black Rat
-- Bucktooth Flapper
-- Cockroach
-- Cogblade Raptor
-- Corefire Imp
-- Clefthoof Runt
-- Clock'em
-- Crimson Geode
-- Crimson Whelpling
-- Dancing Water Skimmer
-- Dark Phoenix Hatchling
-- Dun Morogh Cub
-- Effervescent Glowfly
-- Eggbert
-- Emerald Turtle
-- Emerald Whelpling
-- Elementium Geode
-- Feral Vermling
-- Feverbite Hatchling
-- Flayer Youngling
-- Fossilized Hatchling
-- Fishy
-- Garden forg
-- Jungle Grub
-- Lava Crab
-- Living Sandling
-- Lil' Tarecgosa
-- Lil' XT
-- Luyu Moth
-- Magical Crawdad
-- Minfernal
-- Mini Mindslayer
-- Pterordax Hatchling
-- Qiraji Guardling
-- Rapana Whelk
-- Terrible Turnip
-- Tiny Harvester
-- Tiny Twister
-- Thundering Serpent Hatchling
-- Thundertail Flapper
-- Tundra Penguin
-- Viscidious Globule
-- Warpstalker Hatchling
-- Water Waveling
-- Wild Crimson Hatchling
-- Wild Golden Hatchling
-- Wild Jade Hatchling
-- Worg Pup
-- Zandalari Toenibbler

--- Notes How To:

-- Beast of Fables:
-- - Set Objective to "Beasts of Fables". 
-- This will disactivate the Pet Swapper and also the infight Pet Swapper.
-- This will disactivate the Auto-Clicker.
-- - Select 3 pets you want to use for the Fable.
-- - Engage Fight.
-- N.B. As of now, Moths/Beetles(and scarabs and such that have Apocalypse)/Striders works togheter to 
-- put the emphasis on Fable Nuke Strategy. Best way to clean Fables with PokeRotation is by having 
-- a Beetle in slot 1 and 2 Striders/Moths combinations in slot 2 and 3. This is intended to cast 
-- Apocalypse on start, hide the beetle, survive 15 rounds and win.

-- Collections
if not LoadAllLists then
	LoadAllLists = true
	
	--Remove Debuffs/Buffs
	--667, Aged Yolk
	--763, Sear Magic
	--835, Eggnog
	--941, High Fiber
	
	--Only works if at least one ally is dead
	--665, Consume Corpse
	
	-- AoE Attacks to be used only while there are 3 ennemies.
	AoEPunchList = { 
		299, -- Arcane Explosion
		319, -- Magma Wave
		387, -- Tympanic Tantrum
		404, -- Sunlight
		419, -- Tidal Wave
		668, -- Dreadfull Breath
		644, -- Quake
		649, -- BONESTORM
		741, -- Whirlwind
		768, -- Omnislash
		774, -- Rapid Fire
		923, -- Flux
	} 
	
	-- Roots and other buffs. These debuff on us will disable Pet Swap.
	BuffNoSwap  = { 
	  	248, -- Rooted
	  	294, -- Charging Rocket
		302, -- Planted
	  	338, -- Webbed
	  	370, -- Sticky Goo
	}
	  
	-- Abilities that give immunity on the next spell
	CantDieList = { 
		284, -- Survival
	}
	
	-- Attacks that are stronger if the ennemi have more life than us.
	ComebackList = { 
		253, -- Comeback
		405, -- Early Advantage
	}
	
	-- Damage Buffs that we want to cast on us.
	DamageBuffList = { 
		188, -- Accuracy
		197, -- Adrenal Glands
		216, -- Inner Vision
		223, -- Focus Chi
		252, -- Uncanny Luck
		263, -- Crystal Overload
		279, -- Heartbroken
		347, -- Roar
		375, -- Trumpet Strike
		426, -- Focus
		488, -- Amplify Magic
		521, -- Hawk Eye
		536, -- Prowl
		589, -- Arcane Storm
		614, -- Competitive Spirit
		740, -- Frenzyheart Brew
		791, -- Stimpack
		809, -- Roll
		936, -- Caw
		
	}
	
	-- Debuff to cast on ennemy. This list will check for Abilit-1 debuffs.
	DeBuffList = { 
		152, -- Poison Fang
		155, -- Hiss
		167, -- Nut Barrage
		176, -- Volcano
		178, -- Immolate
		179, -- Conflagrate
		204, -- Call Lightning
		206, -- Call Blizzard
		212, -- Siphon Life
		249, -- Grasp
		305, -- Exposed Wounds
		314, -- Mangle
		339, -- Sticky Web
		352, -- Banana Barrage
		359, -- Sting
		369, -- Acidic Goo
		371, -- Sticky Goo
		380, -- Poison Spit
		382, -- Brittle Webbing
		398, -- Poison Lash
		411, -- Woodchipper
		447, -- Corrosion
		463, -- Flash
		497, -- Soothe
		501, -- Flame Breath
		515, -- Flyby 
		524, -- Squawk
		527, -- Stench
		592, -- Wild Magic
		628, -- Rock Barrage
		630, -- Poisoned Branch
		631, -- Super Sticky Goo
		642, -- Egg Barrage
		650, -- Bone Prison
		743, -- Creeping Fungus
		756, -- Acid Touch
		784, -- Shriek
		786, -- Blistering Cold
		803, -- Rip
		811, -- Magma Trap
		909, -- Paralyzing Shock
		919, -- Black Claw
		932, -- Croak
		964, -- Autumn Breeze
	} 
	
	SpecialDebuffsList = {
		{ 	Ability = 270, 	Debuff = 271 	}, -- Glowing Toxin
		{	Ability = 362,  Debuff = 542	}, -- Howl
		{ 	Ability = 448, 	Debuff = 781 	}, -- Creeping Ooze
		{	Ability = 468,  Debuff = 469	}, -- Agony
		{	Ability = 522,  Debuff = 738	}, -- Nevermore
		{	Ability = 580,  Debuff = 498    }, -- Food Coma/ Asleep
		{ 	Ability = 632, 	Debuff = 633 	}, -- Confusing Sting	
		{ 	Ability = 657, 	Debuff = 658 	}, -- Plagued Blood
		{ 	Ability = 784, 	Debuff = 494 	}, -- Shriek/ Attack Reduction
		{	Ability = 869,  Debuff = 153	}, -- Darkmoon Curse/ Attack Reduction
		{	Ability = 486,  Debuff = 153	}, -- Drain Power/ Attack Reduction
		{	Ability = 940,  Debuff = 939    }, -- Touch of the Animus
	}
	
	-- Abilities used to Deflect
	DeflectorList = { 
		312, -- Dodge
		440, -- Evanescence
		490, -- Deflection
		764, -- Phase Shift
	} 
	
	ExecuteList = { 
		538, -- Devour
		802, -- Ravage
		917, -- Bloodfang
	}
	
	-- Apocalypse.
	FifteenTurnList = { 
		519, -- Apocalypse
	}
	MeteorStrikeList = {
		518, -- Apocalypse
		519, -- Apocalypse
	}
	
	KamikazeList = { 
		282, -- Explode
		321, -- Unholy Ascension
		568, -- Feign Death
		652, -- Haunt
		663, -- Corpse Explosion
	}
	
	-- Abilities to be cast to heal ouself instantly.
	HealingList = { 
		123, -- Healing Wave
		168, -- Healing Flame
		173, -- Cautherize
		230, -- Cleansing Rain
		247, -- Hibernate
		273, -- Wish
		278, -- Repair
		298, -- Inspiring Song
		383, -- Leech Life
		533, -- Rebuild
		539, -- Bleat
		573, -- Nature's Touch
		576, -- Perk Up
		578, -- Buried Treasure
		598, -- Emerald Dream
		611, -- Ancient Blessing
		745, -- Leech Seed
		770, -- Restoration
		776, -- Love Potion
		922, -- Healing Stream
		-- Leech
		121, -- Death Coil
		160, -- Consume
		449, -- Absorb
		937, -- Siphon Anima
	}
	
	HighDamageIfBuffedList = {
		{	Ability = 221,  Debuff = 927	}, -- Takedown if Stunned
		{	Ability = 221,  Debuff = 174	}, -- Takedown if Stunned (second stun ID)
		{	Ability = 250,  Debuff = 338	}, -- Spiderling Swarm if Webbed
		{ 	Ability = 423, 	Debuff = 491 	}, -- Blood in the Water if Bleeding.
		{	Ability = 461,  Debuff = 462	}, -- Light if Blinded
		{	Ability = 461,  Debuff = 954	}, -- Light if Blinded (second ID)
		{ 	Ability = 345, 	Debuff = 491 	}, -- Maul if Bleeding.
	}	
	HighDMGList = { 
		908, -- Jolt
	
		120, -- Howling Blast
		170, -- Lift-Off
		172, -- Scorched Earth
		179, -- Conflagrate
		158, -- Counterstrike
		186, -- Reckless Strike
		204, -- Call Lightning
		209, -- Ion Cannon
		226, -- Fury of 1,000 Fists
		256, -- Call Darkness
		258, -- Starfall
		330, -- Sons of the Flame
		345, -- Maul
		348, -- Maul (Stun)
		376, -- Headbutt
		400, -- Entangling Roots
		402, -- Stun Seed
		414, -- Frost Nova
		442, -- Spectral Strike
		450, -- Expunge
		453, -- SandStorm
		456, -- Clean-Up
		457, -- Sweep
		460, -- Illuminate
		466, -- Nether Gate
		481, -- Deep Freeze
		493, -- Hoof
		506, -- Cocoon Strike
		508, -- Mosth Dust
		517, -- Nocturnal Strike
		518, -- Predatory Strike
		532, -- Body Slam
		541, -- Chew
		572, -- MudSlide
		586, -- Gift of Winter's Veil
		593, -- Surge of Power
		595, -- Moonfire
		607, -- Cataclysm
		609, -- Instability
		612, -- Proto-Strike
		621, -- Stone Rush
		645, -- Launch
		646, -- Shock and Awe
		649, -- Bone Storm
		669, -- Backflip
		746, -- Spore Shrooms
		752, -- Soulrush
		753, -- Solar Beam
		761, -- Heroic Leap
		762, -- Haymaker
		767, -- Holy Charge
		769, -- Surge of Light
		773, -- Shot Through The Heart
		777, -- Missile
		779, -- Thunderbolt
		788, -- Gauss Rifle
		792, -- Darkflame
		812, -- Sulfuras Smash
		814, -- Rupture
		912, -- QuickSand
		913, -- Spectral Spine
		916, -- Haywire
		942, -- Frying Pan

	} 
	
	-- Buffs that heal us.
 	HoTBuffList = { 
		267, -- Phytosynthesis
		303, -- Plant
		574, -- Nature's Ward

	}
	-- Buffs that heal us.
	HoTList = { 
		160, -- Consume
		230, -- Cleansing Waters
		268, -- Phytosynthesis
		302, -- Planted
		820, -- Nature's Ward
	 }
	 
	ImmunityList = { 
		311, -- Dodge
		331, -- Submerged
		341, -- Flying
		340, -- Burrowed
		505, -- Cocoon Strike
		830, -- Dive
		839, -- Leaping
		852, -- Flying (Launch)
		926, -- Soothe
	}
	
	LastStandList = { 
		283, -- Survival
		568, -- Feign Death
		576, -- Perk Up
		611, -- Ancient Blessing
		794, -- Dark Rebirth
	}
	
	LifeExchangeList = { 
		277, -- Life Exchange
	}
	
	-- Attack that will damage next turn.
	OneTurnList = { 
		159, -- Burrow
		407, -- Meteor Strike
		564, -- Dive
		606, -- Elementium Bolt
		645, -- Launch
		828, -- Sons of the Root
	}
	
	-- Attacks to be used for Pet Leveling
	PetLevelingList = { 
		-- High Priority
		
		-- Low Priority
		155, -- Hiss
		492, -- Rake
	}	
	
	-- Basic attacks
	PunchList = { 
		-- High Priority
		156, -- Vicious Fang
		169, -- Deep Breath
		233, -- Frog Kiss
		293, -- Launch Rocket
		297, -- Pump
		301, -- Lock-On
		323, -- Gravity
		354, -- Barrel Toss
		377, -- Trample
		411, -- Woodchipper
		413, -- Ice Lance
		437, -- Onyx Bite
		459, -- Wind-Up
		471, -- Weakness
		476, -- Dark Simulacrum
		507, -- Moth Balls
		508, -- Moth Dust
		509, -- Surge
		529, -- Belly Slide
		563, -- Quick Attack
		566, -- Powerball
		594, -- Sleeping Gas
		616, -- Blinkstrike
		754, -- Screeching Gears
		765, -- Holy Sword
		775, -- Perfumed Arrow
		778, -- Charge
		849, -- Huge, Sharp Teeth!
		921, -- Hunting Party
		930, -- Huge Fang
		943, -- Chop
		958, -- Trihorn Charge
		-- Normal Priority	
		110, -- Bite
		111, -- Punch
		112, -- Peck
		113, -- Burn
		114, -- Beam
		115, -- Breath
		116, -- Zap
		117, -- Infected Claw
		118, -- Water Jet
		119, -- Scratch
		121, -- Death Coil (Heal)
		122, -- Tail Sweep
		163, -- Stampede 
		184, -- Quills
		193, -- Flank
		202, -- Trash
		210, -- Shadow Slash
		219, -- Jab
		276, -- Swallow You Whole
		347, -- Roar
		349, -- Smash
		355, -- Triple Snap
		356, -- Snap
		360, -- Flurry
		367, -- Chomp
		378, -- Strike
		384, -- Metal Fist
		390, -- Demolish
		393, -- Shadowflame
		406, -- Crush
		420, -- Slicing Wind
		421, -- Arcane Blast
		422, -- Shadow Shock
		424, -- Tail Slap
		429, -- Claw
		432, -- Jade Claw
		445, -- Ooze Touch
		449, -- Absorb
		452, -- Broom
		455, -- Batter
		472, -- Blast of Hatred
		473, -- Focused Beams
		474, -- Interupting Gaze
		477, -- Snowball
		478, -- Magic Hat
		482, -- Laser
		483, -- Psychic Blast
		484, -- Feedback
		492, -- Rake 
		499, -- Diseased Bite
		514, -- Wild Winds
		525, -- Emerald Bite
		528, -- Frost Spit
		608, -- Nether Blast
		617, -- Spark
		626, -- Skitter
		630, -- Poisoned Branch
		648, -- Bone Bite
		668, -- Dreadfull Breath
		712, -- Railgun
		713, -- Blitz
		771, -- Bow Shot
		782, -- Frost Breath
		789, -- U-238 Rounds
		800, -- Impale
		801, -- Stone Shot
		826, -- Weakening Blow
		901, -- Fel Immolate
		910,  -- Sand Bolt
		-- Low Priority
		167, -- Nut Barrage
		253, -- Comeback
		307, -- Kick
		383, -- Leech Life
		389, -- Overtune
		501, -- Flame Breath
		509, -- Surge
		-- Three Turns
		124, -- Rampage
		163, -- Stampede
		198, -- Zergling Rush
		581, -- Flock
		666, -- Rabid Bite
		668, -- Dreadful Breath
		706, -- Swarm
		870, -- Murder
	} 
	
	-- Attacks that are stronger if we are quicker.
	QuickList = { 
		184, -- Quills
		202, -- Thrash
		228, -- Tongue Lash
		307, -- Kick
		360, -- Flurry
		394, -- Lash
		412, -- Gnaw
		441, -- Rend
		455, -- Batter
		474, -- Interrupting Gaze
		504, -- Alpha Strike
		535, -- Pounce
		571, -- Horn Attack
		617, -- Spark
		789, -- U-238 Rounds
		938, -- Interrupting Jolt
	}
	
	-- List of Buffs that we want to cast on us.
	SelfBuffList = { 
		259, -- Invisibility
		318, -- Thorns
		315, -- Spiked Skin
		325, -- Beaver Dam
		366, -- Dazzling Dance
		409, -- Immolation
		426, -- Focus
		444, -- Prismatic Barrier
		479, -- Ice Barrier
		486, -- Drain Power
		488, -- Amplify Magic
		757, -- Lucky Dance
		905, -- Cute Face
		906, -- Lightning Shield
		914, -- Spirit Spikes
		944, -- Heat Up
		962, -- Ironbark
		-- Damage
		188, -- Accuracy
		197, -- Adrenal Glands
		208, -- Supercharge
		216, -- Inner Vision
		263, -- Crystal Overload
		279, -- Heartbroken
		347, -- Roar
		375, -- Trumpet Strike
		488, -- Amplify Magic
		520, -- Hawk Eye
		589, -- Arcane Storm
		791, -- Stimpack
	}
	
	SpecialSelfBuffList = {
		{ 	Ability = 597, 	Buff = 823 	}, -- Emerald Presence
		{	Ability = 851,  Buff = 544	}, -- Vicious Streak
		{	Ability = 364,  Buff = 544	}, -- Leap
		{	Ability = 567,  Buff = 544	}, -- Rush
		{	Ability = 579,  Buff = 735	}, -- Gobble Strike
		{	Ability = 957,  Buff = 485	}, -- Evolution
	}
	
	ShieldBuffList = { 
		165, -- Crouch
		225, -- Staggered Steps
		310, -- Shell Shield
		334, -- Decoy
		392, -- Extra Plating
		431, -- Jadeskin
		436, -- Stoneskin
		465, -- Illusionary Barrier
		751, -- Soul Ward
		760, -- Shield Block
		934, -- Bubble
		960, -- Trihorn Shield
	}
	
	SlowPunchList = {
		228, -- Tongue Lash
		233, -- Frog Kiss
		360, -- Flurry
		377, -- Trample
		390, -- Demolish
		394, -- Lash
		455, -- Batter
		475, -- Eyesurge
		529, -- Belly Slide
	}
	
	SootheList = {
		497, -- Soothe
	}
	
	SpeedBuffList = { 
		162, -- Adrenaline Rush
		194, -- Metabolic Boost
		389, -- Overtune
		838, -- Centrifugal Hooks
	 }
	 
	 SpeedDeBuffList = { 
		357, -- Screech - 25%
		416, -- Frost Shock - 25%
		475, -- Eyeblast
		929, -- Slither
	 }
	 
	 -- Pass Turn
	StunnedDebuffs = {
		498,
		822,
		927,
	}
	
	StunList = { 
		227, -- Blackout Kick
		348, -- Bash
		350, -- Clobber
		569, -- Crystal Prison
		654, -- Ghostly Bite
		670, -- Snap Trap
		766, -- Holy Justice
		772, -- LoveStruck
		780, -- Death Grip
	} 
	
	SuicideList = { 
		282, -- Explode
		321, -- Unholy Ascension
		836, -- Baneling Burst
		652, -- Haunt
		663, -- Corpse Explosion
	} 
	
	SwapoutDebuffList  = { 
		358, -- 
		379, -- Poison Spit
		822, -- Frog Kiss
	}
	  	
	TeamDebuffList = { 
		167, -- Nut Barrage
		190, -- Cyclone
		214, -- Death and Decay
		232, -- Swarm of Flies
		503, -- Flamethrower
		575, -- Slippery Ice
		640, -- Toxic Smoke
		642, -- Egg Barrage
		644, -- Rock Barrage
		860, -- Flamethrower
		920, -- Primal Cry
	}
	
	-- Attack that will damage in three turns.
	ThreeTurnList = { 
		386, -- XE-321 Boombot
		513, -- Whirlpool
		634, -- Minefield
		418, -- Geyser
		606, -- Elementium Bolt
		647, -- Bombing Run
	}
	
	ThreeTurnHighDamageList = { 
		124, -- Rampage
	 	218, -- Curse of Doom
		489, -- Mana Surge
		624, -- Ice Tomb
		636, -- Sticky Grenade
		917, -- Bloodfang				
	}
	
	-- Attacks to Deflect.
	ToDeflectList = { 
		296, -- Pumped Up
		331, -- Submerged
		340, -- Burrow
		353, -- Barrel Ready
		341, -- Lift-Off
		830, -- Dive
		839, -- Leaping

	}
	
	TeamHealBuffsAbilities = { 
		511, -- Renewing Mists
		539, -- Bleat
		254, -- Tranquility
	 }

	TeamHealBuffsList = { 
		510, -- Renewing Mists
		255, -- Tranquility
	}
	
	TurretsList = { 
		710, -- Build Turret
	} 
	
	
	-- List of Pets to chase.
	MopList = {	
		"Adder",
		"Alpine Chipmunk",
		"Alpine Foxling",
		"Alpine Foxling Kit",
		"Alpine Hare",
		"Amber Moth",
		"Amethyst Spiderling",
		"Anodized Robo Cub",
		"Arctic Fox Kit",
		"Ash Lizard",
		"Ash Viper",
		"Baby Ape",
		"Bandicoon",
		"Bandicoon Kit",
		"Bat",
		"Beetle",
		"Biletoad",
		"Black Lamb",
		"Black Rat",
		"Blighted Squirrel",
		"Blighthawk",
		"Borean Marmot",
		"Bucktooth Flapper",
		"Cat",
		"Cheetah Cub",
		"Chicken",
		"Clefthoof Runt",
		"Clouded Hedgehog",
		"Cockroach",
		"Cogblade Raptor",
		"Coral Adder",
		"Coral Snake",
		"Crested Owl",
		"Crimson Geode",
		"Crimson Shale Hatchling",
		"Crystal Beetle",
		"Crystal Spider",
		"Dancing Water Skimmer",
		"Darkshore Cub",
		"Death's Head Cockroach",
		"Desert Spider",
		"Dragonbone Hatchling",
		"Dung Beetle",
		"Effervescent Glowfly",
		"Elder Python",
		"Electrified Razortooth",
		"Elfin Rabbit",
		"Emerald Boa",
		"Emerald Proto-Whelp",
		"Emerald Shale Hatchling",
		"Emerald Turtle",
		"Emperor Crab",
		"Eternal Strider",
		"Fawn",
		"Fel Flame",
		"Festering Maggot",
		"Fire Beetle",
		"Fire-Proof Roach",
		"Fledgling Nether Ray",
		"Fjord Rat",
		"Fjord Worg Pup",
		"Forest Moth",
		"Fluxfire Feline",
		"Frog",
		"Fungal Moth",
		"Gazelle Fawn",
		"Gilded Moth",
		"Giraffe Calf",
		"Gold Beetle",
		"Golden Civet",
		"Golden Civet Kitten",
		"Grasslands Cottontail",
		"Grassland Hopper",
		"Grasslands Cottontail",
		"Grey Moth",
		"Grizzly Squirrel",
		"Grove Viper",
		"Harpy Youngling",
		"Highlands Mouse",
		"Highlands Skunk",
		"Highlands Turkey",
		"Horned Lizard",
		"Horny Toad",
		"Huge Toad",
		"Imperial Eagle Chick",
		"Infected Fawn",
		"Infected Squirrel",
		"Infinite Whelping",
		"Irradiated Roach",
		"Jumping Spider",
		"Jungle Darter",
		"Jungle Grub",
		"King Snake",
		"Kuitan Mongoose",
		"Kun-Lai Runt",
		"Larva",
		"Lava Crab",
		"Leopard Scorpid",
		"Leopard Tree Frog",
		"Little Black Ram",
		"Locust",
		"Lofty Libram",
		"Lost of Lordaeron",
		"Luyu Moth",
		"Mac Frog",
		"Maggot",
		"Malayan Quillrat",
		"Malayan Quillrat Pup",
		"Marsh Fiddler",
		"Masked Tanuki",
		"Masked Tanuki Pup",
		"Mei Li Sparkler",
		"Mirror Strider",
		"Minfernal",
		"Molten Hatchling",
		"Mongoose Pup",
		"Mountain Skunk",
		"Nether Faerie Dragon",
		"Nether Roach",
		"Nexus Whelpling",
		"Nordrassil Wisp",
		"Oasis Moth",
		"Oily Slimeling",
		"Parrot",
		"Plains Monitor",
		"Prairie Dog",
		"Prairie Mouse",
		"Qiraji Guardling",
		"Rabbit",
		"Rabid Nut Varmint 5000",
		"Rapana Whelk",
		"Rat",
		"Rattlesnake",
		"Ravager Hatchling",
		"Red-Tailed Chipmunk",
		"Resilient Roach",
		"Roach",
		"Robo-Chick",
		"Rock Viper",
		"Ruby Sapling",
		"Rusty Snail",
		"Sand Kitten",
		"Sandy Petrel",
		"Savory Beetle",
		"Scarab Hatchling",
		"Scorpid",
		"Scorpling",
		"Scourged Whelpling",
		"Sea Gull",
		"Sidewinder",
		"Shimmershell Snail",
		"Shrine Fly",
		"Shore Crab",
		"Shy Bandicoon",
		"Sifang Otter",
		"Silent Hedgehog",
		"Silithid Hatchling",
		"Silky Moth",
		"Small Frog",
		"Snake",
		"Snow Cub",
		"Snowy Owl",
		"Softshell Snapling",
		"Spawn of Onyxia",
		"Spiky Lizard",
		"Spiny Lizard",
		"Spiny Terrapin",
		"Spirit Crab",
		"Sporeling Sprout",
		"Spotted Bell Frog",
		"Squirrel",
		"Stinkbug",
		"Stormwind Rat",
		"Stripe-Tailed Scorpid",
		"Stunded Shardhorn",
		"Stunted Yeti",
		"Summit Kid",
		"Sumprush Rodent",
		"Swamp Croaker",
		"Tainted Cockroach",
		"Tainted Moth",
		"Tainted Rat",
		"Thundertail Flapper",
		"Tiny Bog Beast",
		"Tiny Twister",
		"Toad",
		"Tolai Hare",
		"Tol'vir Scarab",
		"Topaz Shale Hatchling",
		"Tree Python",
		"Tundra Penguin",
		"Turkey",
		"Turquoise Turtle",
		"Twilight Beetle",
		"Twilight Fiendling",
		"Unborn Val'kyr",
		"Venomspitter Hatchling",
		"Warpstalker Hatchling",
		"Water Snake",
		"Water Waveling",
		"Wild Crimson Hatchling",
		"Wild Golden Hatchling",
		"Wild Jade Hatchling",
		"Yakrat",
		"Yellow-Bellied Marmot",
		"Zooey Snake",
	}
end

--- CHANGELOG
-- PokeRotation v1.20
-- - Hopefully fixed Nav issues. Do not forget to make sure your offsets are right or use Click-To-Move.

-- PokeRotation v1.19
-- - Changed follower from nav to click-to-move because PQR_UnitInfo wich is used for Nav is actually broken.

-- PokeRotation v1.18
-- - Reverted Follower to the old setup. Should not give issues with stopping uselessly. I reverted for now as I do not have time to make it work better 
-- so for now its the old nav and nothing to prevent "bottish" behaviours so beware.

-- PokeRotation v1.17
-- - Fixed some 5.4 lua error.
-- - New Pet Swap Table is Working now. Enjoy more options to Pet Swapping. This should fix the Pet Leveling 1 round.
-- - Implemented FableNuke Beast of Fable Rotation.

-- PokeRotation v1.16
-- - Restored old version of swapper as new one was too buggy. I will rewrite it from scratch with tables anyway so I just
-- put back old switcher with lil additions so it should all work beside Wild and Favorites priority for leveling. I was unsatisfied with the new version.

-- PokeRotation v1.15
-- - Removed PSX print when swapping, was using it to test.

-- PokeRotation v1.14
-- - Kuukuu made the full list of abilities. Now ALL abilities are coded beside Remove Debuffs/Buffs Aged Yolk,
-- Sear Magic, Eggnog and High Fiber and the Canibalism ability Consume Corpse.
-- - Fixed (Hopefully) 1 round leveling even if both team misses or heal.
-- - Fixed some issue with swapper that would result in eternal loop leading to client crash in some rare situations.
-- - Fixed some other swapper issues.
-- - Improved Overlay Timer at the end of fight.
-- - Added range for auto-clicker to set maximum range you want the charater to chase pets.
-- - Added very light timer when out of battle to let the pet swaps effectively.
-- - Added priority to Pet Swapper Leveling to Swap in the Favorite Pets first. It will still call the 
-- Non-Favorites if no Favorite Pet Match the desired swap levels.
-- - Added Objective Selection to allow Selection of Different Rotations by default. This will allow
-- better usage of skills depending on situations.

-- PokeRotation v1.13
-- - Added ALL Batlle Pet Names to collections. Nav can now be used all over the maps. Enjoy!
-- - If you find of any that is missing please let me know.
-- - CheckBox Swap Out Health should now work accordingly, if you uncheck, it should no longer pet swap.


-- PokeRotation v1.12
-- - Kuukuu added a lot of abilities to collections, now only Humanoid, Magic, Mech, and Undead are not all coded, the rest should be 100% 
-- working(abilities of these types, not necessarily pets.) TYVM Kuukuu for the hard effort!

-- PokeRotation v1.11
-- - Fixed Pet Swap Max level to make it work with lvl 25 enabled.
-- - Added Capture Option to capture specific Number of Pets instead of always 3. 

-- PokeRotation v1.10
-- - Fixed PvP Queueing, my bad.

-- Pokerotation v1.09
-- - Added Pause Button that can be assigned in PQI. To pause both in and out of battle.
----In Battle Mods
-- - Modifications to Switcher to take best pet against ennemy pet when switching.
-- - Fixed a bug that was occuring when Pet Journal is not synced to battle that was resulting in pets spamming wrong abilities.
----Out of Battle Mods
-- - Added options to swap leveling pet in slot 1 to PQI.
-- - Added options to swap pets in slot 2 and 3 if they are under Swap In Threshold. The profile will take pets that are over Pet Swap Value and that you have set to favorites in your pet journal.
-- - Added PvP Queueing options to PQI.
-- - Slightly improved Navigation.
----Know issue
-- - If you set search parameters in pet journal the swapper will throw errors. I know what's causing it but I still have to find a fix for this.

-- Pokerotation v1.08
-- - Added Nav Engine to enable semi-afk pet farming. As usual, don't get too far, keep an eye to it.
-- - Added health value in PQI for SwapOut/SwapIn.
-- - Should now switch properly if pet3 is dead.

-- PokeRotation v1.07
-- - Fixed Capture lua error.
-- - Optimized Switching.



---- PokeRotation Nav system ---
if PetLevelingCheck == nil then return false end
if IsSwapping == nil then IsSwapping = GetTime() end
if not inBattle 
  and IsSwapping <= GetTime() - 1
  and AutoClickerCheck 
  and not (PetLevelingCheck and Petlevel == 25 ) then	
	--if inBattle then return false end
	if SetManual == nil then SetManual = false end
	if SetTimerScan == nil then SetTimerScan = 0 end
	MyX, MyY = PQR_UnitInfo("player") 
	
	-- Holding Right Click should give back control to the user once.
	if IsMouselooking() and not SetManual then
		MoveForwardStop() 
		TurnRightStop() 
		TurnLeftStop() 
		SetManual = true
	end
	
	-- Interact with Battle pets.
	if UnitIsWildBattlePet("target") 
	  and UnitExists("target") ~= nil 
	  and not inBattle 
	  and UnitIsDeadOrGhost("target") == nil 
	  and ( ClickSlowly == nil or ClickSlowly <= GetTime() - 3 )then
	  	if CML_GetDistance("player","target") <= 15 
	  	  and select(2, CML_GetDistance("player","target")) > 0
	  	  and IsMounted("player") then
	  	  	SitStandOrDescendStart()
	  	end
		InteractUnit(UnitName("target"))
		ClickSlowly = GetTime()
	end

	-- Switch target and defend ouself if attacked.
	if UnitAffectingCombat("player") 
	  and not UnitAffectingCombat("target") 
	  and ( TargetThrottle == nil or TargetThrottle < GetTime() - 1 ) then
	  	TargetNearestEnemy()
	  	TargetThrottle = GetTime()
	end
	
	-- Blacklist Dead Units.
	if not UnitAffectingCombat("player")
	  and UnitIsDeadOrGhost("target") ~= nil then
		for i = 1, #MopList do
	  		if UnitName("target") ==  MopList[i] then
--	  			Blacklist[i] = GetTime()
	  			ClearTarget()
	 			TargetThrottle = GetTime()
	  		end
	  	end
	end
	
	-- Set Table for Range check and take most optimal target first.
	ClickTarget = { { Name = "No Target", Dist = 10000, IsBattlePet = false } }
	if SetTimerScan <= GetTime() - 2 
	  and not inBattle then
		for i = 1, #MopList do
			TargetUnit(MopList[i])
			if UnitExists("target") ~= nil
			  and not UnitAffectingCombat("player") then
		  		if UnitIsWildBattlePet("target")
		  		  and not UnitIsDeadOrGhost("target") then
		  			
		  			if UnitName("target") == nil then TarName = "No Targets" else TarName = UnitName("target") end
		  			if CML_GetDistance("player","target") == nil then TarDist = 10000 else TarDist = CML_GetDistance("player","target") end
		  			if UnitIsWildBattlePet("target") == nil then TarBattlePet = false else TarBattlePet = UnitIsWildBattlePet("target") end
					if TarDist <= FollowerDistanceValue or not FollowerDistanceCheck then
						table.insert( ClickTarget,{ 
							Name = TarName, 
							Dist = TarDist, 
							IsBattlePet = TarBattlePet
						} ) 
					end
--					print(ClickTarget[i].Name.." Found at "..ClickTarget[i].Dist)		
				end
			end
		end
		ClearTarget()
		SetTimerScan = GetTime()
	end
	
	table.sort(ClickTarget, function(x,y) return x.Dist < y.Dist end)
	
	-- Click 1st target in table.
	if not UnitAffectingCombat("player")
	  and ClickTarget[1].Name ~= nil then
		TargetUnit(ClickTarget[1].Name)
	end
	
	-- If we have no target, target a dead target or get into Pet Battle then stop movement.
	if IsMoving 
	  and ( UnitExists("target") == nil 
	  or UnitIsDeadOrGhost("target")) then
		MoveForwardStop() TurnLeftStop() TurnRightStop() DescendStop()
		IsMoving = false
	end
	
	-- Setup Walk parameters.
	if UnitExists("target") ~= nil
	  and PQR_UnitInfo("target") ~= PQR_UnitInfo("player") then
		if CalmDown == nil then CalmDown = GetTime() end
		if not PQR_IsOutOfSight("target") and CalmDown~= nil then
			if CalmDown <= GetTime() - 3 then
		  		IsMoving = true
		  		FollowUnit = "target"
		  		FollowDistance = 3
			end
		end
	else 
		FollowUnit = nil
	end
	
	-- Call walk function.
	local Px,Py,Pz,Pr = PQR_UnitInfo("player") 
	if UnitExists(FollowUnit) 
	  and not IsMouselooking() then 
	  	local x,y,z = PQR_UnitInfo(FollowUnit) 
	  	SetManual = false
	  	Walk(x,y,Px,Py,Pr,z,Pz) 
	elseif IsMoving then
		MoveForwardStop() TurnLeftStop() TurnRightStop() DescendStop()
		IsMoving = false
	end
end

-- Release Movement during battle.
if inBattle or STOPALL then
	AscendStop()
	DescendStop() 
	MoveForwardStop() 
	StrafeLeftStop()
	StrafeRightStop()
	TurnLeftStop() 
	TurnRightStop() 
	STOPALL = false
end



----- Rotation
if inBattle and not ( PauseKey and PauseKeyCheck ) and ObjectiveValue == 4 then
	if Pet2ExactHP == 0 then
  		if Pet3ExactHP == 0 then
  			C_PetBattles.ChangePet(1)
  		else
  			C_PetBattles.ChangePet(3)
  		end
  	end
  	if Pet1ExactHP == 0 then
  		if Pet2ExactHP == 0 then
  			C_PetBattles.ChangePet(3)
  		else
  			C_PetBattles.ChangePet(2)
  		end
  	end
  	if Pet3ExactHP == 0 then
  		if Pet2ExactHP == 0 then
  			C_PetBattles.ChangePet(1)
  		else
  			C_PetBattles.ChangePet(2)
  		end
  	end
	PassTurn()
	Deflect()
	Execute()
	Kamikaze()
	LastStand()
	ShieldBuff()
	LifeExchange()
	SimpleHealing()
	DelayFifteenTurn()
	DelayThreeTurn()
	DelayOneTurn()
	TeamHealBuffs()
	HoTBuff()
	HighDamageIfBuffed()
	SelfBuff()
	DamageBuff()
	SpeedDeBuff()
	AoEPunch()
	ThreeTurnHighDamage()
	SimpleHighPunch(1)
	SimplePunch(1)
	SimpleHighPunch(2)
	DeBuff()
	Soothe()
	Stun()
	TeamDebuff()
	Turrets(1)
	Turrets(2)
	SpeedBuff()
	QuickPunch()
	Comeback()
	SimplePunch(2)
	Turrets(3)
	SimpleHighPunch(3)
	SimplePunch(3)
	
	C_PetBattles.UseAbility(1) -- Attack 1
	C_PetBattles.UseAbility(2) -- Attack 2
	C_PetBattles.UseAbility(3) -- Attack 3
	C_PetBattles.SkipTurn() -- skip turn.
end



------ Fable Rotation
if C_PetBattles.IsInBattle() 
  and IsBuffed(nil, 2, 956) 
  and ( ObjectiveValue == 3 or 4 )
  and ( not ( PauseKey and PauseKeyCheck ) ) then
  
  	DelayFifteenTurn()
  	
  	if activePetSlot == 1 then
  		found = false
  		for i = 1, C_PetBattles.GetNumAuras(1, 0) or 0 do
   			local auraID = C_PetBattles.GetAuraInfo(1, 0, i)
   			if auraID == 683 then   
 	   			found = true     
   			end
 		end	
	  	-- Get out as soon as we get a Apocalypse Debuff on ennemy team.
	  	if found then
	  		C_PetBattles.ChangePet(2)
	  	end
  	end
  	if activePetSlot ~= 1 then
  		for i = 1, C_PetBattles.GetNumAuras(1, 0) or 0 do
   			local auraID = C_PetBattles.GetAuraInfo(1, 0, i)
   			if auraID == 683 then   
	  			if select(3, C_PetBattles.GetAuraInfo(1, 0, i)) < 2 then
	  				C_PetBattles.ChangePet(1)
	  			end
	  		end
 		end	
  	end
  	if activePetSlot == 1 then
  		for i = 1, C_PetBattles.GetNumAuras(1, 0) or 0  do
   			local auraID = C_PetBattles.GetAuraInfo(1, 0, i)
   			if auraID == 683 then   
	  			if select(3, C_PetBattles.GetAuraInfo(1, 0, i)) < 3 then
	  			--	print("Survies Caliss")
	  				AbilitySpam(283)
	  			end
	  		end
 		end	
  	end
  	
  	if Pet2ExactHP == 0 then
  		if Pet3ExactHP == 0 then
  			C_PetBattles.ChangePet(1)
  		else
  			C_PetBattles.ChangePet(3)
  		end
  	end
  	if Pet1ExactHP == 0 then
  		if Pet2ExactHP == 0 then
  			C_PetBattles.ChangePet(3)
  		else
  			C_PetBattles.ChangePet(2)
  		end
  	end
  	if Pet3ExactHP == 0 then
  		if Pet2ExactHP == 0 then
  			C_PetBattles.ChangePet(1)
  		else
  			C_PetBattles.ChangePet(2)
  		end
  	end

--	print("fable")
	PassTurn()
	if not IsBuffed(496, 2,496) 
	  and not IsBuffed(924, 2,924) then
		Soothe()
	end
	Deflect()
--	Execute()
	Kamikaze()
	DelayOneTurn()
	LastStand()
	ShieldBuff()
	LifeExchange()
	SimpleHealing()
	
	DelayThreeTurn()
	TeamHealBuffs()
	HoTBuff()
	SelfBuff()
	DamageBuff()
	SpeedDeBuff()
	if IsBuffed(496, 2,496) then -- if NME is soothed(Drowsy)
		if activePetSlot == 2 then
			if Pet3HP > 70 then
				C_PetBattles.ChangePet(3)
				return true
			end
		end		
		C_PetBattles.SkipTurn() -- skip turn 
		return true
	end
	if IsBuffed(926, 2,926) then -- if NME is soothed
		C_PetBattles.SkipTurn() -- skip turn
		return true
	end
	if IsBuffed(236, 2,236) then -- if NME is soothed
		C_PetBattles.SkipTurn() -- skip turn
		return true
	end
	HighDamageIfBuffed()
	AoEPunch()
	ThreeTurnHighDamage()
	SimpleHighPunch(1)
	SimpleHighPunch(2)
	SimpleHighPunch(3)
	SimplePunch(1)
	DeBuff()
	Stun()
	TeamDebuff()
	Turrets(1)
	Turrets(2)
	SpeedBuff()
	QuickPunch()
	Comeback()
	SimplePunch(2)
	Turrets(3)
	
	SimplePunch(3)
	
--	C_PetBattles.UseAbility(1) -- Attack 1
--	C_PetBattles.UseAbility(2) -- Attack 2
--	C_PetBattles.UseAbility(3) -- Attack 3
	C_PetBattles.SkipTurn() -- skip turn.
end

------ Rotation for PvP
if inBAttle and ( inPvPBattle ~= nil or 
ObjectiveValue == 2 )
  and not ( PauseKey and PauseKeyCheck ) then
	PassTurn()
	Deflect()
	Execute()
	Kamikaze()
	LastStand()
	ShieldBuff()
	LifeExchange()
	SimpleHealing()
	DelayFifteenTurn()
	DelayThreeTurn()
	DelayOneTurn()
	TeamHealBuffs()
	HoTBuff()
	HighDamageIfBuffed()
	SelfBuff()
	DamageBuff()
	SpeedDeBuff()
	AoEPunch()
	ThreeTurnHighDamage()
	SimpleHighPunch(1)
	SimplePunch(1)
	SimpleHighPunch(2)
	DeBuff()
	Stun()
	TeamDebuff()
	Turrets(1)
	Turrets(2)
	SpeedBuff()
	QuickPunch()
	Comeback()
	SimplePunch(2)
	Turrets(3)
	SimpleHighPunch(3)
	SimplePunch(3)
	
--	C_PetBattles.UseAbility(1) -- Attack 1
--	C_PetBattles.UseAbility(2) -- Attack 2
--	C_PetBattles.UseAbility(3) -- Attack 3
	C_PetBattles.SkipTurn() -- skip turn.
end



---- Swap Table
-- Disable all filters in Pet Journal --
if IsSwapping == nil then IsSwapping = GetTime() end

-- Pet swap table --
if not inBattle 
  and PetSwapCheck 
  and PetLevelingCheck
  and not PvPCheck 
  and ObjectiveValue == 1 then
  
  	-- Pet Leveling Slot 1
	if PetLevel(1) >= PetSwapValue or PetLevel(1) < PetSwapMinValue or JournalHealth(1) <= SwapInHealthValue then
		
		CML_PetTable = { }
		
		for i = 1, select(2,C_PetJournal.GetNumPets()) do
			petID, _, _, _, level, favorite, _, _, _, _, _, _, _, isWild, canBattle, _, _, _ = C_PetJournal.GetPetInfoByIndex(i)
			if petID ~= nil then
				if isWild then WildConvert = 1 else WildConvert = 0 end
				if Favorite then FavoriteConvert = 1 else FavoriteConvert = 0 end
				if canBattle
				  and ( level < PetSwapValue and JournalHealthGUID(petID) >= SwapInHealthValue )
				  and level >= PetSwapMinValue 
				  and petID ~= C_PetJournal.GetPetLoadOutInfo(1) 
				  and petID ~= C_PetJournal.GetPetLoadOutInfo(2) 
				  and petID ~= C_PetJournal.GetPetLoadOutInfo(3) 
				  and select(5, C_PetJournal.GetPetStats(select (1,C_PetJournal.GetPetInfoByIndex(i)))) >= LevelingRarityValue then
					table.insert( CML_PetTable,{ 
						ID = petID, 
						Level = level, 
						Favorite = FavoriteConvert,
						Wild = WildConvert,
					} ) 
					-- print("Inserted "..petID.." "..level.." "..FavoriteConvert.." "..WildConvert)
				end
			end
		end
		
		table.sort(CML_PetTable, function(x,y) return x.Favorite < y.Favorite end)
		
		-- Level Sorts
		if LevelingPriorityValue == 1 or  3  then
			table.sort(CML_PetTable, function(x,y) return x.Level < y.Level end)
		end
		if LevelingPriorityValue == 2 or 4 then
			table.sort(CML_PetTable, function(x,y) return x.Level > y.Level end)
		end
		
		-- Wild Sorts
		if LevelingPriorityValue ==  3 or 4	then
			table.sort(CML_PetTable, function(x,y) return x.Wild < y.Wild end)
		end
		
			C_PetJournal.SetPetLoadOutInfo(1, CML_PetTable[1].ID)

	end
	
	
	-- Other pets check health
	for i = 1, 3 do
		if not ( i == 1 and PetLevelingCheck ) then
			if ( JournalHealth(i) <= SwapInHealthValue or PetLevel(i) ~= 25 )then
			 		  
			  	CML_RingnersTable = { }
			
				for j = 1, select(2,C_PetJournal.GetNumPets()) do
					petID, _, _, _, level, favorite, _, _, _, _, _, _, _, isWild, canBattle, _, _, _ = C_PetJournal.GetPetInfoByIndex(j)
					if petID ~= nil then
						if isWild then WildConvert = 1 else WildConvert = 0 end
						if Favorite then FavoriteConvert = 1 else FavoriteConvert = 0 end
						if canBattle
						  and JournalHealthGUID(petID) >= SwapInHealthValue
						  and level >= PetSwapMinValue 
						  and petID ~= C_PetJournal.GetPetLoadOutInfo(1) 
						  and petID ~= C_PetJournal.GetPetLoadOutInfo(2) 
						  and petID ~= C_PetJournal.GetPetLoadOutInfo(3) 
						  and select(5, C_PetJournal.GetPetStats(select (1,C_PetJournal.GetPetInfoByIndex(j)))) >= 4 then
							table.insert( CML_RingnersTable,{ 
								ID = petID, 
								Level = level, 
								Favorite = FavoriteConvert,
								Wild = WildConvert,
							} ) 
							 -- print("Inserted Ringner "..petID.." "..level.." "..FavoriteConvert.." "..WildConvert)
						end
					end
				end
				
				-- Favorites Sorts
				table.sort(CML_RingnersTable, function(x,y) return x.Favorite < y.Favorite end)
				
				-- Level Sorts
				table.sort(CML_RingnersTable, function(x,y) return x.Level > y.Level end)
	
				-- Switch Pet
				C_PetJournal.SetPetLoadOutInfo(i, CML_RingnersTable[1].ID)
			end
		end
	end
end