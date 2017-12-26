IncludeFile("Lib\\TOIR_SDK.lua")
IncludeFile("Lib\\OrbNew.lua")
--IncludeFile("Lib\\AntiGapCloser.lua")

Twitch = class()

function OnLoad()
	if GetChampName(GetMyChamp()) == "Twitch" then
		Twitch:__init()
	end
end

function Twitch:__init()
	orbwalk = Orbwalking()
	self.menuOrbwalk = menuInst.addItem(SubMenu.new("Orbwalking", Lua_ARGB(255, 100, 250, 50)))
	orbwalk:LoadToMenu(self.menuOrbwalk)

	--antiGap = ChallengerAntiGapcloser()
	--self.menuantiGap = menuInst.addItem(SubMenu.new("Anti-Gapcloser", Lua_ARGB(255, 100, 250, 50)))
	--antiGap:LoadToMenu(self.menuantiGap)

	--Main menu
	self.menu = menuInst.addItem(SubMenu.new("Twitch", Lua_ARGB(255, 100, 250, 50)))

	-- VPrediction
	vpred = VPrediction(self.menu)

	--TS
    self.menu_ts = TargetSelector(1750, 0, myHero, true, self.menu, true)

	--Draw
	self.menu_Draw = self.menu.addItem(SubMenu.new("Drawings"))
	self.menu_Draw_Already = self.menu_Draw.addItem(MenuBool.new("Draw When Already", true))
	self.menu_Draw_Q = self.menu_Draw.addItem(MenuBool.new("Draw Q Time Stealth", true))
	self.menu_Draw_Qrange = self.menu_Draw.addItem(MenuBool.new("Draw Q Range", true))
	self.menu_Draw_W = self.menu_Draw.addItem(MenuBool.new("Draw W Range", true))
	self.menu_Draw_Erange = self.menu_Draw.addItem(MenuBool.new("Draw E Range", true))
	self.menu_Draw_E = self.menu_Draw.addItem(MenuBool.new("Draw E Damage", true))
	self.menu_Draw_R = self.menu_Draw.addItem(MenuBool.new("Draw R Range", true))

	--Combo
	--self.menu_Combo = self.menu.addItem(SubMenu.new("Combo"))
	self.menu_ComboQ = self.menu.addItem(SubMenu.new("Setting Q"))
	self.menu_Combo_Q = self.menu_ComboQ.addItem(MenuBool.new("Use Q In Combo", true))
	self.menu_Combo_QCount = self.menu_ComboQ.addItem(MenuSlider.new("Auto Q if Have", 3, 0, 5, 1))
	--self.menu_Combo_QRecall = self.menu_ComboQ.addItem(MenuBool.new("Safe Recall", true))
	self.menu_Combo_QRecall = self.menu_ComboQ.addItem(MenuKeyBind.new("Safe Recall", 66))


	self.menu_ComboW = self.menu.addItem(SubMenu.new("Setting W"))
	self.menu_Combo_W = self.menu_ComboW.addItem(MenuBool.new("Auto Use W Combo", false))
	self.menu_Combo_Wmode = self.menu_ComboW.addItem(MenuStringList.new("W Mode", { "Normal ", "Behind Target", "Front Target" }, 2))
	self.menu_Combo_Wgap = self.menu_ComboW.addItem(MenuBool.new("Use W Anti GapClose", true))
	self.menu_Combo_WendDash = self.menu_ComboW.addItem(MenuBool.new("Use W End Dash", true))
	self.menu_Combo_WCount = self.menu_ComboW.addItem(MenuSlider.new("Auto W if Hit", 2, 1, 5, 1))

	self.menu_ComboE = self.menu.addItem(SubMenu.new("Setting E"))
	self.menu_Combo_E = self.menu_ComboE.addItem(MenuStringList.new("Mode Target", { "Normal ", "Have E  "}, 2))
	--self.menu_Combo_ECount = self.menu_ComboE.addItem(MenuSlider.new("Auto E If Stack", 6, 0, 6, 1))
	--self.menu_Combo_EAuto = self.menu_ComboE.addItem(MenuBool.new("Auto E If Out Range", true))
	self.menu_Combo_EAuto = self.menu_ComboE.addItem(MenuSlider.new("Auto E Out Range & Stack", 3, 0, 6, 1))
	self.menu_Combo_EKs = self.menu_ComboE.addItem(MenuBool.new("Auto E Kill Steal", true))
	--self.menu_Combo_EKsminion = self.menu_ComboE.addItem(MenuBool.new("Auto E Last Hit", true))
	self.menu_ComboE.addItem(MenuSeparator.new("E In Jungle"))
	self.menu_Combo_EKsBlue = self.menu_ComboE.addItem(MenuBool.new("Auto E KS Blue", true))
	self.menu_Combo_EKsRed = self.menu_ComboE.addItem(MenuBool.new("Auto E KS Red", true))
	self.menu_Combo_EKsDragon = self.menu_ComboE.addItem(MenuBool.new("Auto E KS Dragon", true))
	self.menu_Combo_EKsBaron = self.menu_ComboE.addItem(MenuBool.new("Auto E KS Baron", true))


	self.menu_ComboR = self.menu.addItem(SubMenu.new("Setting R"))
	self.menu_Combo_R = self.menu_ComboR.addItem(MenuBool.new("Use R In Combo", true))
	self.menu_Combo_RCount = self.menu_ComboR.addItem(MenuSlider.new("Auto R If Have Enemy", 2, 1, 5, 1))
	--self.menu_Combo_Rks = self.menu_ComboR.addItem(MenuBool.new("Use R Kill Steal", true))

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
	self.menu_ModSkinValue = self.menu_ModSkin.addItem(MenuSlider.new("Set Skin", 10, 0, 20, 1))

	menuInstSep.setValue("Twitch Magic")

	self.Q = Spell(_Q, GetTrueAttackRange())
    self.W = Spell(_W, 1050)
    self.E = Spell(_E, 1350)
    self.R = Spell(_R, GetTrueAttackRange() + 300)
    self.Q:SetActive()
    self.W:SetSkillShot(0.25, 1750, 300, true)
    self.E:SetActive()
    self.R:SetActive()

	Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
