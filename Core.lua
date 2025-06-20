local addonname = ...

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
    
    -- Similar implementation for guides section
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