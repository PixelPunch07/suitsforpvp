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
 dont fucking use this
function ENT:Use(activator, caller)
 if (!caller.isWearingArmor) then
	     caller.GooberArmor = true
	caller.oldModel = caller:GetModel()
	caller:SetModelScale(0.7)
	caller:SetRunSpeed( 2900 )
	caller:SetWalkSpeed( 200 )
	caller:SetFriction( 0.01)
	caller:SetHealth( 6900 )
	caller:SetMaxHealth( 6900 )
	caller:SetArmor(1000000)
	caller:SetMaxArmor(1000000)
	caller:SetJumpPower(550)
	caller:Give("weapon_suit_fists")
	caller:SetBloodColor( 3 )
	caller:SetModel("models/ralsei/ralsei.mdl")
	caller.shouldTakeLessDamageItself = false
	caller.shouldFallDamageBeReducedArmor = true
	caller.isWearingArmor = true
	self:Remove()
	end
end;

hook.Add("PlayerSay", "DropArmor", function(ply, text)
	if (string.lower(text) == "/dropsuit") then
		if (ply.GooberArmor) then
		ply.GooberArmor = false
		ply.shouldTakeLessDamageItself = false
	    ply.shouldFallDamageBeReducedArmor = false
	    ply.isWearingArmor = false
		ply:StripWeapon("weapon_suit_fists")
        ply:SetModel(ply.oldModel)
		ply:SetFriction(8)
		ply:SetHealth(100)
		pky:SetMaxHealth(100)
		ply:SetRunSpeed(500)
		ply:SetWalkSpeed(200)
		ply:SetArmor(0)
		ply:SetMaxArmor(255)
		ply:SetJumpPower(230)
		local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 30
			trace.filter = ply
			
		 ents.Create("thegoober_suit")
		 local trl = util.TraceLine(trace)
		 local pr = ents.Create("thegoober_suit")
		 pr:SetPos(trl.HitPos)
		 pr:Spawn()
		 return ""
		 end
	end
end)
