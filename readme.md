<img src="/Data/Docs/architect.png">  

# Kingdom Come Deliverance Modifcation - Architect
 
A base-building / sandboxing modification for kingdom come deliverance.

This modification aims to add base-building / sandboxing mechanics to the existing game - no new save required.

Constructions are also persistent across your save sates.

### Usage / Keys
Execute builder_help in the ingame console for additional help.

- Mousewheel up/down - Choose building 
- Mouse 3 - Construct building
- Mouse 5 - Remove building, Remove last building
- F9 - Reload the mod

#### Console commands
- #reloadall - Reloads the source files of the modification
- #deleteall - Deletes ALL constructions youve build
- #showall   - Lists all constructions to the tale
- #deleteAt(index) - Delete the construction with the number "index" (use showall)

Contact: http://github.com/benjaminfoo/
Mail: dataframes@googlemail.com

### Changelog
v0.3b
- refactoring, ui finish
- added console commands

v0.2b
- bug-fixes, removed all known problems
- finished major refactoring
- unique naming of entities (GUIDs)
- setup proper constructions


v0.1b
- advanced ingame-console functionality
- added persistence (constructions wont get lost on save- & loading)

v0.1
- basic functionality
- construct and deconstruct buildings
- mock-api 

#### TODO
- undo / redo last n entities (partially done)
- add production cost for items
- add usable items
- add feature to enable or disable debug output for mod
- add feature to gather resources, money, food, water, etc. 
- research - how could npcs use / walk / circumvent constructions of the player
- define a radius or ruleset for allowing / disabling building

