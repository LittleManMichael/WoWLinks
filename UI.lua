local addonName = ...

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
    
    -- Make sure the backdrop is properly defined
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
    
    -- Custom close button
    local closeButton = CreateFrame("Button", nil, self.frame)
    closeButton:SetSize(32, 32)
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    
    -- Use X texture for close button
    local closeTexture = closeButton:CreateTexture(nil, "ARTWORK")
    closeTexture:SetAllPoints()
    closeTexture:SetTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeButton:SetNormalTexture(closeTexture)
    
    local closeHighlightTexture = closeButton:CreateTexture(nil, "HIGHLIGHT")
    closeHighlightTexture:SetAllPoints()
    closeHighlightTexture:SetTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
    closeHighlightTexture:SetBlendMode("ADD")
    closeButton:SetHighlightTexture(closeHighlightTexture)
    
    closeButton:SetScript("OnClick", function() 
        self.frame:Hide() 
    end)
    
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
    
    -- Create custom tabs
    for i, name in ipairs(tabNames) do
        tabs[i] = CreateFrame("Button", "WoWLinksTab"..i, self.frame)
        tabs[i]:SetSize(90, 24)
        
        -- Tab background
        local bg = tabs[i]:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(0.1, 0.1, 0.1, 0.7)
        tabs[i].bg = bg
        
        -- Tab border
        local border = CreateFrame("Frame", nil, tabs[i])
        border:SetPoint("TOPLEFT", -1, 1)
        border:SetPoint("BOTTOMRIGHT", 1, -1)
        border:SetFrameLevel(tabs[i]:GetFrameLevel() - 1)
        
        local borderTex = border:CreateTexture(nil, "BACKGROUND")
        borderTex:SetAllPoints()
        borderTex:SetColorTexture(0.4, 0.4, 0.4, 0.7)
        
        -- Tab text
        local text = tabs[i]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("CENTER", 0, 0)
        text:SetText(name)
        tabs[i].text = text
        
        -- Tab highlight
        local highlight = tabs[i]:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetAllPoints()
        highlight:SetColorTexture(0.3, 0.3, 0.3, 0.5)
        highlight:SetBlendMode("ADD")
        
        -- Content frame for this tab
        tabs[i].content = CreateFrame("Frame", nil, tabFrame)
        tabs[i].content:SetPoint("TOPLEFT", tabFrame, "TOPLEFT", 0, 0)
        tabs[i].content:SetPoint("BOTTOMRIGHT", tabFrame, "BOTTOMRIGHT", 0, 0)
        tabs[i].content:Hide()
        tabContents[i] = tabs[i].content
        
        -- Position tabs
        if i == 1 then
            tabs[i]:SetPoint("BOTTOMLEFT", tabFrame, "TOPLEFT", 0, 1)
        else
            tabs[i]:SetPoint("LEFT", tabs[i-1], "RIGHT", 2, 0)
        end
        
        -- Tab click handling
        tabs[i]:SetScript("OnClick", function()
            for j, tab in ipairs(tabs) do
                if i == j then
                    -- Selected tab
                    tab.content:Show()
                    tab.text:SetTextColor(1, 1, 1)
                    tab.bg:SetColorTexture(0.25, 0.25, 0.25, 0.9)
                else
                    -- Unselected tabs
                    tab.content:Hide()
                    tab.text:SetTextColor(0.8, 0.8, 0.8)
                    tab.bg:SetColorTexture(0.1, 0.1, 0.1, 0.7)
                end
            end
        end)
    end
    
    -- Setup tabs content
    self:SetupClassesTab(tabContents[1])
    self:SetupToolsTab(tabContents[2])
    self:SetupFavoritesTab(tabContents[3])
    self:SetupSettingsTab(tabContents[4])
    
    -- Store tabs for later access
    self.tabs = tabs
    
    -- Select first tab by default (simulate a click)
    tabs[1]:GetScript("OnClick")(tabs[1])
end

