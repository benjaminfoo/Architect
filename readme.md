<img src="/Data/Docs/architect_nm.png">  

# KCD - Architect
 
A modification for Kingdom Come Deliverance which introduces base-building mechanics and new features to the game.

This project allows the construction of entities within the games world - 
this means that the player can spawn anything from simple props to flora & fauna, vegetation, houses, walls, towers,
tents, chairs, benches, beds, etc. anywhere in the world.

Make a backup of your saved games before doing anything else. \
Constructions are saved across your savegames - there is no new save required.

If you're having fun with this mod you're maybe interested in buying me a coffee :) \
Thanks to [Warhorse Studios](https://warhorsestudios.cz) for creating this gem!

For changelogs, planned features or in-depth details see [https://benjaminfoo.github.io/Architect/](https://benjaminfoo.github.io/Architect/)

<br>

### Installation
Download the latest release, unzip the archive into your KingdomComeDeliverance\mods - folder.
If the installation was succesful you'll see the instructions-message on how to use the mod when the game has been started
(and a savegame loaded or a new game hast been created).

##### For Steam
The following list of files files need to be stored at: \
`Steam\steamapps\common\KingdomComeDeliverance\mods\architect\`
- mod.manifest
- keybinds.cfg
- Data\architect.pak

##### For Epic Store
This will get updated soon - however, take a look at the posts section of this site - people using epic were also able to use this mod.

##### Using Dev-mode
You need to start the game with devmode enabled (the modification won't work otherwise). \

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

Reload the project sources at runtime \
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

All commands are available in upper / lowercase format.

```

SetHome()
-- set the position of the home

Home()
-- set the players position the home position


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

##### Thanks / Credits
Big thanks to [Warhorse Studios](https://warhorsestudios.cz) for creating such a great game, with engine, assets & sdk -
this fun project wouldnt be possible without you.

Also big thanks to the modding community on nexus﻿ and discord (i dont know the public link currently, TODO).

Thanks @sexybiscuit for creating the great video on how to use and install the modification!
