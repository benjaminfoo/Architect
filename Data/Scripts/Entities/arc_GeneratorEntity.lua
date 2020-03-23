---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The GeneratorEntity is the common parent type for constructions which generate some kind of resource.
---
--- For example: TODO :)
---
---

GeneratorEntity = {
    Client = {},
    Server = {},
    Properties = {

        class = "BasicEntity",

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
            bRigidBody = 0,
            bPushableByPlayers = 0,
            sName = "GeneratorEntity",

            Density = -1,
            Mass = -1,

            CollisionFiltering = {
                collisionType = { },
                collisionIgnore = { }
            }


        },

        -- locking system
        deletion_lock = false,

        -- resource system
        -- generator
        generatorItem = "none",
        generatorItemAmount = 0,
        generatorCooldown = 999,
        generator_generated = 0,

        -- serialize entity for persistence
        bSaved_by_game = 1,
        Saved_by_game = 1,
        bSerialize = 1,


        --
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

        objectModel = "Objects/Natural/Bushes/cliff_bush_a1.cgf",
        bPhysicalize = 1,
        sName = "GeneratorEntity",
        fDensity = -1,
        fMass = -1

    },
    States = {  },


    nShootCount = 0,
    nContactCount = 0,
    nLog = 1,
    fDamage = 0,
    fCollisionDamage = 0,
    nDamageQueueSize = 100,
}


function GeneratorEntity:OnReset()
    System.LogAlways("GeneratorEntity OnReset")

    self:Activate(1);

    -- self:CreateStaticEntity( self.Properties.fMass,-1 );
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

function GeneratorEntity.Client:OnDamage(Hit)
    System.LogAlways "On Damage Client hit"
end

function GeneratorEntity.Server:OnDamage(Hit)
    System.LogAlways "On Damage Server hit"
end

function GeneratorEntity:OnDamage(Hit)
    System.LogAlways "On Damage hit"
end

function GeneratorEntity:Event_StartAnimation(sender)
    self:StartAnimation(0, self.Properties.Animation);
end

function GeneratorEntity:Event_StopAnimtion(sender)
    self:ResetAnimation(0, -1);
end

function GeneratorEntity:OnContact(Hit)
    self.nContactCount = self.nContactCount + 1;
    local dmg = Hit.CollisionDmg;
    if dmg then
        self.fCollisionDamage = self.fCollisionDamage + dmg;
    end
    local dam = format("%.2f", self.fCollisionDamage);
    if Hud then
        Hud:AddMessage("Collided with " .. self.Properties.sName .. " " .. self.nContactCount .. " times, total damage " .. dam);
    end

    if (self.nLog == 1) then
        System.Log("Dumping the hit structure:");
        for name, value in pairs(Hit) do
            System.Log(" " .. name);
        end
        self.nLog = 0
    end
end

function GeneratorEntity:OnSpawn()
    self.bRigidBodyActive = 1;
    self:SetFromProperties();
end

-- todo - refactor like there is no tomorrow, but tomorrow
function GeneratorEntity.Server:OnUpdate(delta)
    -- System.LogAlways("GeneratorEntity.Server onUpdate" .. tostring(delta))

    --[[
    countdownTime = countdownTime - delta
    if countdownTime <= 0 then
        countdownTime = countdownTime + self.Properties.generatorCooldown

        self.Properties.generator_generated = self.Properties.generator_generated + 1

        -- System.LogAlways("Something should happen now: " .. "\n" .. "Generated water by " .. self:GetName() .. " - " .. tostring(self.Properties.generator_generated))

        -- TODO - remove this comment
        -- Time for an update! Finished the implementation of custom generators.
        -- This could be used for water collectors, or scenarios for wood income, money income, decrease, ...
    end
    ]]

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

-- determines if the entity is useable overall
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

-- Determines if the entity is useable by the player
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

-- This callback aggregates the available actions of the entity
function GeneratorEntity:GetActions(user, firstFast)
    output = {}

    -- we'll provide a regular functionwhich gets executed when "using" the entity
    AddInteractorAction(output, firstFast, Action():hint("Gather " .. self.Properties.generatorItem):action("use"):func(
            (function()

                -- do something actively when used (like generate some item, ...)
                if self.Properties.generatorOnUse then
                    self.Properties.generator_generated = self.Properties.generator_generated + 1
                end

                Game.SendInfoText("Amount of " .. self.Properties.generatorItem .. ": " .. tostring(self.Properties.generator_generated), true, nil, 3)

            end))
                                                   :interaction(inr_chair):enabled(1))

    return output
end

-- This code is used to obtain resources after the player used the entity to gather resources
-- Script.SetTimerForFunction(1000, "GatherStone", {}, false)
function GatherStone(self)
    System.LogAlways("Ive done something after one second")
end

--
function GeneratorEntity:OnUsed(user)

end

--
function GeneratorEntity:OnUsedHold(user)

end

--
GeneratorEntity.FlowEvents = {
    Inputs = {
        Used = { GeneratorEntity.Event_Used, "bool" },
        EnableUsable = { GeneratorEntity.Event_EnableUsable, "bool" },
        DisableUsable = { GeneratorEntity.Event_DisableUsable, "bool" },

        Hide = { GeneratorEntity.Event_Hide, "bool" },
        UnHide = { GeneratorEntity.Event_UnHide, "bool" },
        Remove = { GeneratorEntity.Event_Remove, "bool" },
        Ragdollize = { GeneratorEntity.Event_Ragdollize, "bool" },

        StartAnimation = { GeneratorEntity.Event_StartAnimation, "bool" },
        StopAnimation = { GeneratorEntity.Event_StopAnimation, "bool" },
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

        StartAnimation = "bool",
        StopAnimation = "bool",
    },
}

MakeUsable(GeneratorEntity);
AddHeavyObjectProperty(GeneratorEntity);
AddInteractLargeObjectProperty(GeneratorEntity);
SetupCollisionFiltering(GeneratorEntity);