function WoWLinks:SetupClassesTab(frame)
    -- Get player's class and spec data first
    local _, playerClass = UnitClass("player")
    local playerClassColor = RAID_CLASS_COLORS[playerClass]
    local classDisplayName = LOCALIZED_CLASS_NAMES_MALE[playerClass] or playerClass
    local currentSpec = GetSpecialization()
    local currentSpecID = currentSpec and GetSpecializationInfo(currentSpec) or nil
    local currentSpecName = currentSpecID and select(2, GetSpecializationInfoByID(currentSpecID)) or "Unknown"
    
    -- Create scrollframe and content first
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame)
    scrollFrame:SetPoint("TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -20, 0)
    
    local scrollbar = CreateFrame("Slider", nil, scrollFrame)
    scrollbar:SetWidth(16)
    scrollbar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 0, 0)
    scrollbar:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0, 0)
    scrollbar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
    local thumb = scrollbar:GetThumbTexture()
    thumb:SetSize(16, 24)
    thumb:SetColorTexture(0.4, 0.4, 0.4, 0.7)
    
    scrollbar:SetMinMaxValues(0, 1000)
    scrollbar:SetValueStep(1)
    scrollbar:SetValue(0)
    
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(scrollFrame:GetWidth(), 1000)
    scrollFrame:SetScrollChild(content)
    
    scrollbar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
    end)
    
    -- Current character section
    local currentClassFrame = CreateFrame("Frame", nil, content)
    currentClassFrame:SetSize(scrollFrame:GetWidth() - 20, 30)
    currentClassFrame:SetPoint("TOPLEFT", 10, -10)
    
    local currentBg = currentClassFrame:CreateTexture(nil, "BACKGROUND")
    currentBg:SetAllPoints()
    currentBg:SetColorTexture(0.3, 0.3, 0.4, 1.0)
    
    local currentTitle = currentClassFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    currentTitle:SetPoint("LEFT", 10, 0)
    currentTitle:SetText("Current Character")
    
    -- Current spec frame
    local currentSpecFrame = CreateFrame("Frame", nil, content)
    currentSpecFrame:SetSize(scrollFrame:GetWidth() - 40, 30)
    currentSpecFrame:SetPoint("TOPLEFT", currentClassFrame, "BOTTOMLEFT", 20, 0)
    
    local currentSpecBg = currentSpecFrame:CreateTexture(nil, "BACKGROUND")
    currentSpecBg:SetAllPoints()
    currentSpecBg:SetColorTexture(0.2, 0.2, 0.3, 1.0)
    
    local classIcon = currentSpecFrame:CreateTexture(nil, "ARTWORK")
    classIcon:SetSize(20, 20)
    classIcon:SetPoint("LEFT", 5, 0)
    
    if WoWLinksData.classIcons[playerClass] then
        classIcon:SetTexture(WoWLinksData.classIcons[playerClass].file)
        classIcon:SetTexCoord(unpack(WoWLinksData.classIcons[playerClass].coords))
    end
    
    local specText = currentSpecFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    specText:SetPoint("LEFT", classIcon, "RIGHT", 5, 0)
    specText:SetText(classDisplayName .. " - " .. currentSpecName)
    if playerClassColor then
        specText:SetTextColor(playerClassColor.r, playerClassColor.g, playerClassColor.b)
    end
    
    local expandButton = CreateFrame("Button", nil, currentSpecFrame)
    expandButton:SetSize(80, 20)
    expandButton:SetPoint("RIGHT", -5, 0)
    
    local expandButtonBg = expandButton:CreateTexture(nil, "BACKGROUND")
    expandButtonBg:SetAllPoints()
    expandButtonBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
    
    local expandButtonText = expandButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    expandButtonText:SetPoint("CENTER", 0, 0)
    expandButtonText:SetText("View Links")
    
    local currentSpecContent = CreateFrame("Frame", nil, content)
    currentSpecContent:SetSize(scrollFrame:GetWidth() - 60, 0)
    currentSpecContent:SetPoint("TOPLEFT", currentSpecFrame, "BOTTOMLEFT", 0, 0)
    currentSpecContent:Hide()
    
    -- Populate current spec data
    local hasPlayerData = false
    if WoWLinksData.classes[playerClass] then
        for specKey, specData in pairs(WoWLinksData.classes[playerClass].specs) do
            if specKey:find(currentSpecName) or currentSpecName:find(specKey) then
                hasPlayerData = true
                self:PopulateSpecContent(currentSpecContent, specData, currentSpecName, playerClass)
                break
            end
        end
    end
    
    if not hasPlayerData then
        local noDataText = currentSpecContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noDataText:SetPoint("CENTER", 0, -15)
        noDataText:SetText("No data available for " .. currentSpecName .. " " .. playerClass)
        currentSpecContent:SetHeight(30)
    end
    
    expandButton:SetScript("OnClick", function()
        if currentSpecContent:IsShown() then
            currentSpecContent:Hide()
            expandButtonText:SetText("View Links")
        else
            currentSpecContent:Show()
            expandButtonText:SetText("Hide Links")
        end
        self:RecalculateContentHeight(content)
    end)
    
    -- Divider and all classes section
    local divider = content:CreateTexture(nil, "ARTWORK")
    divider:SetSize(scrollFrame:GetWidth() - 20, 2)
    divider:SetPoint("TOPLEFT", 10, -80 - (currentSpecContent:IsShown() and currentSpecContent:GetHeight() or 0))
    divider:SetColorTexture(0.4, 0.4, 0.4, 0.8)
    
    local allClassesTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    allClassesTitle:SetPoint("TOPLEFT", 10, -90 - (currentSpecContent:IsShown() and currentSpecContent:GetHeight() or 0))
    allClassesTitle:SetText("All Classes")
    
    -- Create class buttons
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
        expandIcon:SetText("▶")
        
        local dropdown = CreateFrame("Frame", nil, content)
        dropdown:SetSize(scrollFrame:GetWidth() - 40, 0)
        dropdown:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 20, 0)
        dropdown:Hide()
        
        local specYOffset = 0
        
        for specName, specData in pairs(classData.specs) do
            local specButton = CreateFrame("Button", nil, dropdown)
            specButton:SetSize(dropdown:GetWidth(), 25)
            specButton:SetPoint("TOPLEFT", 0, specYOffset)
            
            local specBg = specButton:CreateTexture(nil, "BACKGROUND")
            specBg:SetAllPoints()
            specBg:SetColorTexture(0.2, 0.2, 0.2, 1.0)
            
            local specText = specButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            specText:SetPoint("LEFT", 10, 0)
            specText:SetText(specName)
            specText:SetTextColor(1.0, 0.6, 0.2)
            
            local specExpandIcon = specButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            specExpandIcon:SetPoint("RIGHT", -5, 0)
            specExpandIcon:SetText("▶")
            
            local specContent = CreateFrame("Frame", nil, dropdown)
            specContent:SetSize(dropdown:GetWidth(), 0)
            specContent:SetPoint("TOPLEFT", specButton, "BOTTOMLEFT", 0, 0)
            specContent:Hide()
            
            local specContentBg = specContent:CreateTexture(nil, "BACKGROUND")
            specContentBg:SetAllPoints()
            specContentBg:SetColorTexture(0.13, 0.13, 0.13, 1.0)
            
            self:PopulateSpecContent(specContent, specData, specName, className)
            
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
        
        dropdown:SetHeight(-specYOffset)
        
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
    
    content:SetHeight(math.max(-yOffset + 20, scrollFrame:GetHeight()))
    
    -- Store references
    self.classScrollFrame = scrollFrame
    self.classContent = content
    self.currentSpecContent = currentSpecContent
    self.currentExpandButton = expandButton
    self.allClassesDivider = divider
    self.allClassesTitle = allClassesTitle
    self.classButtons = classButtons
