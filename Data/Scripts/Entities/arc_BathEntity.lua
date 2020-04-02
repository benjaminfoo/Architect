---
--- Author:  Benjamin Foo
---

BathEntity = {
    Client = {},
    Server = {},
    Properties = {

        class = "BasicEntity",

        bTurnedOn = 1,
        bExcludeCover = 0,
        fUsabilityDistance = 100,

        Script = {
            Misc = ""
        },

        Physics = {
            bPhysicalize = 1,
            bRigidBody = 0,
            bPushableByPlayers = 0,
            sName = "BathEntity",

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

        useCategory = nil,


        -- serialize entity for persistence
        bSaved_by_game = 1,
        Saved_by_game = 1,
        bSerialize = 1,


        --
        bInteractiveCollisionClass = 1,

        object_Model = "objects/buildings/refugee_camp/bad_straw.cgf",

        sName = "BathEntity",
    },
    States = {  },

}

function BathEntity:OnReset()
    System.LogAlways("BathEntity OnReset")

    self:Activate(1);

end;

function BathEntity.Server:OnInit()
    System.LogAlways("BathEntity Server OnInit")

    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end ;

end;

function BathEntity.Client:OnInit()
    System.LogAlways("BathEntity client OnInit")

    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end ;

    System.LogAlways("BathEntity client loaded ...")

end

function BathEntity:OnSpawn()
    self.bRigidBodyActive = 1;
    self:SetFromProperties();
end

function BathEntity.Server:OnUpdate(delta)

end

function BathEntity.Client:OnUpdate(delta)

end

function BathEntity:SetupModel()

    local Properties = self.Properties;


    System.LogAlways("SetupModel")
    System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)
    -- System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)

    self:LoadObject(0, Properties.object_Model);

    self:PhysicalizeThis();

    -- disable near fade-out by default
    self:SetViewDistUnlimited()

end

function BathEntity:OnLoad(table)
    self.object_Model = table.object_Model;

    -- reload persisted values
    local Properties = self.Properties;
    Properties.object_Model = table.object_Model;
    Properties.generator = table.generator
    Properties.generatorItem = table.generatorItem
    Properties.generatorItemId = table.generatorItemId
    Properties.generatorItemAmount = table.generatorItemAmount
    Properties.generatorCooldown = table.generatorCooldown
    Properties.generatorGeneratedAmount = table.generatorGeneratedAmount
    Properties.generatorItemCosts = table.generatorItemCosts
    Properties.deletion_lock = table.deletion_lock
    Properties.useCategory = table.useCategory

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

function BathEntity:OnSave(table)
    table.object_Model = self.Properties.object_Model;
    table.deletion_lock = self.Properties.deletion_lock

    table.generator = self.Properties.generator
    table.generatorItem = self.Properties.generatorItem
    table.generatorItemId = self.Properties.generatorItemId
    table.generatorItemAmount = self.Properties.generatorItemAmount
    table.generatorCooldown = self.Properties.generatorCooldown
    table.generatorGeneratedAmount = self.Properties.generatorGeneratedAmount
    table.generatorItemCosts = self.Properties.generatorItemCosts
    table.useCategory = self.Properties.useCategory

    System.LogAlways("Saving")
    System.LogAlways("Persisting Entity.object_model: " .. table.object_Model)
end

function BathEntity:IsRigidBody()
    local Properties = self.Properties;
    local Mass = Properties.Mass;
    local Density = Properties.Density;
    if (Mass == 0 or Density == 0 or Properties.bPhysicalize ~= 1) then
        return false;
    end
    return true;
end

function BathEntity:PhysicalizeThis()
    local Physics = self.Properties.Physics;

    EntityCommon.PhysicalizeRigid(self, 0, Physics, self.bRigidBodyActive);
end

function BathEntity:SetFromProperties()
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

function BathEntity:OnPropertyChange()
    if (self.__usable) then
        if (self.__origUsable ~= self.Properties.bUsable or self.__origPickable ~= self.Properties.bPickable) then
            self.__usable = nil;
        end
    end
    self:SetFromProperties();
end

function BathEntity:Event_Remove()
    System.LogAlways("Removing construction")

    self:DrawSlot(0, 0);
    self:DestroyPhysics();
    self:ActivateOutput("Remove", true);
end

function BathEntity:Event_Hide()
    System.LogAlways("Hiding entity ...")
    self:Hide(1);
    self:ActivateOutput("Hide", true);
end

function BathEntity:Event_UnHide()
    System.LogAlways("Unhiding entity ...")
    self:Hide(0);
    self:ActivateOutput("UnHide", true);
end

function BathEntity:Event_Ragdollize()
    self:RagDollize(0);
    self:ActivateOutput("Ragdollized", true);
    if (self.Event_RagdollizeDerived) then
        self:Event_RagdollizeDerived();
    end
end

function BathEntity.Client:OnPhysicsBreak(vPos, nPartId, nOtherPartId)
    self:ActivateOutput("Break", nPartId + 1);
end

-- determines if the entity is useable overall
function BathEntity:IsUsable(user)
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
function BathEntity:IsUsableByPlayer(user)

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
function BathEntity:GetActions(user, firstFast)

    output = {}

    -- KingdomComeDeliverance/Tools/luadoc/luadoc/!!MEMBERTYPE_Methods_C_ScriptBindActor.html
    -- C_ScriptBindActor__WashDirtAndBlood

    if (self.Properties.useCategory == "addDirt") then
        AddInteractorAction(output, firstFast, Action():hint("Charcoal yourself"):action("use"):func((
                function()
                    dirtVal = 1
                    player.actor:AddDirt(dirtVal)
                    Game.SendInfoText("You are covered in Charcoal now.", true, nil, 3)
                end))                                  :enabled(1))
    end

    if (self.Properties.useCategory == "wash") then
        AddInteractorAction(output, firstFast, Action():hint("Wash yourself"):action("use"):func((
                function()
                    cleanVal = 1
                    player.actor:WashDirtAndBlood(cleanVal)
                    player.actor:WashItems(cleanVal)
                    Game.SendInfoText("You have washed yourself!", true, nil, 3)
                end))                                  :enabled(1))
    end

    return output

end


--
function BathEntity:OnUsed(user)

end

--
function BathEntity:OnUsedHold(user)

    System.LogAlways("BathEntity Used OnHold")
end

--
BathEntity.FlowEvents = {
    Inputs = {
        Used = { BathEntity.Event_Used, "bool" },
        EnableUsable = { BathEntity.Event_EnableUsable, "bool" },
        DisableUsable = { BathEntity.Event_DisableUsable, "bool" },

        Hide = { BathEntity.Event_Hide, "bool" },
        UnHide = { BathEntity.Event_UnHide, "bool" },
        Remove = { BathEntity.Event_Remove, "bool" },
        Ragdollize = { BathEntity.Event_Ragdollize, "bool" },
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

MakeUsable(BathEntity);
AddHeavyObjectProperty(BathEntity);
AddInteractLargeObjectProperty(BathEntity);
SetupCollisionFiltering(BathEntity);
