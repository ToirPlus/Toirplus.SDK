IncludeFile("Lib\\TOIR_SDK.lua")
IncludeFile("Lib\\OrbNew.lua")
--IncludeFile("Lib\\AntiGapCloser.lua")

Graves = class()

function OnLoad()
	if GetChampName(GetMyChamp()) == "Graves" then
		Graves:__init()
	end
end

function Graves:__init()
	orbwalk = Orbwalking()
	self.menuOrbwalk = menuInst.addItem(SubMenu.new("Orbwalking", Lua_ARGB(255, 100, 250, 50)))
	orbwalk:LoadToMenu(self.menuOrbwalk)

	--antiGap = ChallengerAntiGapcloser()
	--self.menuantiGap = menuInst.addItem(SubMenu.new("Anti-Gapcloser", Lua_ARGB(255, 100, 250, 50)))
	--antiGap:LoadToMenu(self.menuantiGap)

	--Main menu
	self.menu = menuInst.addItem(SubMenu.new("Graves", Lua_ARGB(255, 100, 250, 50)))

	-- VPrediction
	vpred = VPrediction(self.menu)

	--TS
    self.menu_ts = TargetSelector(1750, 0, myHero, true, self.menu, true)

	--Draw
	self.menu_Draw = self.menu.addItem(SubMenu.new("Drawings Spell"))
	self.menu_Draw_Already = self.menu_Draw.addItem(MenuBool.new("Draw When Already", true))
	self.menu_Draw_Q = self.menu_Draw.addItem(MenuBool.new("Draw Q Range", true))
	self.menu_Draw_W = self.menu_Draw.addItem(MenuBool.new("Draw W Range", true))
	self.menu_Draw_E = self.menu_Draw.addItem(MenuBool.new("Draw E Range", true))
	self.menu_Draw_R = self.menu_Draw.addItem(MenuBool.new("Draw R1 Range", true))
	self.menu_Draw_R2 = self.menu_Draw.addItem(MenuBool.new("Draw R2 Range", true))

	--Combo
	--self.menu_Combo = self.menu.addItem(SubMenu.new("Combo"))
	self.menu_ComboQ = self.menu.addItem(SubMenu.new("Setting Q"))
	self.menu_Combo_Q = self.menu_ComboQ.addItem(MenuBool.new("Use Q", true))
	self.menu_Combo_QendDash = self.menu_ComboQ.addItem(MenuBool.new("Auto Q End Dash", true))
	self.menu_Combo_Qtowall = self.menu_ComboQ.addItem(MenuBool.new("Auto Q If Wall", true))
	self.menu_Combo_Qks = self.menu_ComboQ.addItem(MenuBool.new("Use Q Kill Steal", true))


	self.menu_ComboW = self.menu.addItem(SubMenu.new("Setting W"))
	self.menu_Combo_W = self.menu_ComboW.addItem(MenuBool.new("Auto Use W Combo", false))
	self.menu_Combo_Wgap = self.menu_ComboW.addItem(MenuBool.new("Use W Anti GapClose", true))
	self.menu_Combo_WendDash = self.menu_ComboW.addItem(MenuBool.new("Use W End Dash", true))
	self.menu_Combo_Wks = self.menu_ComboQ.addItem(MenuBool.new("Use W Kill Steal", true))

	self.menu_ComboE = self.menu.addItem(SubMenu.new("Setting E"))
	self.menu_Combo_E = self.menu_ComboE.addItem(MenuBool.new("Enable E", true))
	self.menu_Combo_EJungle = self.menu_ComboE.addItem(MenuBool.new("Enable E Reload JungFarm", true))
	self.menu_Combo_EMode = self.menu_ComboE.addItem(MenuStringList.new("E Mode", { "Mouse ", "Side  ", "Safe position" }, 3))

	self.menu_ComboR = self.menu.addItem(SubMenu.new("Setting R"))
	self.menu_Combo_R = self.menu_ComboR.addItem(MenuBool.new("Enable R", true))
	self.menu_Combo_Rhit = self.menu_ComboR.addItem(MenuSlider.new("Auto R if Hit", 2, 1, 5, 1))
	self.menu_Combo_Rks = self.menu_ComboR.addItem(MenuBool.new("Use R Kill Steal", true))

	self.menu_ComboSmite = self.menu.addItem(SubMenu.new("Setting Smite"))
	self.menu_Combo_Smiteks = self.menu_ComboSmite.addItem(MenuBool.new("Use Smite Kill Steal", true))
	self.menu_Combo_Smite = self.menu_ComboSmite.addItem(MenuBool.new("Use Smite in Combo", true))
	self.menu_ComboSmite.addItem(MenuSeparator.new("Smite Jungle"))
	--self.menu_keybin_Smite = self.menu_ComboSmite.addItem(MenuKeyBind.new("Enable Smite Jungle", 32))
	self.menu_Combo_SmiteSmall = self.menu_ComboSmite.addItem(MenuBool.new("Use Smite Small Jungle", true))
	self.menu_Combo_SmiteBlue = self.menu_ComboSmite.addItem(MenuBool.new("Use Smite Blue", true))
	self.menu_Combo_SmiteRed = self.menu_ComboSmite.addItem(MenuBool.new("Use Smite Red", true))
	self.menu_Combo_SmiteDragon = self.menu_ComboSmite.addItem(MenuBool.new("Use Smite Dragon", true))
	self.menu_Combo_SmiteBaron = self.menu_ComboSmite.addItem(MenuBool.new("Use Smite Baron", true))

	self.menu_ModSkin = self.menu.addItem(SubMenu.new("Mod Skin"))
	self.menu_ModSkinValue = self.menu_ModSkin.addItem(MenuSlider.new("Set Skin", 16, 0, 20, 1))

	menuInstSep.setValue("Graves Magic")

	self.Q = Spell(_Q, 1000)
    self.W = Spell(_W, 1100)
    self.E = Spell(_E, 450)
    self.R = Spell(_R, 1100)
    self.R2 = Spell(_R, 1800)
    self.Q:SetSkillShot(0.25, 2100, 100, true)
    self.W:SetSkillShot(0.25, 1500, 300, true)
    self.E:SetSkillShot()
    self.R:SetSkillShot(0.25, 2100, 100, true)
    self.R2:SetSkillShot(0.25, 2100, 100, true)

	Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
