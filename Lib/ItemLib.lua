--[[
refer link
https://github.com/AimTecIO/Aimtec.SDK/blob/master/Aimtec.SDK/Damage/ItemId.cs

I T E M



source or target

DamageType = 
  1="Physical", 
  2="Magical", 
  1="True"


int   GetItemByID(int nID) -- return pItem
int   GetItemID(int nSlotItem) -- return item ID
void  BuyItem(int nID)
myHero.HasItem(nID)

]]--

local function GetCurrentHP(unit,factor) return (factor or 1) * unit.HP end
local function GetMaxHP(unit,factor) return (factor or 1) * unit.MaxHP end

local ItemLibTable = {
  ["BladeoftheRuinedKing"] = {
  {ID = 3153, Range = 550, SpellEffectType = 3, DamageType = 1, Damage = function(source, target) return target.Type == 1 and math.min(GetCurrentHP(target,0.08), 60) or math.max(GetCurrentHP(target,0.08), 15) end},

  }

}

local function ID_AbyssalScepter() return 3001 end
local function ID_AegisoftheLegion() return 3105 end
local function ID_AetherWisp() return 3113 end
local function ID_AmplifyingTome() return 1052 end
local function ID_AncientCoin() return 3301 end
local function ID_ArcaneSweeper() return 3187 end
local function ID_ArchangelsStaff() return 3003 end
local function ID_ArchangelsStaffQuickCharge() return 3007 end
local function ID_ArdentCenser() return 3504 end
local function ID_AthenesUnholyGrail() return 3174 end
local function ID_BamisCinder() return 3751 end
local function ID_BannerofCommand() return 3060 end
local function ID_BansheesVeil() return 3102 end
local function ID_BerserkersGreaves() return 3006 end
local function ID_BFSword() return 1038 end
local function ID_BilgewaterCutlass() return 3144 end
local function ID_BladeoftheRuinedKing() return 3153 end
local function ID_BlastingWand() return 1026 end
local function ID_BootsofMobility() return 3117 end
local function ID_BootsOfSpeed() return 1001 end
local function ID_BootsofSwiftness() return 3009 end
local function ID_BrawlersGloves() return 1051 end
local function ID_CatalystofAeons() return 3010 end
local function ID_CaulfieldsWarhammer() return 3133 end
local function ID_ChainVest() return 1031 end
local function ID_ChaliceofHarmony() return 3028 end
local function ID_CloakofAgility() return 1018 end
local function ID_ClothArmor() return 1029 end
local function ID_ControlWard() return 2055 end
local function ID_CorruptingPotion() return 2033 end
local function ID_CrystallineBracer() return 3801 end
local function ID_Cull() return 1083 end
local function ID_Dagger() return 1042 end
local function ID_DeadMansPlate() return 3742 end
local function ID_DeathsDance() return 3812 end
local function ID_DeathsDaughter() return 3902 end
local function ID_DervishBlade() return 3137 end
local function ID_DietPoroSnax() return 2054 end
local function ID_DoransBlade() return 1055 end
local function ID_DoransRing() return 1056 end
local function ID_DoransShield() return 1054 end
local function ID_DuskbladeofDraktharr() return 3147 end
local function ID_EdgeofNight() return 3814 end
local function ID_ElixirofIron() return 2138 end
local function ID_ElixirofSorcery() return 2139 end
local function ID_ElixirofWrath() return 2140 end
local function ID_EnchantmentBloodrazor() return 1416 end
local function ID_EnchantmentCinderhulk() return 1401 end
local function ID_EnchantmentRunicEchoes() return 1402 end
local function ID_EnchantmentWarrior() return 1400 end
local function ID_EntropyField() return 3643 end
local function ID_EspressoSnax() return 3682 end
local function ID_EssenceReaver() return 3508 end
local function ID_ExecutionersCalling() return 3123 end
local function ID_ExplorersWard() return 2050 end
local function ID_EyeoftheEquinox() return 2303 end
local function ID_EyeoftheOasis() return 2302 end
local function ID_EyeoftheWatchers() return 2301 end
local function ID_FaceoftheMountain() return 3401 end
local function ID_FaerieCharm() return 1004 end
local function ID_FarsightAlteration() return 3363 end
local function ID_FiendishCodex() return 3108 end
local function ID_FireatWill() return 3901 end
local function ID_FlashZone() return 3640 end
local function ID_ForbiddenIdol() return 3114 end
local function ID_FrostedSnax() return 3680 end
local function ID_Frostfang() return 3098 end
local function ID_FrostQueensClaim() return 3092 end
local function ID_FrozenHeart() return 3110 end
local function ID_FrozenMallet() return 3022 end
local function ID_GiantsBelt() return 1011 end
local function ID_GiantSlayer() return 3034 end
local function ID_GlacialShroud() return 3024 end
local function ID_GoldenTranscendence() return 3460 end
local function ID_GoldenTranscendenceDisabled() return 3461 end
local function ID_GreaterStealthTotemTrinket() return 3361 end
local function ID_GreaterVisionTotemTrinket() return 3362 end
local function ID_GuardianAngel() return 3026 end
local function ID_GuardiansHammer() return 3184 end
local function ID_GuardiansHorn() return 2051 end
local function ID_GuardiansOrb() return 3112 end
local function ID_GuinsoosRageblade() return 3124 end
local function ID_HauntingGuise() return 3136 end
local function ID_HeadofKhaZix() return 3175 end
local function ID_HealthPotion() return 2003 end
local function ID_Hexdrinker() return 3155 end
local function ID_HextechGLP800() return 3030 end
local function ID_HextechGunblade() return 3146 end
local function ID_HextechProtobelt01() return 3152 end
local function ID_HextechRevolver() return 3145 end
local function ID_HuntersMachete() return 1041 end
local function ID_HuntersPotion() return 2032 end
local function ID_HuntersTalisman() return 1039 end
local function ID_IcebornGauntlet() return 3025 end
local function ID_InfinityEdge() return 3031 end
local function ID_IonianBootsofLucidity() return 3158 end
local function ID_JaurimsFist() return 3052 end
local function ID_Kindlegem() return 3067 end
local function ID_KircheisShard() return 2015 end
local function ID_KnightsVow() return 3109 end
local function ID_LastWhisper() return 3035 end
local function ID_LiandrysTorment() return 3151 end
local function ID_LichBane() return 3100 end
local function ID_LocketoftheIronSolari() return 3190 end
local function ID_LongSword() return 1036 end
local function ID_LordDominiksRegards() return 3036 end
local function ID_LordVanDammsPillager() return 3104 end
local function ID_LostChapter() return 3802 end
local function ID_LudensEcho() return 3285 end
local function ID_Manamune() return 3004 end
local function ID_ManamuneQuickCharge() return 3008 end
local function ID_MawofMalmortius() return 3156 end
local function ID_MejaisSoulstealer() return 3041 end
local function ID_MercurialScimitar() return 3139 end
local function ID_MercurysTreads() return 3111 end
local function ID_MikaelsCrucible() return 3222 end
local function ID_MoonflairSpellblade() return 3170 end
local function ID_Morellonomicon() return 3165 end
local function ID_MortalReminder() return 3033 end
local function ID_Muramana() return 3042 end
local function ID_NashorsTooth() return 3115 end
local function ID_NeedlesslyLargeRod() return 1058 end
local function ID_NegatronCloak() return 1057 end
local function ID_NexusSiegeSiegeWeaponSlot() return 3637 end
local function ID_NinjaTabi() return 3047 end
local function ID_NomadsMedallion() return 3096 end
local function ID_NullMagicMantle() return 1033 end
local function ID_Ohmwrecker() return 3056 end
local function ID_OracleAlteration() return 3364 end
local function ID_OraclesExtract() return 2047 end
local function ID_OverlordsBloodmail() return 3084 end
local function ID_PerfectHexCore() return 3198 end
local function ID_Phage() return 3044 end
local function ID_PhantomDancer() return 3046 end
local function ID_Pickaxe() return 1037 end
local function ID_PoachersDirk() return 3252 end
local function ID_PoroSnax() return 2052 end
local function ID_PortPad() return 3635 end
local function ID_PrototypeHexCore() return 3200 end
local function ID_QuicksilverSash() return 3140 end
local function ID_RabadonsDeathcap() return 3089 end
local function ID_RainbowSnaxPartyPack() return 3683 end
local function ID_RaiseMorale() return 3903 end
local function ID_RanduinsOmen() return 3143 end
local function ID_RapidFirecannon() return 3094 end
local function ID_RaptorCloak() return 2053 end
local function ID_RavenousHydra() return 3074 end
local function ID_RecurveBow() return 1043 end
local function ID_Redemption() return 3107 end
local function ID_RefillablePotion() return 2031 end
local function ID_RejuvenationBead() return 1006 end
local function ID_RelicShield() return 3302 end
local function ID_RighteousGlory() return 3800 end
local function ID_RodofAges() return 3027 end
local function ID_RodofAgesQuickCharge() return 3029 end
local function ID_RubyCrystal() return 1028 end
local function ID_RubySightstone() return 2045 end
local function ID_RunaansHurricane() return 3085 end
local function ID_RylaisCrystalScepter() return 3116 end
local function ID_SanguineBlade() return 3181 end
local function ID_SapphireCrystal() return 1027 end
local function ID_SeekersArmguard() return 3191 end
local function ID_SeerStoneTrinket() return 3462 end
local function ID_SeraphsEmbrace() return 3040 end
local function ID_SerratedDirk() return 3134 end
local function ID_Sheen() return 3057 end
local function ID_ShieldTotem() return 3647 end
local function ID_SiegeBallista() return 3631 end
local function ID_SiegeRefund() return 3642 end
local function ID_SiegeSightWarder() return 3649 end
local function ID_SiegeTeleport() return 3630 end
local function ID_SiegeTeleportInactive() return 3648 end
local function ID_Sightstone() return 2049 end
local function ID_SkirmishersSabre() return 3715 end
local function ID_SorcerersShoes() return 3020 end
local function ID_SoulAnchorTrinket() return 3345 end
local function ID_SpectresCowl() return 3211 end
local function ID_SpellthiefsEdge() return 3303 end
local function ID_SpiritVisage() return 3065 end
local function ID_StalkersBlade() return 3706 end
local function ID_StatikkShiv() return 3087 end
local function ID_SteraksGage() return 3053 end
local function ID_Stinger() return 3101 end
local function ID_SunfireCape() return 3068 end
local function ID_SuperSpicySnax() return 3681 end
local function ID_SweepingLensTrinket() return 3341 end
local function ID_TalismanofAscension() return 3069 end
local function ID_TargonsBrace() return 3097 end
local function ID_TearoftheGoddess() return 3070 end
local function ID_TearoftheGoddessQuickCharge() return 3073 end
local function ID_TheBlackCleaver() return 3071 end
local function ID_TheBlackSpear() return 3599 end
local function ID_TheBloodthirster() return 3072 end
local function ID_TheDarkSeal() return 1082 end
local function ID_TheHexCoremk1() return 3196 end
local function ID_TheHexCoremk2() return 3197 end
local function ID_TheLightbringer() return 3185 end
local function ID_Thornmail() return 3075 end
local function ID_Tiamat() return 3077 end
local function ID_TitanicHydra() return 3748 end
local function ID_TotalBiscuitofRejuvenation() return 2010 end
local function ID_TowerBeamofRuination() return 3634 end
local function ID_TowerStormBulwark() return 3636 end
local function ID_TrackersKnife() return 3711 end
local function ID_TrinityForce() return 3078 end
local function ID_Unknown1() return 3632 end
local function ID_VampiricScepter() return 1053 end
local function ID_VanguardBanner() return 3641 end
local function ID_VoidStaff() return 3135 end
local function ID_WardensMail() return 3082 end
local function ID_WardingTotemTrinket() return 3340 end
local function ID_WarmogsArmor() return 3083 end
local function ID_WickedHatchet() return 3122 end
local function ID_WitsEnd() return 3091 end
local function ID_WoogletsWitchcap() return 3090 end
local function ID_YoumuusGhostblade() return 3142 end
local function ID_Zeal() return 3086 end
local function ID_ZekesHarbinger() return 3050 end
local function ID_ZhonyasHourglass() return 3157 end
local function ID_ZzRotPortal() return 3512 end