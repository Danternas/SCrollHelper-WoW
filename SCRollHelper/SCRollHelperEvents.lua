-- Module to catch events and process them

-- Namespaces
local _, SCRollHelper = ...;

SCRollHelper.bonuses = 0;

-- Event to catch rolls
local frame=CreateFrame("Frame");-- Need a frame to capture events
frame:RegisterEvent("CHAT_MSG_SYSTEM");-- Register our event
frame:SetScript("OnEvent",function(self,event,msg)-- OnEvent handler receives event triggers
    if event=="CHAT_MSG_SYSTEM" and string.find(msg,"%w+%srolls%s%d+%s%(%d+-%d+%)") ~= nil then -- Check if correct format. System message in the form of "name rolls X (Y-Z)"
        SCRollHelper.processRollMessage (msg)
    end
end);

-- Function to turn the raw system roll message into data we can handle
function SCRollHelper.processRollMessage (msg)
    msg = string.gsub(msg,"%s%(%d+-%d+%)","") -- Cut out the back part
    print (msg)
    msg = string.gsub(msg,"%srolls%s","") -- Cut out the middle part
    print (msg)
    for i in string.gmatch(msg,"%a+") do player = i  end -- Should be player name
    for i in string.gmatch(msg,"%d+") do rollvalue = i  end -- Should be the roll value

    SCRollHelper.UIError( "Eventcatcher:" .. rollvalue .. " " .. SCRollHelper.bonuses); -- Troubleshooting

    --Check if the own character made the roll
    if player == UnitName("player") then
        SCRollHelper.MessageRoll (tonumber(rollvalue)) -- Post a message with the result
    end

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

-- Function to turn the roll data into a message for the player
function SCRollHelper.MessageRoll (rollvalue)
    SCRollHelper.UIError("Starting function MessageRoll with value " .. rollvalue); -- Troubleshooting
    SCRollHelper.UIError("Bonus is " .. SCRollHelper.bonuses); -- Troubleshooting

    if SCRollHelper.bonuses <= 0 then
        negpos = "" -- If negative
    else
        negpos = "+" -- If positive
    end

    -- Assemble and print the string
    local strSend = "SCroll: You have rolled: " .. (SCRollHelper.bonuses+rollvalue) .. " " .. "(" .. -- row 1/2
        SCRollHelper.dices .. "-" .. SCRollHelper.sides .. ")" .. negpos .. SCRollHelper.bonuses; -- row 2/2
    print (strSend)

    -- local index = GetChannelName("Raid") -- It finds General is a channel at index 1
    -- if (index~=nil) then 
    --     SendChatMessage(strSend , "RAID", nil, index); 
    -- else
    --     index = GetChannelName("Party") -- It finds General is a channel at index 1
    --     if (index~=nil) then 
    --         SendChatMessage(strSend , "PARTY", nil, index); 
    --     end
    -- end
end