end



function Graves:OnTick()

	--[[orbwalk:RegisterAfterAttackCallback(function()
		if CanCast(_E) and orbwalk:ComboMode("Combo") and self.menu_Combo_E.getValue() then
			self:LogicE()
		end

		if CanCast(_E) and self.menu_Combo_EJungle.getValue() then
			local orbT = orbwalk:GetTargetOrb()
    		if orbT ~= nil and GetType(orbT) == 3 then
    			CastSpellToPos(GetMousePos().x,GetMousePos().z, _E)
    		end
		end
	end)]]

	self:AutoQW()

	self:KillSteal()

	self:LogicSmiteJungle()

	if orbwalk:ComboMode("Combo") then
		SetLuaCombo(true)
		self:LogicQ()
		self:LogicW()
		self:LogicR()
	end
	if self.menu_ModSkinValue.getValue() ~= 0 then
		ModSkin(self.menu_ModSkinValue.getValue())
	end
end

function Graves:GetIndexSmite()
	if GetSpellIndexByName("SummonerSmite") > -1 then
		return GetSpellIndexByName("SummonerSmite")
	elseif GetSpellIndexByName("S5_SummonerSmiteDuel") > -1 then
		return GetSpellIndexByName("S5_SummonerSmiteDuel")
	elseif GetSpellIndexByName("S5_SummonerSmitePlayerGanker") > -1 then
		return GetSpellIndexByName("S5_SummonerSmitePlayerGanker")
	end
	return -1
end

