-- Ui module

-- Namespaces
local _, SCRollSystem = ...;
SCRollSystem.MakeUi = {};
local MakeUi = SCRollSystem.MakeUi;
local UIConfig;

-- helper function to throw errors.
local function UIError( msg )
    print(msg);
end

UIError("SCrollsystem - Initialisation complete (SCMakeUi.lua)"); -- Troubleshooting

-- Function to toggle the Ui visible or not. If no Ui then create one.
function SCRollSystem.ToggleUi ()
    UIError("Toggle function - Toggling ui.");  -- Troubleshooting
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

    -- Clsoe button
    local close = CreateFrame("Button", "MainUiclose", f, "UIPanelCloseButton")

    -- Frames and regions
    UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
    UIConfig.title:SetFontObject("GameFontHighlight");
    UIConfig.title:SetPoint("CENTER", UIConfig.TitleBg, "CENTER", 0, -2);
    UIConfig.title:SetText("Shadow Crescent Roll Helper");



    -- Input boxes
    -- Input number of dice
    UIConfig.attackBoxDice = CreateFrame("EditBox",nil, UIConfig, "InputBoxTemplate");
    UIConfig.attackBoxDice:SetWidth(30)
	UIConfig.attackBoxDice:SetHeight(150)
	UIConfig.attackBoxDice:SetPoint("CENTER", UIConfig, "TOP", 0, -40);
	UIConfig.attackBoxDice:SetMaxLetters(3)

    -- Input number of sides
    UIConfig.attackBoxSides = CreateFrame("EditBox",nil, UIConfig, "InputBoxTemplate");
    UIConfig.attackBoxSides:SetWidth(30)
	UIConfig.attackBoxSides:SetHeight(150)
	UIConfig.attackBoxSides:SetPoint("CENTER", UIConfig, "TOP", 40, -40);
	UIConfig.attackBoxSides:SetMaxLetters(3)

    -- Input number of bonuses    
    UIConfig.attackBoxBonuses = CreateFrame("EditBox",nil, UIConfig, "InputBoxTemplate");
    UIConfig.attackBoxBonuses:SetWidth(30)
	UIConfig.attackBoxBonuses:SetHeight(150)
	UIConfig.attackBoxBonuses:SetPoint("CENTER", UIConfig, "TOP", 80, -40);
	UIConfig.attackBoxBonuses:SetMaxLetters(3)

    -- Buttons//
    -- Attack button
    UIConfig.attackButton = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    UIConfig.attackButton:SetPoint("CENTER", UIConfig, "TOP", 140, -40);
    UIConfig.attackButton:SetSize(80, 16);
    UIConfig.attackButton:SetText("Roll!");
    UIConfig.attackButton:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.attackButton:SetHighlightFontObject("GameFontHighlightLarge");
    UIConfig.attackButton:SetScript("OnClick", function()

        -- Get the values from the input boxes, or 0.
        local diceValue = UIConfig.attackBoxDice:GetText() or 0;
        local sidesValue = UIConfig.attackBoxSides:GetText() or 0;
        local bonusesValue = UIConfig.attackBoxBonuses:GetText() or 0;

        UIError("BOTTONCLICK! Attack with ",attackValue); -- Troubleshooting

        SCRollSystem.CallRoll(diceValue,sidesValue,bonusesValue)
    end);

    -- UIConfig.attackButton:SetPushedFontObject("");

    -- Defence button
    UIConfig.defenceButton = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    UIConfig.defenceButton:SetPoint("CENTER", UIConfig, "TOP", 140, -80);
    UIConfig.defenceButton:SetSize(80, 16);
    UIConfig.defenceButton:SetText("Roll!");
    UIConfig.defenceButton:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.defenceButton:SetHighlightFontObject("GameFontHighlightLarge");
    UIConfig.defenceButton:SetScript("OnClick", function()
        UIError("BOTTONCLICK! Defence with ",defenceSliderValue); -- Troubleshooting
        SCRollSystem.CallRoll(1,defenceSliderValue)
    end);

    -- UIConfig.defenceButton:SetPushedFontObject("");

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
    --     UIError("SLIDERCHANGE! ", attackSliderValue); -- Troubleshooting
    --     attackButtonText = "Roll " .. attackSliderValue; -- Change the text on the button 1/2
    --     UIConfig.attackButton:SetText(attackButtonText); -- Change the text on the button 2/2
    -- end);



    UIConfig:Hide(); -- Start hidden
    return UIConfig; -- Return

end
