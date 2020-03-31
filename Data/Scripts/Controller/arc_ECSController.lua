---
--- Author:  Benjamin Foo
---
--- Description
--- ECSController handles entity and their properties
---

-- gets called once when the ecsManager gets spawned
function ECSController_Init()
    System.LogAlways("Init ECSController !")
end

-- gets called every second, use delta to get time between this and the last rendered frame
function ECSController_OnUpdate()


    -- manage the hit-checking for the preview-system
    rayCastHitOnUpdate()

end

System.LogAlways("Loaded ECSController ...")
