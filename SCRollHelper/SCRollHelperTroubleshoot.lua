-- Helper module for troubleshooting
-- Planned to be enabled through alpha, disabled throug beta and removed in release

-- Namespaces
local _, SCRollHelper = ...;

troubleshootingEnabled = true; -- True if troubleshooting is enabled

if troubleshootingEnabled ==  true then
    -- helper function to throw errors.
    function SCRollHelper.UIError( msg )
        print(msg);
    end
end