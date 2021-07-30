-- Rolling module

-- Namespaces
local _, SCRollSystem = ...

-- helper function to throw errors.
local function UIError( msg )
    print(msg);
end

-- bonuses is a shared variable
bonuses = 0;

UIError("SCrollsystem - Initialisation complete (SCRollRoll.lua)"); -- Troubleshooting

-- Function to call a server roll
function SCRollSystem.CallRoll (dices,sides,bonuses)

    local dices = tonumber(dices);
    local sides = tonumber(sides);
    bonuses = tonumber(bonuses);

    if tonumber(dices) == nil or tonumber(sides) == nil then
        return UIError( "You've entered a non-number character!" ); 
    end

    if tonumber(bonuses) == nil then
        bonuses = 0; 
    end

    UIError("Starting function CallRoll with " .. dices .. " " .. sides); -- Troubleshooting
  
    -- Check dice numbers
    if dices == 0   then    return UIError( "You must have at least one die." );            end
    if dices > 10   then    return UIError( "You can only roll 10 dice at a time." );       end
    if sides < 2    then    return UIError( "Must have at least two sides." );              end
    if sides > 1000 then    return UIError( "Dice cannot have more than 1000 sides." );     end
    UIError("Dice check done!"); -- Troubleshooting


    -- Get roll(s) from server
    for i = 1, dices do RandomRoll( 1, sides );    	
    UIError("Roll:" .. i); -- Troubleshooting
    UIError("Sides:" .. sides); -- Troubleshooting



    i = i + 1; -- Counter
    end
end

function SCRollSystem.MessageRoll (rollvalue,player)
    UIError("Starting function MessageRoll with value " .. rollvalue); -- Troubleshooting
    UIError("Bonus is " .. bonuses); -- Troubleshooting

    local strSend = "SCroll: " .. player .. " rolls " .. (bonuses+rollvalue);
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

-- Event to catch rolls
local frame=CreateFrame("Frame");-- Need a frame to capture events
frame:RegisterEvent("CHAT_MSG_SYSTEM");-- Register our event
frame:SetScript("OnEvent",function(self,event,msg)-- OnEvent handler receives event triggers
    if event=="CHAT_MSG_SYSTEM" and string.find(msg,"%w+%srolls%s%d+%s%(%d+-%d+%)") ~= nil then -- Check if correct format. System message in the form of "name rolls X (Y-Z)"
      msg = string.gsub(msg,"%s%(%d+-%d+%)","") -- Cut out the back part
      print (msg)
      msg = string.gsub(msg,"%srolls%s","") -- Cut out the middle part
      print (msg)
      for i in string.gmatch(msg,"%a+") do player = i  end
      for i in string.gmatch(msg,"%d+") do rollvalue = i  end

      SCRollSystem.MessageRoll (tonumber(rollvalue),player) -- Post a message with these results
    end
end);
