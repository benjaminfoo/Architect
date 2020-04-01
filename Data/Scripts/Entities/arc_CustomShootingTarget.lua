Script.ReloadScript("Scripts/Default/Entities/actor/BasicActor.lua");

CustomShootingTarget = {
    Client = {},
    Server = {},
    Properties = {
        object_Model = "objects/props/target/target.cgf",

        Physics = {
            bPhysicalize = 1,
            bPushableByPlayers = 0,
            sName = "GeneratorEntity",

            Density = 1,
            Mass = 1,

            bRigidBody = 0,
            bRigidBodyActive = 0,
            bRigidBodyAfterDeath = 0,
            bActivateOnDamage = 0,
        },

        shootCount = 0,
    },

    States = { "Activated", "Deactivated", "Turning", "Init" },
}


--
function CustomShootingTarget:OnReset()
    local props = self.Properties;
    if (not EmptyString(props.object_Model)) then
        self:LoadObject(0, props.object_Model);
    end ;

    self:Activate(1);
    local Physics = self.Properties.Physics;
    EntityCommon.PhysicalizeRigid(self, 0, Physics, true);

    System.LogAlways("OnReset CustomShootingTarget!")

end;


--
function CustomShootingTarget:OnSave(table)
    table.object_Model = self.Properties.object_Model;
end;


--
function CustomShootingTarget:OnLoad(table)
    self.object_Model = table.object_Model;

    -- load the persisted model path from the save file
    self:LoadObject(0, table.object_Model)

    -- initialize the physical parameter of this entity (like size, shape, etc)
    -- self:PhysicalizeThis()

    -- disable near fade-out by default
    self:SetViewDistUnlimited()

end;


--
function CustomShootingTarget:OnPropertyChange()
    self:OnReset();
end;


--
function CustomShootingTarget.Server:OnInit()
    self.physics = {
        bRigidBody = 1,
        bRigidBodyActive = 1,
        Density = -1,
        Mass = -1,
    };
    self:OnReset();

    System.LogAlways("OnInit CustomShootingTarget!")

end;


--
function CustomShootingTarget.Client:OnHit(hit)
    -- System.LogAlways("Someone at Client OnHit me!")
    self.Properties.shootCount = self.Properties.shootCount + 1

    hitMessage = "Hit target!" .. "\n" .. "Hit-Count: " .. tonumber(self.Properties.shootCount)

    Game.SendInfoText(hitMessage, true, nil, 3)

end


--
function CustomShootingTarget.Client:OnDamage(hit)
    System.LogAlways("Someone at Client OnDamage me!")
end


--
function CustomShootingTarget.Client:OnEvent(hit)
    System.LogAlways("Someone at Client OnEvent me!")
end


--
function CustomShootingTarget:OnHit(hit)
    System.LogAlways("Someone at Client OnHit me but local !")
end


--
function CustomShootingTarget:OnDamage(hit)
    System.LogAlways("Someone at Client OnDamage me but local !")
end


--
function CustomShootingTarget:OnEvent(hit)
    System.LogAlways("Someone at Client OnEvent me but local !")
end


--
function CustomShootingTarget.Server:OnHit(hit)
    System.LogAlways("Someone at Client OnHit me but local !")
end


--
function CustomShootingTarget.Server:OnDamage(hit)
    System.LogAlways("Someone at Client OnDamage me but local !")
end


--
function CustomShootingTarget.Server:OnEvent(hit)
    System.LogAlways("Someone at Client OnEvent me but local !")
end


--
function CustomShootingTarget.Server:OnHit(hit)

    System.LogAlways("Someone at server shot me!")

    if (self:GetState() ~= "Activated") then
        return ;
    end ;
    local vTmp = g_Vectors.temp;
    SubVectors(vTmp, self:GetPos(), hit.pos);
    local dist = LengthVector(vTmp);
    dist = ((1 - (dist * 2)) + 0.08) * 10;
    if (dist > 9.4) then
        dist = 10;
    else
        dec = string.find(dist, ".", 1, 1)
        dist = tonumber(string.sub(dist, 1, dec - 1))
    end ;

end;


--
function CustomShootingTarget:Event_Activated()
    self:GotoState("Init");
    BroadcastEvent(self, "Activated")
end;


--
function CustomShootingTarget:Event_Deactivated()
    System.LogAlways("Event_deacted - onbeginstate ")

    self.ended = 1;
    self:GotoState("Deactivated");
    BroadcastEvent(self, "Deactivated")
end;

CustomShootingTarget.FlowEvents = {
    Inputs = {
        Deactivated = { CustomShootingTarget.Event_Deactivated, "bool" },
        Activated = { CustomShootingTarget.Event_Activated, "bool" },
    },
    Outputs = {
        Deactivated = "bool",
        Activated = "bool",
        Hit = "int",
        Damage = "int",
        PlayerOne = "int",
        PlayerTwo = "int",
    },
}

MakeUsable(CustomShootingTarget);
MakePickable(CustomShootingTarget);
MakeTargetableByAI(CustomShootingTarget);
MakeKillable(CustomShootingTarget);