function Graves:GetSmiteDamage(target)
	if self:GetIndexSmite() > -1 then
		if GetType(target) == 0 then
			if GetSpellNameByIndex(myHero.Addr, self:GetIndexSmite()) == "S5_SummonerSmitePlayerGanker" then
				return 20 + 8*myHero.Level;
			end
			if GetSpellNameByIndex(myHero.Addr, self:GetIndexSmite()) == "S5_SummonerSmiteDuel" then
				return 54 + 6*myHero.Level;
			end

		end
		local DamageSpellSmiteTable = {390, 410, 430, 450, 480, 510, 540, 570, 600, 640, 680, 720, 760, 800, 850, 900, 950, 1000}
		return DamageSpellSmiteTable[myHero.Level]
	end
	return 0
end

function Graves:LogicSmiteJungle()
	for i, minions in ipairs(orbwalk:JungleTbl()) do
        if minions ~= 0 then
            local jungle = GetUnit(minions)
            if jungle.Type == 3 and jungle.TeamId == 300 and GetDistance(jungle.Addr) < GetTrueAttackRange() and
                (GetObjName(jungle.Addr) ~= "PlantSatchel" and GetObjName(jungle.Addr) ~= "PlantHealth" and GetObjName(jungle.Addr) ~= "PlantVision") then

                if IsValidTarget(jungle.Addr, 650) and self:GetSmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName == "SRU_Red" and self.menu_Combo_SmiteRed.getValue() then
                    CastSpellTarget(jungle.Addr, self:GetIndexSmite())
                end
                if IsValidTarget(jungle.Addr, 650) and self:GetSmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName == "SRU_Blue" and self.menu_Combo_SmiteBlue.getValue() then
                    CastSpellTarget(jungle.Addr, self:GetIndexSmite())
                end

                if IsValidTarget(jungle.Addr, 650) and self:GetSmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName == "SRU_RiftHerald" and self.menu_Combo_SmiteDragon.getValue() then
                    CastSpellTarget(jungle.Addr, self:GetIndexSmite())
                end

                if IsValidTarget(jungle.Addr, 650) and self:GetSmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName == "SRU_Baron" and self.menu_Combo_SmiteBaron.getValue() then
                    CastSpellTarget(jungle.Addr, self:GetIndexSmite())
                end

                if IsValidTarget(jungle.Addr, 650) and self:GetSmiteDamage(jungle.Addr) > jungle.HP and self.menu_Combo_SmiteSmall.getValue() then
                	if jungle.CharName == "SRU_Razorbeak" or jungle.CharName == "SRU_Murkwolf" or jungle.CharName == "SRU_Gromp" or jungle.CharName == "SRU_Krug" then
                    	CastSpellTarget(jungle.Addr, self:GetIndexSmite())
                	end
                end

                if IsValidTarget(jungle.Addr, 650) and self:GetSmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName:find("SRU_Dragon") and self.menu_Combo_SmiteDragon.getValue() then
                    CastSpellTarget(jungle.Addr, self:GetIndexSmite())
                end
            end
        end
    end
end

function Graves:LogicE()
	local TargetE = self.menu_ts:GetTarget(GetTrueAttackRange())
	if CanCast(_E) and TargetE ~= 0 then
		target = GetAIHero(TargetE)
		if target.IsMelee then
			local dashPos = self:CastDash(true);
			if dashPos ~= Vector(0, 0, 0) then
				CastSpellToPos(dashPos.x,dashPos.z, _E)
			end
		end
	end

	if orbwalk:ComboMode("Combo") and myHero.MP > 140 and not myHero.HasBuff("gravesbasicattackammo2") then
		local dashPos = self:CastDash();
		if CanCast(_E) and dashPos ~= Vector(0, 0, 0) then
			CastSpellToPos(dashPos.x,dashPos.z, _E)
		end
	end
end

