<img src="/Data/Docs/architect.png">  

# Kingdom Come Deliverance Modifcation - Architect
 
A base-building / sandboxing modification for kingdom come deliverance.

This modification aims to add base-building / sandboxing mechanics to the existing game - no new save required.

Constructions are also persistent across your save sates.

## Installation
Download the latest release, unzip the archive into your `KingdomComeDeliverance\mods`-folder 

## Usage / Keys
Execute builder_help in the ingame console for additional help.

Choose the next construction (from 0 to 251)
Button: MouseWheel up

Choose the previous construction (from 0 to 251)
Button: MouseWheel down

Create construction
Button: Middle mouse button

Remove construction
Button: Mouse 5 (the previous side-button on the mouse)

## Technical
### Console commands
- 

### Lua functions
- #reloadall() - Reloads the source files of the modification
- #deleteall() - Deletes ALL constructions youve build
- #showall()   - Lists all constructions to the tale
- #deleteAt(index)() - Delete the construction with the number "index" (use #showall())

### HowTo
Change default key-bindings
- The `keybinds.cfg` file contains all keybindings used in the project - change it to a key or a controller button as you like.

### Changelog
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

