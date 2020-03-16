--[[
print("parameterizedConstructions = {")
for i = 1, #buildings do
    building = buildings[i]
    print("\t{ " ..
            "modelPath = " .. '\"'.. building .. '\"' .. ", " ..
            "sitable = false, " ..
            "useable = false, " ..
            "saveable = false, " ..
            "cookable = false, " ..
            "sleepable = false " ..
            " }" .. ", ")

end
print("}")
]]

--[[
    BuiltEntity = {
        modelPath = 0,
        name = "",
        resourcesCost = {
            wood = 10,
            stone = 5
        }
    }

    Inventory = {
        balance=0,
        withdraw = function (self, v)
            self.balance = self.balance - v
        end
    }

    function Inventory:deposit (v)
        self.balance = self.balance + v
    end

    Inventory.deposit(Inventory, 200.00)
    Inventory:withdraw(100.00)
    function Inventory:new (o)
        o = o or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end

    a = Inventory:new{balance = 0}
    a:deposit(100.00)

    print(a.balance)

    a:withdraw(25)
    print(a.balance)
]]
