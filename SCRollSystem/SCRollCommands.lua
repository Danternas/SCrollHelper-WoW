-- Namespaces
local _, SCRollSystem = ...

-- SLASH COMMANDS //
-- Register slash commands
SLASH_SCROLLSYSTEMS1, SLASH_SCROLLSYSTEMS2 = '/scroll', '/scrollsystem'; -- Define slashcommand /scroll and /scrollsystem
print("SCrollsystem - Initialisation complete (SCRollCommands.lua)") -- Troubleshooting

-- Handle slash commands (/scroll)
function rollcommand(msg, editBox)
  print("SCrollsystem - Local function rollcommands") -- Troubleshooting

    -- If empty then toggle the Ui and end the function
    if msg == "" then 
        print("SCrollsystem - Empty message recognised") -- Troubleshooting
        SCRollSystem.ToggleUi ();
        return
        -- Else make a roll
    -- elseif string.find( msg:lower(), "(%d*)[dD](%d+)([+-]?)(%d*)" ) then
    elseif string.find( msg:lower(), "(%d*)" ) then
        local sides = msg:lower();
        local dices = 1
        print("SCrollsystem - Roll recognised! ", "Dices:", dices,"Sides:", sides,"Command:", msg) -- Troubleshooting
        SCRollSystem.CallRoll (dices,sides)
    else
        print("Scrollsystem - Error: Cannot recognise command") -- Troubleshooting
    end
end

-- add /rollcommand to command list
SlashCmdList.SCROLLSYSTEMS = rollcommand; 