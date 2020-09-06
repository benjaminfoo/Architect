---
--- Author:  Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The BasicBuildingEntity is the common parent type for static constructions for decoration purposes or ld.
---
---

BasicBuildingEntity = {
    Client = {},
    Server = {},
    Properties = {

        class = "BasicEntity",
        object_Model = "objects/default/primitive_sphere.cgf",

        bTurnedOn = 1,

        bSaved_by_game = 1,
        bSerialize = 1,
        deletion_lock = false,

        Physics = {
            bPhysicalize = 1,
            bRigidBody = 0,
            bPushableByPlayers = 0,

            Density = -1,
            Mass = -1,

            CollisionFiltering = {
                collisionType = { },
                collisionIgnore = { }
            }
        },
    },

    Script = {
    }
}

function BasicBuildingEntity:OnSpawn()
    -- System.LogAlways("Spawned basic entity ...")

    --[[
    if (self.Properties.MultiplayerOptions.bNetworked == 0) then
        self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
    end

    self.bRigidBodyActive = 1;
    ]]

    self:SetFromProperties();
end

function BasicBuildingEntity:SetFromProperties()
    local Properties = self.Properties;

    if (Properties.object_Model == "") then
        return
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

    -- setup entity flags
    self:SetFlags(ENTITY_FLAG_RAIN_OCCLUDER, 1)
    self:SetFlags(ENTITY_FLAG_CASTSHADOW, 1)

end

function BasicBuildingEntity:SetupModel()

    local Properties = self.Properties;

    -- System.LogAlways("SetupModel")
    -- System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)
    -- System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)

    self:LoadObject(0, Properties.object_Model);

    self:PhysicalizeThis();

    -- disable near fade-out by default
    self:SetViewDistUnlimited()
end

function BasicBuildingEntity:OnLoad(table)
    self.object_Model = table.object_Model;

    local Properties = self.Properties;
    Properties.object_Model = table.object_Model;

    -- System.LogAlways("Loading")
    -- System.LogAlways("Persisted_Entity.object_model: " .. table.object_Model)

    -- load the persisted model path from the save file
    self:LoadObject(0, table.object_Model)

    -- initialize the physical parameter of this entity (like size, shape, etc)
    self:PhysicalizeThis()

    -- disable near fade-out by default
    self:SetViewDistUnlimited()

    -- setup entity flags
    self:SetFlags(ENTITY_FLAG_RAIN_OCCLUDER, 1)
    self:SetFlags(ENTITY_FLAG_CASTSHADOW, 1)

end

function BasicBuildingEntity:OnSave(table)
    table.object_Model = self.Properties.object_Model;

    -- System.LogAlways("Saving")
    -- System.LogAlways("Persisting Entity.object_model: " .. table.object_Model)

end

function BasicBuildingEntity:IsRigidBody()
    local Properties = self.Properties;
    local Mass = Properties.Mass;
    local Density = Properties.Density;
    if (Mass == 0 or Density == 0 or Properties.bPhysicalize ~= 1) then
        return false;
    end
    return true;
end

function BasicBuildingEntity:PhysicalizeThis()
    local Physics = self.Properties.Physics;
    EntityCommon.PhysicalizeRigid(self, 0, Physics, self.bRigidBodyActive);
end

function BasicBuildingEntity:OnPropertyChange()
    if (self.__usable) then
        if (self.__origUsable ~= self.Properties.bUsable or self.__origPickable ~= self.Properties.bPickable) then
            self.__usable = nil;
        end
    end
    self:SetFromProperties();
end

function BasicBuildingEntity:OnReset()
    System.LogAlways("OnReset entity ...")

    self:ResetOnUsed();
    self:DrawSlot(0, 1);

    local PhysProps = self.Properties.Physics;
    if (PhysProps.bPhysicalize == 1) then
        self:PhysicalizeThis();
        self:AwakePhysics(0);
    end
end

function BasicBuildingEntity:Event_Remove()
    System.LogAlways("Removing construction")

    self:DrawSlot(0, 0);
    self:DestroyPhysics();
    self:ActivateOutput("Remove", true);
end

function BasicBuildingEntity:Event_Hide()
    System.LogAlways("Hiding entity ...")
    self:Hide(1);
    self:ActivateOutput("Hide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_Hide", _time, CurrentCinematicName, self:GetName());
    end
end

function BasicBuildingEntity:Event_UnHide()
    System.LogAlways("Unhiding entity ...")
    self:Hide(0);
    self:ActivateOutput("UnHide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_UnHide", _time, CurrentCinematicName, self:GetName());
    end
end

function BasicBuildingEntity:Event_Ragdollize()
    self:RagDollize(0);
    self:ActivateOutput("Ragdollized", true);
    if (self.Event_RagdollizeDerived) then
        self:Event_RagdollizeDerived();
    end
end

function BasicBuildingEntity.Client:OnPhysicsBreak(vPos, nPartId, nOtherPartId)
    self:ActivateOutput("Break", nPartId + 1);
end

function BasicBuildingEntity:IsUsable(user)
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

BasicBuildingEntity.FlowEvents = {
    Inputs = {
        Used = { BasicBuildingEntity.Event_Used, "bool" },
        EnableUsable = { BasicBuildingEntity.Event_EnableUsable, "bool" },
        DisableUsable = { BasicBuildingEntity.Event_DisableUsable, "bool" },

        Hide = { BasicBuildingEntity.Event_Hide, "bool" },
        UnHide = { BasicBuildingEntity.Event_UnHide, "bool" },
        Remove = { BasicBuildingEntity.Event_Remove, "bool" },
        Ragdollize = { BasicBuildingEntity.Event_Ragdollize, "bool" },
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

MakeUsable(BasicBuildingEntity);
AddHeavyObjectProperty(BasicBuildingEntity);
AddInteractLargeObjectProperty(BasicBuildingEntity);
SetupCollisionFiltering(BasicBuildingEntity);
