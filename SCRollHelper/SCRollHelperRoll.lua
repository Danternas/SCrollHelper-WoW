-- Module to generate rolls

-- Namespaces
local _, SCRollHelper = ...;

SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollRoll.lua)"); -- Troubleshooting

--Make global variables dices and sides
SCRollHelper.dices = 0;
SCRollHelper.sides = 0;

-- Function to call a server roll
function SCRollHelper.CallRoll (incdices,incsides,incbonuses)

    -- Force the input intop numbers. Any ninvalid input will result in nil
    SCRollHelper.dices = tonumber(incdices);
    SCRollHelper.sides = tonumber(incsides);
    SCRollHelper.bonuses = tonumber(incbonuses);

    -- Check and set the dices, sides and bonus numbers for a nil value. Throw an error if there is one.
    if SCRollHelper.dices == nil or SCRollHelper.sides == nil or SCRollHelper.bonuses == nil then
        print ("You've entered a non-number character as a dice!"); 
        print ("Number of dices: " .. (SCRollHelper.dices or "Not a valid number!"))
        print ("Sides of the dices: " .. (SCRollHelper.sides or "Not a valid number!"))
        print ("Modifier: " .. (SCRollHelper.bonuses or "Not a valid number!"))
        return
    end


    SCRollHelper.UIError("CallRoll check done with " .. SCRollHelper.dices .. " " .. SCRollHelper.sides .. " and global bonus " .. SCRollHelper.bonuses); -- Troubleshooting
  
    -- Check dice numbers
    if SCRollHelper.dices == 0   then    return SCRollHelper.UIError( "You must have at least one die." );            end
    if SCRollHelper.dices > 10   then    return SCRollHelper.UIError( "You can only roll 10 dice at a time." );       end
    if SCRollHelper.sides < 2    then    return SCRollHelper.UIError( "Must have at least two sides." );              end
    if SCRollHelper.sides > 1000 then    return SCRollHelper.UIError( "Dice cannot have more than 1000 sides." );     end
    SCRollHelper.UIError("Dice check done!"); -- Troubleshooting

    -- Get roll(s) from server
    for i = 1, SCRollHelper.dices do RandomRoll( 1, SCRollHelper.sides);    	
    SCRollHelper.UIError("Roll:" .. i); -- Troubleshooting
    SCRollHelper.UIError("Sides:" .. SCRollHelper.sides); -- Troubleshooting

    i = i + 1; -- Counter
    end
end




