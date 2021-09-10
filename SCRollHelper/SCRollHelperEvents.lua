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
    -- Check if correct format. System message in the form of "name rolls X (Y-Z)". ALso check if rolling is going on.

    SCRollHelper.UIError("SCRollHelper (SCRollHelperEvents.lua) - Event detected "); -- Troubleshooting

    if event == "CHAT_MSG_SYSTEM" and string.find(msg,"%srolls%s%d+%s%(%d+-%d+%)") ~= nil and SCRollHelper.globalRolling == true then

        SCRollHelper.UIError("SCRollHelper (SCRollHelperEvents.lua) - System message detected and filtered with msg = " .. msg); -- Troubleshooting

        SCRollHelper.processRollMessage (msg)
        SCRollHelper.globalRolling = false; -- Set rolling to false (not going on)
    end

    if event == "ADDON_LOADED" and msg == "SCRollHelper" then -- On login
        SCRollHelper.UIError("SCRollHelper (SCRollHelperEvents.lua) - ADDON_LOADED detected, calling function to load or create database."); -- Troubleshooting

        -- Call function to load the saved variables
        SCRollHelper.loadSavedVariables ()
        
    end

    if event == "PLAYER_LOGOUT" then -- On player logout
        SCrollHelperCurrentDB["RollRow"] = SCRollHelper.CleanNils(SCrollHelperCurrentDB["RollRow"]); -- Clean the database before logout
        SCrollHelperDB = SCrollHelperCurrentDB; -- Save the Database into SavedVariables
    end

end);

--SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollHelperEvents.lua)"); -- Troubleshooting