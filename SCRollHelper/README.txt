## Interface: 90100
## Title: Shadow Crescent Roll Helper
## Notes: A simple addon to aid in rolling. Designed primarily for roleplaying events.
## Author: Danternas (Thomas Johansson); Copyright (c) 2021 Danternas (See LICENCE.txt)
## Version: 0.6 Alpha
## DefaultState: enabled
## SavedVariablesPerCharacter: SCrollHelperDB
# Contact: dev.danternas@gmail.com

#What is this?
#A very simple add-on to streamline rolls commonly used for roleplaying. You can set up to 20 custom rolls with names and modifiers which will be easily accessible in a menu.

# How to use:
#Use /scroll or /scrollhelper to toggle the menu. 
#Use the checkboxes to choose what rows to save for next login.
#The addon will call a roll with Name, X-Y and the use Z as a modifier. The results will be given to you in the main chat window.

#Change notes
#- Fixed bug where letter with apostrophes (like: á) will make the addon not recognize that the correct character has rolled.
#- You can now add a global bonus that applies to all rolls.
#- Longer character limit on the roll names.
#- Addon should discover if the database is old or faulty and reset the addon (from previous alphas).
#- Version number visible in addon window's title.

#Files:
SCRollHelperInit.lua
SCRollHelperUi.lua
SCRollHelperRoll.lua
SCRollHelperCommands.lua
SCRollHelperEvents.lua