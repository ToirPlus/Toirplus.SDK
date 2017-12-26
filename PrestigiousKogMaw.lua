local huge, floor, sqrt, max, min = math.huge, math.floor, math.sqrt, math.max, math.min
local abs, deg, acos = math.abs, math.deg, math.acos
local insert, remove = table.insert , table.remove

local Q = 0
local W = 1
local E = 2
local R = 3

local VP

IncludeFile("Lib\\TOIR_SDK.lua")

local function GetDistanceSqr(p1, p2)
  p2 = p2 or myHero
    
  local dx = p1.x - p2.x
  local dz = p1.z - p2.z

  return dx*dx + dz*dz
end

local function GetDistance(p1,p2)
	return sqrt(GetDistanceSqr(p1,p2))
end

local function IsValidTarget(unit, range)
        local range = range or huge
        if type(unit) == "number" then
                return unit ~= 0 and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and IsEnemy(unit) and GetDistance(GetOrigin(unit)) <= range
        else
                return unit and unit.IsValid and not unit.IsDead and unit.IsVisible and unit.CanSelect and unit.IsEnemy and not unit.IsInvulnerable and unit.Distance <= range
        end
end

local function PrintChat(msg) --Credits to Shulepong kappa
	return __PrintTextGame("<b><font color=\"#4286f4\">[PrestigiousSeries] </font></b> </font><font color=\"#c5eff7\"> " .. msg .. " </font><b><font color=\"#4286f4\"></font></b> </font>")
end

PrestigiousKogMaw = class()

function PrestigiousKogMaw:__init()

	self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self:LoadMenu()
	self:LoadSpells()
	SetLuaCombo(true)
	SetLuaHarass(true)
	SetLuaLaneClear(true)

	Callback.Add("Tick", function(...) self:OnTick(...) end)
	Callback.Add("Draw", function(...) self:OnDraw(...) end)
    --Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    PrintChat("KogMaw Loaded. Good Luck!")
end

function PrestigiousKogMaw:LoadMenu()
	    --[[Main Menu]]
		self.menu = menuInst.addItem(SubMenu.new("Prestigious KogMaw", Lua_ARGB(255, 100, 250, 50)))

		--[[VPred]]
		VP = VPrediction(menu)
		--[[TS]]
		self.menu_ts = TargetSelector(1500, 1, myHero, true, self.menu, true)

		--[[Combo]]
		self.menu_combo = self.menu.addItem(SubMenu.new("Combo"))
		self.menu_combo_q = self.menu_combo.addItem(MenuBool.new("Use Q", true))		
		self.menu_combo_w = self.menu_combo.addItem(MenuBool.new("Use W", true))
		self.menu_combo_e = self.menu_combo.addItem(MenuBool.new("Use E", true))

		--[[Harass]]
		self.menu_harass = self.menu.addItem(SubMenu.new("Harass"))
		self.menu_harass_q = self.menu_harass.addItem(MenuBool.new("Use Q", true))		
		self.menu_harass_w = self.menu_harass.addItem(MenuBool.new("Use W", true))
		self.menu_harass_e = self.menu_harass.addItem(MenuBool.new("Use E", true))

		--[[Clear]]
		self.menu_clear = self.menu.addItem(SubMenu.new("Clear"))
		self.menu_clear_w = self.menu_clear.addItem(MenuBool.new("Use W", true))
		self.menu_clear_w_min = self.menu_clear.addItem(MenuSlider.new("Minions Nearby to use W", 3, 1, 5, 1))
		--self.menu_clear_e = self.menu_clear.addItem(MenuBool.new("Use E", true))
		--self.menu_clear_e_min = self.menu_clear.addItem(MenuSlider.new("Minions Hit to use E", 3, 1, 5, 1))
		self.menu_clear_r = self.menu_clear.addItem(MenuBool.new("Use R", true))
		self.menu_clear_r_min = self.menu_clear.addItem(MenuSlider.new("Mininions Hit to use R", 3, 1, 5, 1))

		--[[Draw]]
		self.menu_draw = self.menu.addItem(SubMenu.new("Drawings"))
		self.menu_draw_disable = self.menu_draw.addItem(MenuBool.new("Disable All Drawings", false))
		self.menu_draw_w = self.menu_draw.addItem(MenuBool.new("Draw W Range", true))
		self.menu_draw_r = self.menu_draw.addItem(MenuBool.new("Draw R Range", true))

		--[[Advanced Features]]
		self.menu_adv = self.menu.addItem(SubMenu.new("Advanced Features"))
		self.menu_adv_orb = self.menu_adv.addItem(MenuSlider.new("Disable Orb if AS > x", 3, 1, 5, 0.1))
		self.menu_adv_r_immobile = self.menu_adv.addItem(MenuBool.new("Auto R on Immobile", true))
		self.menu_adv_r_snipe = self.menu_adv.addItem(MenuBool.new("Auto R Snipe", true))

		--[[Keys]]
		self.menu_key = self.menu.addItem(SubMenu.new("Keys"))
		self.menu_key_combo = self.menu_key.addItem(MenuKeyBind.new("Combo Key", 32))
		self.menu_key_harass = self.menu_key.addItem(MenuKeyBind.new("Harass Key", 67))
		self.menu_key_clear = self.menu_key.addItem(MenuKeyBind.new("Clear Key", 86))