end

function WoWLinks:SetupToolsTab(frame)
    -- Custom scrollframe
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame)
    scrollFrame:SetPoint("TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -20, 0)
    
    -- Create scroll bar
    local scrollbar = CreateFrame("Slider", nil, scrollFrame)
    scrollbar:SetWidth(16)
    scrollbar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 0, 0)
    scrollbar:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0, 0)
    scrollbar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
    local thumb = scrollbar:GetThumbTexture()
    thumb:SetSize(16, 24)
    thumb:SetColorTexture(0.4, 0.4, 0.4, 0.7)
    
    scrollbar:SetMinMaxValues(0, 1000)
    scrollbar:SetValueStep(1)
    scrollbar:SetValue(0)
    
    -- Create scroll frame content 
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(scrollFrame:GetWidth(), 1000) -- Initial height
    scrollFrame:SetScrollChild(content)
    
    -- Set up scrollbar script
    scrollbar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
    end)
    
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
        
        -- Custom visit button
        local visitButton = CreateFrame("Button", nil, toolFrame)
        visitButton:SetSize(80, 22)
        visitButton:SetPoint("TOPRIGHT", -10, -10)
        
        local visitBg = visitButton:CreateTexture(nil, "BACKGROUND")
        visitBg:SetAllPoints()
        visitBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        
        local visitText = visitButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        visitText:SetPoint("CENTER", 0, 0)
        visitText:SetText("Visit")
        
        visitButton:SetScript("OnClick", function()
            WoWLinks:OpenURL(tool.url, tool.name)
        end)
        
        -- Custom favorite checkbox
        local favButton = CreateFrame("CheckButton", nil, toolFrame)
        favButton:SetSize(24, 24)
        favButton:SetPoint("RIGHT", visitButton, "LEFT", -5, 0)
        
        -- Create visuals for checked/unchecked states
        local checkedTexture = favButton:CreateTexture(nil, "ARTWORK")
        checkedTexture:SetAllPoints()
        checkedTexture:SetColorTexture(0, 0.8, 0, 0.8)
        favButton:SetCheckedTexture(checkedTexture)
        
        local uncheckedTexture = favButton:CreateTexture(nil, "ARTWORK")
        uncheckedTexture:SetAllPoints()
        uncheckedTexture:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        favButton:SetNormalTexture(uncheckedTexture)
        
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
    
    -- Create custom scrollframe
    local scrollFrame = CreateFrame("ScrollFrame", nil, self.favoritesTab)
    scrollFrame:SetPoint("TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -20, 0)
    
    -- Create scroll bar
    local scrollbar = CreateFrame("Slider", nil, scrollFrame)
    scrollbar:SetWidth(16)
    scrollbar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 0, 0)
    scrollbar:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0, 0)
    scrollbar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
    local thumb = scrollbar:GetThumbTexture()
    thumb:SetSize(16, 24)
    thumb:SetColorTexture(0.4, 0.4, 0.4, 0.7)
    
    scrollbar:SetMinMaxValues(0, 1000)
    scrollbar:SetValueStep(1)
    scrollbar:SetValue(0)
    
    -- Create scroll frame content 
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(scrollFrame:GetWidth(), 1000) -- Initial height
    scrollFrame:SetScrollChild(content)
    
    -- Set up scrollbar script
    scrollbar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
    end)
    
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
        
        -- Custom visit button
        local visitButton = CreateFrame("Button", nil, favFrame)
        visitButton:SetSize(80, 22)
        visitButton:SetPoint("TOPRIGHT", -10, -10)
        
        local visitBg = visitButton:CreateTexture(nil, "BACKGROUND")
        visitBg:SetAllPoints()
        visitBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        
        local visitText = visitButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        visitText:SetPoint("CENTER", 0, 0)
        visitText:SetText("Visit")
        
        visitButton:SetScript("OnClick", function()
            WoWLinks:OpenURL(favorite.url, favorite.name)
        end)
        
        -- Custom remove button
        local removeButton = CreateFrame("Button", nil, favFrame)
        removeButton:SetSize(80, 22)
        removeButton:SetPoint("TOPRIGHT", visitButton, "TOPLEFT", -5, 0)
        
        local removeBg = removeButton:CreateTexture(nil, "BACKGROUND")
        removeBg:SetAllPoints()
        removeBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
        
        local removeText = removeButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        removeText:SetPoint("CENTER", 0, 0)
        removeText:SetText("Remove")
        
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
    
    -- Scale slider - custom implementation
    local scaleText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scaleText:SetPoint("TOPLEFT", 30, -60)
    scaleText:SetText("UI Scale: " .. WoWLinksDB.settings.scale)
    
    local scaleSlider = CreateFrame("Slider", "WoWLinksScaleSlider", frame)
    scaleSlider:SetPoint("TOPLEFT", 30, -80)
    scaleSlider:SetWidth(200)
    scaleSlider:SetHeight(16)
    scaleSlider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
    local scaleThumb = scaleSlider:GetThumbTexture()
    scaleThumb:SetSize(16, 24)
    
    local scaleSliderTexture = scaleSlider:CreateTexture(nil, "BACKGROUND")
    scaleSliderTexture:SetTexture("Interface\\Buttons\\UI-SliderBar-Border")
    scaleSliderTexture:SetAllPoints()
    
    scaleSlider:SetMinMaxValues(0.5, 1.5)
    scaleSlider:SetValueStep(0.05)
    scaleSlider:SetValue(WoWLinksDB.settings.scale)
    scaleSlider:SetOrientation("HORIZONTAL")
    
    scaleSlider:SetScript("OnValueChanged", function(self, value)
        WoWLinksDB.settings.scale = value
        WoWLinks.frame:SetScale(value)
        scaleText:SetText("UI Scale: " .. string.format("%.2f", value))
    end)
    
    -- Opacity slider - custom implementation
    local opacityText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    opacityText:SetPoint("TOPLEFT", 30, -120)
    opacityText:SetText("UI Opacity: " .. WoWLinksDB.settings.opacity * 100 .. "%")
    
    local opacitySlider = CreateFrame("Slider", "WoWLinksOpacitySlider", frame)
    opacitySlider:SetPoint("TOPLEFT", 30, -140)
    opacitySlider:SetWidth(200)
    opacitySlider:SetHeight(16)
    opacitySlider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
    local opacityThumb = opacitySlider:GetThumbTexture()
    opacityThumb:SetSize(16, 24)
    
    local opacitySliderTexture = opacitySlider:CreateTexture(nil, "BACKGROUND")
    opacitySliderTexture:SetTexture("Interface\\Buttons\\UI-SliderBar-Border")
    opacitySliderTexture:SetAllPoints()
    
    opacitySlider:SetMinMaxValues(0.1, 1)
    opacitySlider:SetValueStep(0.05)
    opacitySlider:SetValue(WoWLinksDB.settings.opacity)
    opacitySlider:SetOrientation("HORIZONTAL")
    
    opacitySlider:SetScript("OnValueChanged", function(self, value)
        WoWLinksDB.settings.opacity = value
        WoWLinks.frame:SetAlpha(value)
        opacityText:SetText("UI Opacity: " .. string.format("%.0f", value * 100) .. "%")
    end)
    
    -- Reset button - custom implementation
    local resetButton = CreateFrame("Button", nil, frame)
    resetButton:SetSize(100, 24)
    resetButton:SetPoint("TOPLEFT", 30, -180)
    
    local resetBg = resetButton:CreateTexture(nil, "BACKGROUND")
    resetBg:SetAllPoints()
    resetBg:SetColorTexture(0.3, 0.3, 0.3, 0.8)
    
    local resetText = resetButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    resetText:SetPoint("CENTER", 0, 0)
    resetText:SetText("Reset Settings")
    
    resetButton:SetScript("OnClick", function()
        WoWLinksDB = nil
        ReloadUI()
    end)
end