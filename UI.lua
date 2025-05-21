local addonName, WoWLinks = ...

function WoWLinks:CreateMainFrame()
    -- Main frame
    self.frame = CreateFrame("Frame", "WoWLinksFrame", UIParent, "BackdropTemplate")
    self.frame:SetSize(600, 450)
    self.frame:SetPoint("CENTER")
    self.frame:SetFrameStrata("HIGH")
    self.frame:SetMovable(true)
    self.frame:EnableMouse(true)
    self.frame:RegisterForDrag("LeftButton")
    self.frame:SetScript("OnDragStart", self.frame.StartMoving)
    self.frame:SetScript("OnDragStop", self.frame.StopMovingOrSizing)
    self.frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    
    -- Title bar
    local titleBar = CreateFrame("Frame", nil, self.frame)
    titleBar:SetHeight(30)
    titleBar:SetPoint("TOPLEFT", 0, 0)
    titleBar:SetPoint("TOPRIGHT", 0, 0)
    
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("CENTER", titleBar, "CENTER")
    title:SetText("WoWLinks")
    
    -- Close button
    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    
    -- Create tab container
    self:CreateTabs()
    
    -- Set frame scale from saved settings
    self.frame:SetScale(WoWLinksDB.settings.scale)
    self.frame:SetAlpha(WoWLinksDB.settings.opacity)
    
    -- Hide initially
    self.frame:Hide()
end

function WoWLinks:CreateTabs()
    local tabs = {}
    local tabContents = {}
    local tabNames = {"Classes", "Tools", "Favorites", "Settings"}
    
    -- Tab container
    local tabFrame = CreateFrame("Frame", nil, self.frame)
    tabFrame:SetPoint("TOPLEFT", 15, -35)
    tabFrame:SetPoint("BOTTOMRIGHT", -15, 15)
    
    -- Create tabs
    for i, name in ipairs(tabNames) do
        tabs[i] = CreateFrame("Button", "WoWLinksTab"..i, self.frame, "CharacterFrameTabButtonTemplate")
        tabs[i]:SetText(name)
        tabs[i].content = CreateFrame("Frame", nil, tabFrame)
        tabs[i].content:SetPoint("TOPLEFT", tabFrame, "TOPLEFT", 0, 0)
        tabs[i].content:SetPoint("BOTTOMRIGHT", tabFrame, "BOTTOMRIGHT", 0, 0)
        tabs[i].content:Hide()
        tabContents[i] = tabs[i].content
        
        if i == 1 then
            tabs[i]:SetPoint("TOPLEFT", tabFrame, "BOTTOMLEFT", 0, 0)
        else
            tabs[i]:SetPoint("TOPLEFT", tabs[i-1], "TOPRIGHT", -14, 0)
        end
        
        tabs[i]:SetScript("OnClick", function()
            for j, tab in ipairs(tabs) do
                if i == j then
                    PanelTemplates_SelectTab(tab)
                    tab.content:Show()
                else
                    PanelTemplates_DeselectTab(tab)
                    tab.content:Hide()
                end
            end
        end)
    end
    
    -- Setup classes tab
    self:SetupClassesTab(tabContents[1])
    
    -- Setup tools tab
    self:SetupToolsTab(tabContents[2])
    
    -- Setup favorites tab
    self:SetupFavoritesTab(tabContents[3])
    
    -- Setup settings tab
    self:SetupSettingsTab(tabContents[4])
    
    -- Store tabs for later access
    self.tabs = tabs
    
    -- Select first tab by default
    PanelTemplates_SelectTab(tabs[1])
    tabs[1].content:Show()
end

