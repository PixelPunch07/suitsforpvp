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
	caller:EmitSound(Sound("pain/specter_intro3.mp3"))
	caller:SetRunSpeed( 2300 )
	caller:SetWalkSpeed( 900 )
	caller:SetHealth( 3000000 )
	caller:SetMaxHealth( 3000000 )
	caller:SetArmor(20000)
	caller:SetMaxArmor(20000)
	caller:Give("weapon_suit_fists")
	caller:SetBloodColor( 3 )
	caller:SetModel("models/napixel/customchar/fantasy/thedarkmage/thedarkmage.mdl")
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
		ply:StripWeapon("weapon_suit_fists")
        ply:SetModel(ply.oldModel)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(255)
		ply:SetRunSpeed(500)
		ply:SetWalkSpeed(200)
		local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 30
			trace.filter = ply
			
		 ents.Create("darknessrider_suit")
		 local trl = util.TraceLine(trace)
		 local pr = ents.Create("darknessrider_suit")
		 pr:SetPos(trl.HitPos)
		 pr:Spawn()
		 return ""
		 end
	end
end)
