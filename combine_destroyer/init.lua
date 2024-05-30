AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_crates/supply_crate01.mdl")
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
	   caller.oldPresModel = caller:GetModel()
	   caller.PreservatorArmor = true
	   caller.slightDamReduce = true
	 caller:SetRunSpeed( 950 )
	caller:SetWalkSpeed( 600 )
	caller:SetJumpPower( 600 )
	caller:SetHealth( 750000 ) 
	caller:SetMaxHealth( 750000 )
	caller:SetMaxArmor( 150000 )
	caller:SetArmor( 150000 )
		caller:Give("weapon_combinesummon")
		caller:Give("weapon_overwatchgaster")
	caller.shouldSuitRegenHealth = true
	caller:SetBloodColor( -1 )
	caller.isWearingArmor = true
	caller:SetModel("models/cultist/hl_a/combine_commander/combine_commander.mdl") -- Model of the Preservator Armor
	if (caller.shouldSuitRegenHealth) then
      local regenUpToHealthMax = 200000
      local healPeriodInst = 30
      local timerArmRegName = "SuitHealthRegenTimer_" .. caller:SteamID()

       if (timer.Exists(timerArmRegName)) then
            return
       end
 
       timer.Create(timerArmRegName, healPeriodInst, 0, function()
           if (!IsValid(caller)) then
                return
           end
 
           if (caller:Health() >= regenUpToHealthMax) then
                timer.Remove(timerArmRegName)
               
             return
           end
     
           caller:SetHealth(caller:Health() + 350000)
		   caller:SetArmor(caller:Armor() + 60000)
		   caller:EmitSound( "items/medshot5.wav", 75 )
       end)
   end

	self:Remove()
	end
end

hook.Add("PlayerSay", "DropPresArmor", function(ply, text)
	if (string.lower(text) == "/unweararmor") then
		if (ply.PreservatorArmor) then
		ply.PreservatorArmor = false
	    ply.isWearingArmor = false
		ply:StripWeapon("weapon_combinesummon")
		ply:StripWeapon("weapon_overwatchgaster")
		ply.shouldSuitRegenHealth = false
		ply.slightDamReduce = false
		timer.Remove("SuitHealthRegenTimer_" .. ply:SteamID())
        ply:SetModel(ply.oldPresModel)
		local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 30
			trace.filter = ply
			
		 ents.Create("WEEDordon")
		 local trl = util.TraceLine(trace)
		 local pr = ents.Create("WEEDordon")
		 pr:SetPos(trl.HitPos)
		 pr:Spawn()
		 return ""
		 end
	end
end)