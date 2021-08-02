-- Module to catch events and process them

-- Namespaces
local _, SCRollHelper = ...;

-- Event frame to catch rolls for processing
local eventFrame=CreateFrame("Frame");-- Need a frame to capture events
eventFrame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
eventFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
eventFrame:RegisterEvent("CHAT_MSG_SYSTEM"); -- Fired whenever there is a system message

-- OnEvent function for CHAT_MSG_SYSTEM (Catching System Messages)
eventFrame:SetScript("OnEvent",function(self,event,msg)-- OnEvent handler receives event triggers
    if event == "CHAT_MSG_SYSTEM" and string.find(msg,"%w+%srolls%s%d+%s%(%d+-%d+%)") ~= nil then -- Check if correct format. System message in the form of "name rolls X (Y-Z)"
        SCRollHelper.processRollMessage (msg)
    end

    if event == "ADDON_LOADED" and msg == "SCRollHelper" then -- On login
        SCrollHelperCurrentDB = SCrollHelperDB or {RollRow={},Settings={}}; -- Load SavedVariables into Database, or create a new Database
    end

    if event == "PLAYER_LOGOUT" then -- On player logout
        SCrollHelperCurrentDB["RollRow"] = SCRollHelper.CleanNils(SCrollHelperCurrentDB["RollRow"]); -- Clean the database before logout
        SCrollHelperDB = SCrollHelperCurrentDB; -- Save the Database into SavedVariables
    end

end);

--SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollHelperEvents.lua)"); -- Troubleshooting