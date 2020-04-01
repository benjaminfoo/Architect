---
--- Author:  Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The CookingSpotEntity is the common parent type for constructions which offer some kind of cooking functionality.
---
---

CookingSpotEntity = {
    Client = {},
    Server = {},
    Properties = {

        class = "BasicEntity",

        bTurnedOn = 1,
        bExcludeCover = 0,

        bSaved_by_game = 1,
        Saved_by_game = 1,
        bSerialize = 1,

        deletion_lock = false,

        fUsabilityDistance = 100,

        Script = {
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

        soclasses_SmartObjectHelpers = "",
        soclasses_SmartObjectClass = "",

        UseMessage = "",
        sWH_AI_EntityCategory = "",
        bInteractiveCollisionClass = 1,
        object_Model = "",
        guidSmartObjectType = "",
        esFaction = "",
        MultiplayerOptions = {},
    },

    Script = {
    }
}

local Physics_DX9MP_Simple = {
    bPhysicalize = 1,
    bPushableByPlayers = 0,

    Density = 0,
    Mass = 0,

}
function CookingSpotEntity:OnSpawn()
    if (self.Properties.MultiplayerOptions.bNetworked == 0) then
        self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
    end

    self.bRigidBodyActive = 1;

    self:SetFromProperties();
end
function CookingSpotEntity:SetFromProperties()
    local Properties = self.Properties;

    if (Properties.object_Model == "") then
        do
            return
        end ;
    end

    self.freezable = (tonumber(Properties.bFreezable) ~= 0);

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
function CookingSpotEntity:SetupModel()

    local Properties = self.Properties;

    System.LogAlways("SetupModel")
    System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)
    -- System.LogAlways("self.Properties.object_model: " .. Properties.object_Model)

    self:LoadObject(0, Properties.object_Model);

    self:PhysicalizeThis();

    -- disable near fade-out by default
    self:SetViewDistUnlimited()
end

function CookingSpotEntity:OnLoad(table)
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


--
function CookingSpotEntity:OnSave(table)
    table.object_Model = self.Properties.object_Model;
end


--
function CookingSpotEntity:IsRigidBody()
    local Properties = self.Properties;
    local Mass = Properties.Mass;
    local Density = Properties.Density;
    if (Mass == 0 or Density == 0 or Properties.bPhysicalize ~= 1) then
        return false;
    end
    return true;
end


--
function CookingSpotEntity:PhysicalizeThis()
    local Physics = self.Properties.Physics;
    if (CryAction.IsImmersivenessEnabled() == 0) then
        Physics = Physics_DX9MP_Simple;
    end
    EntityCommon.PhysicalizeRigid(self, 0, Physics, self.bRigidBodyActive);
end


--
function CookingSpotEntity:OnPropertyChange()
    if (self.__usable) then
        if (self.__origUsable ~= self.Properties.bUsable or self.__origPickable ~= self.Properties.bPickable) then
            self.__usable = nil;
        end
    end
    self:SetFromProperties();
end


--
function CookingSpotEntity:OnReset()
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
function CookingSpotEntity:Event_Remove()
    System.LogAlways("Removing construction")

    self:DrawSlot(0, 0);
    self:DestroyPhysics();
    self:ActivateOutput("Remove", true);
end


--
function CookingSpotEntity:Event_Hide()
    System.LogAlways("Hiding entity ...")
    self:Hide(1);
    self:ActivateOutput("Hide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_Hide", _time, CurrentCinematicName, self:GetName());
    end
end


--
function CookingSpotEntity:Event_UnHide()
    System.LogAlways("Unhiding entity ...")
    self:Hide(0);
    self:ActivateOutput("UnHide", true);
    if CurrentCinematicName then
        Log("%.3f %s %s : Event_UnHide", _time, CurrentCinematicName, self:GetName());
    end
end


--
function CookingSpotEntity:Event_Ragdollize()
    self:RagDollize(0);
    self:ActivateOutput("Ragdollized", true);
    if (self.Event_RagdollizeDerived) then
        self:Event_RagdollizeDerived();
    end