function WoWLinks:SetupClassesTab(frame)
    -- Create scrollframe
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 0)
    
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(scrollFrame:GetWidth(), 1000)
    scrollFrame:SetScrollChild(content)
    
    -- Add current character section at the top
    local currentClassFrame = CreateFrame("Frame", nil, content)
    currentClassFrame:SetSize(scrollFrame:GetWidth() - 20, 30)
    currentClassFrame:SetPoint("TOPLEFT", 10, -10)
    
    local currentBg = currentClassFrame:CreateTexture(nil, "BACKGROUND")
    currentBg:SetAllPoints()
    currentBg:SetColorTexture(0.3, 0.3, 0.4, 1.0) -- Slightly different color to stand out
    
    local currentTitle = currentClassFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    currentTitle:SetPoint("LEFT", 10, 0)
    currentTitle:SetText("Current Character")
    
    -- Get player's class and spec
    local _, playerClass = UnitClass("player")
    local currentSpec = GetSpecialization()
    local currentSpecID = currentSpec and GetSpecializationInfo(currentSpec) or nil
    local currentSpecName = currentSpecID and select(2, GetSpecializationInfoByID(currentSpecID)) or "Unknown"
    
    -- Current spec content
    local currentSpecFrame = CreateFrame("Frame", nil, content)
    currentSpecFrame:SetSize(scrollFrame:GetWidth() - 40, 30)
    currentSpecFrame:SetPoint("TOPLEFT", currentClassFrame, "BOTTOMLEFT", 20, 0)
    
    local currentSpecBg = currentSpecFrame:CreateTexture(nil, "BACKGROUND")
    currentSpecBg:SetAllPoints()
    currentSpecBg:SetColorTexture(0.2, 0.2, 0.3, 1.0)
    
    -- Class icon
    local classIcon = currentSpecFrame:CreateTexture(nil, "ARTWORK")
    classIcon:SetSize(20, 20)
    classIcon:SetPoint("LEFT", 5, 0)
    
    if WoWLinksData.classIcons[playerClass] then
        classIcon:SetTexture(WoWLinksData.classIcons[playerClass].file)
        classIcon:SetTexCoord(unpack(WoWLinksData.classIcons[playerClass].coords))
    end
    
    local specText = currentSpecFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    specText:SetPoint("LEFT", classIcon, "RIGHT", 5, 0)
    specText:SetText(playerClass .. " - " .. currentSpecName)
    
    -- Expand button for current spec
    local expandButton = CreateFrame("Button", nil, currentSpecFrame, "UIPanelButtonTemplate")
    expandButton:SetSize(80, 20)
    expandButton:SetPoint("RIGHT", -5, 0)
    expandButton:SetText("View Links")
    
    -- Create content container for current spec (initially hidden)
    local currentSpecContent = CreateFrame("Frame", nil, content)
    currentSpecContent:SetSize(scrollFrame:GetWidth() - 60, 0) -- Height will be calculated
    currentSpecContent:SetPoint("TOPLEFT", currentSpecFrame, "BOTTOMLEFT", 0, 0)
    currentSpecContent:Hide()
    
    -- Detect if we have data for the player's class/spec
    local hasPlayerData = false
    if WoWLinksData.classes[playerClass] then
        -- Find the matching spec in our data (handle slight naming differences)
        for specKey, specData in pairs(WoWLinksData.classes[playerClass].specs) do
            if specKey:find(currentSpecName) or currentSpecName:find(specKey) then
                hasPlayerData = true
                
                -- Set up content for current spec
                self:PopulateSpecContent(
                    currentSpecContent, 
                    specData, 
                    currentSpecName, 
                    playerClass
                )
                break
            end
        end
    end
    
    if not hasPlayerData then
        -- No data for this class/spec
        local noDataText = currentSpecContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noDataText:SetPoint("CENTER", 0, -15)
        noDataText:SetText("No data available for " .. currentSpecName .. " " .. playerClass)
        currentSpecContent:SetHeight(30)
    end
    
    -- Toggle current spec content
    expandButton:SetScript("OnClick", function()
        if currentSpecContent:IsShown() then
            currentSpecContent:Hide()
            expandButton:SetText("View Links")
        else
            currentSpecContent:Show()
            expandButton:SetText("Hide Links")
        end
        self:RecalculateContentHeight(content)
    end)
    
    -- Add divider
    local divider = content:CreateTexture(nil, "ARTWORK")
    divider:SetSize(scrollFrame:GetWidth() - 20, 2)
    divider:SetPoint("TOPLEFT", 10, -80 - (currentSpecContent:IsShown() and currentSpecContent:GetHeight() or 0))
    divider:SetColorTexture(0.4, 0.4, 0.4, 0.8)
    
    local allClassesTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    allClassesTitle:SetPoint("TOPLEFT", 10, -90 - (currentSpecContent:IsShown() and currentSpecContent:GetHeight() or 0))
    allClassesTitle:SetText("All Classes")
    
    -- Create class buttons (starting below the divider)
    local yOffset = -110 - (currentSpecContent:IsShown() and currentSpecContent:GetHeight() or 0)
    local classButtons = {}
    local index = 1
    
    for className, classData in pairs(WoWLinksData.classes) do
        local button = CreateFrame("Button", nil, content)
        button:SetSize(scrollFrame:GetWidth() - 20, 30)
        button:SetPoint("TOPLEFT", 10, yOffset)
        
        local bg = button:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(0.27, 0.27, 0.27, 1.0)
        
        local icon = button:CreateTexture(nil, "ARTWORK")
        icon:SetSize(20, 20)
        icon:SetPoint("LEFT", 5, 0)
        
        if WoWLinksData.classIcons[className] then
            icon:SetTexture(WoWLinksData.classIcons[className].file)
            icon:SetTexCoord(unpack(WoWLinksData.classIcons[className].coords))
        end
        
        local text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("LEFT", icon, "RIGHT", 5, 0)
        text:SetText(className)
        
        local expandIcon = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        expandIcon:SetPoint("RIGHT", -5, 0)
        expandIcon:SetText("▶") -- Default to collapsed
        
        -- Dropdown content for specs
        local dropdown = CreateFrame("Frame", nil, content)
        dropdown:SetSize(scrollFrame:GetWidth() - 40, 0) -- Height will be calculated
        dropdown:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 20, 0)
        dropdown:Hide()
        
        -- Populate spec buttons
        local specYOffset = 0
        
        for specName, specData in pairs(classData.specs) do
            -- Spec button
            local specButton = CreateFrame("Button", nil, dropdown)
            specButton:SetSize(dropdown:GetWidth(), 25)
            specButton:SetPoint("TOPLEFT", 0, specYOffset)
            
            local specBg = specButton:CreateTexture(nil, "BACKGROUND")
            specBg:SetAllPoints()
            specBg:SetColorTexture(0.2, 0.2, 0.2, 1.0)
            
            local specText = specButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            specText:SetPoint("LEFT", 10, 0)
            specText:SetText(specName)
            specText:SetTextColor(1.0, 0.6, 0.2) -- Orange-ish color
            
            local specExpandIcon = specButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            specExpandIcon:SetPoint("RIGHT", -5, 0)
            specExpandIcon:SetText("▶") -- Default to collapsed
            
            -- Spec content
            local specContent = CreateFrame("Frame", nil, dropdown)
            specContent:SetSize(dropdown:GetWidth(), 0) -- Height will be calculated
            specContent:SetPoint("TOPLEFT", specButton, "BOTTOMLEFT", 0, 0)
            specContent:Hide()
            
            local specContentBg = specContent:CreateTexture(nil, "BACKGROUND")
            specContentBg:SetAllPoints()
            specContentBg:SetColorTexture(0.13, 0.13, 0.13, 1.0)
            
            -- Populate spec content
            self:PopulateSpecContent(specContent, specData, specName, className)
            
            -- Toggle spec content visibility
            specButton:SetScript("OnClick", function()
                if specContent:IsShown() then
                    specContent:Hide()
                    specExpandIcon:SetText("▶")
                    self:RecalculateClassDropdown(dropdown)
                else
                    specContent:Show()
                    specExpandIcon:SetText("▼")
                    self:RecalculateClassDropdown(dropdown)
                end
            end)
            
            specYOffset = specYOffset - 30 - (specContent:IsShown() and specContent:GetHeight() or 0)
        end
        
        -- Set initial dropdown height
        dropdown:SetHeight(-specYOffset)
        
        -- Toggle class dropdown visibility
        button:SetScript("OnClick", function()
            if dropdown:IsShown() then
                dropdown:Hide()
                expandIcon:SetText("▶")
            else
                dropdown:Show()
                expandIcon:SetText("▼")
            end
            self:RecalculateContentHeight(content)
        end)
        
        yOffset = yOffset - 35 - (dropdown:IsShown() and dropdown:GetHeight() or 0)
        classButtons[index] = button
        button.dropdown = dropdown
        index = index + 1
    end
    
    -- Calculate final content height
    content:SetHeight(math.max(-yOffset + 20, scrollFrame:GetHeight()))
    
    -- Store references for updates
    self.classScrollFrame = scrollFrame
    self.classContent = content
    self.currentSpecContent = currentSpecContent
    self.currentExpandButton = expandButton
    self.allClassesDivider = divider
    self.allClassesTitle = allClassesTitle
    self.classButtons = classButtons
