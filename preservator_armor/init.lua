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
	end
end

function ENT:Use(activator, caller)
	if (!caller.isWearingArmor) then
			caller.PreservatorArmor = true
	   caller.oldModel = caller:GetModel()
	   caller:SetRunSpeed( 2000 )
	   caller:SetWalkSpeed( 200 )
	   caller:SetHealth( 200000 )
	   caller:SetMaxHealth( 200000 )
	   caller:Give("weapon_suit_fists")
	   caller:SetBloodColor( 3 )
	   caller:SetModel("models/reverse/godspeed/godspeed.mdl")
	   caller.shouldTakeLessDamageItself = false
	   caller.shouldFallDamageBeReducedArmor = false
	   caller.isWearingArmor = true
	   self:Remove()
	   end
   end;

hook.Add("PlayerSay", "DropPresArmor", function(ply, text)
	if (string.lower(text) == "/unweararmor") then
		if (ply.PreservatorArmor) then
		ply.PreservatorArmor = false
	    ply.isWearingArmor = false
		ply.shouldSuitRegenHealth = false
		ply.slightDamReduce = false
		timer.Remove("SuitHealthRegenTimer_" .. ply:SteamID())
        ply:SetModel(ply.oldPresModel)
		local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 30
			trace.filter = ply
			
		 ents.Create("preservator_armor")
		 local trl = util.TraceLine(trace)
		 local pr = ents.Create("preservator_armor")
		 pr:SetPos(trl.HitPos)
		 pr:Spawn()
		 return ""
		 end
	end
end)