end



function Twitch:OnTick()

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
	--__PrintTextGame(tostring(self:RemainQ()))


	self:AutoQ()
	self:AutoW()
	self:AutoE()
	self:AutoR()
	self:ReCall()

	self:KillSteal()

	self:LogicSmiteJungle()

	if orbwalk:ComboMode("Combo") then
		SetLuaCombo(true)
		self:LogicQ()
		self:LogicW()
		self:LogicE()
		self:LogicR()
	end

	if self.menu_ModSkinValue.getValue() ~= 0 then
		ModSkin(self.menu_ModSkinValue.getValue())
	end
end

function Twitch:GetIndexSmite()
	if GetSpellIndexByName("SummonerSmite") > -1 then
		return GetSpellIndexByName("SummonerSmite")
	elseif GetSpellIndexByName("S5_SummonerSmiteDuel") > -1 then
		return GetSpellIndexByName("S5_SummonerSmiteDuel")
	elseif GetSpellIndexByName("S5_SummonerSmitePlayerGanker") > -1 then
		return GetSpellIndexByName("S5_SummonerSmitePlayerGanker")
	end
	return -1
end

function Twitch:GetIndexRecall()
	if GetSpellIndexByName("recall") > -1 then
		return GetSpellIndexByName("recall")
	end
	return -1
end

function Twitch:GetSmiteDamage(target)
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

function Twitch:LogicSmiteJungle()
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

function Twitch:LogicQ()
    local orbT = orbwalk:GetTargetOrb()
	if orbT ~= nil and GetType(orbT) == 0 then
		if myHero.MP > 180 and GetDistance(orbT) < GetTrueAttackRange() and self.menu_Combo_Q.getValue() and CanCast(_Q) then
			CastSpellTarget(myHero.Addr, _Q)
		end
	end
end