function Graves:LogicQ()
	local TargetQ = self.menu_ts:GetTarget(self.Q.range)
	if CanCast(_Q) and TargetQ ~= 0 then
		target = GetAIHero(TargetQ)
		local CastPosition, HitChance, Position = vpred:GetLineCastPosition(target, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
    	local QPred = myHeroPos:Extended(CastPosition, self.Q.range - 100) --endPosition



		if TargetQ ~= nil then
			if (GetDistance(TargetQ) < self.Q.range - 100 and GetDistance(TargetQ) > 300  or self:IsImmobileTarget(TargetQ) or
				IsWall(QPred.x, QPred.y, QPred.z)) then
				if self:GetIndexSmite() > -1 and self.menu_Combo_Smite.getValue() then
					CastSpellTarget(TargetQ, self:GetIndexSmite())
				end
				if CastPosition and HitChance >= 2 and self.menu_Combo_Q.getValue() then
		        	CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
		    	end
		    end
		end
	end
end

function Graves:LogicW()
	local TargetW = self.menu_ts:GetTarget(self.W.range)
	if CanCast(_W) and TargetW ~= 0 then
		target = GetAIHero(TargetW)
		local CastPosition, HitChance, Position = vpred:GetCircularCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(target, self.W.delay, self.W.width, self.W.speed, myHero, false)
		local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)

		if TargetW ~= nil then
			if (GetDistance(TargetW) < self.W.range - 100 and GetDistance(TargetW) > 300  or self:IsImmobileTarget(TargetW)) then
				if self:GetIndexSmite() > -1 and self.menu_Combo_Smite.getValue() then
					CastSpellTarget(TargetW, self:GetIndexSmite())
				end

				if CastPosition and HitChance >= 2 and self.menu_Combo_W.getValue() then
		        	CastSpellToPos(CastPosition.x, CastPosition.z, _W)
		    	end
		    end
		end

		if DashPosition ~= nil then
			if GetDistance(DashPosition) <= 300 and self.menu_Combo_Wgap.getValue() then
	    		CastSpellToPos(DashPosition.x, DashPosition.z, _W)
	    	end
		end
	end
end

