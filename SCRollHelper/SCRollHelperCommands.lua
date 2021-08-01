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
        -- Else make a roll
    -- elseif string.find( msg:lower(), "(%d*)[dD](%d+)([+-]?)(%d*)" ) then
    elseif string.find( msg:lower(), "(%d*)" ) then
        local sides = msg:lower();
        local dices = 1
        SCRollHelper.UIError("SCRollHelper - Roll recognised! " .. " Dices:" .. dices .. " Sides:" .. sides .. " Command:" .. msg); -- Troubleshooting
        SCRollHelper.CallRoll (dices,sides)
    else
        SCRollHelper.UIError("SCRollHelper - Error: Cannot recognise command"); -- Troubleshooting
    end
end

-- add /rollcommand to command list
SlashCmdList.SCROLLHELPER = rollcommand; 

SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollHelperCommands.lua)"); -- Troubleshooting