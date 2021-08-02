-- Ui module

-- Namespaces
local _, SCRollHelper = ...;
SCRollHelper.MakeUi = {};
local MakeUi = SCRollHelper.MakeUi;
local UIConfig;

-- Common variables
local newrollrowY = -50;
local mainframeYsize = 80;

-- Function to check the values put into the editboxes
function SCRollHelper.chkInputValues (incdices,incsides,incbonuses)

    SCRollHelper.UIError("SCRollHelper.chkInputValues - Checking incdices: ".. incdices .. " incsides ".. incsides.. " incbonuses " .. incbonuses); -- Troubleshooting

    -- Force the input intop numbers. Any invalid input will result in nil
    local outdices = tonumber(incdices);
    local outsides = tonumber(incsides);
    local outbonuses = tonumber(incbonuses);

    -- Check and set the dices, sides and bonus numbers for a nil value. Throw an error if there is one.
    if outdices == nil or outsides == nil or outbonuses == nil then
        print ("You've entered a non-number character as a dice!"); 
        print ("Number of dices: " .. (outdices or "Not a valid number!"))
        print ("Sides of the dices: " .. (outsides or "Not a valid number!"))
        print ("Modifier: " .. (outbonuses or "Not a valid number!"))
        return outdices, outsides, outbonuses, false -- Abort the check and return false, meaning the check didn't pass
    end

    SCRollHelper.UIError("SCRollHelper.chkInputValues - Check done and returning outdices " .. outdices .. " outsides " .. outsides .. " outbonuses " .. outbonuses); -- Troubleshooting

    return outdices, outsides, outbonuses, true
end

-- Function to toggle the Ui visible or not. If no Ui then create one.
function MakeUi:ToggleUi ()
    SCRollHelper.UIError("Toggle function - Toggling ui.");  -- Troubleshooting
    local menu = UIConfig or MakeUi:CreateMenu();
    SCMainFrm:SetShown(not menu:IsShown());
end

-- Function to make the Ui
function MakeUi:CreateMenu()

    -- If the Database lack a point for the main frame then fill that in
    if SCrollHelperCurrentDB["Settings"]["MainFramePoint"] == nil then
        SCrollHelperCurrentDB["Settings"]["MainFramePoint"] = {"CENTER", nil, "CENTER", 0, 0};
    end

    -- Setup the UI frame
    UIConfig = CreateFrame("Frame", "SCMainFrm", UIParent, "UIPanelDialogTemplate"); -- BasicFrameTemplateWithInset/UIPanelDialogTemplate
    UIConfig:SetPoint(unpack(SCrollHelperCurrentDB["Settings"]["MainFramePoint"]));
    UIConfig:SetSize(430,mainframeYsize);
    UIConfig:SetMovable(true);
    UIConfig:EnableMouse(true);
    UIConfig:SetFrameStrata("HIGH")
    UIConfig:RegisterForDrag("LeftButton");
    UIConfig:SetScript("OnDragStart", UIConfig.StartMoving);
    --UIConfig:SetScript("OnDragStop", UIConfig.StopMovingOrSizing);
    UIConfig:SetScript("OnDragStop", function () -- When stopping to drag the frame
        UIConfig:StopMovingOrSizing();
        local point, relativeTo, relativePoint, xOfs, yOf = UIConfig:GetPoint(); -- Get the position.
        SCrollHelperCurrentDB["Settings"]["MainFramePoint"] = {point, relativeTo, relativePoint, xOfs, yOf};
    end);

    -- Frames and regions
    UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY", "UIPanelDialogTemplate");
    UIConfig.title:ClearAllPoints ();
    UIConfig.title:SetFontObject("GameFontHighlight");
    UIConfig.title:SetPoint("CENTER", SCMainFrmTitleBG, "CENTER", 0, 1); -- UIConfig.title:SetPoint("CENTER", UIConfig.TitleBg, "CENTER", 0, 55);
    UIConfig.title:SetText("Shadow Crescent Roll Helper");

    -- Close button
    local close = CreateFrame("Button", "MainUiclose", f, "UIPanelCloseButton")

    -- Make a button for making more rows of buttons and boxes!
    newrowbtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    newrowbtn:SetPoint("CENTER", UIConfig, "TOP", 0, -50);
    newrowbtn:SetSize(362, 20);
    newrowbtn:SetText("Create row");
    newrowbtn:SetNormalFontObject("GameFontNormalLarge");
    newrowbtn:SetHighlightFontObject("GameFontHighlightLarge");
    newrowbtn:SetScript("OnClick", function() -- When clicked
            SCRollHelper.setupNewRow (1,100,0,"Unnamed",false) -- Call the function to set up a new row of buttons (values: 1-100+0 Unnamed)
    end);

    -- Load the saved Ui
    SCRollHelper.loadSavedVariables ()

    -- Make a first button and input boxes using the fancy function MakeUi:CreateRow (value is the distance of the row from the top)
    -- SCRollHelper.setupNewRow (1,100,0,"Unnamed",false)

    UIConfig:Hide(); -- Start hidden
    return UIConfig; -- Return

