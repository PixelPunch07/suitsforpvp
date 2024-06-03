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
	caller:EmitSound(Sound("pain/intro_new.mp3"))
	caller:SetRunSpeed( 1400 )
	caller:SetWalkSpeed( 800 )
	caller:SetHealth( 300000 )
	caller:SetMaxHealth( 300000 )
	caller:SetArmor(10000)
	caller:SetMaxArmor(10000)
	caller:Give("tfa_cso_stormgiant_v8")
	caller:SetBloodColor( 3 )
	caller:SetModel("models/models/konnie/lotfjudge/lotfjudge.mdl")
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
		ply:StripWeapon("tfa_cso_stormgiant_v8")
        ply:SetModel(ply.oldModel)
		ply:SetRunSpeed(500)
		ply:SetWalkSpeed(200)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(255)
		local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 30
			trace.filter = ply
			
		 ents.Create("cosmicbreaker_suit")
		 local trl = util.TraceLine(trace)
		 local pr = ents.Create("cosmicbreaker_suit")
		 pr:SetPos(trl.HitPos)
		 pr:Spawn()
		 return ""
		 end
	end
end)