function Graves:LogicR()
	local TargetR = self.menu_ts:GetTarget(self.R.range)
	if CanCast(_R) and TargetR ~= 0 then
		target = GetAIHero(TargetR)
		local CastPosition, HitChance, Position = vpred:GetLineCastPosition(target, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 and self:CountEnemyInLine(target) > self.menu_Combo_Rhit.getValue() then
			CastSpellToPos(CastPosition.x, CastPosition.z, _R)
		end
	end
end

function Graves:AutoQW()
	local TargetQ = self.menu_ts:GetTarget(self.Q.range)
	if CanCast(_Q) and TargetQ ~= 0 then
		target = GetAIHero(TargetQ)
		local CastPosition, HitChance, Position = vpred:GetLineCastPosition(target, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(target, self.Q.delay, self.Q.width, self.Q.speed, myHero, false)
		local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
    	local QPred = myHeroPos:Extended(CastPosition, self.Q.range - 150)

	    if CastPosition ~= nil and HitChance >= 2 then
	    	if GetDistance(CastPosition) <= self.Q.range and IsWall(QPred.x, QPred.y, QPred.z) and self.menu_Combo_Qtowall.getValue()  then
	        	CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
	        end
	    end

	    if DashPosition ~= nil then
	    	if GetDistance(DashPosition) <= self.Q.range and self.menu_Combo_QendDash.getValue() then
	    		CastSpellToPos(DashPosition.x, DashPosition.z, _Q)
	    	end
		end
	end

	local TargetW = self.menu_ts:GetTarget(self.W.range)
	if CanCast(_W) and TargetW ~= 0 then
		target = GetAIHero(TargetW)
		local CastPosition, HitChance, Position = vpred:GetCircularCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(target, self.W.delay, self.W.width, self.W.speed, myHero, false)
		local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)

	    if DashPosition ~= nil then
	    	if GetDistance(DashPosition) <= self.W.range and self.menu_Combo_WendDash.getValue() then
	    		CastSpellToPos(DashPosition.x, DashPosition.z, _W)
	    	end
		end
	end
end

function Graves:KillSteal()
	local TargetR = self.menu_ts:GetTarget(self.R.range)
	if TargetR ~= nil and IsValidTarget(TargetR, self.R.range) and CanCast(_R) and self.menu_Combo_Rks.getValue() then
		targetR = GetAIHero(TargetR)

		local CastPosition, HitChance, Position = vpred:GetLineCastPosition(targetR, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if GetDistance(TargetR) < self.R.range and GetDamage("R", targetR) > GetHealthPoint(TargetR) then
			CastSpellToPos(CastPosition.x, CastPosition.z, _R)
		end
	end

	local TargetQ = self.menu_ts:GetTarget(self.Q.range)
	if TargetQ ~= nil and IsValidTarget(TargetQ, self.Q.range) and CanCast(_Q) and self.menu_Combo_Qks.getValue() then
		targetQ = GetAIHero(TargetQ)

		local CastPosition, HitChance, Position = vpred:GetLineCastPosition(targetQ, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if GetDistance(TargetQ) < self.Q.range and GetDamage("Q", targetQ) > GetHealthPoint(TargetQ) then
			CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
		end
	end

	local TargetW = self.menu_ts:GetTarget(self.W.range)
	if TargetW ~= nil and IsValidTarget(TargetW, self.W.range) and CanCast(_W) and self.menu_Combo_Wks.getValue() then
		targetW = GetAIHero(TargetW)
		local CastPosition, HitChance, Position = vpred:GetLineCastPosition(targetW, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		if GetDistance(TargetW) < self.W.range and GetDamage("W", targetW) > GetHealthPoint(TargetW) then
			CastSpellToPos(CastPosition.x, CastPosition.z, _W)
		end
	end

	local TargetSmite = self.menu_ts:GetTarget(650)
	if TargetSmite ~= nil and IsValidTarget(TargetSmite, 650) and CanCast(self:GetIndexSmite()) and self.menu_Combo_Smiteks.getValue() then
		if self:GetSmiteDamage(TargetSmite) > GetHealthPoint(TargetSmite) then
			CastSpellTarget(TargetSmite, self:GetIndexSmite())
		end
	end
end

function Graves:CountEnemyInLine(target)
	local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
    local targetPos = Vector(target.x, target.y, target.z)
    local targetPosEx = myHeroPos:Extended(targetPos, 500)
    local NH = 1
	for i=1, 4 do
		local h = GetAIHero(GetEnemyHeroes()[i])
		local proj2, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(myHeroPos, targetPosEx, h)
		if isOnSegment and GetDistance(proj2, h) < 65 then
			NH = NH + 1
		end
	end
	return NH
end

function Graves:OnDraw()

	--for i = 1, 15, 1 do
    	--local angle = i * 2 * math.pi / 15
    	--local point = Vector(myHero.x + self.Q.range * math.cos(angle), myHero.y + self.Q.range * math.sin(angle), myHero.z);
    	--table.insert(points, point)
    	--DrawCircleGame(point.x , point.y, point.z, 20, Lua_ARGB(255,255,0,0))
  	--end

    --local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
    --local targetPos = Vector(GetMousePos().x, GetMousePos().y, GetMousePos().z)
    --local EPred = myHeroPos:Extended(targetPos, self.Q.range - 100) --endPosition



    --local A = Vector(100, 200, 300)

    --local B = Vector(400, 500, 600)

    --DrawLineGame(myHero.x, myHero.y, myHero.z, targetPos.x, targetPos.y, targetPos.z, 3)
    --DrawLineGame(GetMousePos().x, GetMousePos().y, GetMousePos().z, 400, 500, 600, 3)

    --[[local TargetSmite = self.menu_ts:GetTarget(650)
    if TargetSmite ~= nil and IsValidTarget(TargetSmite, 650) and CanCast(self:GetIndexSmite()) then
	    targetSmite = GetAIHero(TargetSmite)
	    DrawCircleGame(targetSmite.x , targetSmite.y, targetSmite.z, 65, Lua_ARGB(255,255,255,0))
	    local target = Vector(GetPos(targetSmite.Addr))
	   	local proj2, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(myHeroPos, targetPos, target)
	   	proj = Vector(proj2.x, 0, proj2.z)
	   	__PrintTextGame(tostring(proj))
	    --if isOnSegment and (GetDistanceSqr(target, proj2) <= (65) ^ 2) then

	    	--__PrintTextGame(tostring(proj2).."--"..tostring(pointLine).."--"..tostring(isOnSegment))
	        --return true
	    --end
	end]]
				--local CP, HC = HP:GetPredict(HP_R, t, Vector(myHero))

				--__PrintTextGame(tostring(NH))
    --DrawCircleGame(C.x , C.y, C.z, 300, Lua_ARGB(255,255,0,0))
    --for i = 1, 6 * (self.Q.range - 100), self.Q.range - 100 do
    	--local VL = myHeroPos:Extended(targetPos, i)
    	--if IsWall(EPred.x, EPred.y, EPred.z) then
    		--DrawCircleGame(EPred.x , EPred.y, EPred.z, 300, Lua_ARGB(255,255,0,0))
    	--end
    --end

    --[[local radius = 250;
    local start2 = Vector(GetMousePos().x, GetMousePos().y, GetMousePos().z)
    local end2 = myHeroPos:Extended(start2, self.Q.range - 100)
    local dir = (end2 - start2):Normalized()
    local pDir = dir:Perpendicular();
    local rightEndPos = end2 + pDir * radius;
    local leftEndPos = end2 - pDir * radius;
    local rEndPos = Vector(rightEndPos.x, rightEndPos.y, myHero.z)
    local lEndPos = Vector(leftEndPos.x, leftEndPos.y, myHero.z)
	local step = GetDistance(start2, rEndPos) / 10;
	for i = 1, 10, 1 do
		local pr = start2:Extended(rEndPos, step * i);
        local pl = start2:Extended(lEndPos, step * i);
        if IsWall(pr.x, pr.y, pr.z) and IsWall(pl.x, pl.y, pl.z) then
        	DrawCircleGame(pr.x , pr.y, pr.z, 300, Lua_ARGB(255,255,0,0))
    		DrawCircleGame(pl.x , pl.y, pl.z, 300, Lua_ARGB(255,255,0,0))
        end
	end]]
	--for i = 1, 70, 1 do
		--for j = 1, 6, 1 do
			--newPos = Vector(GetMousePos().x + 65 * j, GetMousePos().y + 65 * j, GetMousePos().z);
			--rotated = myHeroPos:RotateAroundPoint(targetPos, 45 * i)

			--DrawCircleGame(rotated.x , rotated.y, rotated.z, 100, Lua_ARGB(255,255,0,0))
		--end
	--end



	if self.menu_Draw_Already.getValue() then
		if self.menu_Draw_Q.getValue() and self.Q:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,0,0))
		end
		if self.menu_Draw_W.getValue() and self.W:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,0,0))
		end
		if self.menu_Draw_E.getValue() and self.E:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,0,255,0))
		end
		if self.menu_Draw_R.getValue() and self.R:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range, Lua_ARGB(255,0,0,255))
		end
		if self.menu_Draw_R2.getValue() and self.R:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R2.range, Lua_ARGB(255,0,0,255))
		end
	else
		if self.menu_Draw_Q.getValue() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,0,0))
		end
		if self.menu_Draw_W.getValue() and self.W:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,0,0))
		end
		if self.menu_Draw_E.getValue() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,0,255,0))
		end
		if self.menu_Draw_R.getValue() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range, Lua_ARGB(255,0,0,255))
		end
		if self.menu_Draw_R2.getValue() and self.R:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R2.range, Lua_ARGB(255,0,0,255))
		end
	end