end

function WoWLinks:SetupToolsTab(frame)
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 0)
    
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(scrollFrame:GetWidth(), 600)
    scrollFrame:SetScrollChild(content)
    
    local yOffset = -10
    
    for i, tool in ipairs(WoWLinksData.tools) do
        local toolFrame = CreateFrame("Frame", nil, content)
        toolFrame:SetSize(scrollFrame:GetWidth() - 20, 60)
        toolFrame:SetPoint("TOPLEFT", 10, yOffset)
        
        local bg = toolFrame:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(0.1, 0.1, 0.1, 0.5)
        
        local title = toolFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        title:SetPoint("TOPLEFT", 10, -10)
        title:SetText(tool.name)
        
        local desc = toolFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        desc:SetPoint("TOPLEFT", 10, -30)
        desc:SetText(tool.description)
        
        local visitButton = CreateFrame("Button", nil, toolFrame, "UIPanelButtonTemplate")
        visitButton:SetSize(80, 22)
        visitButton:SetPoint("TOPRIGHT", -10, -10)
        visitButton:SetText("Visit")
        visitButton:SetScript("OnClick", function()
            WoWLinks:OpenURL(tool.url, tool.name)
        end)
        
        local favButton = CreateFrame("CheckButton", nil, toolFrame, "UICheckButtonTemplate")
        favButton:SetSize(24, 24)
        favButton:SetPoint("RIGHT", visitButton, "LEFT", -5, 0)
        favButton:SetChecked(WoWLinksDB.favorites[tool.url] ~= nil)
        favButton:SetScript("OnClick", function()
            if favButton:GetChecked() then
                WoWLinksDB.favorites[tool.url] = {
                    name = tool.name,
                    description = tool.description,
                    url = tool.url
                }
            else
                WoWLinksDB.favorites[tool.url] = nil
            end
            WoWLinks:UpdateFavoritesTab()
        end)
        
        yOffset = yOffset - 70
    end
    
    content:SetHeight(-yOffset + 20)
