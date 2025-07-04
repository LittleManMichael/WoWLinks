-- Create global table
WoWLinks = {}

-- Debug function
function WoWLinks:Debug(msg)
    if true then -- Set to false to disable debug messages
        print("|cFF33FF99WoWLinks Debug:|r " .. tostring(msg))
    end
end

-- Initialize the addon
function WoWLinks:Init()
    self:Debug("Initializing WoWLinks")
    
    -- Create DB if it doesn't exist
    if not WoWLinksDB then
        WoWLinksDB = {
            favorites = {},
            settings = {
                scale = 1.0,
                opacity = 0.9,
            }
        }
    end
    
    -- Create main frame if it doesn't exist yet
    if not self.frame then
        self:CreateMainFrame()
    end
    
    print("|cFF33FF99WoWLinks:|r Addon loaded. Type /wl or /wowlinks to open.")
end

function WoWLinks:HandleSlashCommand(msg)
    self:Debug("Slash command received: " .. tostring(msg))
    
    if msg == "reset" then
        WoWLinksDB = nil
        self:Init()
        print("|cFF33FF99WoWLinks:|r Settings reset.")
    else
        self:ToggleUI()
    end
end

function WoWLinks:ToggleUI()
    self:Debug("Toggle UI called. Current status: " .. (self.frame:IsShown() and "Shown" or "Hidden"))
    
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self.frame:Show()
    end
end

function WoWLinks:OpenURL(url, title)
    -- Copy URL to clipboard functionality
    if not StaticPopupDialogs["WOWLINKS_URL"] then
        StaticPopupDialogs["WOWLINKS_URL"] = {
            text = "Copy this URL for %s:",
            button1 = "Close",
            hasEditBox = true,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            OnShow = function(self, data)
                self.editBox:SetText(data.url)
                self.editBox:SetFocus()
                self.editBox:HighlightText()
            end,
            EditBoxOnEscapePressed = function(self)
                self:GetParent():Hide()
            end,
            preferredIndex = 3,
        }
    end
    
    StaticPopup_Show("WOWLINKS_URL", title, nil, {url = url})
end

-- Helper function to recalculate dropdown height
function WoWLinks:RecalculateClassDropdown(dropdown)
    local height = 0
    for _, child in ipairs({dropdown:GetChildren()}) do
        if child:IsShown() then
            height = height + child:GetHeight()
        end
    end
    dropdown:SetHeight(height)
    self:RecalculateContentHeight(dropdown:GetParent())
end

-- Helper function to recalculate content height
function WoWLinks:RecalculateContentHeight(content)
    local height = 0
    for _, child in ipairs({content:GetChildren()}) do
        if child:IsShown() then
            height = height + child:GetHeight() + 5
        end
    end
    content:SetHeight(math.max(height, content:GetParent():GetHeight()))
end