function Twitch:LogicW()
	local TargetW = self.menu_ts:GetTarget(self.W.range)
	if CanCast(_W) and TargetW ~= 0 then
		target = GetAIHero(TargetW)
		local CastPosition, HitChance, Position = vpred:GetCircularCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(target, self.W.delay, self.W.width, self.W.speed, myHero, false)
		local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)

		if (GetDistance(TargetW) < self.W.range - 300 and GetDistance(TargetW) > 300  or self:IsImmobileTarget(TargetW)) then
			if self:GetIndexSmite() > -1 and self.menu_Combo_Smite.getValue() then
				CastSpellTarget(TargetW, self:GetIndexSmite())
			end
			if self.menu_Combo_W.getValue() then
				if CastPosition and HitChance >= 2 and self.menu_Combo_Wmode.getValue() == 1 then
		        	CastSpellToPos(CastPosition.x, CastPosition.z, _W)
		    	end
		    	if CastPosition and HitChance >= 2 and self.menu_Combo_Wmode.getValue() == 2 then
		    		posBehind = CastPosition:Extended(myHero, -150)
		        	CastSpellToPos(posBehind.x, posBehind.z, _W)
		    	end
		    	if CastPosition and HitChance >= 2 and self.menu_Combo_Wmode.getValue() == 3 then
		    		posFront = CastPosition:Extended(myHero, 150)
		        	CastSpellToPos(posFront.x, posFront.z, _W)
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

function Twitch:LogicE()
	if self.menu_Combo_E.getValue() == 2 then
		local target = self:GetTargetBuffE(GetTrueAttackRange() + 50)
		orbwalk:ForceTarget(target)
	end
end

function Twitch:LogicR()
    local orbT = orbwalk:GetTargetOrb()
	if orbT ~= nil and GetType(orbT) == 0 and myHero.MP > 140 and self.menu_Combo_R.getValue() and CanCast(_R) then
		CastSpellTarget(myHero.Addr, _Q)
	end
end

function Twitch:AutoQ()
    if CountEnemyChampAroundObject(myHero.Addr, 650) >= self.menu_Combo_QCount.getValue() and CountAllyChampAroundObject(myHero.Addr, 650) < CountEnemyChampAroundObject(myHero.Addr, 650) and CanCast(_Q) then
    	CastSpellTarget(myHero.Addr, _Q)
    end
end

function Twitch:AutoW()
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

function Twitch:AutoE()
	local target = self:GetTargetBuffE(self.E.range)
	if target ~= nil then		
		--targetE = GetAIHero(target)	
		--__PrintTextGame(tostring(self:GetStackBuffE(target)))
		--if self:GetStackBuffE(target) >= self.menu_Combo_ECount.getValue() and CanCast(_E) then
			--CastSpellTarget(myHero.Addr, _E)
		--end
		
		if IsValidTarget(target, self.E.range) and self:GetStackBuffE(target) >= self.menu_Combo_EAuto.getValue() and GetDistance(target) >= self.E.range * 0.80 and CanCast(_E) then
			--__PrintTextGame(tostring(GetDistance(target)))
			CastSpellTarget(myHero.Addr, _E)
		end
	end

    for i, minions in ipairs(orbwalk:JungleTbl()) do
        if minions ~= 0 then
            local jungle = GetUnit(minions)
            if jungle.Type == 3 and jungle.TeamId == 300 and GetDistance(jungle.Addr) < self.E.range and
                (GetObjName(jungle.Addr) ~= "PlantSatchel" and GetObjName(jungle.Addr) ~= "PlantHealth" and GetObjName(jungle.Addr) ~= "PlantVision") then
                --local stack = GetBuff(GetBuffByName(jungle.Addr, "TwitchDeadlyVenom"))
                --__PrintTextGame(tostring(self:getEDmg(jungle)))
                if IsValidTarget(jungle.Addr, self.E.range) and self:getEDmg(jungle) > jungle.HP and jungle.CharName == "SRU_Red" and self.menu_Combo_EKsRed.getValue() then
                    CastSpellTarget(jungle.Addr, _E)
                end

                if IsValidTarget(jungle.Addr, self.E.range) and self:getEDmg(jungle) > jungle.HP and jungle.CharName == "SRU_Blue" and self.menu_Combo_EKsBlue.getValue() then
                    CastSpellTarget(jungle.Addr, _E)
                end

                if IsValidTarget(jungle.Addr, self.E.range) and self:getEDmg(jungle) > jungle.HP and jungle.CharName == "SRU_RiftHerald" and self.menu_Combo_SmiteRed.getValue() then
                    CastSpellTarget(jungle.Addr, _E)
                end

                if IsValidTarget(jungle.Addr, self.E.range) and self:getEDmg(jungle) > jungle.HP and jungle.CharName == "SRU_Baron" and self.menu_Combo_EKsBaron.getValue() then
                    CastSpellTarget(jungle.Addr, _E)
                end

                if IsValidTarget(jungle.Addr, self.E.range) and self:getEDmg(jungle) > jungle.HP and jungle.CharName:find("SRU_Dragon") and self.menu_Combo_EKsDragon.getValue() then
                    eCastSpellTarget(jungle.Addr, _E)
                end
                --__PrintTextGame(self:getEDmg(jungle))
            end
        end
    end
