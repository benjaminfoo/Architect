RigidBody = {
    type = "RigidBody",
    MapVisMask = 0,

    Properties = {
        soclasses_SmartObjectClass = "",
        bAutoGenAIHidePts = 0,

        objModel = "Objects/box.cgf",
        Density = 5000,
        Mass = 1,
        bResting = 1,
        bVisible = 1,
        bRigidBodyActive = 1,
        bActivateOnRocketDamage = 0,
        Impulse = { X = 0, Y = 0, Z = 0 },
        max_time_step = 0.01,
        sleep_speed = 0.04,
        damping = 0,
        water_damping = 1.5,
        water_resistance = 0,
    },
    temp_vec = { x = 0, y = 0, z = 0 },
    PhysParams = { mass = 0, density = 0 },

    updateTime = 500,
    gravityUpdate = 0,

    Editor = {
        Icon = "physicsobject.bmp",
        IconOnTop = 1,
    },
}
function RigidBody:OnInit()
    self.ModelName = "";
    self.Mass = 0;
    self:OnReset();
end
function RigidBody:OnReset()
    System.LogAlways("Rigidbody OnReset")
    if (self.ModelName ~= self.Properties.objModel or self.Mass ~= self.Properties.Mass) then
        self.Mass = self.Properties.Mass;
        self.ModelName = self.Properties.objModel;
        self:LoadObject(0, self.ModelName);

    end

    local Properties = self.Properties;

    if (Properties.bVisible == 0) then
        self:DrawSlot(0, 0);
    else
        self:DrawSlot(0, 1);
    end

    local physType;
    if (self.Properties.bRigidBodyActive == 1) then
        physType = PE_RIGID;
        self.PhysParams.density = Properties.Density;
        self.PhysParams.mass = Properties.Mass;
    else
        physType = PE_STATIC;
    end

    self:Physicalize(0, physType, self.PhysParams);
    self:SetPhysicParams(PHYSICPARAM_SIMULATION, self.Properties);
    self:SetPhysicParams(PHYSICPARAM_BUOYANCY, self.Properties);

    self:AwakePhysics(1);
    if (self.Properties.bAutoGenAIHidePts == 1) then
        self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 0);
    else
        self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 2);
    end

end
function RigidBody:OnPropertyChange()
    self:OnReset();
end

function RigidBody:OnCollision(hitData)
    System.LogAlways("Rigidbody Event - OnCollision")

    for key, value in pairs(hitData) do
        System.LogAlways("k: " .. key .. " | val: " .. value)
    end
end

function Fog:OnBeginState()
    System.LogAlways("Rigidbody OnBeginState")

end

function RigidBody:OnEndState()
    System.LogAlways("Rigidbody OnEndState")
end

function RigidBody:OnContact(player)
    System.LogAlways("Rigidbody Event - OnCantact")
    self:Event_OnTouch(player);
end
function RigidBody:OnDamage(hit)
    System.LogAlways("Rigidbody onDamage")

    if (hit.ipart) then
        self:AddImpulse(hit.ipart, hit.pos, hit.dir, hit.impact_force_mul);
    end

    if (self.Properties.bActivateOnRocketDamage) then
        if (hit.explosion) then
            self:AwakePhysics(1);
        end
    end
end
function RigidBody:OnShutDown()
end
function RigidBody:OnTimer()
end

function RigidBody:OnUpdate()
    self.gravityUpdate = self.gravityUpdate + _frametime;

    if (self.gravityUpdate < 0.5) then
        return ;
    end

    self.gravityUpdate = 0.0;
    EntityUpdateGravity(self);
end

function RigidBody:Event_AddImpulse(sender)
    self.temp_vec.x = self.Properties.Impulse.X;
    self.temp_vec.y = self.Properties.Impulse.Y;
    self.temp_vec.z = self.Properties.Impulse.Z;
    self:AddImpulse(0, nil, self.temp_vec, 1);
end

function RigidBody:OnDamage(hit)
    System.LogAlways("Rigidbody OnDamage")

end

function RigidBody:Event_Activate(sender)
    System.LogAlways("Rigidbody Event_Activate")

    self:CreateRigidBody(self.Properties.Density, self.Properties.Mass, 0);

    self:Activate(1);
    self:AwakePhysics(1);
end
function RigidBody:Event_Show(sender)
    self:DrawSlot(0, 1);
end
function RigidBody:Event_Hide(sender)
    self:DrawSlot(0, 0);
end
function RigidBody:Event_OnTouch(sender)
    System.LogAlways("Rigidbody Event_OnTouch")
    BroadcastEvent(self, "OnTouch");
end

RigidBody.FlowEvents = {
    Inputs = {
        Activate = { RigidBody.Event_Activate, "bool" },
        AddImpulse = { RigidBody.Event_AddImpulse, "bool" },
        Hide = { RigidBody.Event_Hide, "bool" },
        Show = { RigidBody.Event_Show, "bool" },
        OnTouch = { RigidBody.Event_OnTouch, "bool" },
    },
    Outputs = {
        Activate = "bool",
        AddImpulse = "bool",
        Hide = "bool",
        Show = "bool",
        OnTouch = "bool",
    },
}
