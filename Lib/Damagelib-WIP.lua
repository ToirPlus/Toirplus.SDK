[[
Slot = "Q","W","E","R"
Stage = 
  1=Default,
  2=WayBack,
  3=Detonation,
  4=DamagePerSecond,
  5=SecondForm,
  6=ThirdForm,
  7=SecondCast,
  8=ThirdCast,
  9=AgainstMinions,
  10=AgainstMonsters,
  11=AgainstTurrets,
  12=Buff,
  13=AreaOfEffect,
  14=Collision,
  15=Empowered,
  16=Effect,
  17=ReducedDamage

SpellEffectType = 1="None", 2="AoE", 3="Single", 4="OverTime", 5="Attack"
DamageType = 1="Physical", 2="Magical", 1="True"
IsApplyOnHit = true or false 



]]


local function GetAD(unit,factor) return (factor or 1) * unit.TotalDmg end
local function GetAP(unit,factor) return (factor or 1) * unit.MagicDmg end
local function GetPer100AP(unit,factor) return (factor or 1) / 100 * GetAP(unit) end --100AP = 1%  value / 100 * source.MagicDmg 
local function GetBonusAD(unit,factor) return (factor or 1) * unit.BonusDmg end
local function GetCurrentHP(unit,factor) return (factor or 1) * unit.HP end
local function GetMaxHP(unit,factor) return (factor or 1) * unit.MaxHP end
local function GetPercentHP(unit) return unit.MaxHP / unit.HP * 100 end
local function GetMissingPercentHP(unit,factor) return (factor or 1) / 100 * (GetMaxHP(unit) - GetCurrentHP(unit)) end
local function GetCurrentMana(unit,factor) return (factor or 1) * unit.MP end
local function GetMaxMana(unit,factor) return (factor or 1) * unit.MaxMP end
local function GetLevel(unit,factor) return (factor or 1) * unit.Level end
local function GetArmor(unit,factor) return (factor or 1) * unit.Armor end
local function GetBonusArmor(unit,factor) return (factor or 1) * unit.BonusArmor end
local function GetBaseArmor(unit,factor) return (factor or 1) * (unit.Armor - unit.BonusArmor) end
local function GetMagicArmor(unit,factor) return (factor or 1) * unit.MagicArmor end
local function GetBonusMagicArmor(unit,factor) return (factor or 1) * unit.BonusMagicArmor end
local function GetBaseMagicArmor(unit,factor) return (factor or 1) * (unit.MagicArmor - unit.BonusMagicArmor) end
local function GetBonusCriticalDamage(unit,factor) return (factor or 1) * unit.BonusCriticalDamage end
local function GetMoveSpeed(unit,factor) return (factor or 1) * unit.MoveSpeed end



