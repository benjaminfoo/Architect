---
--- Author:  Benjamin Foo
---

TownBookEntity = {
    Client = {},
    Server = {},
    Properties = {

        class = "BasicEntity",

        bTurnedOn = 1,
        bExcludeCover = 0,
        fUsabilityDistance = 100,
        object_Model = "objects/props/alchemy/book/alchemy_book.cgf",

        Script = {
            Misc = ""
        },

        Physics = {
            bPhysicalize = 1,
            bRigidBody = 0,
            bPushableByPlayers = 0,
            sName = "TownBookEntity",

            Density = -1,
            Mass = -1,

            CollisionFiltering = {
                collisionType = { },
                collisionIgnore = { }
            }


        },

        -- TODO
        -- TODO - THESE VALUES NEED TO GET SAVED AND RELOADED :)
        -- TODO

        -- locking system
        deletion_lock = false,

        -- resource system
        -- generator

        -- is this construction a generator?
        generator = false,

        -- is this construction producing something when used?
        generatorOnUse = false,

        -- the name of the generated resource
        generatorItem = "none",

        -- the amount of generated resources
        generatorItemAmount = -1,

        -- the costs for producing this item
        generatorItemCosts = {},

        -- the amount of time the user has to wait for producing a new resource
        generatorCooldown = 999,

        -- the current cooldown amount, please dont change this
        countdownTime = -2,

        -- how much has this construction already created?
        generatorGeneratedAmount = 0,


        -- serialize entity for persistence
        bSaved_by_game = 1,
        Saved_by_game = 1,
        bSerialize = 1,

        bInteractiveCollisionClass = 1,

    },
    States = {  },

}

function TownBookEntity:OnReset()
    System.LogAlways("TownBookEntity OnReset")

    self:Activate(1);

end;

function TownBookEntity.Server:OnInit()
    System.LogAlways("TownBookEntity Server OnInit")

    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end ;

end;

function TownBookEntity.Client:OnInit()
    System.LogAlways("TownBookEntity client OnInit")

    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end ;

    System.LogAlways("TownBookEntity client loaded ...")

end

function TownBookEntity:OnSpawn()
    self.bRigidBodyActive = 1;
    self:SetFromProperties();
end

-- todo - refactor like there is no tomorrow, but tomorrow
function TownBookEntity.Server:OnUpdate(delta)

end

function TownBookEntity.Client:OnUpdate(delta)

end

function TownBookEntity:SetupModel()

    local Properties = self.Properties;

    System.LogAlways("SetupModel")
    System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)
    -- System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)

    self:LoadObject(0, Properties.object_Model);

    self:PhysicalizeThis();

    -- disable near fade-out by default
    self:SetViewDistUnlimited()

end

function TownBookEntity:OnLoad(table)
    self.object_Model = table.object_Model;

    -- reload persisted values
    local Properties = self.Properties;
    Properties.object_Model = table.object_Model;
    Properties.deletion_lock = table.deletion_lock


    -- the initial timer of this generator
    System.LogAlways("Loading")
    System.LogAlways("Persisted_Entity.object_model: " .. table.object_Model)

    -- load the persisted model path from the save file
    self:LoadObject(0, table.object_Model)

    -- initialize the physical parameter of this entity (like size, shape, etc)
    self:PhysicalizeThis()

    -- disable near fade-out by default
    self:SetViewDistUnlimited()

end

function TownBookEntity:OnSave(table)
    table.object_Model = self.Properties.object_Model;
    table.deletion_lock = self.Properties.deletion_lock

    System.LogAlways("Saving")
    System.LogAlways("Persisting Entity.object_model: " .. table.object_Model)
end

function TownBookEntity:IsRigidBody()
    local Properties = self.Properties;
    local Mass = Properties.Mass;
    local Density = Properties.Density;
    if (Mass == 0 or Density == 0 or Properties.bPhysicalize ~= 1) then
        return false;
    end
    return true;
end

function TownBookEntity:PhysicalizeThis()
    local Physics = self.Properties.Physics;

    EntityCommon.PhysicalizeRigid(self, 0, Physics, self.bRigidBodyActive);
end

function TownBookEntity:SetFromProperties()
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

function TownBookEntity:OnPropertyChange()
    if (self.__usable) then
        if (self.__origUsable ~= self.Properties.bUsable or self.__origPickable ~= self.Properties.bPickable) then
            self.__usable = nil;
        end
    end
    self:SetFromProperties();
end

function TownBookEntity:Event_Remove()
    System.LogAlways("Removing construction")

    self:DrawSlot(0, 0);
    self:DestroyPhysics();
    self:ActivateOutput("Remove", true);
end

function TownBookEntity:Event_Hide()
    System.LogAlways("Hiding entity ...")
    self:Hide(1);
    self:ActivateOutput("Hide", true);
end

function TownBookEntity:Event_UnHide()
    System.LogAlways("Unhiding entity ...")
    self:Hide(0);
    self:ActivateOutput("UnHide", true);
end

function TownBookEntity:Event_Ragdollize()
    self:RagDollize(0);
    self:ActivateOutput("Ragdollized", true);
    if (self.Event_RagdollizeDerived) then
        self:Event_RagdollizeDerived();
    end
end

function TownBookEntity.Client:OnPhysicsBreak(vPos, nPartId, nOtherPartId)
    self:ActivateOutput("Break", nPartId + 1);
end

-- determines if the entity is useable overall
function TownBookEntity:IsUsable(user)
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

-- Determines if the entity is useable by the player
function TownBookEntity:IsUsableByPlayer(user)

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

-- This callback aggregates the available actions of the entity
function TownBookEntity:GetActions(user, firstFast)
    output = {}

    -- we'll provide a regular functionwhich gets executed when "using" the entity

    AddInteractorAction(output, firstFast, Action():hint("Show statistics"):action("use"):func((
            function()
                Game.SendInfoText(
                        "Use #showstats() in the ingame console for town stats \nThis will get updated in future versions.",
                        true, nil, 5)
            end
    ))                                             :interaction(inr_chair):enabled(1))

    return output
end


--
function TownBookEntity:OnUsed(user)

end


--
function TownBookEntity:OnUsedHold(user)

    System.LogAlways("TownBookEntity Used OnHold")
end

TownBookEntity.FlowEvents = {
    Inputs = {
        Used = { TownBookEntity.Event_Used, "bool" },
        EnableUsable = { TownBookEntity.Event_EnableUsable, "bool" },
        DisableUsable = { TownBookEntity.Event_DisableUsable, "bool" },

        Hide = { TownBookEntity.Event_Hide, "bool" },
        UnHide = { TownBookEntity.Event_UnHide, "bool" },
        Remove = { TownBookEntity.Event_Remove, "bool" },
        Ragdollize = { TownBookEntity.Event_Ragdollize, "bool" },
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

MakeUsable(TownBookEntity);
AddHeavyObjectProperty(TownBookEntity);
AddInteractLargeObjectProperty(TownBookEntity);
SetupCollisionFiltering(TownBookEntity);
