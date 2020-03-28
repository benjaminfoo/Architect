---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The PreviewEntity is the common parent type for constructions which offer some kind of functionality.
---
--- For example, a bed provides the ability to sleep, a chair provides the ability to sit, etc.
---
---

PreviewEntity = {
    Client = {},
    Server = {},
    Properties = {

        MaxSpeed = 1,
        fHealth = 100,
        bTurnedOn = 1,
        bExcludeCover = 0,

        bSaved_by_game = 0,
        Saved_by_game = 0,
        bSerialize = 0,

        deletion_lock = false,

        fUsabilityDistance = 100,

        class = "BasicEntity",

        Script = {
        },

        Physics = {
            bPhysicalize = 0,
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
        sWH_AI_EntityCategory = "",
        bInteractiveCollisionClass = 1,

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

function PreviewEntity:OnSpawn()

    self.bRigidBodyActive = 0;

    self:SetFromProperties();
end

function PreviewEntity:SetFromProperties()
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

function PreviewEntity:SetupModel()

    local Properties = self.Properties;

    System.LogAlways("SetupModel")
    System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)
    -- System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)

    self:LoadObject(0, Properties.object_Model);

    -- self:PhysicalizeThis();

    -- disable near fade-out by default
    self:SetViewDistUnlimited()
end

function PreviewEntity:OnLoad(table)
    self.health = table.health;
    self.dead = table.dead;
    self.object_Model = table.object_Model;

    local Properties = self.Properties;
    Properties.object_Model = table.object_Model;


end

function PreviewEntity:OnSave(table)
    table.health = self.health;
    table.dead = self.dead;
    table.object_Model = self.Properties.object_Model;
end

function PreviewEntity:IsRigidBody()
    local Properties = self.Properties;
    local Mass = Properties.Mass;
    local Density = Properties.Density;
    if (Mass == 0 or Density == 0 or Properties.bPhysicalize ~= 1) then
        return false;
    end
    return true;
end

function PreviewEntity:PhysicalizeThis()
    local Physics = self.Properties.Physics;
    EntityCommon.PhysicalizeRigid(self, 0, Physics, self.bRigidBodyActive);
end

function PreviewEntity:OnPropertyChange()
    if (self.__usable) then
        if (self.__origUsable ~= self.Properties.bUsable or self.__origPickable ~= self.Properties.bPickable) then
            self.__usable = nil;
        end
    end
    self:SetFromProperties();
end

function PreviewEntity:OnReset()
    System.LogAlways("OnReset entity ...")

    self:ResetOnUsed();
    self:DrawSlot(0, 1);

end
function PreviewEntity:Event_Remove()
    System.LogAlways("Removing construction")

    self:DrawSlot(0, 0);
    self:ActivateOutput("Remove", true);
end
function PreviewEntity:Event_Hide()
    System.LogAlways("Hiding entity ...")
    self:Hide(1);
    self:ActivateOutput("Hide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_Hide", _time, CurrentCinematicName, self:GetName());
    end
end
function PreviewEntity:Event_UnHide()
    System.LogAlways("Unhiding entity ...")
    self:Hide(0);
    self:ActivateOutput("UnHide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_UnHide", _time, CurrentCinematicName, self:GetName());
    end
end
function PreviewEntity:Event_Ragdollize()
    self:RagDollize(0);
    self:ActivateOutput("Ragdollized", true);
    if (self.Event_RagdollizeDerived) then
        self:Event_RagdollizeDerived();
    end
end
function PreviewEntity.Client:OnPhysicsBreak(vPos, nPartId, nOtherPartId)
    self:ActivateOutput("Break", nPartId + 1);
end

function PreviewEntity:IsUsable(user)
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

function PreviewEntity:IsUsableByPlayer(user)

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

function PreviewEntity:GetActions(user, firstFast)

end

function PreviewEntity:OnUsed(user)
end

function PreviewEntity:OnUsedHold(user)
end

function PreviewEntity:GetReadingQuality()

    local str = self.Properties.Bed.esReadingQuality;

    if str == "none" then
        return 0;
    elseif str == "bed_ground" then
        return 1;
    elseif str == "bed" then
        return 3;
    elseif str == "bed_exceptional" then
        return 4;
    elseif str == "bench_table" then
        return 5;
    elseif str == "bench_notable" then
        return 6;
    else
        return 0;
    end
end

function PreviewEntity:GetSleepQuality()

    local str = self.Properties.Bed.esSleepQuality;

    if str == "low" then
        return 2;
    elseif str == "medium" then
        return 3;
    elseif str == "high" then
        return 1;
    elseif str == "exceptional" then
        return 0;
    else
        return 2;
    end
end

PreviewEntity.FlowEvents = {
    Inputs = {
        Used = { PreviewEntity.Event_Used, "bool" },
        EnableUsable = { PreviewEntity.Event_EnableUsable, "bool" },
        DisableUsable = { PreviewEntity.Event_DisableUsable, "bool" },

        Hide = { PreviewEntity.Event_Hide, "bool" },
        UnHide = { PreviewEntity.Event_UnHide, "bool" },
        Remove = { PreviewEntity.Event_Remove, "bool" },
        Ragdollize = { PreviewEntity.Event_Ragdollize, "bool" },
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