end

function PrestigiousKogMaw:LoadSpells()
	self.SpellQ = {Speed = 1650, Range = 1100, Delay = 0.35, Width = 70}
	self.SpellW = {Speed = 1600, Range = nil , Delay = 0.25, Width = 55}
	self.SpellE = {Speed = 1400, Range = 1200, Delay = 0.25, Width = 120}
	self.SpellR = {Speed = huge, Range = nil , Delay = 1.25, Width = 240} 
end

function PrestigiousKogMaw:GetSpellRange(spell)
	if spell == W then
		return GetTrueAttackRange() + (110 + 20 * myHero.LevelSpell(W)) or GetTrueAttackRange()	
	elseif spell == R then
		return myHero.CollisionRadius + 900 + 300* myHero.LevelSpell(R) or 0--{1400, 1700, 2200} ?		
	end	
end


function PrestigiousKogMaw:GetPred(unit, table)
	if table == self.SpellQ then
		return VP:GetLineCastPosition(unit, table.Delay, table.Width, table.Range, table.Speed, myHero, true, 0)
	elseif table == self.SpellE then
		return VP:GetLineAOECastPosition(unit, table.Delay, table.Width, table.Range, table.Speed, myHero)
		-- returns AOECastPosition, MainTargetHitChance, nTargets
	elseif table == self.SpellR then
		return VP:GetCircularAOECastPosition(unit, table.Delay, table.Width, self:GetSpellRange(R) , table.Speed, myHero, false)
		--returns AOECastPosition, MainTargetHitChance, nTargets
	else
		PrintChat("GetPred error!")
	end
end

local time= os.clock()
function PrestigiousKogMaw:OnTick()
	self:OnImmobile()

	--[[Blocks input if user is Dead, Typing or Recalling]]
	if myHero.IsDead or IsTyping() or myHero.IsRecall then return end

	--[[Disable Orb if AtkSpeed > Slider]]
	if (1/myHero.CDBA)  > self.menu_adv_orb.getValue() and GetTimeGame() < myHero.CDBAExpires then -- GetTimeGame() - (myHero.CDBAExpires - myHero.CDBA) < myHero.CDBA
		SetLuaMoveOnly(true)
		--__PrintTextGame("move disabled")
	else  --if (1/myHero.CDBA) <= self.menu_adv_orb.getValue() then
		SetLuaMoveOnly(false)
		--__PrintTextGame("move enabled")
	end

	--[[Auto R Settings]]
	if self.menu_adv_r_snipe.getValue() then self:Snipe() end

	
	--[[Main Script Functions]]
	local target = self.menu_ts:GetTarget() --bugged af
	if target == 0 then return end	--CountEnemyChampAroundObject(myHero.Addr,2000)
	target = GetAIHero(target)

	if self.menu_key_combo.getValue() then
		self:Combo(target)		
	elseif self.menu_key_harass.getValue() then
		self:Harass(target)
	elseif self.menu_key_clear.getValue() then
		self:Clear()
	end
end

function PrestigiousKogMaw:GetRDmg(target)
	local dmg = (60 + 40*myHero.LevelSpell(R) + myHero.BonusDmg * 0.65 + myHero.MagicDmg * 0.25) * (target.HP/target.MaxHP < 0.4 and 2 or ((1 - target.HP/target.MaxHP) * 0.83) + 1)
	return myHero.CalcMagicDamage(target.Addr, dmg)
end

function PrestigiousKogMaw:Snipe() 					
	if CanCast(R) == false then return end
	for k,v in pairs(GetEnemyHeroes()) do
		local enemy = GetAIHero(v)
		if IsValidTarget(enemy, self:GetSpellRange(R)) and enemy.HP <= self:GetRDmg(enemy) and enemy.Distance >= GetTrueAttackRange() then
			local CastPos, hC , n = self:GetPred(enemy,self.SpellR)
			if hC >= 3 then 
				CastSpellToPos(CastPos.x,CastPos.z, R) 
			elseif hC >= 2 and myHero.HasBuff("kogmawlivingartillerycost") == false and myHero.MP > 80 then
				CastSpellToPos(CastPos.x,CastPos.z, R) 
			end 
			break
		end
	end
