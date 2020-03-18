---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The GeneratorEntity is the common parent type for constructions which generate some kind of resource.
---
--- For example: TODO :)
---
-- Script.ReloadScript("scripts/Utils/EntityUtils.lua")

GeneratorEntity = {
    Client = {},
    Server = {},
    Properties = {

        class = "BasicEntity",

        generated_value = 0,

        MaxSpeed = 1,
        fHealth = 100,
        bTurnedOn = 1,
        bExcludeCover = 0,
        fUsabilityDistance = 100,

        Script = {
            Misc = ""
        },

        Physics = {
            bPhysicalize = 1,
            bRigidBody = 1,
            bPushableByPlayers = 1,
            Density = -1,
            Mass = -1,
        },

        bSaved_by_game = 1,
        Saved_by_game = 1,
        bSerialize = 1,

        bInteractiveCollisionClass = 1,
        object_Model = "objects/buildings/refugee_camp/bad_straw.cgf",
        guidSmartObjectType = "39012413-1895-4828-b202-b3835a78984d",

        --[[
        soclasses_SmartObjectHelpers = "",
        soclasses_SmartObjectClass = "",
        UseMessage = "",
        sWH_AI_EntityCategory = "",
        esFaction = "",
        bMissionCritical = 0,
        bCanTriggerAreas = 0,
        DmgFactorWhenCollidingAI = 1,
        ]]
    },
    States = {  },
}

function GeneratorEntity:OnSpawn()
    self.bRigidBodyActive = 1;
    self:SetFromProperties();
end

function GeneratorEntity:OnReset()
    System.LogAlways("GeneratorEntity OnReset")

    self:Activate(1);
    -- self:SetCurrentSlot(0);
    -- self:PhysicalizeThis(0);

end;

function GeneratorEntity.Server:OnInit()
    System.LogAlways("GeneratorEntity Server OnInit")

    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end ;

end;

function GeneratorEntity.Client:OnInit()
    System.LogAlways("GeneratorEntity client OnInit")

    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end ;

    System.LogAlways("GeneratorEntity client loaded ...")

end

countdownTime = 3 -- two and a half seconds

function GeneratorEntity.Server:OnUpdate(delta)
    -- System.LogAlways("GeneratorEntity.Server onUpdate" .. tostring(delta))

    countdownTime = countdownTime - delta
    if countdownTime <= 0 then
        countdownTime = countdownTime + 3

        self.Properties.generated_value = self.Properties.generated_value + 1

        System.LogAlways("Something should happen now: " .. "\n" .. "Generated water by " .. self:GetName() .. " - " .. tostring(self.Properties.generated_value))

    end

end

function GeneratorEntity.Client:OnUpdate(delta)
    -- System.LogAlways("GeneratorEntity.Client onUpdate" .. tostring(delta))
end

function GeneratorEntity:SetupModel()

    local Properties = self.Properties;

    System.LogAlways("SetupModel")
    System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)
    -- System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)

    self:LoadObject(0, Properties.object_Model);

    self:PhysicalizeThis();

    -- disable near fade-out by default
    self:SetViewDistUnlimited()
end

function GeneratorEntity:OnLoad(table)
    self.health = table.health;
    self.dead = table.dead;
    self.object_Model = table.object_Model;

    local Properties = self.Properties;
    Properties.object_Model = table.object_Model;

    System.LogAlways("Loading")
    System.LogAlways("Persisted_Entity.object_model: " .. table.object_Model)

    -- load the persisted model path from the save file
    self:LoadObject(0, table.object_Model)

    -- initialize the physical parameter of this entity (like size, shape, etc)
    self:PhysicalizeThis()

    -- disable near fade-out by default
    self:SetViewDistUnlimited()

end

function GeneratorEntity:OnSave(table)
    table.health = self.health;
    table.dead = self.dead;
    table.object_Model = self.Properties.object_Model;

    System.LogAlways("Saving")
    System.LogAlways("Persisting Entity.object_model: " .. table.object_Model)

end
function GeneratorEntity:IsRigidBody()
    local Properties = self.Properties;
    local Mass = Properties.Mass;
    local Density = Properties.Density;
    if (Mass == 0 or Density == 0 or Properties.bPhysicalize ~= 1) then
        return false;
    end
    return true;
end

function GeneratorEntity:PhysicalizeThis()
    local Physics = self.Properties.Physics;

    EntityCommon.PhysicalizeRigid(self, 0, Physics, self.bRigidBodyActive);
end

