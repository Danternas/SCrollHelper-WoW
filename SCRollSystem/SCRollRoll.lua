-- Namespaces
local _, SCRollSystem = ...

print("SCrollsystem - Initialisation complete (SCRollRoll.lua)")

-- Function to call a server roll
function SCRollSystem.CallRoll (dices,sides)

    local dices = tonumber(dices) or 0;
    local sides = tonumber(sides) or 0;

    print("Starting function CallRoll", dices, sides) -- Troubleshooting
  
    -- Check dice numbers
    if dices == 0   then    return UIError( "You must have at least one die." );            end
    if dices > 10   then    return UIError( "You can only roll 10 dice at a time." );       end
    if sides < 2    then    return UIError( "Must have at least two sides." );              end
    if sides > 1000 then    return UIError( "Dice cannot have more than 1000 sides." );     end
    print("Dice check done!") -- Troubleshooting


    -- Get roll(s) from server
    for i = 1, dices do RandomRoll( 1, sides );    	
    i = i + 1;
    print("Roll:", i) -- Troubleshooting
    print("Sides:", sides) -- Troubleshooting
    
    end
end