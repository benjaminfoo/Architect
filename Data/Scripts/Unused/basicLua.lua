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

Account = {
    balance=0,
    withdraw = function (self, v)
        self.balance = self.balance - v
    end
}

function Account:deposit (v)
    self.balance = self.balance + v
end

Account.deposit(Account, 200.00)
Account:withdraw(100.00)
function Account:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

a = Account:new{balance = 0}
a:deposit(100.00)

print(a.balance)

a:withdraw(25)
print(a.balance)
]]
