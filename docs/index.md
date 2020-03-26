---
#
# Here you can change the text shown in the Home page before the Latest Posts section.
#
# Edit cayman-blog's home layout in _layouts instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
#
layout: home
---
<hr>
# Welcome
This project allows the construction of entities within the games world - 
this means that the player can spawn anything from simple props to flora & fauna, vegetation, houses, walls, towers,
tents, chairs, benches, beds, etc. anywhere in the world.

Make a backup of your saved games before doing anything else.  
Constructions are saved across your savegames - there is no new save required.  

There are _no DLCs required_ in order to use this mod.

Thanks to [Warhorse Studios](https://warhorsestudios.cz) for creating this gem!

<br>

## Installation
Download the latest release, unzip the archive into your KingdomComeDeliverance\mods - folder.
If the installation was succesful you'll see the instructions-message on how to use the mod when the game has been started
(and a savegame loaded or a new game hast been created).

### Using the devmode
You need to start the game with devmode enabled (the modification won't work otherwise).  
**In your OS / explorer / shell:** 
`<Steam>\steamapps\common\KingdomComeDeliverance\Bin\Win64\KingdomCome.exe -devmode`
  
### For Steam Users
The following list of files files need to be stored at: 
`Steam\steamapps\common\KingdomComeDeliverance\mods\architect\`
- mod.manifest
- keybinds.cfg
- Data\architect.pak

### For Epic Store Users
This will get updated soon - however, take a look at the posts section of this site - people using epic were also able to use this mod.

### Uninstall / Removal
Its also safe to remove the mod at any time (if you've already created something within the game, without
deleting it first, the entity stays in the game. Use **#deleteall()** within the ingame-console to clean up your scene.)


<br>

## Usage / Keys
These keys can be used to interact with the mod - they're also shown ingame.

Choose the next construction (from 0 to ~200)  
Button MouseWheel up  

Choose the previous construction (from 0 to ~200)  
Button MouseWheel down  

Create a new construction  
Key V

Remove a construction  
Key G

Lock / unlock construction for deletion  
Key O  

<br>

## Features
This is an overview of all the implemented features this project contains.

### Constructions
One target functionality architect introduces is the concept of constructions.

```
A construction is an entity within the cryengine
There are different kinds of properties an entity can use from

Construction, Construction-Properties
 - name (optional) - the name of the construction - the name will be built from the modelPath
 - modelPath       - the relative path to the *.cgf file, contains the name of the model file and its physics
 - description     - the description for the construction
 - groschenPrice   - the price in groschen the user has to pay upfront (to whom? who recieves this money) => maybe there should be some kind of logic that 50% goes to the king and 50% to the city, and at some point you will get the money back or something like that, some kind of insurence or something
 - sitable         - if true, the player can sit on this object
 - useable         - if true, the player can use the object in some way
 - saveable        - if true, the instance of the construction gets saved
 - cookable        - if true, the player can use the construction for cooking
 - sleepable       - if true, the player can use the construction for sleeping

Properties related to generating some item over a specified amount of time
(like collecting water passively) or craft something out of x for y (x = generated item, y = cost of crafting for item x)
 - generator           - if true, the item generates items over time specified by following properties
 - generatorOnUse      - if true, the construction can be used by the player to generate an item
 - generatorItem       - the item that gets crafted on use or after time
 - generatorItemCosts  - the costs for producing this item (a set of resources and amounts)
 - generatorCooldown   - the length of the intervall after an item gets generated passievly
 - generatorItemAmount - the amount of items the user recieves after an intervall

Notes
- Constructions which only contain a modelPath are handled as static entites (no functionality, just a model + collider + manged in savegames)
```

<br>

### Town management
Its possible to define basic attributes of a home or town now. 
You can set a home position and return back any time or set a name for your town.
There is also a statistics command which shows different aspects of your town.

Sets the current player-location as home / town  
`setHome()`

Sets the town's name to Farkletown  
`setHomeName("Farkletown")`

Returns the player to his home / town  
`getHome()`
    
Displays a resume (a list of attributes, like name, town, generated resources) for your current town  
`showStats()`

<br>

### Resource Management
Another new feature architect introduces is the management of resources. 

There are different kinds of resources:
```
resources = {

    -- basic resources
    wood = 0,
    stone = 0,

    -- basic needs
    food = 0,
    water = 0,

    -- the money of the user, this should be bind to the actuals player value
    groschen = 0,

    -- this can be used for baking bread or other food in kingdom come deliverance
    wheat = 0,

    coal = 0,
    cords = 0,
    linen = 0,
} 
```
Building constructions will require the user to spend money and / or resources in order to actually built something - 
like the ingredients of a recipe. The implementation is not finished yet.


<br>

### Crafting
A construction who posses attributes like generatorOnUse can be used to realize simple crafting mechanics.

```
{
    -- create a new construction which can be used for crafting
    modelPath = "...",
    generatorOneUse = true
    generatorItem = "wood"
    -- TODO
} 
```
.. this needs an update first.

<br>  

## Current features / To-Dos / bugs
This list contains all the features planned for later development, recommended by myself or the community:

- resource / cost management system (for spending and recieving groschen w constructions)
  - needs balancing
  - implement costs for crafting or producing resources or items
  - implement costs for building stuff, should be in the recipe above!
  
   
- custom crafting systems 
  - needs balancing
  - implement costs for crafting or producing resources or items
  - implement costs for building stuff, should be in the recipe above! 
  
  
- add further constructions
  - a working kitchen / campfire
  - add aim target with hit detection (like "hit one time, ...") on arrow hit
  - trigger / buttons
  
- misc  
  - keybind for enabling / disabling the mod - on f12 - pressed => you have activated the mod, these are the keys... etc.
  - spawn setups with relations to npcs or items
  - make torches & lights toggleable
  - preview for constructions
  - preview-mode for rotation, translation of the constructions
  - ... siege invasions ... ?
  
<br>  

  
## Technical
This is an overview of all the available console- and lua- commands this project contains.

### Console commands
The following list contains regular console commands

- architect_help - show the help menu (also shows all available lua functionality)
- architect_clear - clear the ingame console
- architect_gamble - win or loose 5 groschen!
- architect_log - print some text to the ingame-console
- architect_recompileAll - reload the source-code of the project


### Lua functions
These functions offer advanced usage to the modifications internals, use at your own risk and save the game. \
In order to execute a lua function, you have to prepend a '#'-character to execute it.

All commands are available in upper / lowercase format.

```
Search(string s) 
-- Search for entites which name contains string s
-- For example: #search("stone") - emits a list of entities containing the string "stone"
-- Use Select to use one of your findings (without using the mouse wheel)

Select(nr)
-- selects the construction at Number nr and updates the user interface

SelectFirst()  
-- selects the first construction and updates the user interface

SelectLast()
-- selects the last construction and updates the user interface

showall() 
-- lists all constructions to the ingame console

deleteall()
-- deletes all constructions you've created

deleteAt(index)()
-- delete the construction at number index (use #showall())

toggleEntityLock()
-- toggles the deletion_lock-value of the currently faced entity
-- If true, the entity wont get deleted, no matter which function / mechanism is used,
-- if false, the entity will get deleted (default) 

reloadall()
-- Reloads the source files of the project at runtime

rayCastHit()
-- Use a raycast to determine entities in front of the player


lockAll()
-- locks all constructions from the user
-- this method is useful when used after loading a saved game - this way you can keep your changes 

unlockAll()
-- unlocks all constructions from the user

setHome()
-- Sets the current player-location as home / town

setHomeName("Farkletown")
-- Sets the town's name

getHome()
-- Returns the player to his home / town
    
showStats()
-- Displays a resume (a list of attributes, like name, town, generated resources) for your current town

```

<br>




<br>
 
##### Implemented features - tl;dr
- custom constructions / entities, or existing with custom actions / usages
- custom entities for the generation of resources
- implement un/locking mechanism
- implement advanced ingame-console usage and help
- implement minimalistic user interface
- provide ability to build constructions based on ingame assets
- provide ability to extend the modification for easier usage / development


<br>

### Changelog
This list contains all changes happened during development - the versions should be compatible to each other (maybe) - already created entities wont be affected.

```
- Alpha versions (a) are unstable and in subject of larger changes - expect bugs.
- Beta versions are more stable and in subject of smaller bugfixes - expect less bugs :).

changelog 0.5.3b
- updated docs and added about page - https://benjaminfoo.github.io/Architect/
- "should-be-stable"-release

changelog 0.5.3a
- implemented alot of console functionality for easer use (use #search("string"), #select(nr), #selectFirst(), #selectLast(), ...)
- implemented resource-system
- implemented resource-generation (passively & overtime, actively when used)
- implemented basic town management (
- updated simple crafting-system (see the resource-system and generation)
- updated locking-system (use #lockAll() or #unlockAll()
- updated available constructions (changed data-model, provided additional data for new model, added alot of interior, ...)


changelog 0.5.2b
- added fallback keybinding
- limited user to only remove his own constructions (no more deleted doors, ... or dogs)
- added deletion lock for entities (by pressing 'O' you're locking the currently faced entity, which makes it undeleteable, press again to retoggle the state)
- updated construction-types, construction-set (its now possible to build a water generators or different kind of ovens)
- updated console commands (allows selection of the first, last or n-th entity from available constructions) 
- the functionalities / mechanics of constructions now work on saved/loaded games
- updated console commands, refactored almost entire project, updated docs :)

Version 0.5.1a
- increased compatibility with other modifications

Version 0.5a
- added basic custom crafting system (this only works with constructions created by the player) 
- added useable entities (like chairs, beds, benches, etc.)
- updates of custom actions and entities
- refactored project, upgraded entity-model, controller, utils, documentation etc.
- removed invalid references from assets

Version 0.4b
- added option to rebind keys (look at the keybinds.cfg file to define your own keys)
- added further docs

Version 0.3b
- added console commands
- refactoring, ui finish
- documentation, screenshots

Version 0.2b
- bug-fixes, removed all known problems
- setup proper constructions
- unique naming of entities

Version 0.1b
- advanced ingame-console functionality
- added persistence (constructions wont get lost on save- & loading a level)

Version 0.1a
- basic functionality
- construct and deconstruct buildings
- mock-api
```

<br>

### Misc.

##### Change default key-bindings
The `keybinds.cfg` file contains all keybindings used in the project - change it to a key or a controller button as you like.

##### Add new constructions to the selection, remove constructions
Not every asset is referenced in the project, because some are not suitable (split into multiple parts which would be a 
pain to position by hand, some are graphical effects, some are too large to be positioned by the player, etc.).

However, one could add models / cgfs from the assets  on its own, the currently used constructions are 
listed in the file: https://github.com/benjaminfoo/Architect/blob/master/Data/Scripts/Manager/BuildingsManager.lua

<br>

#### Thanks / Credits
Thanks to [Warhorse Studios](https://warhorsestudios.cz) for creating such a great game, with engine, assets & sdk -
this fun project wouldnt be possible without you.

Also big thanks to the modding community on nexus﻿.

Thanks @sexybiscuit for creating the great video on how to use and install the modification!
