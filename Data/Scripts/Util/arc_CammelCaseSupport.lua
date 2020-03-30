---
--- Author:  Benjamin Foo
---
--- Contains lua methods in different variations and parameter types.
--- This also contains simple aliases for methods in order to type less into the games console.

--
-- Data/Scripts/Manager/arc_BuildingsManager.lua
--

function Search(keyword)
    search(keyword)
end

function find(keyword)
    search(keyword)
end

--
-- Data/Scripts/Manager/arc_ConstructionController.lua
--


-- reloads the sources at runtime
-- keeps track of some wanted changes though
function reloadAll()
    reloadall()
end

-- select the first cons. but lowerCase
function selectFirst()
    SelectFirst()
end

-- select the last cons. but lowerCase
function selectLast()
    SelectLast()
end

-- select cons. but lowerCase
function select(newIndex)
    bIndex = newIndex;
    updateSelection()
end

function ShowAll()
    showall()
end

function showAll()
    showall()
end

-- delete every cons. but lowerCase
function deleteAll()
    deleteall()
end


-- delete every cons. but lowerCase
function lockall()
    lockAll()
end


---
--- Data/Scripts/Manager/arc_ResourcesController.lua
---

function ShowStats()
    showStats()
end


---
--- Data/Scripts/Utils/arc_runtime.lua
---

function setHomeName(newName)
    SetHomeName(newName)
end
function setHome()
    SetHome()
end
function getHome()
    GetHome()
end
function makeSunhine()
    MakeSunhine()
end
