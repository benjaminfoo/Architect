---
--- Author:  Benjamin Foo
---
--- The DynamicBuildingEntity is the common parent type for constructions which offer some kind of functionality.
---
DynamicBuildingEntity = {
    Client = {},
    Server = {},
    Properties = {

        bTurnedOn = 1,
        bExcludeCover = 0,

        bSaved_by_game = 1,
        Saved_by_game = 1,
        bSerialize = 1,
        deletion_lock = false,

        fUsabilityDistance = 100,

        class = "Bed",
        sSittingTagGlobal = "sittingNoTable",

        Script = {
            esBedTypes = "ground",
            Misc = ""
        },

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

        UseMessage = "",
        sWH_AI_EntityCategory = "Bed",
        bInteractiveCollisionClass = 1,
        object_Model = "objects/buildings/refugee_camp/bad_straw.cgf",
        guidSmartObjectType = "39012413-1895-4828-b202-b3835a78984d",
        MultiplayerOptions = {},

        -- soclasses_SmartObjectClass = "",
        -- sWH_AI_EntityCategory = "",
        -- bMissionCritical = 0,
        -- bCanTriggerAreas = 0,
        -- esFaction = "",
        -- DmgFactorWhenCollidingAI = 1,
    },

    Script = {
    }
}


--
function DynamicBuildingEntity:OnSpawn()
    if (self.Properties.MultiplayerOptions.bNetworked == 0) then
        self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
    end

    self.bRigidBodyActive = 1;

    self:SetFromProperties();
end


--
function DynamicBuildingEntity:SetFromProperties()
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

    -- setup entity flags
    self:SetFlags(ENTITY_FLAG_RAIN_OCCLUDER, 1)
    self:SetFlags(ENTITY_FLAG_CASTSHADOW, 1)

end


--
function DynamicBuildingEntity:SetupModel()

    local Properties = self.Properties;

    System.LogAlways("SetupModel")
    System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)
    -- System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)

    self:LoadObject(0, Properties.object_Model);

    self:PhysicalizeThis();

    -- disable near fade-out by default
    self:SetViewDistUnlimited()
end


-- reloading stored values from savegame
function DynamicBuildingEntity:OnLoad(table)
    self.object_Model = table.object_Model;

    local Properties = self.Properties;
    Properties.object_Model = table.object_Model;

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


-- persisting values to save game
function DynamicBuildingEntity:OnSave(table)
    table.object_Model = self.Properties.object_Model;
end


--
function DynamicBuildingEntity:IsRigidBody()
    local Properties = self.Properties;
    local Mass = Properties.Mass;
    local Density = Properties.Density;
    if (Mass == 0 or Density == 0 or Properties.bPhysicalize ~= 1) then
        return false;
    end
    return true;
end


--
function DynamicBuildingEntity:PhysicalizeThis()
    local Physics = self.Properties.Physics;
    EntityCommon.PhysicalizeRigid(self, 0, Physics, self.bRigidBodyActive);
end


--
function DynamicBuildingEntity:OnPropertyChange()
    if (self.__usable) then
        if (self.__origUsable ~= self.Properties.bUsable or self.__origPickable ~= self.Properties.bPickable) then
            self.__usable = nil;
        end
    end
    self:SetFromProperties();
end


--
function DynamicBuildingEntity:OnReset()
    System.LogAlways("OnReset entity ...")

    self:ResetOnUsed();
    self:DrawSlot(0, 1);

    local PhysProps = self.Properties.Physics;
    if (PhysProps.bPhysicalize == 1) then
        self:PhysicalizeThis();
        self:AwakePhysics(0);
    end
end


--
function DynamicBuildingEntity:Event_Remove()
    System.LogAlways("Removing construction")

    self:DrawSlot(0, 0);
    self:DestroyPhysics();
    self:ActivateOutput("Remove", true);
end


--
function DynamicBuildingEntity:Event_Hide()
    System.LogAlways("Hiding entity ...")
    self:Hide(1);
    self:ActivateOutput("Hide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_Hide", _time, CurrentCinematicName, self:GetName());
    end
end


--
function DynamicBuildingEntity:Event_UnHide()
    System.LogAlways("Unhiding entity ...")
    self:Hide(0);
    self:ActivateOutput("UnHide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_UnHide", _time, CurrentCinematicName, self:GetName());
    end
end


--
function DynamicBuildingEntity:Event_Ragdollize()
    self:RagDollize(0);
    self:ActivateOutput("Ragdollized", true);
    if (self.Event_RagdollizeDerived) then
        self:Event_RagdollizeDerived();
    end
end


--
function DynamicBuildingEntity.Client:OnPhysicsBreak(vPos, nPartId, nOtherPartId)
    self:ActivateOutput("Break", nPartId + 1);
end


--
function DynamicBuildingEntity:IsUsable(user)
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


--
function DynamicBuildingEntity:IsUsableByPlayer(user)

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


--
function DynamicBuildingEntity:GetActions(user, firstFast)
    output = {}
    return output
end


--
function DynamicBuildingEntity:OnUsed(user)
end


--
function DynamicBuildingEntity:OnUsedHold(user)
end

DynamicBuildingEntity.FlowEvents = {
    Inputs = {
        Used = { DynamicBuildingEntity.Event_Used, "bool" },
        EnableUsable = { DynamicBuildingEntity.Event_EnableUsable, "bool" },
        DisableUsable = { DynamicBuildingEntity.Event_DisableUsable, "bool" },

        Hide = { DynamicBuildingEntity.Event_Hide, "bool" },
        UnHide = { DynamicBuildingEntity.Event_UnHide, "bool" },
        Remove = { DynamicBuildingEntity.Event_Remove, "bool" },
        Ragdollize = { DynamicBuildingEntity.Event_Ragdollize, "bool" },
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

MakeUsable(DynamicBuildingEntity);
MakePickable(DynamicBuildingEntity);
AddHeavyObjectProperty(DynamicBuildingEntity);
AddInteractLargeObjectProperty(DynamicBuildingEntity);
SetupCollisionFiltering(DynamicBuildingEntity);