end

function Twitch:AutoR()
	if CountEnemyChampAroundObject(myHero.Addr, 650) >= self.menu_Combo_RCount.getValue() and CountAllyChampAroundObject(myHero.Addr, 650) < CountEnemyChampAroundObject(myHero.Addr, 650) and CanCast(_R) then
    	CastSpellTarget(myHero.Addr, _R)
    end
end

function Twitch:GetStackBuffE(target)
	if target ~= nil then
		if GetBuffByName(target, "TwitchDeadlyVenom") ~= 0 then
			local stack = GetBuff(GetBuffByName(target, "TwitchDeadlyVenom"))
			return stack.Count
		else
			return 0
		end
	end
	return 0
end

function Twitch:GetTargetBuffE(range)
    local result = nil
    local N = math.huge
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero~= 0 and IsValidTarget(hero, range) and GetBuffByName(hero, "TwitchDeadlyVenom") ~= 0 then
        	table.sort(GetEnemyHeroes(), function(a, b) return self:GetStackBuffE(a) > self:GetStackBuffE(b) end)
            local dmgtohero = GetAADamageHitEnemy(hero) or 1
            local tokill = GetHealthPoint(hero)/dmgtohero
            if tokill < N or result == nil then
                N = tokill
                result = hero
            end
        end
    end
    return result
end

function Twitch:KillSteal()
	for i,hero in pairs(GetEnemyHeroes()) do
        if hero~= 0 and IsValidTarget(hero, self.E.range) and GetBuffByName(hero, "TwitchDeadlyVenom") ~= 0 then
        	target = GetAIHero(hero)
        	if self:RealEDamage(target) > target.HP and CanCast(_E) and self.menu_Combo_EKs.getValue() then        		
        		CastSpellTarget(myHero.Addr, _E)
        	end
        end
    end

	local TargetSmite = self.menu_ts:GetTarget(650)
	if TargetSmite ~= nil and IsValidTarget(TargetSmite, 650) and CanCast(self:GetIndexSmite()) and self.menu_Combo_Smiteks.getValue() then

		if self:GetSmiteDamage(TargetSmite) > GetHealthPoint(TargetSmite) then
			CastSpellTarget(TargetSmite, self:GetIndexSmite())
		end
	end
end


function Twitch:OnProcessSpell(unit, spell)

end

function Twitch:ReCall()
	if self.menu_Combo_QRecall.getValue() then		
		if self.Q:IsReady() then
			CastSpellTarget(myHero.Addr, _Q)			
			DelayAction(function() CastSpellTarget(myHero.Addr, self:GetIndexRecall()) end, 0.5)
		end 
	end
end