end

function Graves:AfterAttack()
	if CanCast(_E) and orbwalk:ComboMode("Combo") and self.menu_Combo_E.getValue() then
		self:LogicE()
	end

	if CanCast(_E) and self.menu_Combo_EJungle.getValue() then
		local orbT = orbwalk:GetTargetOrb()
    	if orbT ~= nil and GetType(orbT) == 3 then
    		CastSpellToPos(GetMousePos().x,GetMousePos().z, _E)
    	end
	end
end

function Graves:OnProcessSpell(unit, spell)
	local spellName = spell.Name:lower()
    if unit.IsMe and orbwalk:IsAutoAttack(spellName) then
    	DelayAction(function() self:AfterAttack() end, 0.1, {})
    end
end

function Graves:IsImmobileTarget(unit)
	if (CountBuffByType(unit, 5) == 1 or CountBuffByType(unit, 11) == 1 or CountBuffByType(unit, 29) == 1 or CountBuffByType(unit, 24) == 1 or CountBuffByType(unit, 10) == 1 or CountBuffByType(unit, 29) == 1) then
		return true
	end
	return false
end

function Graves:CheckWalls(enemyPos)
	local distance = GetDistance(enemyPos)
	local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)

	for i = 100 , 900, 100 do
		local qPos = Vector(enemyPos.x + i, enemyPos.y + i, enemyPos.z)
		--pos = myHeroPos:Extended(enemyPos, distance + 60 * i)
		if IsWall(qPos.x, qPos.y, qPos.z) then
			return qPos
		end
	end
	--return false
