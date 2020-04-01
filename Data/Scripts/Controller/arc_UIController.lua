---
--- Author:  Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- UIController handles the drawing of the user-interface
---

function UIController_Init()
    System.LogAlways("Init ui-controller")
end


-- this could be something like an index for selection handling, i dunno
menuIndex = 1

-- the rendered items of the menu
listItemCount = 10

-- the amount of items which are skipped by using pageUp or pageDown
stepCount = 10

-- if every items has a valid category set this member could be used to track these and show them once in the ui
-- TODO: implement this
lastCategory = ""
categoryString = ""

messageHeader = " Category: n/a"
paddedIndex = 0

-- newMessage is the "buffer" of the ui
messageBuffer = ""

paddingLeft = " " -- do we still need this?
paddingTop = "\n\n\n"

function UIController_OnUpdate()

    log("UIController_OnUpdate")

    if (bIndex == '#') then
        bIndex = 1
    end

    if (not config.modEnabled) then
        System.SetCVar('wh_ui_CopyrightMsgLeft', "")
        return
    end

    -- lineBuffer is the "buffer" of the current line, hast to be reset
    lineBuffer = ""

    for i = 0, listItemCount - 1 do

        -- added the index of this for loop to the current building-index
        -- so when the current selection is for example 23, well start from 23 and end on 42
        paddedIndex = bIndex + i

        -- get the element at index paddedIndex
        constructionModel = parameterizedConstructions[paddedIndex]

        -- if there is a valid construction at the padded index
        if (constructionModel ~= nil and constructionModel.category ~= nil) then

            -- add a selection indicator if menuIndex equals selection or something
            -- TODO


            -- get its name
            newLineStringContent = constructionModel.name

            -- add the content to the current line with proper formation and concatenation
            lineBuffer = lineBuffer .. paddingLeft .. tostring(paddedIndex) .. ".) " .. newLineStringContent .. "\n"

            -- get and check the category - update the header
            currentCategory = constructionModel.category

            -- get the current category
            if (currentCategory ~= lastCategory) then
                messageHeader = " Category: " .. constructionModel.category
            end


        else
            lineBuffer = "" -- this happens on start already and can be removed
        end


        -- append the lineBuffer to the messageBuffer
        messageBuffer = lineBuffer


        -- update the lastDescription
        lastCategory = constructionModel.category

    end

    -- paddingTop concats three new-lines to the beginning of the string
    -- so the label gets some pseudo padding on the top

    if (bIndex > 1) then
        messageBuffer = paddingLeft .. "+++" .. "\n" .. messageBuffer
    end

    resultString = paddingTop .. messageHeader .. "\n" .. messageBuffer

    if (bIndex < #parameterizedConstructions - listItemCount) then
        resultString = resultString .. paddingLeft .. "+++"
    end

    System.SetCVar('wh_ui_CopyrightMsgLeft', resultString)

    lineBuffer = ""

end

function incIndexStep()
    if bIndex < #parameterizedConstructions - stepCount then
        bIndex = bIndex + stepCount
    else
        bIndex = #parameterizedConstructions
    end

    updateSelection()
end

function decIndexStep()
    if bIndex > stepCount then
        bIndex = bIndex - stepCount
    else
        bIndex = 1
    end

    updateSelection()
end

-- Increment the current building index, mouse wheel up
System.ExecuteCommand("bind 'pgdn' #incIndexStep()")

-- Decrement the current building index, mouse wheel down
System.ExecuteCommand("bind 'pgup' #decIndexStep()")