function GeneratorEntity:SetFromProperties()
    local Properties = self.Properties;

    if (Properties.object_Model == "") then
        do
            return
        end ;
    end

    self:SetupModel();

    if (Properties.bAutoGenAIHidePts == 1) then
        self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 0);
    else
        self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 2);
    end

    if (self.Properties.bCanTriggerAreas == 1) then
        self:SetFlags(ENTITY_FLAG_TRIGGER_AREAS, 0);
    else
        self:SetFlags(ENTITY_FLAG_TRIGGER_AREAS, 2);
    end
end

function GeneratorEntity:OnPropertyChange()
    if (self.__usable) then
        if (self.__origUsable ~= self.Properties.bUsable or self.__origPickable ~= self.Properties.bPickable) then
            self.__usable = nil;
        end
    end
    self:SetFromProperties();
end

function GeneratorEntity:Event_Remove()
    System.LogAlways("Removing entity ...")

    self:DrawSlot(0, 0);
    self:DestroyPhysics();
    self:ActivateOutput("Remove", true);
end

function GeneratorEntity:Event_Hide()
    System.LogAlways("Hiding entity ...")
    self:Hide(1);
    self:ActivateOutput("Hide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_Hide", _time, CurrentCinematicName, self:GetName());
    end
end

function GeneratorEntity:Event_UnHide()
    System.LogAlways("Unhiding entity ...")
    self:Hide(0);
    self:ActivateOutput("UnHide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_UnHide", _time, CurrentCinematicName, self:GetName());
    end
end

function GeneratorEntity:Event_Ragdollize()
    self:RagDollize(0);
    self:ActivateOutput("Ragdollized", true);
    if (self.Event_RagdollizeDerived) then
        self:Event_RagdollizeDerived();
    end
end

function GeneratorEntity.Client:OnPhysicsBreak(vPos, nPartId, nOtherPartId)
    self:ActivateOutput("Break", nPartId + 1);
end

function GeneratorEntity:IsUsable(user)
    local ret = nil
    if not self.__usable then
        self.__usable = self.Properties.bUsable
    end

    local mp = System.IsMultiplayer();
    if (mp and mp ~= 0) then
        return 0;
    end

    if (self.__usable == 1) then
        ret = 2
    else
        local PhysProps = self.Properties.Physics;
        if (self:IsRigidBody() == true and user and user.CanGrabObject) then
            ret = user:CanGrabObject(self)
        end
    end

    return ret or 0
end

function GeneratorEntity:IsUsableByPlayer(user)

    local myDirection = g_Vectors.temp_v1;
    local vecToPlayer = g_Vectors.temp_v2;
    local myPos = g_Vectors.temp_v3;

    myDirection = self:GetDirectionVector(0);

    user:GetWorldPos(vecToPlayer);
    self:GetWorldPos(myPos);

    FastDifferenceVectors(vecToPlayer, myPos, vecToPlayer);
    local len = LengthVector(vecToPlayer);

    if (len <= self.Properties.fUsabilityDistance) then
        return true;
    end
    return false;
end

function GeneratorEntity:GetActions(user, firstFast)
    output = {}
    -- AddInteractorAction(output, firstFast, Action():hint("Bake bread"):action("use"):func(self.OnUsed):interaction(inr_chair):enabled(1))
    AddInteractorAction(output, firstFast, Action():hint("Bake bread"):action("use"):func(ent.OnUsed):interaction(inr_chair):enabled(1))
    return output
end

function GeneratorEntity:OnUsed(user)
    Game.SendInfoText("Used by player", true, nil, 3)
end

function GeneratorEntity:OnUsedHold(user)

end

GeneratorEntity.FlowEvents = {
    Inputs = {
        Used = { GeneratorEntity.Event_Used, "bool" },
        EnableUsable = { GeneratorEntity.Event_EnableUsable, "bool" },
        DisableUsable = { GeneratorEntity.Event_DisableUsable, "bool" },

        Hide = { GeneratorEntity.Event_Hide, "bool" },
        UnHide = { GeneratorEntity.Event_UnHide, "bool" },
        Remove = { GeneratorEntity.Event_Remove, "bool" },
        Ragdollize = { GeneratorEntity.Event_Ragdollize, "bool" },
    },
    Outputs = {
        Used = "bool",
        EnableUsable = "bool",
        DisableUsable = "bool",
        Activate = "bool",
        Hide = "bool",
        UnHide = "bool",
        Remove = "bool",
        Ragdollized = "bool",
        Break = "int",
    },
}

MakeUsable(GeneratorEntity);
AddHeavyObjectProperty(GeneratorEntity);
AddInteractLargeObjectProperty(GeneratorEntity);
SetupCollisionFiltering(GeneratorEntity);
