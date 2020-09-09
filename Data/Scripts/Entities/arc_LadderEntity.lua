LadderEntity =
{
	Properties = 
	{
		bSaved_by_game = 1,
		object_Model = "Objects/structures/ladder/siege_ladder.cgf",

		deletion_lock = false,

		bUseOnlyFromFront = 0,
		bUsable	= 1,
		bTopBlocked	= 0,
		bTopOnPalisade = 0,
		height = 3.7, -- this varies from ladder to ladder ...
		
		esLadderType = "Ladder",
		
		sWH_AI_EntityCategory = "Ladder",
		guidSmartObjectType = "",
		soclasses_SmartObjectHelpers = "",
		soclasses_SmartObjectClass = "",
		bInteractiveCollisionClass = 1,

		ViewLimits =
		{
			horizontalViewLimit 		= 30,
			verticalUpViewLimit 		= 45,
			verticalDownViewLimit 		= -45,
		},
		Offsets =
		{
			bShowHelpers = 0,
			verticalDistanceBetweenRungs		= 0.25,
			getOnDistanceAwayTop 				= 0.85,
			getOnDistanceAwayBottom				= 0,
		},
		Movement =
		{
			movementAcceleration 		= 5,
			movementSpeedUpwards 		= 2.5,
			movementSpeedDownwards 		= 2.25,
			movementSettleSpeed 		= 0.8,
			movementInertiaDecayRate 	= 5.5,
		},		
  },
  	
	Editor=
	{
		Icon = "ladder.bmp",
		IconOnTop=1,
	},

	Server = {},
}

function LadderEntity:OnSpawn()	
	self:LoadObject( 0,self.Properties.object_Model );
	self:Physicalize(0,PE_STATIC,{mass = 0, density = 0});
	self:SetInteractiveCollisionType();

	if (System.IsEditor()) then
		self:Activate(1);
	end
    
    self.Runtime = { isUsable = self.Properties.bUsable == 1 }
    
end

function LadderEntity:SetInteractiveCollisionType()
	local filtering = {}
	
	if(self.Properties.bInteractiveCollisionClass == 1) then
		filtering.collisionClass = 262144;
	else
		filtering.collisionClassUNSET = 262144;
	end
	
	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering );
end

function LadderEntity:OnPropertyChange()
	self:LoadObject( 0,self.Properties.object_Model );
	self:Physicalize(0,PE_STATIC,{mass = 0, density = 0});
	self:SetInteractiveCollisionType();
end

function LadderEntity:GetActions(user,firstFast)
    output = {}
	
    if(not self.Runtime.isUsable) then
		return output
	end
	
	if(user.human:CanUseLadder(self.id,self.Properties.height,self.Properties.bUseOnlyFromFront) == 1) then
        AddInteractorAction( output, firstFast, Action():hint("@use_ladder"):action("use"):func(LadderEntity.OnUsed):interaction(inr_ladder ) )
    end
	
    return output
end

function LadderEntity:OnUsed(user)
    user.human:GrabOnLadder(self.id);
end

function LadderEntity:IsUsable(user)
    if(not self.Runtime.isUsable) then
        return 0;
    end
    return user.human:CanUseLadder(self.id,self.Properties.height,self.Properties.bUseOnlyFromFront);
end

function LadderEntity.Server:OnUpdate(frameTime)
	if(System.IsEditing() and self.Properties.Offsets.bShowHelpers==1) then
		local pos = self:GetWorldPos();
		local frontDirection = self:GetDirectionVector(1);
		local upDirection = self:GetDirectionVector(2);
		local playerStart = pos.y;
		
		local ladderGetOn  = pos;
		local ladderGetOff = SumVectors(ladderGetOn,ScaleVector(upDirection,self.Properties.height - self.Properties.Offsets.getOnDistanceAwayTop));
		Game.DebugDrawCylinder(ladderGetOn.x, ladderGetOn.y, ladderGetOn.z, 0.3, 0.001, 60, 60, 255, 100);
		Game.DebugDrawCylinder(ladderGetOff.x, ladderGetOff.y, ladderGetOff.z, 0.3, 0.001, 60, 60, 255, 100);
				
		local height = SumVectors(pos,ScaleVector(upDirection,self.Properties.height));
		Game.DebugDrawCylinder(height.x,height.y,height.z,0.3, 0.001, 60, 255, 60, 100);
	end
end

function LadderEntity:SetUsable( usable )
    self.Runtime.isUsable = usable;
end

function TriggerBase:OnLoad(table)
    self.Runtime = table.Runtime;

	self.Properties.object_Model = table.object_Model;
	self.Properties.deletion_lock = table.deletion_lock;
	self.Properties.height = table.height

	self:LoadObject( 0,self.Properties.object_Model );
	self:Physicalize(0,PE_STATIC,{mass = 0, density = 0});
	self:SetInteractiveCollisionType();
	self:SetViewDistUnlimited()

	self:SetFlags(ENTITY_FLAG_RAIN_OCCLUDER, 1)
	self:SetFlags(ENTITY_FLAG_CASTSHADOW, 1)
end

function TriggerBase:OnSave(table)
    table.Runtime = self.Runtime;

	table.object_Model = self.Properties.object_Model
	table.deletion_lock = self.Properties.deletion_lock
	table.height = self.Properties.height
end

function LadderEntity:OnLoad(table)

	self.Properties.object_Model = table.object_Model;
	self.Properties.deletion_lock = table.deletion_lock;
	self.Properties.height = table.height

	self:LoadObject( 0,self.Properties.object_Model );
	self:Physicalize(0,PE_STATIC,{mass = 0, density = 0});
	self:SetInteractiveCollisionType();
	self:SetViewDistUnlimited()

end

function LadderEntity:OnSave(table)

	table.object_Model = self.Properties.object_Model
	table.deletion_lock = self.Properties.deletion_lock
	table.height = self.Properties.height
end