end


--
function CookingSpotEntity.Client:OnPhysicsBreak(vPos, nPartId, nOtherPartId)
    self:ActivateOutput("Break", nPartId + 1);
end


--
function CookingSpotEntity:IsUsable(user)
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
function CookingSpotEntity:IsUsableByPlayer(user)

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
function CookingSpotEntity:GetActions(user, firstFast)
    output = {}

    -- we'll provide a regular functionwhich gets executed when "using" the entity
    AddInteractorAction(output, firstFast, Action():hint("Bake bread"):action("use"):func((function()
        -- This is only a prototype
        -- TODO: define needed resources for newly crafted items
        -- TODO: define dynamic amounts for recipes and results

        -- 5e9b4fa1-aafa-4352-b5d6-58df2c263caa : Nettle
        local recipeName = "Bread"
        local costUUIDs = "5e9b4fa1-aafa-4352-b5d6-58df2c263caa"
        local costAmount = 1
        local costResource = "Nettle"


        -- bread:  86e4ff24-88db-4024-abe6-46545fa0fbd1
        local craftedResourceUUID = "86e4ff24-88db-4024-abe6-46545fa0fbd1"
        local craftedAmount = 1
        local playerTable = "player_item"

        -- 1. Check if costs are covered for creating the construction
        if (availableResources - costAmount >= 0) then

            -- 2. Remove costs from inventory
            removeItem(costUUIDs, costAmount)

            -- this is for debugging purposes - this should work two times
            availableResources = availableResources - costAmount

            resultSuccess = Database.LoadTable(playerTable)

            -- 3. Create new item instance, add to inventory
            newItemInstance = ItemManager.CreateItem(craftedResourceUUID, 100, craftedAmount)
            player.inventory:AddItem(newItemInstance);

            Game.SendInfoText("Created " .. craftedAmount .. "x " .. recipeName .. " for " .. costAmount .. "x " .. costResource
                    .. "\n" .. "" .. costResource .. " left: " .. tostring(availableResources), true, nil, 3)
        else
            -- If there arent enough resources available than needed, abort this
            Game.SendInfoText("Not enough resources for " .. craftedAmount .. "x " .. recipeName, true, nil, 3)
        end

        -- XGenAIModule.SendMessageToEntity(player.this.id, "player:request", "target(" .. Framework.WUIDToMsg(XGenAIModule.GetMyWUID(ent)) .. "), mode ('use')")

    end)):interaction(inr_chair):enabled(1))

    return output
end


--
function CookingSpotEntity:OnUsed(user)


    --
end


--
function CookingSpotEntity:OnUsedHold(user)
    -- System.LogAlways("Hello World! this entity has been used!")
    -- XGenAIModule.SendMessageToEntity(player.this.id, "player:request", "target(" .. Framework.WUIDToMsg(XGenAIModule.GetMyWUID(self)) .. "), mode ('use'), behavior('player_use_sleep')")
end

CookingSpotEntity.FlowEvents = {
    Inputs = {
        Used = { CookingSpotEntity.Event_Used, "bool" },
        EnableUsable = { CookingSpotEntity.Event_EnableUsable, "bool" },
        DisableUsable = { CookingSpotEntity.Event_DisableUsable, "bool" },

        Hide = { CookingSpotEntity.Event_Hide, "bool" },
        UnHide = { CookingSpotEntity.Event_UnHide, "bool" },
        Remove = { CookingSpotEntity.Event_Remove, "bool" },
        Ragdollize = { CookingSpotEntity.Event_Ragdollize, "bool" },
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

MakeUsable(CookingSpotEntity);
MakePickable(CookingSpotEntity);
AddHeavyObjectProperty(CookingSpotEntity);
AddInteractLargeObjectProperty(CookingSpotEntity);
SetupCollisionFiltering(CookingSpotEntity);