-- Helper function to populate spec content
function WoWLinks:PopulateSpecContent(container, specData, specName, className)
    local contentYOffset = -5
    
    -- Content creators section
    local creatorsTitle = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    creatorsTitle:SetPoint("TOPLEFT", 10, contentYOffset)
    creatorsTitle:SetText("Content Creators:")
    creatorsTitle:SetTextColor(0.8, 0.8, 0.8)
    contentYOffset = contentYOffset - 20
    
    -- Divider
    local divider = container:CreateTexture(nil, "ARTWORK")
    divider:SetSize(container:GetWidth() - 20, 1)
    divider:SetPoint("TOPLEFT", 10, contentYOffset)
    divider:SetColorTexture(0.27, 0.27, 0.27, 1.0)
    contentYOffset = contentYOffset - 5
    
    for _, creator in ipairs(specData.creators) do
        local creatorFrame = CreateFrame("Frame", nil, container)
        creatorFrame:SetSize(container:GetWidth() - 20, 20)
        creatorFrame:SetPoint("TOPLEFT", 10, contentYOffset)
        
        local creatorBg = creatorFrame:CreateTexture(nil, "BACKGROUND")
        creatorBg:SetAllPoints()
        creatorBg:SetColorTexture(0.16, 0.16, 0.16, 1.0)
        
        local creatorText = creatorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        creatorText:SetPoint("LEFT", 10, 0)
        creatorText:SetText(creator.name)
        creatorText:SetTextColor(0.4, 0.8, 1.0) -- Light blue
        
        -- Custom visit button
        local visitButton = CreateFrame("Button", nil, creatorFrame)
        visitButton:SetSize(50, 20)
        visitButton:SetPoint("RIGHT", -60, 0)
        
        local visitBg = visitButton:CreateTexture(nil, "BACKGROUND")
        visitBg:SetAllPoints()
        visitBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        
        local visitText = visitButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        visitText:SetPoint("CENTER", 0, 0)
        visitText:SetText("Visit")
        
        visitButton:SetScript("OnClick", function()
            WoWLinks:OpenURL(creator.url, creator.name)
        end)
        
        -- Custom fav button
        local favButton = CreateFrame("Button", nil, creatorFrame)
        favButton:SetSize(50, 20)
        favButton:SetPoint("RIGHT", -5, 0)
        
        local favBg = favButton:CreateTexture(nil, "BACKGROUND")
        favBg:SetAllPoints()
        favBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        
        local favText = favButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        favText:SetPoint("CENTER", 0, 0)
        favText:SetText("Fav")
        
        favButton:SetScript("OnClick", function()
            if not WoWLinksDB.favorites[creator.url] then
                WoWLinksDB.favorites[creator.url] = {
                    name = creator.name,
                    description = "Content Creator: " .. specName .. " " .. className,
                    url = creator.url
                }
            else
                WoWLinksDB.favorites[creator.url] = nil
            end
            WoWLinks:UpdateFavoritesTab()
        end)
        
        contentYOffset = contentYOffset - 25
    end
    
    -- Guides section
    contentYOffset = contentYOffset - 10
    
    local guidesTitle = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    guidesTitle:SetPoint("TOPLEFT", 10, contentYOffset)
    guidesTitle:SetText("Guides:")
    guidesTitle:SetTextColor(0.8, 0.8, 0.8)
    contentYOffset = contentYOffset - 20
    
    -- Divider
    local guidesDivider = container:CreateTexture(nil, "ARTWORK")
    guidesDivider:SetSize(container:GetWidth() - 20, 1)
    guidesDivider:SetPoint("TOPLEFT", 10, contentYOffset)
    guidesDivider:SetColorTexture(0.27, 0.27, 0.27, 1.0)
    contentYOffset = contentYOffset - 5
    
    for _, guide in ipairs(specData.guides) do
        local guideFrame = CreateFrame("Frame", nil, container)
        guideFrame:SetSize(container:GetWidth() - 20, 20)
        guideFrame:SetPoint("TOPLEFT", 10, contentYOffset)
        
        local guideBg = guideFrame:CreateTexture(nil, "BACKGROUND")
        guideBg:SetAllPoints()
        guideBg:SetColorTexture(0.16, 0.16, 0.16, 1.0)
        
        local guideText = guideFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        guideText:SetPoint("LEFT", 10, 0)
        guideText:SetText(guide.name)
        guideText:SetTextColor(0.4, 0.8, 1.0) -- Light blue
        
        -- Custom visit button
        local visitButton = CreateFrame("Button", nil, guideFrame)
        visitButton:SetSize(50, 20)
        visitButton:SetPoint("RIGHT", -60, 0)
        
        local visitBg = visitButton:CreateTexture(nil, "BACKGROUND")
        visitBg:SetAllPoints()
        visitBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        
        local visitText = visitButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        visitText:SetPoint("CENTER", 0, 0)
        visitText:SetText("Visit")
        
        visitButton:SetScript("OnClick", function()
            WoWLinks:OpenURL(guide.url, guide.name)
        end)
        
        -- Custom fav button
        local favButton = CreateFrame("Button", nil, guideFrame)
        favButton:SetSize(50, 20)
        favButton:SetPoint("RIGHT", -5, 0)
        
        local favBg = favButton:CreateTexture(nil, "BACKGROUND")
        favBg:SetAllPoints()
        favBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        
        local favText = favButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        favText:SetPoint("CENTER", 0, 0)
        favText:SetText("Fav")
        
        favButton:SetScript("OnClick", function()
            if not WoWLinksDB.favorites[guide.url] then
                WoWLinksDB.favorites[guide.url] = {
                    name = guide.name,
                    description = "Guide: " .. specName .. " " .. className,
                    url = guide.url
                }
            else
                WoWLinksDB.favorites[guide.url] = nil
            end
            WoWLinks:UpdateFavoritesTab()
        end)
        
        contentYOffset = contentYOffset - 25
    end
    
    -- Set content height
    container:SetHeight(-contentYOffset + 5)
end

-- Register events and slash commands
local function OnAddonLoaded(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "WoWLinks" then
        WoWLinks:Debug("ADDON_LOADED fired for WoWLinks")
        
        -- Register slash commands
        SLASH_WOWLINKS1 = "/wowlinks"
        SLASH_WOWLINKS2 = "/wl"
        SlashCmdList["WOWLINKS"] = function(msg) 
            WoWLinks:HandleSlashCommand(msg) 
        end
        
        WoWLinks:Init()
    elseif event == "PLAYER_ENTERING_WORLD" then
        WoWLinks:Debug("PLAYER_ENTERING_WORLD fired")
        -- Additional setup after player enters world if needed
    end
end

-- Create and register event frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", OnAddonLoaded)

-- Print startup message
print("|cFF33FF99WoWLinks:|r Initializing...")