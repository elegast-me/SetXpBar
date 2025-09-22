-- Function to set the XP rate
local function SetXpRate(rate)
    -- Sends a chat message to mod-individual-xp to set the XP rate
    SendChatMessage(".xp set " .. rate, "SAY")
end

-- List of XP rates with corresponding functions
local xpRates = {
    { text = "Experience:", isTitle = true },
    { text = "x1", func = function() SetXpRate(1) end },
    { text = "x2", func = function() SetXpRate(2) end },
    { text = "x3", func = function() SetXpRate(3) end },
    { text = "x4", func = function() SetXpRate(4) end },
    { text = "x5", func = function() SetXpRate(5) end },
}

-- Function to initialize the dropdown menu
local function InitializeMenu(self, level)
    if not level then return end
    for _, rate in pairs(xpRates) do
        local info = UIDropDownMenu_CreateInfo()
        info.text = rate.text
        info.func = rate.func
        info.isTitle = rate.isTitle
        UIDropDownMenu_AddButton(info, level)
    end
end

-- Create the dropdown menu frame
local xpBarMenu = CreateFrame("Frame", "SetXpBarMenu", UIParent, "UIDropDownMenuTemplate")
xpBarMenu.initialize = InitializeMenu

-- Enable mouse interaction with the XP bar
local xpBarFrame

local function SetupXpBarInteraction()
    if IsAddOnLoaded("ElvUI") then
        local elvUIBar = _G["ElvUI_ExperienceBar"]
        if elvUIBar then
            -- Store the original OnMouseDown script if it exists
            local originalOnMouseDown = elvUIBar:GetScript("OnMouseDown")
            
            -- Override the OnMouseDown script
            elvUIBar:SetScript("OnMouseDown", function(self, button)
                if button == "RightButton" then
                    EasyMenu(xpRates, xpBarMenu, "cursor", 3, -3, "MENU")
                end
                
                -- Call the original OnMouseDown script if it exists
                if originalOnMouseDown then
                    originalOnMouseDown(self, button)
                end
            end)
            
            elvUIBar:EnableMouse(true) -- Ensure mouse is enabled
        else
            -- If the frame isn't available yet, try again after a short delay
            C_Timer.After(1, SetupXpBarInteraction)
        end
    else
        -- Fallback to default UI's MainMenuExpBar
        xpBarFrame = MainMenuExpBar
        if xpBarFrame then
            xpBarFrame:EnableMouse(true)
            xpBarFrame:SetScript("OnMouseDown", function(self, button)
                if button == "RightButton" then
                    EasyMenu(xpRates, xpBarMenu, "cursor", 3, -3, "MENU")
                end
            end)
        end
    end
end

-- Listen for PLAYER_LOGIN event to ensure all addons are loaded
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function(self, event, ...)
    SetupXpBarInteraction()
    self:UnregisterEvent("PLAYER_LOGIN")
end)

-- Custom XP Rate Popup Dialog
StaticPopupDialogs["SET_XP_RATE"] = {
    text = "Enter custom XP rate:",
    button1 = "Set Rate",
    button2 = "Cancel",
    hasEditBox = true, -- Dialog has an edit box for user input
    -- Function to execute when the "Set Rate" button is clicked
    OnAccept = function(self)
        local rate = self.editBox:GetText()
        SetXpRate(rate)
    end,
    timeout = 0,
    whileDead = true, -- Dialog persists even when other windows are open
    hideOnEscape = true, -- Dialog closes when the escape key is pressed
    preferredIndex = 3, -- Index to avoid taint from UIParent
}
