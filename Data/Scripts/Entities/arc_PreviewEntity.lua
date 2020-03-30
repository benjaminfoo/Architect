---
--- Author:  Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The PreviewEntity is used by the PreviewSystem in order to visualize the currently selected construction to the user.
---
---

PreviewEntity = {
    Client = {},
    Server = {},
    Properties = {

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

            CollisionFiltering = {
                collisionType = { },
                collisionIgnore = { }
            }
        },

        UseMessage = "",
        sWH_AI_EntityCategory = "",
        bInteractiveCollisionClass = 1,

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


PreviewEntity.FlowEvents = {
    Inputs = {
        Remove = { PreviewEntity.Event_Remove, "bool" },
    },
    Outputs = {
        Activate = "bool",
        Remove = "bool",
    },
}