end

function PrestigiousKogMaw:OnImmobile()
	for k,v in pairs(GetEnemyHeroes()) do
		local enemy = GetAIHero(v)
		if IsValidTarget(enemy, self:GetSpellRange(R)) and enemy.Distance >= GetTrueAttackRange() and CanCast(R) and self.menu_adv_r_immobile.getValue() then
			local IsImmobile, CastPos = VP:IsImmobile(enemy, self.SpellR.Delay, self.SpellR.Width, self.SpellR.Speed, myHero)
			if IsImmobile then CastSpellToPos(CastPos.x,CastPos.z, R) end 
			break
		end
		if IsValidTarget(enemy, self.SpellQ.Range) and CanCast(Q) then
			local IsImmobile, CastPos = VP:IsImmobile(enemy, self.SpellQ.Delay, self.SpellQ.Width, self.SpellQ.Speed, myHero)
			if IsImmobile then CastSpellToPos(CastPos.x,CastPos.z, Q) end 
			break
		end
	end

end

function PrestigiousKogMaw:Combo(target)

	if CanCast(Q) and self.menu_combo_q.getValue() and IsValidTarget(target, self.SpellQ.Range) and ((CanAttack() == false and CanMove()) or target.Distance > GetTrueAttackRange()) then
		local CastPos, hC = self:GetPred(target,self.SpellQ)
		if hC >= 2 then CastSpellToPos(CastPos.x,CastPos.z, Q) end 
	end
		
	if CanCast(W) and self.menu_combo_w.getValue() and CountEnemyChampAroundObject(myHero.Addr,self:GetSpellRange(W)) >= 1 then
		CastSpellToPos(myHero.x,myHero.z, W) 
	end

	if CanCast(E) and self.menu_combo_e.getValue() and IsValidTarget(target, self.SpellE.Range) then
		local CastPos, hC, n = self:GetPred(target,self.SpellE)
		if hC >= 2 then CastSpellToPos(CastPos.x,CastPos.z, E) end 
	end
end

function PrestigiousKogMaw:Harass(target)

	if CanCast(Q) and self.menu_harass_q.getValue() and IsValidTarget(target, self.SpellQ.Range) and ((CanAttack() == false and CanMove()) or target.Distance > GetTrueAttackRange()) then
		local CastPos, hC = self:GetPred(target,self.SpellQ)
		if hC >= 2 then CastSpellToPos(CastPos.x,CastPos.z, Q) end 
	end

	if CanCast(W) and self.menu_harass_w.getValue() and CountEnemyChampAroundObject(myHero.Addr,self:GetSpellRange(W)) >= 1 then
		CastSpellToPos(myHero.x,myHero.z, W) 
	end

	if CanCast(E) and self.menu_harass_e.getValue() and IsValidTarget(target, self.SpellE.Range) then
		local CastPos, hC, n = self:GetPred(target,self.SpellE)
		if hC >= 2 then CastSpellToPos(CastPos.x,CastPos.z, E) end 
	end

end

function PrestigiousKogMaw:Clear(target)
	if CanCast(W) and self.menu_clear_w.getValue() and CountEnemyMinionAroundObject(myHero.Addr,self:GetSpellRange(R)) >= self.menu_clear_w_min.getValue() then
		CastSpellToPos(myHero.x,myHero.z, W) 
	end

	if CanCast(R) and self.menu_clear_r.getValue() and CountEnemyMinionAroundObject(myHero.Addr,self:GetSpellRange(R)) >= self.menu_clear_r_min.getValue() then
		self.EnemyMinions.range = self:GetSpellRange(R)
		self.EnemyMinions:update()
		for k, v in pairs(self.EnemyMinions.objects) do
			if CountEnemyMinionAroundObject(v.Addr, self.SpellR.Width) >= self.menu_clear_r_min.getValue() then --This sucks but probably the fastest way(Right would use MEC)
				CastSpellToPos(v.x,v.z, R)
			end
		end 
	end
	

end

function PrestigiousKogMaw:OnDraw()
	if self.menu_draw_disable.getValue() then return end
   	if self.menu_draw_w.getValue() and CanCast(_W) then
    	DrawCircleGame(myHero.x, myHero.y, myHero.z, self:GetSpellRange(W), Lua_ARGB(255, 100, 100, 100))
    end
    if self.menu_draw_r.getValue() and CanCast(_R) then
    	DrawCircleGame(myHero.x, myHero.y, myHero.z, self:GetSpellRange(R), Lua_ARGB(255, 100, 100, 100))
    end
end




function OnLoad()
	if myHero.CharName == "KogMaw" then
		PrestigiousKogMaw()
	end
end

