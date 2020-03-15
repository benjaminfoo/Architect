<img src="/Data/Docs/architect.png">  

# Kingdom Come Deliverance Modification - Architect
 
A base-building modification for Kingdom Come Deliverance by Warhorse Studios.

This modification adds base-building mechanics to the existing game by providing the ability to create constructions
within the games world (its not possible to remove existing structures).

The player can spawn anything from simple props, flora & fauna, trees, sheds, houses, walls, towers, etc. (see how to add custom entities)

Constructions are saved across your savegames - there is no new save required.

Its also safe to remove the mod at any time (however - if you've already created something within the game, without
deleting it then, the entity stays in the game. Use **#deleteall()** within the ingame-console to clean up your scene.) 

## Installation
Download the latest release, unzip the archive into your `KingdomComeDeliverance\mods`-folder 

## Usage / Keys
These keys can be used to interact with the mod - they're also shown ingame.

Choose the next construction (from 0 to 251)
Button: MouseWheel up

Choose the previous construction (from 0 to 251)
Button: MouseWheel down

Create construction
Button: V

Remove construction
Button: G


## Technical

### Console commands
- architect_help - show the help menu
- architect_clear - clear the ingame console
- architect_gamble - win or loose 5 groschen!
- architect_eval - eval some string of lua
- architect_log, log - print some text to the ingame-console
- architect_recompileAll - reload the source-code of the project


### Lua functions
In order to execute a lua function, you have to prepend a '#'-character to execute it
- reloadall() - Reloads the source files of the modification
- deleteall() - Deletes ALL constructions youve build
- showall()   - Lists all constructions to the ingame console
- deleteAt(index)() - Delete the construction with the number "index" (use #showall())


### HowTo
##### Change default key-bindings
The `keybinds.cfg` file contains all keybindings used in the project - change it to a key or a controller button as you like.

##### Add new constructions to the selection, remove constructions
Not every asset is referenced in the project, because some are not suitable (split into multiple parts which would be a 
pain to position by hand, some are graphical effects, some are too large to be positioned by the player, etc.).

However, one could add models / cgfs from the assets  on its own, the currently used constructions are 
listed in the file: https://github.com/benjaminfoo/Architect/blob/master/Data/Scripts/Manager/BuildingsManager.lua


### Changelog
This is the list of changes - the version should be compatible to each other. 
Your already created entities wont be affected.

v0.5a
- added useable entities (like chairs, benches, beds, etc.)
- refactored project, upgraded entity-model, etc.
- removed invalid references from assets

v0.4b
- added option to rebind keys (look at the keybinds.cfg file to define your own keys) 
- added further docs 

v0.3b
- added console commands
- refactoring, ui finish
- documentation, screenshots

v0.2b
- bug-fixes, removed all known problems
- finished major refactoring
- unique naming of entities (GUIDs)
- setup proper constructions

v0.1b
- advanced ingame-console functionality
- added persistence (constructions wont get lost on save- & loading a level)

v0.1
- basic functionality
- construct and deconstruct buildings
- mock-api 

