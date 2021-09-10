-- Main module

-- Namespaces and global variables
local _, SCRollHelper = ...;
SCRollHelper.globalRolling = false;
SCRollHelper.globalBonusesValue = 0;

-- Some basics
SCrollHelperCurrentDB = {}; -- Initalise main database
troubleshootingEnabled = true; -- "true"" if troubleshooting is enabled

-- helper function to throw errors.
function SCRollHelper.UIError( msg )
    if troubleshootingEnabled ==  false then
        print(msg);
    end
end

-- Function to clean out nil values from an array
function SCRollHelper.CleanNils(array)
    local sorted = {} -- Make a temporary array
    for _,i in pairs(array) do  -- Iterate the Database
        sorted[ #sorted+1 ] = i -- Add non-nil items
    end
    return sorted -- Return the sorted array
end

-- Function to load in all the saved variables
function SCRollHelper.loadSavedVariables ()

    -- Copy SavedVariables into Database, or create a new Database if one doesn't exist.
    SCrollHelperCurrentDB = SCrollHelperDB or {RollRow={},Settings={},GlobalBonus=0,CurrentVersion="v0.6 Alpha"};

    -- Load global roll bonus, or set it to 0
    SCRollHelper.globalBonusesValue = SCrollHelperCurrentDB["GlobalBonus"] or 0;

    -- Check version - If version data doesn't exist then wipe the database (For version 0.6)
    if SCrollHelperCurrentDB["CurrentVersion"] ~= "v0.6 Alpha" then
        SendSystemMessage("SCRollHelper - Database error or old database -> Resetting the addon's SavedVariables."); 
        SCrollHelperCurrentDB = {RollRow={},Settings={},GlobalBonus=0,CurrentVersion="v0.6 Alpha"} -- Make a new working database
    end

    -- Load the current version
    SCRollHelper.CurrentVersion = SCrollHelperCurrentDB["CurrentVersion"];

    SCRollHelper.UIError("SCRollHelper (SCRollHelperInit.lua) - Savedvariables loaded. globalBonusesValue is " .. SCRollHelper.globalBonusesValue);

end

SCRollHelper.UIError("SCRollHelper (SCRollHelperInit.lua) - Initialisation complete "); -- Troubleshooting

