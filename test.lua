IncludeFile("Lib\\AllClass.lua") -- cai nay co sk
IncludeFile("Lib\\VPrediction.lua")
IncludeFile("SOW.lua")

SetLuaCombo(true)
SetLuaHarass(true)
SetLuaLaneClear(true)
SetLuaBasicAttackOnly(true)
SetLuaMoveOnly(true)

local VP, SOWi = nil, nil

if VPrediction then
	VP = VPrediction()
	if VP then
		__PrintTextGame('VPrediction Loaded')
	end
end

if SOW then
	SOWi = SOW(VP)

	if SOWi then
		__PrintTextGame('SOW Loaded')
	end
end

AddTickCallback(function () SOWi:EnableAttacks() end)