end

local function GetDistanceSqr(Pos1, Pos2)
  --local Pos2 = Pos2 or Vector(myHero)
  local P2 = GetOrigin(Pos2) or GetOrigin(myHero)
  local P1 = GetOrigin(Pos1)
  local dx = Pos1.x - Pos2.x
  local dz = (Pos1.z or Pos1.y) - (Pos2.z or Pos2.y)
  return dx * dx + dz * dz
end


function Graves:IsUnderTurretEnemy(pos)			--Will Only work near myHero
	GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
		if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
			local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
			if GetDistanceSqr(turretPos,pos) < 915*915 then
				return true
			end
		end
	end
	return false
end

function Graves:IsUnderAllyTurret(pos)
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
  for k,v in pairs(pUnit) do
    if not IsDead(v) and IsTurret(v) and IsAlly(v) and GetTargetableToTeam(v) == 4 then
      local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
      if GetDistance(turretPos,pos) < 915 then
        return true
      end
    end
  end
    return false
end

function Graves:CountEnemiesInRange(pos, range)
    local n = 0
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    for i, object in ipairs(pUnit) do
        if GetType(object) == 0 and not IsDead(object) and not IsInFog(object) and GetTargetableToTeam(object) == 4 and IsEnemy(object) then
        	local objectPos = Vector(GetPos(object))
          	if GetDistanceSqr(pos, objectPos) <= math.pow(range, 2) then
            	n = n + 1
          	end
        end
    end
    return n
end

local function CountAlliesInRange(pos, range)
    local n = 0
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    for i, object in ipairs(pUnit) do
        if GetType(object) == 0 and not IsDead(object) and not IsInFog(object) and GetTargetableToTeam(object) == 4 and IsAlly(object) then
          if GetDistanceSqr(pos, object) <= math.pow(range, 2) then
              n = n + 1
          end
        end
    end
    return n
end


local function CirclePoints(CircleLineSegmentN, radius, position)
  local points = {}
  for i = 1, CircleLineSegmentN, 1 do
    local angle = i * 2 * math.pi / CircleLineSegmentN
    local point = Vector(position.x + radius * math.cos(angle), position.y + radius * math.sin(angle), position.z);
    table.insert(points, point)
  end
  return points
end