local DamageLibTable = {
  ["Aatrox"] = {
    {Slot = "Q", Stage = 1, SpellEffectType = 2, DamageType = 1, Damage = function(source, target, level) return ({10, 35, 60, 95, 120})[level] + GetAD(source,1.1) end},
    {Slot = "W", Stage = 1, SpellEffectType = 0, DamageType = 1, Damage = function(source, target, level) return ({50, 85, 120, 155, 190})[level] + GetBonusAD(source,0.75) end},
    {Slot = "E", Stage = 1, SpellEffectType = 2, DamageType = 1, Damage = function(source, target, level) return ({75, 115, 155, 195, 235})[level] + GetBonusAD(source,0.7) end},
    {Slot = "R", Stage = 1, SpellEffectType = 2, DamageType = 2, Damage = function(source, target, level) return ({200, 300, 400})[level] + GetAP(source) end},
  },

  ["Ahri"] = {
    {Slot = "Q", Stage = 1, SpellEffectType = 5, DamageType = 2, Damage = function(source, target, level) return ({40, 65, 90, 115, 140})[level] + GetAP(source,0.35) end},
    {Slot = "Q", Stage = 2, SpellEffectType = 5, DamageType = 3, Damage = function(source, target, level) return ({40, 65, 90, 115, 140})[level] + GetAP(source,0.35) end},
    {Slot = "W", Stage = 1, SpellEffectType = 5, DamageType = 2, Damage = function(source, target, level) return ({40, 65, 90, 115, 140})[level] + GetAP(source,0.3) end},
    {Slot = "W", Stage = 3, SpellEffectType = 0, DamageType = 2, Damage = function(source, target, level) return ({64, 104, 144, 184, 224})[level] + GetAP(source,0.45) end},
    {Slot = "E", Stage = 1, SpellEffectType = 3, DamageType = 2, Damage = function(source, target, level) return ({60, 95, 130, 165, 200})[level] + GetAP(source,0.6) end},
    {Slot = "R", Stage = 1, SpellEffectType = 5, DamageType = 2, Damage = function(source, target, level) return ({70, 110, 150})[level] + GetAP(source,0.25)  end},
  },

  ["Akali"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({35, 55, 75, 95, 115})[level] + GetAP(source,0.4) end},
    {Slot = "Q", Stage = 3, DamageType = 2, SpellEffectType = 0, Damage = function(source, target, level) return ({45, 70, 95, 120, 145})[level] + GetAP(source,0.5) end},
    {Slot = "E", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({70, 100, 130, 160, 190})[level] + GetAP(source,0.6) + GetAD(source,0.8) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({50, 100, 150})[level] + GetAP(source,0.35) end},
  },

  ["Alistar"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({60, 105, 150, 195, 240})[level] + GetAP(source,0.5) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({55, 110, 165, 220, 275})[level] + GetAP(source,0.7) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({20, 25, 30, 35, 40})[level] + GetAp(source,0.4) end}, -- 1sec per dmg
  },

  ["Amumu"] = { -- fk amumu need passvie check >> target 10% magig true dmg 
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({80, 130, 180, 230, 280})[level] + GetAP(source,0.7) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 4, Damage = function(source, target, level) return ({10, 15, 20, 25, 30})[level] + GetMaxHP(target,({0.01, 0.0125, 0.015, 0.0175, 0.02})[level] + GetAP(source)/100 ) end}, -- 1sec per dmg
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({75, 100, 125, 150, 175})[level] + GetAP(source,0.5) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 250, 350})[level] + GetAP(source,0.8) end},
  },

  ["Anivia"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({60, 85, 110, 135, 160})[level] + GetAP(source,0.4) end},
    {Slot = "Q", Stage = 3, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({60, 85, 110, 135, 160})[level] + GetAP(source,0.4) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return (({50, 75, 100, 125, 150})[level] + GetAP(source,0.5) end},
    {Slot = "E", Stage = 15, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return (({50, 75, 100, 125, 150})[level]*2 + GetAP(source) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({40, 60, 80})[level] + GetAP(source,0.125) end},
    {Slot = "R", Stage = 15, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({120, 180, 240})[level] + GetAP(source,0.375) end},
  },

  ["Annie"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({80, 115, 150, 185, 220})[level] + GetAP(source,0.8) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({70, 115, 160, 205, 250})[level] + GetAP(source,0.85) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({20, 30, 40, 50, 60})[level] + GetAP(source,0.2) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 4, Damage = function(source, target, level) return ({150, 275, 400})[level] + GetAP(source,0.65) end},
    {Slot = "R", Stage = 4, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({10, 15, 20})[level] + GetAP(source,0.1) end}, -- per tick
  },

  ["Ashe"] = {
    {Slot = "Q", Stage = 1, IsApplyOnHit = true, DamageType = 1, SpellEffectType = 1, Damage = function(source, target, level) return ({0.21, 0.22, 0.23, 0.24, 0.25})[level] * GetAD(source) end}, -- OnHit SPELL
    {Slot = "W", Stage = 1, DamageType = 1, SpellEffectType = 5, Damage = function(source, target, level) return ({20, 35, 50, 65, 80})[level] + GetAD(source) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({200, 400, 600})[level] + GetAP(source) end},
    {Slot = "R", Stage = 2, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return (({100, 200, 300})[level] + GetAP(source,0.5) end}, -- Splash dmg 
  },

  ["AurelionSol"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({70, 110, 150, 190, 230})[level] + GetAP(source,0.65) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 250, 350})[level] + GetAP(source,0.7) end},
  },
  
  ["Azir"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 1, Damage = function(source, target, level) return ({70, 95, 120, 145, 170})[level] + GetAP(source,0.3) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 1, Damage = function(source, target, level) return ({60, 62, 64, 66, 68, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180})[source.level] + GetAP(source,0.6) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 1, Damage = function(source, target, level) return ({60, 90, 120, 150, 180})[level] + GetAP(source,0.7) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 250, 450})[level] + GetAP(source,0.6) end},
  },

  ["Blitzcrank"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({80, 135, 190, 245, 300})[level] + GetAP(source) end},
    {Slot = "E", Stage = 1, IsApplyOnHit = true, DamageType = 1, SpellEffectType = 1, Damage = function(source, target, level) return GetAP(source) end}, -- OnHit SPELL
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({250, 375, 500})[level] + GetAP(source) end},
    {Slot = "R", Stage = 5, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({100, 200, 300})[level] + GetAP(source,0.2) end},
  },

  ["Bard"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({80, 125, 170, 215, 260})[level] + GetAP(source,0.65) end},
  },

  ["Brand"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({80, 110, 140, 170, 200})[level] + GetAP(source,0.55) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({75, 120, 165, 210, 255})[level] + GetAP(source,0.6) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({70, 90, 110, 130, 150})[level] + GetAP(source,0.35) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({100, 200, 300})[level] + GetAP(source,0.25) end},
  },

  ["Braum"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({60, 105, 150, 195, 240})[level] + GetMaxHP(source,0.025) end},
    {Slot = "Q", Stage = 12, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return 6.4 + GetLevel(source) * 1.6 end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 250, 350})[level] + GetAP(source,0.6) end},
  },

  ["Caitlyn"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({30, 70, 110, 150, 190})[level] + GetAD(source,({1.3, 1.4, 1.5, 1.6, 1.7})[level]) end},
    {Slot = "Q", Stage = 5, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({20.1, 46.9, 73.7, 100.5, 127.3})[level] + GetAD(source,({0.871, 0.938, 1.005, 1.072, 1.139})[level]) end},
    {Slot = "W", Stage = 1, DamageType = 1, SpellEffectType = 5, Damage = function(source, target, level) return ({40, 90, 140, 190, 240})[level] + GetBonusAD(source,({0.4, 0.55, 0.7, 0.85, 1.0})[level]) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({70, 110, 150, 190, 230})[level] + GetAP(source,0.8) end},
    {Slot = "R", Stage = 1, DamageType = 1, SpellEffectType = 3, Damage = function(source, target, level) return ({250, 475, 700})[level] + GetBonusAD(source,2.0) end},
  },

  ["Camille"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, SpellEffectType = 1, Damage = function(source, target, level) return ({0.2, 0.25, 0.3, 0.35, 0.4})[level] * GetAD(source) end},
    {Slot = "Q", Stage = 15, DamageType = 1, SpellEffectType = 1, Damage = function(source, target, level) return ({0.4, 0.5, 0.6, 0.7, 0.8})[level] * GetAD(source) end},
    {Slot = "W", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({70, 100, 130, 160, 190})[level] + GetBonusAD(source,0.6) end},
    {Slot = "W", Stage = 15, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({70, 100, 130, 160, 190})[level] + GetBonusAD(source,0.6) + GetMaxHP(source,({0.06, 0.065, 0.07, 0.075, 0.08})[level] + GetAD(source,0.03) / 100) end},
    {Slot = "E", Stage = 1, DamageType = 1, SpellEffectType = 3, Damage = function(source, target, level) return ({75, 120, 165, 210, 255})[level] + GetAD(source,0.75) end},
  },

  ["Cassiopeia"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({75, 120, 165, 210, 255})[level] + GetAP(source,0.7) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({20, 35, 50, 65, 80})[level] + GetAP(source,0.15) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return 48 + 4 * source.level + GetAP(source,0.1) + ({10, 30, 50, 70, 90})[level] + GetAP(source,0.5) or 0 end},
    {Slot = "E", Stage = 15, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return 48 + 4 * source.level + GetAP(source,0.1) +  GetBuffStack(target.Addr, "poison") > 0 and ({10, 30, 50, 70, 90})[level] + GetAP(source,0.5) or 0 end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 250, 350})[level] + GetAP(source,0.5) end},
  },

  ["Chogath"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({80, 135, 190, 245, 300})[level] + GetAP(source) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({75, 125, 175, 225, 275})[level] + GetAP(source,0.7) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 1, Damage = function(source, target, level) return ({20, 30, 40, 50, 60})[level] + GetAP(source,0.3) + GetMaxHP(target,GetBuffStack(source.Addr, "vorpalspikes") > 0 and 1 * 0.005 + 0.03) end},
    {Slot = "R", Stage = 1, DamageType = 3, SpellEffectType = 3, Damage = function(source, target, level) return ({300, 475, 650})[level] + GetAP(source,0.5) + 0.1 * (source.MaxHP - (574.4 + 80 * source.level - 80)) end}, -- need check
  },

  ["Corki"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({75, 120, 165, 210, 255})[level] + GetAP(source,0.5) * GetBonusAD(source,0.5) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({60, 90, 120, 150, 180})[level] + GetAP(source,0.4) end},
    {Slot = "W", Stage = 15, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({30, 47.5, 65, 82.5, 100})[level] + GetBonusAD(source,1.5) + GetAP(source,0.2) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 4, Damage = function(source, target, level) return ({20, 35, 50, 65, 80})[level] + GetBonusAD(source,0.4) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({75, 100, 125})[level] + GetAP(source,0.2) + GetAD(source,({0.15, 0.45, 0.75})[level]) end},
    {Slot = "R", Stage = 5, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 200, 255})[level] + GetAP(source,0.4) + GetAD(source,({0.3, 0.90, 1.5})[level]) end},
  },

  ["Darius"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({40, 70, 100, 130, 160})[level] + GetAD(source,(({1, 1.1, 1.2, 1.3, 1.4})[level])) end},
    {Slot = "W", Stage = 1, DamageType = 1, IsApplyOnHit = true SpellEffectType = 1, Damage = function(source, target, level) return GetAD(source,0.4) end},
    {Slot = "R", Stage = 1, DamageType = 3, SpellEffectType = 3, Damage = function(source, target, level) return ({100, 200, 300})[level] + GetBonusAD(source,0.75) + GetBuffStack(source.Addr, "dariushemo") > 0 and ({20, 40, 60})[level] * 0.15 end},

  },

  ["Diana"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({60, 95, 130, 165, 200})[level] + GetAP(source,0.7) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({22, 34, 46, 58, 70})[level] + GetAP(source,0.2) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 3, DDamage = function(source, target, level) return ({100, 160, 220})[level] + GetAP(source,0.6) end},
  },

  ["DrMundo"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) if target.Type == 1 then return math.min(({300, 350, 400, 450, 500})[level],math.max(({80, 130, 180, 230, 280})[level], ({15, 17.5, 20, 22.5, 25})[level] / 100 * target.HP)) end; return math.max(({80, 130, 180, 230, 280})[level],({15, 17.5, 20, 22.5, 25})[level] / 100 * target.HP) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({40, 55, 70, 85, 100})[level] + GetAP(source,0.2) end}
    {Slot = "E", Stage = 1, DamageType = 1, IsApplyOnHit = true, SpellEffectType = 1, Damage = function(source, target, level) return GetMaxHP(source,({0.03, 0.035, 0.04, 0.045, 0.05})[level] + 0.2) end}
  },

  ["Draven"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, IsApplyOnHit = true, SpellEffectType = 1, Damage = function(source, target, level) return ({35, 40, 45, 50, 55})[level] + GetBonusAD(source,({0.65, 0.75, 0.85, 0.95, 0.105})[level]) end},
    {Slot = "E", Stage = 1, DamageType = 1, SpellEffectType = 5, Damage = function(source, target, level) return ({75, 110, 145, 180, 215})[level] + GetBonusAD(source,0.5) end},
    {Slot = "R", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({175, 275, 375})[level] + GetBonusAD(source,1.1) end},
    {Slot = "R", Stage = 5, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({70, 110, 150})[level] + GetBonusAD(source,0.44) end},

  },

  ["Ekko"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({60, 75, 90, 105, 120})[level] + GetAP(source,0.3) end},
    {Slot = "Q", Stage = 2, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({40, 65, 90, 115, 140})[level] + GetAP(source,0.6) end},
    {Slot = "E", Stage = 1, DamageType = 2, IsApplyOnHit = true , SpellEffectType = 1, Damage = function(source, target, level) return ({40, 65, 90, 115, 140})[level] + GetAP(source,0.4) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 300, 450})[level] + GetAP(source,1.5) end}
  },

  ["Elise"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({40, 75, 110, 145, 180})[level] + GetCurrentHP(target, 0.04 + (GetPer100AP(source,0.03))) end},
    {Slot = "Q", Stage = 5, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({60, 100, 140, 180, 220})[level] + GetCurrentHP(target, 0.08 + (GetPer100AP(source,0.03))) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({55, 95, 135, 175, 215})[level] + GetAP(sourceo, 0.95) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 4, Damage = function(source, target, level) return ({10, 15, 20, 25})[level] + GetAP(source,0.15) end},
  },

  ["Evelynn"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({25, 30, 35, 40, 45})[level] + GetAP(source,0.3) end},
    {Slot = "Q", Stage = 3, DamageType = 2, SpellEffectType = 1, Damage = function(source, target, level) return ({10, 20, 30, 40, 50})[level] + GetAP(source,0.25) end},
    {Slot = "Q", Stage = 7, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({25, 30, 35, 40, 45})[level] + GetAP(source,0.3) end},    
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({250, 300, 350, 400, 450})[level] + GetAP(source,0.6) end},    
    {Slot = "E", Stage = 1, DamageType = 2, IsApplyOnHit = true, SpellEffectType = 3, Damage = function(source, target, level) return ({30, 45, 60, 75, 90})[level] + GetMaxHP(target, 0.04 + (GetPer100AP(source,0.03))) end},
    {Slot = "E", Stage = 15, DamageType = 2, IsApplyOnHit = true, SpellEffectType = 2, Damage = function(source, target, level) return ({60, 80, 100, 120, 140})[level] +  GetMaxHP(target, 0.06 + (GetPer100AP(source,0.04))) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 275, 400})[level] + GetAP(source,0.75) end},
    {Slot = "R", Stage = 15, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({300, 550, 800})[level] + GetAP(source,1.5) end},
  },

  ["Ezreal"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, IsApplyOnHit = true, SpellEffectType = 3, Damage = function(source, target, level) return ({35, 55, 75, 95, 115})[level] + GetAP(source,0.4) + GetAD(source,1.25) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({70, 115, 160, 205, 250})[level] + GetAP(source,0.8) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({80, 130, 180, 230, 280})[level] + GetAP(source,0.75) + GetBonusAD(source0.5) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({350, 500, 650})[level] + GetAP(source,0.9) + GetAD(source) end},
  },

  ["Fiddlesticks"] = {
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 4, Damage = function(source, target, level) return ({80, 105, 130, 155, 180})[level] + GetAP(source,0.45) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({65, 85, 105, 125, 145})[level] + GetAP(source,0.45) end},
    {Slot = "E", Stage = 9, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({97.5, 127.5, 157.5, 187.5, 217.5})[level] + GetAP(source,0.675) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({125, 225, 325})[level] + GetAP(source,0.45) end},
  },

  ["Fiora"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, IsApplyOnHit = true, SpellEffectType = 3 Damage = function(source, target, level) return ({70, 80, 90, 100, 110})[level] + GetBonusAD(source,({0.95, 1, 1.05, 1.1, 1.15})[level]) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({90, 130, 170, 210, 250})[level] + GetAP(source) end},
  },

  ["Fizz"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({10, 25, 40, 55, 70})[level] + GetAD(source) + GetAP(source,0.35) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 1, Damage = function(source, target, level) return ({20, 30, 40, 50, 60})[level] + GetAP(source,0.4) end},
    {Slot = "W", Stage = 15, DamageType = 2, SpellEffectType = 1, Damage = function(source, target, level) return ({60, 90, 120, 150, 180})[level] + GetAP(source,1.2) end},
    {Slot = "W", Stage = 4, DamageType = 2, SpellEffectType = 4, Damage = function(source, target, level) return ({20, 30, 40, 50, 60})[level] + GetAP(source,0.4) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({70, 120, 170, 220, 270})[level] + GetAP(source,0.75) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({150, 250, 350})[level] + GetAP(source,0.6) end},
    {Slot = "R", Stage = 5, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({225, 325, 425})[level] + GetAP(source,0.6) end},
    {Slot = "R", Stage = 6, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({300, 400, 500})[level] + GetAP(source,0.6) end},
  },

  ["Galio"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({50, 80, 110, 140, 170})[level] + GetAP(source,0.8) end},
    {Slot = "Q", Stage = 4, DamageType = 2, SpellEffectType = 4, Damage = function(source, target, level) return ({10, 13.3, 16.7, 20, 23.3})[level] + GetAP(source,0.2) + GetMaxHP(target,GetPer100AP(source,0.03))  end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 5, Damage = function(source, target, level) return ({100, 130, 160, 190, 220})[level] + GetAP(source,0.9) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({150, 250, 350})[level] + GetAP(source,0.7) end},
  },

  ["Gangplank"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, IsApplyOnHit = true, SpellEffectType = 3, Damage = function(source, target, level) return ({20, 45, 70, 95, 120})[level] + GetAD(source) end},
    {Slot = "E", Stage = 1, DamageType = 1, SpellEffectType = 1, Damage = function(source, target, level) return ({80, 135, 190, 245, 300})[level] + GetAD(source) end}, -- need add ignoring armor (-40%) 
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({35, 60, 85})[level] + GetAP(source,0.1) end},
  },

  ["Garen"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, IsApplyOnHit = true, SpellEffectType = 1, Damage = function(source, target, level) return ({30, 55, 80, 105, 130})[level] + GetAD(source,0.4) end},
    {Slot = "E", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({14, 18, 22, 26, 30})[level] + GetAD(source,({0.36, 0.37, 0.38, 0.39, 0.40})[level]) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({175, 350, 52ll5})[level] + ({28.66, 33.33, 40})[level] / 100 * (GetMaxHP(target) - GetCurrentHP(target)) end}, 
  },

  ["Gnar"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, SpellEffectType = 5, Damage = function(source, target, level) return ({5, 45, 85, 125, 165})[level] + GetAD(source,1.15) end},
    {Slot = "Q", Stage = 5, DamageType = 1, SpellEffectType = 5, Damage = function(source, target, level) return ({5, 45, 85, 125, 165})[level] + GetAD(source,1.2) end},
    {Slot = "W", Stage = 1, DamageType = 2, IsApplyOnHit = true, SpellEffectType = 1, Damage = function(source, target, level) return ({10, 20, 30, 40, 50})[level] + GetAP(source) +GetMaxHP(target,({0.06, 0.08, 0.1, 0.12, 0.14})[level]) end},
    {Slot = "W", Stage = 5, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({25, 45, 65, 85, 105})[level] + GetAD(source) end},
    {Slot = "E", Stage = 1, DamageType = 1, SpellEffectType = 3, Damage = function(source, target, level) return ({20, 60, 100, 140, 180})[level] + GetMaxHP(source,0.06) end},
    {Slot = "E", Stage = 5, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({20, 60, 100, 140, 180})[level] + GetMaxHP(source,0.06) end},
    {Slot = "R", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({200, 300, 400})[level] + GetAP(source,0.5) + GetBonusAD(source,0.2) end},
    {Slot = "R", Stage = 14, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({300, 450, 600})[level] + GetAP(source,0.75) + GetBonusAD(source,0.3) end},
  },

  ["Gragas"] = {
    {Slot = "Q", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({80, 120, 160, 200, 240})[level] + GetAP(source,0.6) end},
    {Slot = "W", Stage = 1, DamageType = 2, IsApplyOnHit = true, SpellEffectType = 1, Damage = function(source, target, level) return ({20, 50, 80, 110, 140})[level] + GetMaxHP(target,0.08) + GetAP(source,0.3) end},
    {Slot = "E", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({80, 130, 180, 230, 280})[level] + GetAP(source,0.6) end},
    {Slot = "R", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({200, 300, 400})[level] + GetAP(source,0.7) end},
  },

  ["Graves"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({45, 60, 75, 90, 105})[level] + GetBonusAD(source) end},
    {Slot = "Q", Stage = 2, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({85, 115, 145, 175, 205})[level] + GetBonusAD(source,({0.4, 0.7, 1, 1.3, 1.6})[level]) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({60, 110, 160, 210, 260})[level] + GetAP(source,0.6) end},
    {Slot = "R", Stage = 1, DamageType = 1, SpellEffectType = 3, Damage = function(source, target, level) return ({250, 400, 550})[level] + GetAD(source,1.5) end},
    {Slot = "R", Stage = 13, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({200, 320, 440})[level] + GetAD(source,1.2) end},
  },

  ["Hecarim"] = {
    {Slot = "Q", Stage = 1, DamageType = 1, SpellEffectType = 2, Damage = function(source, target, level) return ({55, 90, 125, 160, 195})[level] + GetBonusAD(source,0.6) end},
    {Slot = "W", Stage = 1, DamageType = 2, SpellEffectType = 4, Damage = function(source, target, level) return ({20, 30, 40, 50, 60})[level] + GetAP(source,0.2) end},
    {Slot = "E", Stage = 1, DamageType = 1, IsApplyOnHit = true, SpellEffectType = 1, Damage = function(source, target, level) return ({45, 80, 115, 150, 185})[level] + GetBonusAD(source,0.5) end},
    {Slot = "R", Stage = 1, DamageType = 2, Damage = function(source, target, level) return ({150, 250, 350})[level] + GetAP(source) end},
  },

}