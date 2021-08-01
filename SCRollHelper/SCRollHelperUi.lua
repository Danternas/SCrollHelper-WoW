-- Ui module

-- Namespaces
local _, SCRollHelper = ...;
SCRollHelper.MakeUi = {};
local MakeUi = SCRollHelper.MakeUi;
local UIConfig;

-- Variable 
newrollrowY = -240;

-- Function to toggle the Ui visible or not. If no Ui then create one.
function MakeUi:ToggleUi ()
    SCRollHelper.UIError("Toggle function - Toggling ui.");  -- Troubleshooting
    local menu = UIConfig or MakeUi:CreateMenu();
    SCRollFrame:SetShown(not menu:IsShown());
end

-- Function to make the Ui
function MakeUi:CreateMenu()

    -- Create the UI frame
    UIConfig = CreateFrame("Frame", "SCRollFrame", UIParent, "BasicFrameTemplateWithInset");
    UIConfig:SetPoint("CENTER");
    UIConfig:SetSize(400,400);
    UIConfig:SetMovable(true);
    UIConfig:EnableMouse(true);
    UIConfig:SetFrameStrata("HIGH")
    UIConfig:RegisterForDrag("LeftButton");
    UIConfig:SetScript("OnDragStart", UIConfig.StartMoving);
    UIConfig:SetScript("OnDragStop", UIConfig.StopMovingOrSizing);

    -- Close button
    local close = CreateFrame("Button", "MainUiclose", f, "UIPanelCloseButton")

    -- Frames and regions
    UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
    UIConfig.title:SetFontObject("GameFontHighlight");
    UIConfig.title:SetPoint("CENTER", UIConfig.TitleBg, "CENTER", 0, -2);
    UIConfig.title:SetText("Shadow Crescent Roll Helper");

    -- -- Sliders//
    -- -- Attack slider
    -- UIConfig.attackSlider = CreateFrame("Slider", nil, UIConfig, "OptionsSliderTemplate");
    -- UIConfig.attackSlider:SetPoint("CENTER", UIConfig, "TOP", 0, -80);
    -- UIConfig.attackSlider:SetMinMaxValues(2,100);
    -- UIConfig.attackSlider:SetValue(20);
    -- UIConfig.attackSlider:SetValueStep(1);
    -- UIConfig.attackSlider:SetObeyStepOnDrag(true);
    -- UIConfig.attackSlider:SetScript("OnValueChanged", function(self,SliderValue) -- Set the roll value when the slider is moved
    --     attackSliderValue = SliderValue;
    --     SCRollHelper.UIError("SLIDERCHANGE! ", attackSliderValue); -- Troubleshooting
    --     attackButtonText = "Roll " .. attackSliderValue; -- Change the text on the button 1/2
    --     UIConfig.attackButton:SetText(attackButtonText); -- Change the text on the button 2/2
    -- end);

    -- Make a button for making more rows of buttons and boxes!
    local newrowbtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    newrowbtn:SetPoint("CENTER", UIConfig, "TOP", 140, -40);
    newrowbtn:SetSize(80, 16);
    newrowbtn:SetText("Create row");
    newrowbtn:SetNormalFontObject("GameFontNormalLarge");
    newrowbtn:SetHighlightFontObject("GameFontHighlightLarge");
    newrowbtn:SetScript("OnClick", function()
        MakeUi:CreateButton (newrollrowY)
        newrollrowY = newrollrowY -40; -- Increase distance to the next row by -40
    end);

    -- Make button and input boxes using the fancy function (value is the distance of the row from the top)
    MakeUi:CreateButton (-80)
    MakeUi:CreateButton (-120)
    MakeUi:CreateButton (-160)
    MakeUi:CreateButton (-200)

    UIConfig:Hide(); -- Start hidden
    return UIConfig; -- Return

end

-- Function to create a row of inputboxes and a button to roll them
function MakeUi:CreateButton (yBtnOffset)

    -- Make the button
    local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    btn:SetPoint("CENTER", UIConfig, "TOP", 140, yBtnOffset);
    btn:SetSize(80, 16);
    btn:SetText("Roll!");
    btn:SetNormalFontObject("GameFontNormalLarge");
    btn:SetHighlightFontObject("GameFontHighlightLarge");

    -- Make box1 (dice)
    local associatedBox1 = CreateFrame("EditBox",nil, UIConfig, "InputBoxTemplate");
    associatedBox1:SetPoint("CENTER", UIConfig, "TOP", 0, yBtnOffset);
    associatedBox1:SetWidth(30)
	associatedBox1:SetHeight(150)
	associatedBox1:SetMaxLetters(3)
    associatedBox1:SetAutoFocus(false)
    associatedBox1:SetText (1)

    -- Make box1 (sides)
    local associatedBox2 = CreateFrame("EditBox",nil, UIConfig, "InputBoxTemplate");
    associatedBox2:SetPoint("CENTER", UIConfig, "TOP", 40, yBtnOffset);
    associatedBox2:SetWidth(30)
    associatedBox2:SetHeight(150)
    associatedBox2:SetMaxLetters(3)
    associatedBox2:SetAutoFocus(false)
    associatedBox2:SetText (100)

    -- Make box (bonuses)
    local associatedBox3 = CreateFrame("EditBox",nil, UIConfig, "InputBoxTemplate");
    associatedBox3:SetPoint("CENTER", UIConfig, "TOP", 80, yBtnOffset);
    associatedBox3:SetWidth(30)
    associatedBox3:SetHeight(150)
    associatedBox3:SetMaxLetters(3)
    associatedBox3:SetAutoFocus(false)
    associatedBox3:SetText (0)

    -- Set up the button's script
    btn:SetScript("OnClick", function()
        -- Get the values from the input boxes, or 0.
        local diceValue = associatedBox1:GetText() or 0;
        local sidesValue = associatedBox2:GetText() or 0;
        local bonusesValue = associatedBox3:GetText() or 0;

        SCRollHelper.UIError("BOTTONCLICK! Attack with dice " .. diceValue .. " sides " .. sidesValue .. " bonuses " .. bonusesValue); -- Troubleshooting

        SCRollHelper.CallRoll(diceValue,sidesValue,bonusesValue)
    end);
end


-- MakeUi.CreateButton (200,50)

SCRollHelper.UIError("SCRollHelper - Initialisation complete (SCRollHelperUi.lua)"); -- Troubleshooting