function Twitch:OnDraw()
	if self.menu_Draw_Already.getValue() then
		if self.menu_Draw_W.getValue() and self.W:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,0,0))
		end
		if self.menu_Draw_Erange.getValue() and self.E:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,0,0,255))
		end
		if self.menu_Draw_R.getValue() and self.R:IsReady() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range, Lua_ARGB(255,0,0,255))
		end
	else		
		if self.menu_Draw_W.getValue() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,0,0))
		end
		if self.menu_Draw_Erange.getValue() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,0,0,255))
		end
		if self.menu_Draw_R.getValue() then
			DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range, Lua_ARGB(255,0,0,255))
		end
	end
	if self.menu_Draw_Qrange.getValue() then
		DrawCircleGame(myHero.x , myHero.y, myHero.z, self:RemainQ() * myHero.MoveSpeed, Lua_ARGB(255, 0, 255, 10))
	end
	
	if self.menu_Combo_QRecall.getValue() then
		if self.Q:IsReady() then
			CastSpellTarget(myHero.Addr, _Q)			
			DelayAction(function() CastSpellTarget(myHero.Addr, self:GetIndexRecall()) end, 0.5)
		end 
	end

	local a,b = WorldToScreen(myHero.x, myHero.y, myHero.z)
	if self.menu_Draw_Q.getValue() and myHero.HasBuff("TwitchHideInShadows") then
    	DrawTextD3DX(a, b, tostring(self:RemainQ()), Lua_ARGB(255, 0, 255, 10))
    end
    if self.menu_Draw_E.getValue() then
	    for i,hero in pairs(GetEnemyHeroes()) do
	        if hero~= 0 and IsValidTarget(hero, self.E.range) and GetBuffByName(hero, "TwitchDeadlyVenom") ~= 0 then
	        	target = GetAIHero(hero)
	            self:DrawHP(target, self:RealEDamage(target))
	        end
	    end
	end

	--self:DrawHP(100)
    --local a,b =  GetHealthBarPos(myHero.Addr)
    --DrawTextD3DX(a, b, tostring(self:RemainQ()), Lua_ARGB(255, 0, 255, 10))
    --DrawBorderBoxD3DX(a, b, 50, 50, 3, Lua_ARGB(255,0,0,255))
	--FilledRectD3DX(a, b, myHero.HP * (108 / myHero.MaxHP), 12, Lua_ARGB(100,255,0,0))
	--local pbuff = GetBuff(GetBuffByName(myHero.Addr, "recall"))
	--__PrintTextGame(pbuff.Name)
	--__PrintTextGame(tostring(CastSpellTarget(myHero.Addr, self:GetIndexRecall())))


	--[[local TargetW = self.menu_ts:GetTarget(self.W.range)
	target = GetAIHero(TargetW)
	--local aa = (GetBuffCount(target.Addr, "TwitchDeadlyVenom") * ({15, 20, 25, 30, 35})[myHero.Level] + 0.2 * myHero.MagicDmg + 0.25 * myHero.TotalDmg) + ({20, 35, 50, 65, 80})[myHero.Level]
    --{Slot = "E", Stage = 2, DamageType = 1, Damage = function(source, target, level) return ({15, 20, 25, 30, 35})[level] + 0.2 * source.MagicDmg + 0.25 * source.TotalDmg + ({20, 35, 50, 65, 80})[level] end},
	--local stack = GetBuff(GetBuffByName(target.Addr, "TwitchDeadlyVenom"))
	if target ~= 0 then
		--__PrintTextGame(tostring(self:getEDmg(target)))
	end]]
	--local stack = GetBuff(GetBuffByName(myHero.Addr, "TwitchHideInShadows"))
	--__PrintTextGame(tostring(GetBuffByName(myHero.Addr, "TwitchHideInShadows")).."--"..tostring(stack.EndT).."--"..tostring(stack.EndT - GetTimeGame()))
end

function Twitch:DrawHP(unit, damage)
	local a,b =  GetHealthBarPos(unit.Addr)
	FilledRectD3DX(a, b, (unit.HP - damage) * (108 / unit.MaxHP), 12, Lua_ARGB(100,0,0,0))
end

