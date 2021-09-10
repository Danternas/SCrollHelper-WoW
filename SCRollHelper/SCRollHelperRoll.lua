-- Module to generate rolls

-- Namespaces
local _, SCRollHelper = ...;

SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollRoll.lua)"); -- Troubleshooting

--Make common variables dices, sides and bonuses
commonDices = 0;
commonSides = 0;
commonBonuses = 0;
commonGlobalBonuses = 0;
commonName = "";

-- Function to call a server roll
function SCRollHelper.CallRoll (incDices,incSides,incBonuses,incGlobalBonuses,incName)
  
    -- Check dice numbers
    if incDices == 0   then    return SendSystemMessage( "SCRollHelper - You must have at least one die." );            end
    if incDices > 1   then    return SendSystemMessage( "SCRollHelper - You can only roll 1 dice at the moment. Work in progress." );       end
    if incSides < 2    then    return SendSystemMessage( "SCRollHelper - Must have at least two sides." );              end
    if incSides > 1000 then    return SendSystemMessage( "SCRollHelper - Dice cannot have more than 1000 sides." );     end
    if incBonuses > 1000 then    return SendSystemMessage( "SCRollHelper - You can't add more than 1000 as a bonus." );     end
    if incGlobalBonuses > 1000 then    return SendSystemMessage( "SCRollHelper - You can't add more than 1000 as a bonus." );     end
    SCRollHelper.UIError("Dice check done!"); -- Troubleshooting

    -- Set the common values
    commonDices = incDices;
    commonSides = incSides;
    commonBonuses = incBonuses;
    commonName = incName;
    commonGlobalBonuses = incGlobalBonuses;

    -- Set that rolling is going on so events knows doesn't discard the roll
    SCRollHelper.globalRolling = true;

    -- Get roll(s) from server
    for i = 1, incDices do RandomRoll( 1, incSides);    	
    SCRollHelper.UIError("Roll:" .. i); -- Troubleshooting
    SCRollHelper.UIError("Sides:" .. incSides); -- Troubleshooting

    i = i + 1; -- Counter
    end
end

-- Function to turn the raw system roll message into data we can handle
function SCRollHelper.processRollMessage (msg)
    SCRollHelper.UIError ("SCRollHelper (SCRollHelperRoll.lua//SCRollHelper.processRollMessage) - Incomming roll process call. msg = " .. msg); -- Troubleshooting
    msg = string.gsub(msg,"%s%(%d+-%d+%)","") -- Cut out the back part
    SCRollHelper.UIError ("SCRollHelper (SCRollHelperRoll.lua//SCRollHelper.processRollMessage) - Processing... " .. msg); -- Troubleshooting
    msg = string.gsub(msg,"%srolls%s","") -- Cut out the middle part
    SCRollHelper.UIError ("SCRollHelper (SCRollHelperRoll.lua//SCRollHelper.processRollMessage) - Processing... " .. msg); -- Troubleshooting

    for i in string.gmatch(msg,"%d+") do rollvalue = i  end -- Remaining number should be the roll value
    msg = string.gsub(msg,"%d+","") -- Cut out the number
    SCRollHelper.UIError ("SCRollHelper (SCRollHelperRoll.lua//SCRollHelper.processRollMessage) - rollvalue extracted: " .. rollvalue); -- Troubleshooting

    player = msg -- Remainder should be player name
    SCRollHelper.UIError ("SCRollHelper (SCRollHelperRoll.lua//SCRollHelper.processRollMessage) - player|msg extracted: " .. player .. "|" .. msg); -- Troubleshooting

    SCRollHelper.UIError( "Eventcatcher:" .. rollvalue .. " " .. commonBonuses); -- Troubleshooting

    --Check if the own character made the roll
    if player == UnitName("player") then
        SCRollHelper.MessageRoll (tonumber(rollvalue)) -- Post a message with the result
    end

end

-- Function to return + or - depending on if the number is negative or positive
function negposCheck (incValue) 
    if incValue >= 0 then
        return "+" -- If positive
    else
        return "" -- If negative
    end
end

-- Function to turn the roll data into a message for the player
function SCRollHelper.MessageRoll (rollvalue)
    SCRollHelper.UIError("Starting function MessageRoll with value " .. rollvalue); -- Troubleshooting
    SCRollHelper.UIError("Bonus is " .. commonBonuses); -- Troubleshooting

    -- Check if the values are negative or positive
    negposBonus = negposCheck (commonBonuses);
    negposBonusGlobal = negposCheck (commonGlobalBonuses);

    -- Assemble and print the string
    local strSend = "SCRollHelper - " .. commonName .. " rolls: " .. (rollvalue+commonBonuses+commonGlobalBonuses) .. " " .. "(" .. commonDices .. "D" -- row 1/2
        .. commonSides .. negposBonus .. commonBonuses .. negposBonusGlobal .. commonGlobalBonuses .. ")"; -- row 2/2
    SendSystemMessage(strSend);
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