end

function WoWLinks:SetupFavoritesTab(frame)
    self.favoritesTab = frame
    self:UpdateFavoritesTab()
end

function WoWLinks:UpdateFavoritesTab()
    if not self.favoritesTab then return end
    
    -- Clear existing content
    self.favoritesTab:SetScript("OnHide", nil)
    for _, child in pairs({self.favoritesTab:GetChildren()}) do
        child:Hide()
        child:SetParent(nil)
    end
    
    -- Create scrollframe
    local scrollFrame = CreateFrame("ScrollFrame", nil, self.favoritesTab, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 0)
    
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(scrollFrame:GetWidth(), 600)
    scrollFrame:SetScrollChild(content)
    
    local yOffset = -10
    local hasFavorites = false
    
    for url, favorite in pairs(WoWLinksDB.favorites) do
        hasFavorites = true
        
        local favFrame = CreateFrame("Frame", nil, content)
        favFrame:SetSize(scrollFrame:GetWidth() - 20, 60)
        favFrame:SetPoint("TOPLEFT", 10, yOffset)
        
        local bg = favFrame:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(0.1, 0.1, 0.1, 0.5)
        
        local title = favFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        title:SetPoint("TOPLEFT", 10, -10)
        title:SetText(favorite.name)
        
        local desc = favFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        desc:SetPoint("TOPLEFT", 10, -30)
        desc:SetText(favorite.description or "")
        
        local visitButton = CreateFrame("Button", nil, favFrame, "UIPanelButtonTemplate")
        visitButton:SetSize(80, 22)
        visitButton:SetPoint("TOPRIGHT", -10, -10)
        visitButton:SetText("Visit")
        visitButton:SetScript("OnClick", function()
            WoWLinks:OpenURL(favorite.url, favorite.name)
        end)
        
        local removeButton = CreateFrame("Button", nil, favFrame, "UIPanelButtonTemplate")
        removeButton:SetSize(80, 22)
        removeButton:SetPoint("TOPRIGHT", visitButton, "TOPLEFT", -5, 0)
        removeButton:SetText("Remove")
        removeButton:SetScript("OnClick", function()
            WoWLinksDB.favorites[url] = nil
            WoWLinks:UpdateFavoritesTab()
        end)
        
        yOffset = yOffset - 70
    end
    
    if not hasFavorites then
        local noFavs = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noFavs:SetPoint("CENTER")
        noFavs:SetText("No favorites yet. Add some from Classes or Tools tabs!")
    end
    
    content:SetHeight(math.max(-yOffset + 20, scrollFrame:GetHeight()))
