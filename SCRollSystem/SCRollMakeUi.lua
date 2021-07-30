-- -- (2)
-- -- f:SetBackdrop( { 
-- --     bgFile = "Interface/Tooltips/UI-Tooltip-Background",
-- --     edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
-- --     tile = true, tileSize = 16, edgeSize = 16, 
-- --     insets = { left = 0, right = 0, top = 0, bottom = 0 }
-- --   });
-- -- f:SetBackdropColor(0, 0, 0, .5)
-- -- f:SetBackdropBorderColor(0, 0, 0)

-- -- (3)
-- f:EnableMouse(true)
-- f:SetMovable(true)
-- f:RegisterForDrag("LeftButton")
-- f:SetScript("OnDragStart", f.StartMoving)
-- f:SetScript("OnDragStop", f.StopMovingOrSizing)
-- f:SetScript("OnHide", f.StopMovingOrSizing)

-- -- (4)
-- local close = CreateFrame("Button", "YourCloseButtonName", f, "UIPanelCloseButton")
-- close:SetPoint("TOPRIGHT", f, "TOPRIGHT")
-- close:SetScript("OnClick", function()
-- 	f:Hide()
-- end)

-- -- (5)
-- local text = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
-- text:SetPoint("CENTER")
-- text:SetText("Hello World!")

-- Namespaces
local _, SCRollSystem = ...

-- function ToggleUi ()
--     local mainframe = UIConfig or MakeUi();
--     SCRollFrame:SetShown(not menu:IsShown());
-- end

print("SCrollsystem - Initialisation complete (SCMakeUi.lua)")

-- Function to make the Ui
function SCRollSystem.MakeUi () 

    -- Create the UI frame
    local UIConfig = CreateFrame("Frame", "SCRollFrame", UIParent, "BasicFrameTemplateWithInset");
    UIConfig:SetPoint("CENTER");
    UIConfig:SetSize(400,400);

    -- Clsoe button
    local close = CreateFrame("Button", "MainUiclose", f, "UIPanelCloseButton")

    -- Frames and regions
    UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
    UIConfig.title:SetFontObject("GameFontHighlight");
    UIConfig.title:SetPoint("CENTER", UIConfig.TitleBg, "CENTER", 0, -2);
    UIConfig.title:SetText("Shadow Crescent Roll System");

    -- Buttons

    -- Attack button
    UIConfig.attackButton = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    UIConfig.attackButton:SetPoint("CENTER", UIConfig, "TOP", 140, -80);
    UIConfig.attackButton:SetSize(80, 16);
    UIConfig.attackButton:SetText("Roll");
    UIConfig.attackButton:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.attackButton:SetHighlightFontObject("GameFontHighlightLarge");

    -- UIConfig.attackButton:SetPushedFontObject("");

    -- Attack slider
    UIConfig.attackSlider = CreateFrame("Slider", nil, UIConfig, "OptionsSliderTemplate");
    UIConfig.attackSlider:SetPoint("CENTER", UIConfig, "TOP", 0, -80);
    UIConfig.attackSlider:SetMinMaxValues(0,100);
    UIConfig.attackSlider:SetValue(0);
    UIConfig.attackSlider:SetValueStep(1);
    UIConfig.attackSlider:SetObeyStepOnDrag(true);

    -- Defence button
    UIConfig.defenceButton = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    UIConfig.defenceButton:SetPoint("CENTER", UIConfig, "TOP", 140, -40);
    UIConfig.defenceButton:SetSize(80, 16);
    UIConfig.defenceButton:SetText("Roll");
    UIConfig.defenceButton:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.defenceButton:SetHighlightFontObject("GameFontHighlightLarge");

    -- UIConfig.defenceButton:SetPushedFontObject("");

    -- Defence slider
    UIConfig.defenceSlider = CreateFrame("Slider", nil, UIConfig, "OptionsSliderTemplate");
    UIConfig.defenceSlider:SetPoint("CENTER", UIConfig, "TOP", 0, -40);
    UIConfig.defenceSlider:SetMinMaxValues(0,100);
    UIConfig.defenceSlider:SetValue(0);
    UIConfig.defenceSlider:SetValueStep(1);
    UIConfig.defenceSlider:SetObeyStepOnDrag(true);

end
