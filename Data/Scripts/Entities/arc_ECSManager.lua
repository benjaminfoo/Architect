---
--- Author:  Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The ECSManager handles the lifecycle of the UIController, in order to render the ui
---
ECSManager = {
    Client = {},
    Server = {},
    Properties = {
        bSaved_by_game = 0,
        Saved_by_game = 0,
        bSerialize = 0
    },
    States = {  },
}

function ECSManager:OnPropertyChange()
    self:OnReset();
    System.LogAlways("ECSManager opc")
end;

function ECSManager:OnSave(tbl)
    System.LogAlways("ECSManager OnSave")

end;

function ECSManager:OnLoad(tbl)
    System.LogAlways("ECSManager OnLoad")
end;

function ECSManager:OnReset()
    System.LogAlways("ECSManager OnReset")

    self:Activate(1);
    -- self:SetCurrentSlot(0);
    -- self:PhysicalizeThis(0);

end;

function ECSManager.Server:OnInit()
    System.LogAlways("ECSManager OnInit")

    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end ;

    Script.UnloadScript("Scripts/Controller/arc_ECSController.lua")
    Script.ReloadScript("Scripts/Controller/arc_ECSController.lua")

end;

function ECSManager.Client:OnInit()
    System.LogAlways("ECSManager OnInit")

    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end ;

    if (ECSController_Init ~= nil) then
        ECSController_Init();
    else
        System.LogAlways("ECSController_Init not loaded ...")

        Script.UnloadScript("Scripts/Controller/arc_ECSController.lua")
        Script.ReloadScript("Scripts/Controller/arc_ECSController.lua")

    end


end;

function ECSManager:OnAction(action, activation, value)

    --[[
    -- not used yet
    System.LogAlways("action: " .. action)
    System.LogAlways("activation: " .. activation)
    System.LogAlways("value: " .. value)

    if (g_gameRules and g_gameRules.Client.OnActorAction) then
        if (not g_gameRules.Client.OnActorAction(g_gameRules, self, action, activation, value)) then
            return;
        end
    end

    if ( ( action == "custom_quest_call_horse_action" ) and ( activation == "press" ) ) then
        local content = { action= action };
        XGenAIModule.SendMessageToEntityData(player.this.id,'player:actionMapReaction', content )
    end
    ]]


end

function ECSManager.Client:OnUpdate()
    -- System.LogAlways("ECSManager.Client onUpdate")

    if (ECSController_OnUpdate ~= nil) then
        ECSController_OnUpdate();
    else
        -- System.LogAlways("ECSController_Init not loaded ...")
        -- Script.UnloadScript("Scripts/Controller/ECSController_Init.lua")
        -- Script.ReloadScript("Scripts/Controller/ECSController_Init.lua")
    end

end;

function ECSManager.Server:OnUpdate()
    -- System.LogAlways("ECSManager.Server onUpdate")
end;

ECSManager.Server.TurnedOn = {
    OnBeginState = function(self)
        BroadcastEvent(self, "TurnOn")
    end,
    OnUpdate = function(self, dt)
        --[[ do something every frame, like rendering, ai, ..]]
    end,
    OnEndState = function(self)

    end,
}

ECSManager.Server.TurnedOff = {
    OnBeginState = function(self)
        BroadcastEvent(self, "TurnOff")
    end,
    OnEndState = function(self)

    end,
}

ECSManager.FlowEvents = {
    Inputs = {
        TurnOn = { ECSManager.Event_TurnOn, "bool" },
        TurnOff = { ECSManager.Event_TurnOff, "bool" },
    },
    Outputs = {
        TurnOn = "bool",
        TurnOff = "bool",
    },
}
