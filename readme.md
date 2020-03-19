<img src="/Data/Docs/architect_nm.png">  

# KCD - Architect
 
A modification for Kingdom Come Deliverance which adds base-building mechanics to the existing game by providing the ability to create constructions
within the games world (its not possible to remove existing structures though).

The player can create anything from simple props to flora & fauna, vegetation, houses, walls, towers, chairs, benches, beds, etc. - any createable entity is already defined within the games data - this modification however just adds and executes additional lua code and makes use of the already existing engine & sdk by warhorse studios.

##### Notes 
- Make a backup of your saved games before doing anything else.
- Constructions are saved across your savegames - there is no new save required.

If you're having fun using this mod, maybe you're interested in buying me a coffee :) \
Thanks to  [Warhorse Studios](https://warhorsestudios.cz) for creating this gem!

<br>

### Installation
Download the latest release, unzip the archive into your KingdomComeDeliverance\mods - folder.
If the installation was succesful you'll see the instructions-message on how to use the mod when the game has been started
(and a savegame loaded or a new game hast been created).

##### For Steam
- Steam\steamapps\common\KingdomComeDeliverance\mods\architect\mod.manifest
- Steam\steamapps\common\KingdomComeDeliverance\mods\architect\keybinds.cfg
- Steam\steamapps\common\KingdomComeDeliverance\mods\architect\Data\architect.pak

##### For Epic Store
This will get updated soon - however, take a look at the posts section of this site - people using epic were also able to use this mod.

##### Using Dev-mode
You need to start the game with devmode enabled (the modification won't work otherwise apparently). \
**In your OS / explorer / shell:** `<Steam>\steamapps\common\KingdomComeDeliverance\Bin\Win64\KingdomCome.exe -devmode`

<br>

## Uninstall / Removal
Its also safe to remove the mod at any time (if you've already created something within the game, without
deleting it first, the entity stays in the game. Use **#deleteall()** within the ingame-console to clean up your scene.)


## Usage / Keys
These keys can be used to interact with the mod - they're also shown ingame.

Choose the next construction (from 0 to ~200) \
Button MouseWheel up

Choose the previous construction (from 0 to ~200) \
Button MouseWheel down

Create a new construction \
Key V

Remove a construction \
Key G

Lock / unlock construction for deletion \
Key O

Lock / unlock construction for deletion \
Key F9

<br>

## Technical

### Console commands
The following list contains regular console commands

- architect_help - show the help menu
- architect_clear - clear the ingame console
- architect_gamble - win or loose 5 groschen!
- architect_eval - eval some string of lua
- architect_log, log - print some text to the ingame-console
- architect_recompileAll - reload the source-code of the project


### Lua functions
These functions offer advanced usage to the modifications internals, use at your own risk and save the game. \
In order to execute a lua function, you have to prepend a '#'-character to execute it.

```
SelectFirst()  
-- selects the first construction and updates the user interface

SelectLast()
-- selects the last construction and updates the user interface

SelectIndex(nr)
-- selects the construction at Number nr and updates the user interface

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
```

<br>

### HowTo
##### Change default key-bindings
The `keybinds.cfg` file contains all keybindings used in the project - change it to a key or a controller button as you like.

##### Add new constructions to the selection, remove constructions
Not every asset is referenced in the project, because some are not suitable (split into multiple parts which would be a 
pain to position by hand, some are graphical effects, some are too large to be positioned by the player, etc.).

However, one could add models / cgfs from the assets  on its own, the currently used constructions are 
listed in the file: https://github.com/benjaminfoo/Architect/blob/master/Data/Scripts/Manager/BuildingsManager.lua

<br>

#### Planned features
This list contains all the features planned for later development, recommended by myself or the community:

- custom crafting systems
- custom constructions / entities, or existing with custom actions / usages
- custom entities for the generation of resources
- resource / cost management system (for spending and recieving groschen w constructions)
- spawn setups with relations to npcs or items
- make torches & lights toggleable
- trigger / buttons
- preview for constructions
- gizmo / mode for rotation, translation of the constructions
- siege invasions
- ...

<br>

### Changelog
This list contains all changes happened during development - the versions should be compatible to each other (maybe) - already created entities wont be affected.

```
- Alpha versions (a) are unstable and in subject of larger changes - expect bugs.
- Beta versions are more stable and in subject of smaller bugfixes - expect less bugs :).

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

##### Thanks / Credits
Big thanks to [Warhorse Studios](https://warhorsestudios.cz) for creating such a great game, with engine, assets & sdk -
this fun project wouldnt be possible without you.

Also big thanks to the modding community on nexus﻿ and discord (i dont know the public link currently, TODO).

Thanks @sexybiscuit for creating the great video on how to use and install the modification!