end

-- Function to create a row of inputboxes and a button to roll them
function MakeUi:CreateRow (yBtnOffset, diceValue, sidesValue, bonusesValue, nameOfRoll,checked)

    -- Make the objects //
    -- Make the roll button
    local rollbtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    rollbtn:SetPoint("CENTER", UIConfig, "TOP", 140, yBtnOffset);
    rollbtn:SetSize(80, 22);
    rollbtn:SetText("Roll!");
    rollbtn:SetNormalFontObject("GameFontNormalLarge");
    rollbtn:SetHighlightFontObject("GameFontHighlightLarge");

    -- Make the checkbutton
    local associatedCB = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate");
    associatedCB:SetText ("Testaaaaaaaaaaaaaaaa");
    associatedCB:SetPoint("CENTER", UIConfig, "TOP", -195, yBtnOffset);
    associatedCB:SetSize(22, 22);
    associatedCB:SetChecked(checked); -- Sets if the box is checked to the input value checked

    -- Make box1 (dice)
    local associatedBox1 = CreateFrame("EditBox", nil, UIConfig, "InputBoxTemplate");
    associatedBox1:SetPoint("CENTER", UIConfig, "TOP", 0, yBtnOffset);
    associatedBox1:SetSize(30, 16);
	associatedBox1:SetMaxLetters(2);
    associatedBox1:SetAutoFocus(false);
    associatedBox1:SetText(diceValue);

    -- Make box1 (sides)
    local associatedBox2 = CreateFrame("EditBox", nil, UIConfig, "InputBoxTemplate");
    associatedBox2:SetPoint("CENTER", UIConfig, "TOP", 40, yBtnOffset);
    associatedBox2:SetSize(30, 16);
    associatedBox2:SetMaxLetters(4);
    associatedBox2:SetAutoFocus(false);
    associatedBox2:SetText(sidesValue);

    -- Make box (bonuses)
    local associatedBox3 = CreateFrame("EditBox", nil, UIConfig, "InputBoxTemplate");
    associatedBox3:SetPoint("CENTER", UIConfig, "TOP", 80, yBtnOffset);
    associatedBox3:SetSize(30, 16);
    associatedBox3:SetMaxLetters(3);
    associatedBox3:SetAutoFocus(false);
    associatedBox3:SetText(bonusesValue);

    -- Make box (name)
    local associatedBoxName = CreateFrame("EditBox", nil, UIConfig, "InputBoxTemplate");
    associatedBoxName:SetPoint("CENTER", UIConfig, "TOP", -100, yBtnOffset);
    associatedBoxName:SetSize(150, 16);
    associatedBoxName:SetMaxLetters(20);
    associatedBoxName:SetAutoFocus(false);
    associatedBoxName:SetText(nameOfRoll);

    -- Set up scrips for the objects//
    -- Set up the roll button's script
    rollbtn:SetScript("OnClick", function() -- When clicked
        
        -- Get the values from the input boxes, or 0.
        local diceValue = associatedBox1:GetText() or 0;
        local sidesValue = associatedBox2:GetText() or 0;
        local bonusesValue = associatedBox3:GetText() or 0;
        local nameOfRoll = associatedBoxName:GetText() or "Custom Roll";

        SCRollHelper.UIError("BOTTONCLICK! Attack with dice " .. diceValue .. " sides " .. sidesValue .. " bonuses " .. bonusesValue); -- Troubleshooting

        -- Use the function to check the values for input errors. chkclr = true means no issues
        diceValue, sidesValue, bonusesValue, chkclr = SCRollHelper.chkInputValues (diceValue,sidesValue,bonusesValue);
        if chkclr == true then -- Only call the roll if the check was clear
            SCRollHelper.rollName = nameOfRoll; -- Set the global variable for the name of the roll
            SCRollHelper.CallRoll(diceValue,sidesValue,bonusesValue,nameOfRoll) -- Call a roll with the values
        end
    end);

    -- Set up the CheckButton's script
    associatedCB:SetScript("OnClick", function()
        if associatedCB:GetChecked () == true then 
            SCRollHelper.UIError ("Checked button!"); -- Troubleshooting

            -- Get the values from the input boxes, or 0.
            local diceValue = associatedBox1:GetText() or 0;
            local sidesValue = associatedBox2:GetText() or 0;
            local bonusesValue = associatedBox3:GetText() or 0;
            local nameOfRoll = associatedBoxName:GetText() or "Unnamed";

            -- Use the function to check the values for input errors. chkclr = true means no issues
            diceValue, sidesValue, bonusesValue, chkclr = SCRollHelper.chkInputValues (diceValue,sidesValue,bonusesValue);
            if chkclr == true then -- Only save the roll if the check was clear 
                

                rowpos = SCRollHelper.detrowpos (yBtnOffset); -- Get the relative position
                SCRollHelper.UIError("Saving rowpos: " .. rowpos .. " At offset: " .. yBtnOffset); -- Troubleshooting

                SCrollHelperCurrentDB["RollRow"][rowpos] = {diceValue,sidesValue,bonusesValue,nameOfRoll}; -- Save row to Database
            end
        else
            rowpos = SCRollHelper.detrowpos (yBtnOffset); -- Get the relative position
            SCRollHelper.UIError("Removing rowpos: " .. rowpos .. " At offset: " .. yBtnOffset); -- Troubleshooting

            SCrollHelperCurrentDB["RollRow"][rowpos] = nil; -- Remove row from Database
        end
    end);

    -- Set up the script for the editbox1
    associatedBox1:SetScript ("OnEditFocusGained", function()
        if associatedCB:GetChecked() == true then -- If the button is checked...
            associatedCB:Click(); -- ... uncheck it.
        end
        SCRollHelper.UIError("Focus lost! - Box2"); -- Troubleshooting
    end);
    associatedBox1:SetScript ("OnTabPressed", function()
        associatedBox2:SetFocus();
    end);
    
    -- Set up the script for the editbox2
    associatedBox2:SetScript ("OnEditFocusGained", function()
        if associatedCB:GetChecked() == true then -- If the button is checked...
            associatedCB:Click(); -- ... uncheck it.
        end
        SCRollHelper.UIError("Focus lost! - Box2"); -- Troubleshooting
    end);
    associatedBox2:SetScript ("OnTabPressed", function()
        associatedBox3:SetFocus();
    end);

    -- Set up the script for the editbox3
    associatedBox3:SetScript ("OnEditFocusGained", function()
        if associatedCB:GetChecked() == true then -- If the button is checked...
            associatedCB:Click(); -- ... uncheck it.
        end
        SCRollHelper.UIError("Focus lost! - Box3"); -- Troubleshooting
    end);

    -- Set up the script for the namebox
    associatedBoxName:SetScript ("OnEditFocusGained", function()
        if associatedCB:GetChecked() == true then -- If the button is checked...
            associatedCB:Click(); -- ... uncheck it.
        end
        SCRollHelper.UIError("Focus lost! - Namebox"); -- Troubleshooting
    end);
    associatedBoxName:SetScript ("OnTabPressed", function()
        associatedBox1:SetFocus();
    end);
end

-- Function to set up creating a new row
function SCRollHelper.setupNewRow (dices,sides,bonuses,rollName,checked)
    if newrollrowY >= -640 then -- Ensure there cannot be more than 20 rows created

        -- Expand the main frame
        SCRollHelper.UIError("Expanding main frame size to: " .. mainframeYsize); -- Troubleshooting
        mainframeYsize = mainframeYsize + 30 -- Increase the Y-size for the main frame
        UIConfig:SetHeight(mainframeYsize); -- Increase the window size to adjust

        -- Make the new row
        SCRollHelper.UIError("Adding new row with newrollrowY: " .. newrollrowY); -- Troubleshooting
        newrowbtn:SetPoint("CENTER", UIConfig, "TOP", 0, newrollrowY-30); -- Update position of this button
        MakeUi:CreateRow (newrollrowY,dices,sides,bonuses,rollName,checked) -- Call function to make the new row.
        newrollrowY = newrollrowY-30; -- Increase distance to the next row by -30

    else
        newrowbtn:Disable(); -- Disable the button to make more
        return print ("You can not have more than 20 rows!")
    end
end

SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollHelperUi.lua)"); -- Troubleshooting