function Twitch:IsImmobileTarget(unit)
	if (CountBuffByType(unit, 5) == 1 or CountBuffByType(unit, 11) == 1 or CountBuffByType(unit, 29) == 1 or CountBuffByType(unit, 24) == 1 or CountBuffByType(unit, 10) == 1 or CountBuffByType(unit, 29) == 1) then
		return true
	end
	return false
end

function Twitch:CountEnemiesInRange(pos, range)
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

function Twitch:InAARange(point)
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

function Twitch:getEDmg(target)
	if target == 0 then
		return
	end
	local Damage = 0
	local DamageAP = {15, 20, 25, 30, 35}
	local DamageAD = {20, 35, 50, 65, 80}

	local stack = GetBuff(GetBuffByName(target.Addr, "TwitchDeadlyVenom"))
	--__PrintTextGame(tostring(stack.Count).."--"..tostring(myHero.BonusDmg).."--"..tostring(myHero.MagicDmg).."--"..tostring(DamageAP[myHero.LevelSpell(_E)]).."--"..tostring(DamageAD[myHero.LevelSpell(_E)]))
	if stack.Count > 0 then
		Damage = stack.Count * (0.25 * myHero.BonusDmg + DamageAP[myHero.LevelSpell(_E)] + 0.2 * myHero.MagicDmg) + DamageAD[myHero.LevelSpell(_E)]
	end
	return myHero.CalcDamage(target.Addr, Damage)
end

function Twitch:RealEDamage(target)
	if target ~= 0 and target.HasBuff("TwitchDeadlyVenom") then
		local damage = 0
		if target.HasBuff("KindredRNoDeathBuff") then
			return 0
		end
		local pbuff = GetBuff(GetBuffByName(target, "UndyingRage"))
		if target.HasBuff("UndyingRage") and pbuff.EndT > GetTimeGame() + 0.3  then
			return 0
		end
		if target.HasBuff("JudicatorIntervention") then
			return 0
		end
		local pbuff2 = GetBuff(GetBuffByName(target, "ChronoShift"))
		if target.HasBuff("ChronoShift") and pbuff2.EndT > GetTimeGame() + 0.3 then
			return 0
		end
		if target.HasBuff("FioraW") then
			return 0
		end
		if target.HasBuff("ShroudofDarkness") then
			return 0
		end
		if target.HasBuff("SivirShield") then
			return 0
		end
		if self.E:IsReady() then
			damage = damage + self:getEDmg(target)
		else
			damage = 0
		end
		if target.HasBuff("Moredkaiser") then
			damage = damage - target.MP
		end
		if target.HasBuff("SummonerExhaust") then
			damage = damage * 0.6;
		end
		if target.HasBuff("BlitzcrankManaBarrierCD") and target.HasBuff("ManaBarrier") then
			damage = damage - target.MP / 2
		end
		if target.HasBuff("GarenW") then
			damage = damage * 0.7;
		end
		if target.HasBuff("ferocioushowl") then
			damage = damage * 0.7;
		end
		return damage
	end
	return 0
end

function Twitch:passiveDmg(target)
	--if not target.HasBuff("TwitchDeadlyVenom") then
		--return 0
	--end
	local stack = GetBuff(GetBuffByName(target, "TwitchDeadlyVenom"))
	local dmg = 6;
	if myHero.Level < 17 then
		dmg = 5
	end
	if myHero.Level < 13 then
		dmg = 4
	end
	if myHero.Level < 9 then
		dmg = 3
	end
	if myHero.Level < 5 then
		dmg = 2
	end
	__PrintTextGame(tostring(stack.EndT))
	local buffTime = stack.EndT - GetTimeGame() -- GetPassiveTime(target, "TwitchDeadlyVenom");
    return (dmg * stack.Count * buffTime) - 20 * buffTime;
end

function Twitch:RemainQ()
	if myHero.HasBuff("TwitchHideInShadows") then
		local stack = GetBuff(GetBuffByName(myHero.Addr, "TwitchHideInShadows"))
		return stack.EndT - GetTimeGame()
	end
	return 0
end
