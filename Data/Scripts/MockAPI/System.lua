---
--- Created by Benjamin Foo.
--- DateTime: 03.03.2020 00:30
---

local System = {}

-- mockup for the add console command function
function System.AddCCommand(name, funcname, desc)
    print("name: " .. name)
    print("funcname: " .. funcname)
    print("desc: " .. desc)
end

-- mockup for the log function
function System.LogAlways(variable)
    print(variable)
end

-- mockup for the lua debugger
function System.ShowDebugger()
    print("Showing lua-debugger ... [ ] ... ")
end

-- mockup for the deletion of the console buffer
function System.ClearConsole()
    print("ClearConsole ... ")
end

-- mockup for the execution of a command
function System.ExecuteCommand(command)
    print("Executing command:" .. command)
end

return System
