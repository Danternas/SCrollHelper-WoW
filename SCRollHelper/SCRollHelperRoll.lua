-- Module to generate rolls

-- Namespaces
local _, SCRollHelper = ...;

SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollRoll.lua)"); -- Troubleshooting

--Make common variables dices, sides and bonuses
commonDices = 0;
commonSides = 0;
commonBonuses = 0;
commonName = "";

-- Function to call a server roll
function SCRollHelper.CallRoll (incDices,incSides,incBonuses,incName)
  
    -- Check dice numbers
    if incDices == 0   then    return SCRollHelper.UIError( "You must have at least one die." );            end
    if incDices > 10   then    return SCRollHelper.UIError( "You can only roll 10 dice at a time." );       end
    if incSides < 2    then    return SCRollHelper.UIError( "Must have at least two sides." );              end
    if incSides > 1000 then    return SCRollHelper.UIError( "Dice cannot have more than 1000 sides." );     end
    SCRollHelper.UIError("Dice check done!"); -- Troubleshooting

    -- Set the common values
    commonDices = incDices;
    commonSides = incSides;
    commonBonuses = incBonuses;
    commonName = incName;

    -- Get roll(s) from server
    for i = 1, incDices do RandomRoll( 1, incSides);    	
    SCRollHelper.UIError("Roll:" .. i); -- Troubleshooting
    SCRollHelper.UIError("Sides:" .. incSides); -- Troubleshooting

    i = i + 1; -- Counter
    end
end

-- Function to turn the raw system roll message into data we can handle
function SCRollHelper.processRollMessage (msg)
    msg = string.gsub(msg,"%s%(%d+-%d+%)","") -- Cut out the back part
    SCRollHelper.UIError (msg); -- Troubleshooting
    msg = string.gsub(msg,"%srolls%s","") -- Cut out the middle part
    SCRollHelper.UIError (msg);  -- Troubleshooting
    for i in string.gmatch(msg,"%a+") do player = i  end -- Should be player name
    for i in string.gmatch(msg,"%d+") do rollvalue = i  end -- Should be the roll value

    SCRollHelper.UIError( "Eventcatcher:" .. rollvalue .. " " .. commonBonuses); -- Troubleshooting

    --Check if the own character made the roll
    if player == UnitName("player") then
        SCRollHelper.MessageRoll (tonumber(rollvalue)) -- Post a message with the result
    end

end

-- Function to turn the roll data into a message for the player
function SCRollHelper.MessageRoll (rollvalue)
    SCRollHelper.UIError("Starting function MessageRoll with value " .. rollvalue); -- Troubleshooting
    SCRollHelper.UIError("Bonus is " .. commonBonuses); -- Troubleshooting

    -- Set if a + or - should be used depending on if the number is negative or positive
    if commonBonuses >= 0 then
        negpos = "+" -- If positive
    else
        negpos = "" -- If negative
    end

    -- Assemble and print the string
    local strSend = commonName .. " roll of: " .. (commonBonuses+rollvalue) .. " " .. "(" -- row 1/2
        .. commonDices .."-" .. commonSides .. ")" .. negpos .. commonBonuses; -- row 2/2
    print (strSend)
end

-- Experimental function to unpack msg word by word (Does not work)
function SCRollHelper.ProcessSystemMessage (msg)
    local args = {}; -- what will be iterated over
    for _, arg in pairs({string.split(" ", msg) }) do -- find all the words split by a space
        if (#arg > 0) then -- if the string is longer than 0, if the string contains an actual word/value.
            table.insert(args, arg); -- insert arg into args
        end
    end

    for id, arg in ipairs(args) do
        print ("arg is ",arg)
    end

end


