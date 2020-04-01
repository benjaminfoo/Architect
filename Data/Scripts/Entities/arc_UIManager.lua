---
--- Author:  Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The UIManager handles the lifecycle of the UIController, in order to render the ui
---
UIManager = {
    Client = {},
    Server = {},
    Properties = {
        bSaved_by_game = 0,
        Saved_by_game = 0,
        bSerialize = 0
    },
    States = {  },
}

function UIManager:OnPropertyChange()
    self:OnReset();
    System.LogAlways("UIManager opc")
end;

function UIManager:OnSave(tbl)
    System.LogAlways("UIManager OnSave")
end;

function UIManager:OnLoad(tbl)
    System.LogAlways("UIManager OnLoad")
end;

function UIManager:OnReset()
    System.LogAlways("UIManager OnReset")

    self:Activate(1);
    -- self:SetCurrentSlot(0);
    -- self:PhysicalizeThis(0);
end;

function UIManager.Server:OnInit()
    System.LogAlways("UIManager OnInit")

    if (not self.bInitialized) then
        self:OnReset()
        self.bInitialized = 1
    end

    Script.UnloadScript("Scripts/Controller/arc_UIController.lua")
    Script.ReloadScript("Scripts/Controller/arc_UIController.lua")

end;

function UIManager.Client:OnInit()
    System.LogAlways("UIManager OnInit")

    if (not self.bInitialized) then
        self:OnReset()
        self.bInitialized = 1
    end ;

    if (UIController_Init ~= nil) then
        UIController_Init();
    else
        System.LogAlways("UIController_Init not loaded ...")

        Script.UnloadScript("Scripts/Controller/arc_UIController.lua")
        Script.ReloadScript("Scripts/Controller/arc_UIController.lua")
    end


end;

function UIManager:OnAction(action, activation, value)

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

function UIManager.Client:OnUpdate()
    -- System.LogAlways("UIManager.Client onUpdate")

    if (UIController_OnUpdate ~= nil) then
        UIController_OnUpdate();
    else
        -- System.LogAlways("UIController_OnUpdate not loaded ...")
        -- Script.UnloadScript("Scripts/Controller/arc_UIController.lua")
        -- Script.ReloadScript("Scripts/Controller/arc_UIController.lua")
    end

end

function UIManager.Server:OnUpdate()
    -- System.LogAlways("UIManager.Server onUpdate")
end;

UIManager.Server.TurnedOn = {
    OnBeginState = function(self)
        BroadcastEvent(self, "TurnOn")
    end,
    OnUpdate = function(self, dt)
        --[[ do something every frame, like rendering, ai, ..]]
    end,
    OnEndState = function(self)

    end,
}

UIManager.Server.TurnedOff = {
    OnBeginState = function(self)
        BroadcastEvent(self, "TurnOff")
    end,
    OnEndState = function(self)

    end,
}

UIManager.FlowEvents = {
    Inputs = {
        TurnOn = { UIManager.Event_TurnOn, "bool" },
        TurnOff = { UIManager.Event_TurnOff, "bool" },
    },
    Outputs = {
        TurnOn = "bool",
        TurnOff = "bool",
    },
}
