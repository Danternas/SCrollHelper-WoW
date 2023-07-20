# SCrollHelper-WoW
A very simple add-on to streamline rolls commonly used for roleplaying. You can set up to 20 custom rolls with names and modifiers which will be easily accessible in a menu. This project was made with two goals in ,mind: To aid my roleplaying guild with a simple, yet functional addon, to easily perform and save rolls used within a combat system. This regardless of what the actual combat system is. Secondly, this addon was made as a learning experience in my pursuit to learn how to code and how to code using lua. Therefore, you will not see any XML or Ace3 usage, even if such would have made for a possibly better addon experience or faster development. On the other hand the use of pure lua code means the project is incredibly small and resource efficient.

USECASE README:
## Interface: 100105
## Title: Shadow Crescent Roll Helper
## Notes: A simple addon to aid in rolling. Designed primarily for roleplaying events.
## Author: Danternas (Thomas Johansson); Copyright (c) 2021 Danternas (See LICENCE.txt)
## Version: 0.6b Alpha
## DefaultState: enabled
## SavedVariablesPerCharacter: SCrollHelperDB
## X-Category: Roleplay
## X-License: MIT License
## X-Website: https://github.com/Danternas/SCrollHelper-WoW
## X-Curse-Project-ID: 510697

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