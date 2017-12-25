--[[
refer link
https://github.com/AimTecIO/Aimtec.SDK/blob/master/Aimtec.SDK/Damage/ItemId.cs


source or target

DamageType = 
  1="Physical", 
  2="Magical", 
  3="True"

int   GetItemByID(int nID) -- return pItem
int   GetItemID(int nSlotItem) -- return item ID
void  BuyItem(int nID)
myHero.HasItem(nID)

]]--

local function GetCurrentHP(unit,factor) return (factor or 1) * unit.HP end
local function GetMaxHP(unit,factor) return (factor or 1) * unit.MaxHP end
local function GetAD(unit,factor) return (factor or 1) * unit.TotalDmg end
local function GetAP(unit,factor) return (factor or 1) * unit.MagicDmg end
local function GetPercentMana(unit) return unit.MP / unit.MaxMP end
local function GetCurrentMana(unit,factor) return (factor or 1) * unit.MP end


local Itemid = {
        ["AbyssalScepter"] = 3001, 
        ["AegisoftheLegion"] = 3105, 
        ["AetherWisp"] = 3113, 
        ["AmplifyingTome"] = 1052, 
        ["AncientCoin"] = 3301, 
        ["ArcaneSweeper"] = 3187, 
        ["ArchangelsStaff"] = 3003, 
        ["ArchangelsStaffQuickCharge"] = 3007, 
        ["ArdentCenser"] = 3504, 
        ["AthenesUnholyGrail"] = 3174, 
        ["BamisCinder"] = 3751, 
        ["BannerofCommand"] = 3060, 
        ["BansheesVeil"] = 3102, 
        ["BerserkersGreaves"] = 3006, 
        ["BFSword"] = 1038, 
        ["BilgewaterCutlass"] = 3144, 
        ["BladeoftheRuinedKing"] = 3153, 
        ["BlastingWand"] = 1026, 
        ["BootsofMobility"] = 3117, 
        ["BootsOfSpeed"] = 1001, 
        ["BootsofSwiftness"] = 3009, 
        ["BrawlersGloves"] = 1051, 
        ["CatalystofAeons"] = 3010, 
        ["CaulfieldsWarhammer"] = 3133, 
        ["ChainVest"] = 1031, 
        ["ChaliceofHarmony"] = 3028, 
        ["CloakofAgility"] = 1018, 
        ["ClothArmor"] = 1029, 
        ["ControlWard"] = 2055, 
        ["CorruptingPotion"] = 2033, 
        ["CrystallineBracer"] = 3801, 
        ["Cull"] = 1083, 
        ["Dagger"] = 1042, 
        ["DeadMansPlate"] = 3742, 
        ["DeathsDance"] = 3812, 
        ["DeathsDaughter"] = 3902, 
        ["DervishBlade"] = 3137, 
        ["DietPoroSnax"] = 2054, 
        ["DoransBlade"] = 1055, 
        ["DoransRing"] = 1056, 
        ["DoransShield"] = 1054, 
        ["DuskbladeofDraktharr"] = 3147, 
        ["EdgeofNight"] = 3814, 
        ["ElixirofIron"] = 2138, 
        ["ElixirofSorcery"] = 2139, 
        ["ElixirofWrath"] = 2140, 
        ["EnchantmentBloodrazor"] = 1416, 
        ["EnchantmentCinderhulk"] = 1401, 
        ["EnchantmentRunicEchoes"] = 1402, 
        ["EnchantmentWarrior"] = 1400, 
        ["EntropyField"] = 3643, 
        ["EspressoSnax"] = 3682, 
        ["EssenceReaver"] = 3508, 
        ["ExecutionersCalling"] = 3123, 
        ["ExplorersWard"] = 2050, 
        ["EyeoftheEquinox"] = 2303, 
        ["EyeoftheOasis"] = 2302, 
        ["EyeoftheWatchers"] = 2301, 
        ["FaceoftheMountain"] = 3401, 
        ["FaerieCharm"] = 1004, 
        ["FarsightAlteration"] = 3363, 
        ["FiendishCodex"] = 3108, 
        ["FireatWill"] = 3901, 
        ["FlashZone"] = 3640, 
        ["ForbiddenIdol"] = 3114, 
        ["FrostedSnax"] = 3680, 
        ["Frostfang"] = 3098, 
        ["FrostQueensClaim"] = 3092, 
        ["FrozenHeart"] = 3110, 
        ["FrozenMallet"] = 3022, 
        ["GiantsBelt"] = 1011, 
        ["GiantSlayer"] = 3034, 
        ["GlacialShroud"] = 3024, 
        ["GoldenTranscendence"] = 3460, 
        ["GoldenTranscendenceDisabled"] = 3461, 
        ["GreaterStealthTotemTrinket"] = 3361, 
        ["GreaterVisionTotemTrinket"] = 3362, 
        ["GuardianAngel"] = 3026, 
        ["GuardiansHammer"] = 3184, 
        ["GuardiansHorn"] = 2051, 
        ["GuardiansOrb"] = 3112, 
        ["GuinsoosRageblade"] = 3124, 
        ["HauntingGuise"] = 3136, 
        ["HeadofKhaZix"] = 3175, 
        ["HealthPotion"] = 2003, 
        ["Hexdrinker"] = 3155, 
        ["HextechGLP800"] = 3030, 
        ["HextechGunblade"] = 3146, 
        ["HextechProtobelt01"] = 3152, 
        ["HextechRevolver"] = 3145, 
        ["HuntersMachete"] = 1041, 
        ["HuntersPotion"] = 2032, 
        ["HuntersTalisman"] = 1039, 
        ["IcebornGauntlet"] = 3025, 
        ["InfinityEdge"] = 3031, 
        ["IonianBootsofLucidity"] = 3158, 
        ["JaurimsFist"] = 3052, 
        ["Kindlegem"] = 3067, 
        ["KircheisShard"] = 2015, 
        ["KnightsVow"] = 3109, 
        ["LastWhisper"] = 3035, 
        ["LiandrysTorment"] = 3151, 
        ["LichBane"] = 3100, 
        ["LocketoftheIronSolari"] = 3190, 
        ["LongSword"] = 1036, 
        ["LordDominiksRegards"] = 3036, 
        ["LordVanDammsPillager"] = 3104, 
        ["LostChapter"] = 3802, 
        ["LudensEcho"] = 3285, 
        ["Manamune"] = 3004, 
        ["ManamuneQuickCharge"] = 3008, 
        ["MawofMalmortius"] = 3156, 
        ["MejaisSoulstealer"] = 3041, 
        ["MercurialScimitar"] = 3139, 
        ["MercurysTreads"] = 3111, 
        ["MikaelsCrucible"] = 3222, 
        ["MoonflairSpellblade"] = 3170, 
        ["Morellonomicon"] = 3165, 
        ["MortalReminder"] = 3033, 
        ["Muramana"] = 3042, 
        ["NashorsTooth"] = 3115, 
        ["NeedlesslyLargeRod"] = 1058, 
        ["NegatronCloak"] = 1057, 
        ["NexusSiegeSiegeWeaponSlot"] = 3637, 
        ["NinjaTabi"] = 3047, 
        ["NomadsMedallion"] = 3096, 
        ["NullMagicMantle"] = 1033, 
        ["Ohmwrecker"] = 3056, 
        ["OracleAlteration"] = 3364, 
        ["OraclesExtract"] = 2047, 
        ["OverlordsBloodmail"] = 3084, 
        ["PerfectHexCore"] = 3198, 
        ["Phage"] = 3044, 
        ["PhantomDancer"] = 3046, 
        ["Pickaxe"] = 1037, 
        ["PoachersDirk"] = 3252, 
        ["PoroSnax"] = 2052, 
        ["PortPad"] = 3635, 
        ["PrototypeHexCore"] = 3200, 
        ["QuicksilverSash"] = 3140, 
        ["RabadonsDeathcap"] = 3089, 
        ["RainbowSnaxPartyPack"] = 3683, 
        ["RaiseMorale"] = 3903, 
        ["RanduinsOmen"] = 3143, 
        ["RapidFirecannon"] = 3094, 
        ["RaptorCloak"] = 2053, 
        ["RavenousHydra"] = 3074, 
        ["RecurveBow"] = 1043, 
        ["Redemption"] = 3107, 
        ["RefillablePotion"] = 2031, 
        ["RejuvenationBead"] = 1006, 
        ["RelicShield"] = 3302, 
        ["RighteousGlory"] = 3800, 
        ["RodofAges"] = 3027, 
        ["RodofAgesQuickCharge"] = 3029, 
        ["RubyCrystal"] = 1028, 
        ["RubySightstone"] = 2045, 
        ["RunaansHurricane"] = 3085, 
        ["RylaisCrystalScepter"] = 3116, 
        ["SanguineBlade"] = 3181, 
        ["SapphireCrystal"] = 1027, 
        ["SeekersArmguard"] = 3191, 
        ["SeerStoneTrinket"] = 3462, 
        ["SeraphsEmbrace"] = 3040, 
        ["SerratedDirk"] = 3134, 
        ["Sheen"] = 3057, 
        ["ShieldTotem"] = 3647, 
        ["SiegeBallista"] = 3631, 
        ["SiegeRefund"] = 3642, 
        ["SiegeSightWarder"] = 3649, 
        ["SiegeTeleport"] = 3630, 
        ["SiegeTeleportInactive"] = 3648, 
        ["Sightstone"] = 2049, 
        ["SkirmishersSabre"] = 3715, 
        ["SorcerersShoes"] = 3020, 
        ["SoulAnchorTrinket"] = 3345, 
        ["SpectresCowl"] = 3211, 
        ["SpellthiefsEdge"] = 3303, 
        ["SpiritVisage"] = 3065, 
        ["StalkersBlade"] = 3706, 
        ["StatikkShiv"] = 3087, 
        ["SteraksGage"] = 3053, 
        ["Stinger"] = 3101, 
        ["SunfireCape"] = 3068, 
        ["SuperSpicySnax"] = 3681, 
        ["SweepingLensTrinket"] = 3341, 
        ["TalismanofAscension"] = 3069, 
        ["TargonsBrace"] = 3097, 
        ["TearoftheGoddess"] = 3070, 
        ["TearoftheGoddessQuickCharge"] = 3073, 
        ["TheBlackCleaver"] = 3071, 
        ["TheBlackSpear"] = 3599, 
        ["TheBloodthirster"] = 3072, 
        ["TheDarkSeal"] = 1082, 
        ["TheHexCoremk1"] = 3196, 
        ["TheHexCoremk2"] = 3197, 
        ["TheLightbringer"] = 3185, 
        ["Thornmail"] = 3075, 
        ["Tiamat"] = 3077, 
        ["TitanicHydra"] = 3748, 
        ["TotalBiscuitofRejuvenation"] = 2010, 
        ["TowerBeamofRuination"] = 3634, 
        ["TowerStormBulwark"] = 3636, 
        ["TrackersKnife"] = 3711, 
        ["TrinityForce"] = 3078, 
        ["Unknown1"] = 3632, 
        ["VampiricScepter"] = 1053, 
        ["VanguardBanner"] = 3641, 
        ["VoidStaff"] = 3135, 
        ["WardensMail"] = 3082, 
        ["WardingTotemTrinket"] = 3340, 
        ["WarmogsArmor"] = 3083, 
        ["WickedHatchet"] = 3122, 
        ["WitsEnd"] = 3091, 
        ["WoogletsWitchcap"] = 3090, 
        ["YoumuusGhostblade"] = 3142, 
        ["Zeal"] = 3086, 
        ["ZekesHarbinger"] = 3050, 
        ["ZhonyasHourglass"] = 3157, 
        ["ZzRotPortal"] = 3512
}