end

function WoWLinks:SetupSettingsTab(frame)
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 20, -20)
    title:SetText("Settings")
    
    -- Scale slider
    local scaleText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scaleText:SetPoint("TOPLEFT", 30, -60)
    scaleText:SetText("UI Scale: " .. WoWLinksDB.settings.scale)
    
    local scaleSlider = CreateFrame("Slider", "WoWLinksScaleSlider", frame, "OptionsSliderTemplate")
    scaleSlider:SetPoint("TOPLEFT", 30, -80)
    scaleSlider:SetWidth(200)
    scaleSlider:SetMinMaxValues(0.5, 1.5)
    scaleSlider:SetValueStep(0.05)
    scaleSlider:SetValue(WoWLinksDB.settings.scale)
    scaleSlider:SetScript("OnValueChanged", function(self, value)
        WoWLinksDB.settings.scale = value
        WoWLinks.frame:SetScale(value)
        scaleText:SetText("UI Scale: " .. string.format("%.2f", value))
    end)
    
    -- Opacity slider
    local opacityText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    opacityText:SetPoint("TOPLEFT", 30, -120)
    opacityText:SetText("UI Opacity: " .. WoWLinksDB.settings.opacity * 100 .. "%")
    
    local opacitySlider = CreateFrame("Slider", "WoWLinksOpacitySlider", frame, "OptionsSliderTemplate")
    opacitySlider:SetPoint("TOPLEFT", 30, -140)
    opacitySlider:SetWidth(200)
    opacitySlider:SetMinMaxValues(0.1, 1)
    opacitySlider:SetValueStep(0.05)
    opacitySlider:SetValue(WoWLinksDB.settings.opacity)
    opacitySlider:SetScript("OnValueChanged", function(self, value)
        WoWLinksDB.settings.opacity = value
        WoWLinks.frame:SetAlpha(value)
        opacityText:SetText("UI Opacity: " .. string.format("%.0f", value * 100) .. "%")
    end)
    
    -- Reset button
    local resetButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    resetButton:SetSize(100, 24)
    resetButton:SetPoint("TOPLEFT", 30, -180)
    resetButton:SetText("Reset Settings")
    resetButton:SetScript("OnClick", function()
        WoWLinksDB = nil
        ReloadUI()
    end)
end