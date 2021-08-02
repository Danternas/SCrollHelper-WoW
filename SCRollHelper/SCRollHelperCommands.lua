-- Slash command module

-- Namespaces
local _, SCRollHelper = ...;
local MakeUi = SCRollHelper.MakeUi;

-- SLASH COMMANDS //
-- Register slash commands
SLASH_SCROLLHELPER1, SLASH_SCROLLHELPER2 = '/scroll', '/scrollhelper'; -- Define slashcommand /scroll and /SCRollHelper

-- Handle slash commands (/scroll)
function rollcommand(msg, editBox)
    SCRollHelper.UIError("SCRollHelper - Local function rollcommands"); -- Troubleshooting

    -- If empty then toggle the Ui and end the function
    if msg == "" then 
        SCRollHelper.UIError("SCRollHelper - Empty message recognised"); -- Troubleshooting
        MakeUi:ToggleUi ()
        return
    else
        SCRollHelper.UIError("SCRollHelper - Error: Cannot recognise command"); -- Troubleshooting
    end
end

-- add /rollcommand to command list
SlashCmdList.SCROLLHELPER = rollcommand; 

SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollHelperCommands.lua)"); -- Troubleshooting