function Graves:CastDash(asap)
    asap = asap and asap or false
    local DashMode = self.menu_Combo_EMode.getValue()
    local bestpoint = Vector(0, 0, 0)
    local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)

    if DashMode == 1 then
    	bestpoint = myHeroPos:Extended(GetMousePos(), self.E.range)
    end

    if DashMode == 2 then
    	local orbT = orbwalk:GetTargetOrb()
    	if orbT ~= nil and GetType(orbT) == 0 then
	    	target = GetAIHero(orbT)
		    local startpos = Vector(myHero.x, myHero.y, myHero.z)
		    local endpos = Vector(target.x, target.y, target.z)
		    local dir = (endpos - startpos):Normalized()
		    local pDir = dir:Perpendicular()
		    local rightEndPos = endpos + pDir * GetDistance(orbT)
		    local leftEndPos = endpos - pDir * GetDistance(orbT)
		    local rEndPos = Vector(rightEndPos.x, rightEndPos.y, myHero.z)
		    local lEndPos = Vector(leftEndPos.x, leftEndPos.y, myHero.z);
		    if GetDistance(GetMousePos(), rEndPos) < GetDistance(GetMousePos(), lEndPos) then
		        bestpoint = myHeroPos:Extended(rEndPos, self.E.range);
		    else
		        bestpoint = myHeroPos:Extended(lEndPos, self.E.range);
		    end
   		end
  	end

    if DashMode == 3 then
	    points = CirclePoints(15, self.E.range, myHeroPos)
	    bestpoint = myHeroPos:Extended(GetMousePos(), self.E.range);
	    local enemies = self:CountEnemiesInRange(bestpoint, 350)

	    for i, point in pairs(points) do
		    local count = self:CountEnemiesInRange(point, 350)
		    if not self:InAARange(point) then
			  	if self:IsUnderAllyTurret(point) then
			        bestpoint = point;
			        enemies = count - 1;
			    elseif count < enemies then
			        enemies = count;
			        bestpoint = point;
			    elseif count == enemies and GetDistance(GetMousePos(), point) < GetDistance(GetMousePos(), bestpoint) then
			        enemies = count;
			        bestpoint = point;
			  	end
		    end
		end
  	end

  	if bestpoint == Vector(0, 0, 0) then
    	return Vector(0, 0, 0)
  	end

  	local isGoodPos = self:IsGoodPosition(bestpoint)

  	if asap and isGoodPos then
    	return bestpoint
  	elseif isGoodPos and self:InAARange(bestpoint) then
    	return bestpoint
  	end
  	return Vector(0, 0, 0)
end

function Graves:InAARange(point)
  --if not "AAcheck" then
    --return true
  --end
  if orbwalk:GetTargetOrb() ~= nil and GetType(orbwalk:GetTargetOrb()) == 0 then
    --local targetpos = GetPos(orbwalk:GetTargetOrb())
    local target = GetAIHero(orbwalk:GetTargetOrb())
    local targetpos = Vector(target.x, target.y, target.z)
    return GetDistance(point, targetpos) < GetTrueAttackRange()
  else
    return self:CountEnemiesInRange(point, GetTrueAttackRange()) > 0
  end
end

function Graves:IsGoodPosition(dashPos)
	local segment = self.E.range / 5;
	local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
	for i = 1, 5, 1 do
		pos = myHeroPos:Extended(dashPos, i * segment)
		if IsWall(pos.x, pos.y, pos.z) then
			return false
		end
	end

	if self:IsUnderTurretEnemy(dashPos) then
		return false
	end

	local enemyCheck = 2 --Config.Item("EnemyCheck", true).GetValue<Slider>().Value;
    local enemyCountDashPos = self:CountEnemiesInRange(dashPos, 600);
    if enemyCheck > enemyCountDashPos then
    	return true
    end
    local enemyCountPlayer = CountEnemyChampAroundObject(myHero.Addr, 400)
    if enemyCountDashPos <= enemyCountPlayer then
    	return true
    end

    return false
end