local DamageItem = {

--[[ Physical ]]--
  ["BladeoftheRuinedKing"] = {
  {Range = 550, DamageType = 1, Damage = function(source, target) return target.Type == 1 and math.min(GetCurrentHP(target,0.08), 60) or math.max(GetCurrentHP(target,0.08), 15) end},
  },

  ["EnchantmentBloodrazor"] = {
  {Range = 550, DamageType = 1, Damage = function(source, target) return target.Type == 1 and math.min(GetMaxHP(target,0.04), 75) or GetMaxHP(target,0.04) end},
  },

  ["RecurveBow"] = {
  {DamageType = 1, Damage = function(source, target) return 15 end},
  },

  ["TitanicHydra"] = {
  {DamageType = 1, Damage = function(source, target) return target.HasBuff("itemtitanichydracleavebuff") == 1 and 40 + GetMaxHP(source,0.1) or 5 + GetMaxHP(target,0.01) end},
  },

  ["TrinityForce"]{
  {DamageType = 1, Damage = function(source, target) return target.HasBuff("sheen") == 1 and GetAD(source,2) end},
  },

  ["Sheen"]{
  {DamageType = 1, Damage = function(source, target) return target.HasBuff("sheen") == 1 and GetAD(source,1) end},
  },

  ["Muramana"]{
  {DamageType = 1, Damage = function(source, target) return GetPercentMana(source) > 0.20 and GetCurrentMana(source,0.06) end},
  },

--[[ Magical ]]--
["GuinsoosRageblade"]{
  {DamageType = 2, Damage = function(source, target) return 15 end},
  },

["NashorsTooth"]{
  {DamageType = 2, Damage = function(source, target) return 15 + GetAP(source,0.15) end},
  },

["WitsEnd"]{
  {DamageType = 2, Damage = function(source, target) return 40 end},
  },  

["LichBane"]{
  {DamageType = 2, Damage = function(source, target) return GetAD(source,0.75) + GetAP(source,0.50) end},
  },  

["KircheisShard"]{
  {DamageType = 2, Damage = function(source, target) return GetBuffCount(source, "ItemStatikShankCharge") == 100 and 50 nd},
  },  

["RapidFirecannon"]{
  {DamageType = 2, Damage = function(source, target) return GetBuffCount(source, "ItemStatikShankCharge") == 100 and ({50, 50, 50, 50, 50, 50, 56, 67, 72, 77, 83, 88, 94, 99, 104, 110, 115, 120})[math.min(source.Level - 1, 17)] nd},
  },  

["StatikkShiv"]{
  {DamageType = 2, Damage = function(source, target) return GetBuffCount(source, "ItemStatikShankCharge") == 100 and ({60, 60, 60, 60, 60, 68, 76, 84, 91, 99, 107, 114, 122, 130, 137, 145, 153, 160})[math.min(source.Level - 1, 17)] nd},
  }

}



