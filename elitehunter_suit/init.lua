AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")



function ENT:Initialize()
	self:SetModel("models/props_junk/wood_crate001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end;
end;

function ENT:Use(activator, caller)
 if (!caller.isWearingArmor) then
	     caller.TitaniumArmor = true
	caller.oldModel = caller:GetModel()
	caller:SetRunSpeed( 3200 )
	caller:SetWalkSpeed( 850 )
	caller:SetHealth( 9500000 )
	caller:SetMaxHealth( 9500000 )
	caller:SetArmor(950000)
	caller:SetMaxArmor(950000)
	caller:SetJumpPower(420)
	caller:Give("tfa_cso_budgetsword")
	caller:SetBloodColor( 3 )
	caller:SetModel("models/timbleweebs/anthem/interceptor_timbles_pbrtest.mdl")
	caller.shouldTakeLessDamageItself = false
	caller.shouldFallDamageBeReducedArmor = true
	caller.isWearingArmor = true
	self:Remove()
	end
end;

hook.Add("PlayerSay", "DropArmor", function(ply, text)
	if (string.lower(text) == "/dropsuit") then
		if (ply.TitaniumArmor) then
		ply.TitaniumArmor = false
		ply.shouldTakeLessDamageItself = false
	    ply.shouldFallDamageBeReducedArmor = false
	    ply.isWearingArmor = false
		ply:StripWeapon("tfa_cso_budgetsword")
        ply:SetModel(ply.oldModel)
		ply:SetArmor(0)
		ply:SetMaxArmor(255)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetWalkSpeed(200)
		ply:SetRunSpeed(500)
		ply:SetJumpPower(230)
		local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 30
			trace.filter = ply
			
		 ents.Create("titanium_armor")
		 local trl = util.TraceLine(trace)
		 local pr = ents.Create("elitehunter_suit")
		 pr:SetPos(trl.HitPos)
		 pr:Spawn()
		 return ""
		 end
	end
end)