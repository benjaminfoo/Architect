---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The CCommandManager contains code related to the ingame-console and the management of key-bindings
---

function architect_dbg()
    System.LogAlways("starting lua-debugger !");
    System.ShowDebugger();
end

function architect_clear()
    System.ClearConsole();
end

function architect_gamble()
    System.LogAlways("Gamble started ..");

    rand = math.random()
    winThreshold = 0.5
    amountOfMoney = 5

    if rand > winThreshold then
        amountOfMoney = 5
    else
        amountOfMoney = -5
    end

    Game.SendInfoText("Gamble: " .. tostring(amountOfMoney) .. " groschen!", false, nil, 1)
    System.ExecuteCommand("wh_cheat_money " .. amountOfMoney)

    System.LogAlways("Gamble finished ..")

end

function architect_eval(line)
    System.LogAlways("Begin eval [%s].", tostring(line))
    --Defining a function from the string and run it
    local func = loadstring(line)
    System.LogAlways(tostring(func()))
    System.LogAlways("End eval [%s].", tostring(line))
    return true
end

function log(line)
    architect_log(tostring(line));
end

function architect_log(line)
    System.LogAlways(tostring(line));
end

function architect_recompile()
    System.LogAlways("called architect_recompile() ...")

    System.ExecuteCommand("#Script.UnloadScript('Scripts/Manager/BuildController.lua')")
    System.ExecuteCommand("#Script.ReloadScript('Scripts/Manager/BuildController.lua')")

    System.LogAlways("... finished architect_recompile()")
end
function architect_recompileAll()
    System.LogAlways("called architect_recompileAll() ...")

    System.ExecuteCommand("#Script.ReloadScripts()")

    System.LogAlways("... finished architect_recompileAll()")
end

---- shortcuts
l = System.LogAlways
t = tostring

function architect_help()
    System.LogAlways("")
    System.LogAlways("architect modification v0.2b - initialized and loaded!");
    System.LogAlways("")
    System.LogAlways("Commands:")
    System.LogAlways("architect_help        - Prints this message")
    System.LogAlways("architect_clear       - Clears the console bugger")
    System.LogAlways("architect_dbg         - Shows the debugger")
    System.LogAlways("architect_gamble      - Gamble in order to win or loose five groschen")
    System.LogAlways("architect_eval        - Eval lua strings")
    System.LogAlways("architect_log         - Log a message to the console")
    System.LogAlways("architect_recompile   - Recompile the mod during runtime")
    System.LogAlways("architect_recompileAll   - Recompile the mod during runtime - use at your own risk")
    System.LogAlways("")
    System.LogAlways("log   - same as architect_log")
    System.LogAlways("l     - same as architect_log")
    System.LogAlways("t(x)  - convert x to string")

end

-- key bindings
System.AddCCommand('architect_help', 'architect_help()', "Shows the help overview")
System.AddCCommand('architect_dbg', 'architect_dbg()', "Starts the lua debugger")
System.AddCCommand('architect_clear', 'architect_clear()', "Clears the console")
System.AddCCommand('architect_gamble', 'architect_gamble()', "Gamble in order to win or loose five groschen")
System.AddCCommand('architect_eval', 'architect_eval(%line)', "Evaluate lua-input")
System.AddCCommand('architect_log', 'architect_log(%line)', "Log %line to the console")
System.AddCCommand('log', 'log(%line)', "Shortcut for architect_log")

System.AddCCommand('architect_recompile', 'architect_recompile()', "Compile the mod sources at runtime")
System.AddCCommand('architect_recompileAll', 'architect_recompileAll()', "Recompile everything during runtime")

-- bindings
-- System.ExecuteCommand("bind f9 architect_recompile ")
