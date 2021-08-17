-- Main module

-- Namespace
local _, SCRollHelper = ...;
SCRollHelper.globalRolling = false;

-- Some basics
SCrollHelperCurrentDB = {}; -- Initalise main database
troubleshootingEnabled = false; -- True if troubleshooting is enabled

-- helper function to throw errors.
function SCRollHelper.UIError( msg )
    if troubleshootingEnabled ==  true then
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

-- Function to turn yBtnOffset into a relative position
function SCRollHelper.detrowpos (yBtnOffset)
    rowpos = ((yBtnOffset * -1)-20)/30; -- Multiply by -1 to turn positive, remove 20 and then get what multiple by 30 it is.
    return rowpos
end

-- Function to call on creating the saved Ui
function SCRollHelper.loadSavedVariables ()

    SCRollHelper.UIError("SCRollHelper.loadSavedVariable - Loading SavedVariables for Ui creation"); -- Troubleshooting

    for _, i in ipairs(SCrollHelperCurrentDB["RollRow"]) do -- Iterate the Database
        incDices, incSides, incBonuses, incName = unpack(i);

        SCRollHelper.UIError("SCRollHelper.loadSavedVariable - Found: " .. incDices .. incSides .. incBonuses .. incName);

        SCRollHelper.setupNewRow (incDices,incSides,incBonuses,incName,true)
    end
end

SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollHelperInit.lua)"); -- Troubleshooting

