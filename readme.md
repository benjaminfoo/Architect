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
Button: MouseWheel up

Choose the previous construction (from 0 to ~200) \
Button: MouseWheel down

Create a new construction \
Key V

Remove an newly created construction \
Key G

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
In order to execute a lua function, you have to prepend a '#'-character to execute it

- reloadall() - Reloads the source files of the modification
- rayCastHit() - Use a raycast to determine entities in front of the player
- deleteall() - Deletes ALL constructions youve build
- showall()   - Lists all constructions to the ingame console
- deleteAt(index)() - Delete the construction with the number "index" (use #showall())

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
This is a list of planned features for later development - this will take some time however

- custom constructions, or existing constructions with custom actions / usages
- define further custom entities
- resource / cost management
- spawn npcs
- spawn items

<br>

### Changelog
This list contains all changes during development - the versions should be compatible to each other, maybe - already created entities wont be affected.


```
Remember
- Alpha versions (a) are unstable and in subject of larger changes - expect bugs.
- Beta versions are more stable and in subject of smaller bugfixes - expect less bugs :).

Version 0.5.1b - dev
- updated available constructions
- added keybinding fallback 
- limited user to only remove his own constructions
- updated documentation

Version 0.5.1a
- increased compatibility with other modifications

Version 0.5a
- added useable entities (like chairs, benches, beds, etc.)
- added custom actions and new entities (generator, cooking)
- added basic custom crafting system
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
- finished major refactoring
- unique naming of entities (GUIDs)
- setup proper constructions

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
