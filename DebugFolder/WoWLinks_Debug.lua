-- Create global table
WoWLinks = {}

-- Debug flag (set to true for more messages)
local DEBUG = true

-- Debug function
local function Debug(msg)
    if DEBUG then
        print("|cFF33FF99WoWLinks Debug:|r " .. tostring(msg))
    end
end

-- Slash command handler
local function SlashCommandHandler(msg)
    print("|cFF33FF99WoWLinks:|r Slash command received: " .. tostring(msg))
    
    if msg == "debug" then
        DEBUG = not DEBUG
        print("|cFF33FF99WoWLinks:|r Debug mode " .. (DEBUG and "enabled" or "disabled"))
    else
        print("|cFF33FF99WoWLinks:|r Attempting to show frame...")
        if WoWLinks.frame then
            if WoWLinks.frame:IsShown() then
                WoWLinks.frame:Hide()
                print("|cFF33FF99WoWLinks:|r Frame hidden")
            else
                WoWLinks.frame:Show()
                print("|cFF33FF99WoWLinks:|r Frame shown")
            end
        else
            print("|cFF33FF99WoWLinks:|r Frame doesn't exist yet")
        end
    end
end

-- Create a simple test frame
local function CreateTestFrame()
    Debug("Creating test frame")
    
    -- Create main frame
    WoWLinks.frame = CreateFrame("Frame", "WoWLinksFrame", UIParent, "BackdropTemplate")
    WoWLinks.frame:SetSize(300, 200)
    WoWLinks.frame:SetPoint("CENTER")
    WoWLinks.frame:SetFrameStrata("HIGH")
    
    -- Add backdrop
    WoWLinks.frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    
    -- Add title text
    local title = WoWLinks.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", 0, -15)
    title:SetText("WoWLinks Debug Frame")
    
    -- Add close button
    local closeButton = CreateFrame("Button", nil, WoWLinks.frame)
    closeButton:SetSize(32, 32)
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    
    local closeTex = closeButton:CreateTexture(nil, "ARTWORK")
    closeTex:SetTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeTex:SetAllPoints()
    closeButton:SetNormalTexture(closeTex)
    
    closeButton:SetScript("OnClick", function()
        Debug("Close button clicked")
        WoWLinks.frame:Hide()
    end)
    
    -- Add test button
    local testButton = CreateFrame("Button", nil, WoWLinks.frame)
    testButton:SetSize(100, 30)
    testButton:SetPoint("CENTER")
    
    local buttonBg = testButton:CreateTexture(nil, "BACKGROUND")
    buttonBg:SetAllPoints()
    buttonBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
    
    local buttonText = testButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    buttonText:SetPoint("CENTER")
    buttonText:SetText("Test Button")
    
    testButton:SetScript("OnClick", function()
        Debug("Test button clicked")
        print("|cFF33FF99WoWLinks:|r Test button works!")
    end)
    
    -- Hide the frame by default
    WoWLinks.frame:Hide()
    
    Debug("Test frame created")
end

-- Event handler
local function OnEvent(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "WoWLinks" then
        Debug("ADDON_LOADED fired for WoWLinks")
        
        -- Register slash commands
        SLASH_WOWLINKS1 = "/wowlinks"
        SLASH_WOWLINKS2 = "/wl"
        SlashCmdList["WOWLINKS"] = SlashCommandHandler
        
        -- Create sample DB if needed
        if not WoWLinksDB then
            WoWLinksDB = {
                favorites = {},
                settings = {
                    scale = 1.0,
                    opacity = 0.9,
                }
            }
        end
        
        -- Create test UI
        CreateTestFrame()
        
        print("|cFF33FF99WoWLinks:|r Addon loaded. Type /wl or /wowlinks to open.")
    elseif event == "PLAYER_ENTERING_WORLD" then
        Debug("PLAYER_ENTERING_WORLD fired")
    end
end

-- Create and register event frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", OnEvent)

-- Print startup message
print("|cFF33FF99WoWLinks:|r Initializing...")