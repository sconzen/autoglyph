SLASH_AUTOGLYPH1, SLASH_AUTOGLYPH2 = '/ag','/autoglyph';
function SlashCmdList.AUTOGLYPH(msg, editbox)
	local frame
	autoglyph();
end

function autoglyph()
	local playerClass, englishClass = UnitClass("player");
	local currentSpec = GetSpecialization()
	local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"

	x = 'Current Glyphs : \n';
	y = 'Recommended Glyphs : \n';

	if (playerClass == 'Death Knight') then
		if (currentSpecName == 'Blood') then 				glyphArray = aa;
		elseif (currentSpecName =='Frost') then 			glyphArray = ab;
		elseif (currentSpecName == 'Unholy') then 			glyphArray = ac;
		else end
	elseif (playerClass == 'Druid') then
		if (currentSpecName == 'Balance') then 				glyphArray = ba;
		elseif (currentSpecName =='Guardian') then 			glyphArray = bb;
		elseif (currentSpecName == 'Feral') then 			glyphArray = bc;
		elseif (currentSpecName == 'Restoration') then 		glyphArray = bd;
		else end
	elseif (playerClass == 'Hunter') then
		if (currentSpecName == 'Beast Mastery') then 		glyphArray = ca;
		elseif (currentSpecName =='Marksmanship') then 		glyphArray = cb;
		elseif (currentSpecName == 'Survival') then 		glyphArray = cc;
		else end
	elseif (playerClass == 'Mage') then
		if (currentSpecName == 'Arcane') then 				glyphArray = da;
		elseif (currentSpecName =='Fire') then 				glyphArray = db;
		elseif (currentSpecName == 'Frost') then 			glyphArray = dc;
		else end
	elseif (playerClass == 'Monk') then
		if (currentSpecName == 'Brewmaster') then 			glyphArray = ea;
		elseif (currentSpecName =='Windwalker') then 		glyphArray = eb;
		elseif (currentSpecName == 'Mistweaver') then 		glyphArray = ec;
		else end
	elseif (playerClass == 'Paladin') then
		if (currentSpecName == 'Holy') then 				glyphArray = fa;
		elseif (currentSpecName =='Protection') then 		glyphArray = fb;
		elseif (currentSpecName == 'Retribution') then 		glyphArray = fc;
		else end
	elseif (playerClass == 'Priest') then
		if (currentSpecName == 'Discipline') then 			glyphArray = ga;
		elseif (currentSpecName =='Shadow') then 			glyphArray = gb;
		elseif (currentSpecName == 'Holy') then 			glyphArray = gc;
		else end
	elseif (playerClass == 'Rogue') then
		if (currentSpecName == 'Assassination') then 		glyphArray = ha;
		elseif (currentSpecName =='Combat') then 			glyphArray = hb;
		elseif (currentSpecName == 'Subtelty') then 		glyphArray = hc;
		else end
	elseif (playerClass == 'Shaman') then
		if (currentSpecName == 'Elemental') then 			glyphArray = ia;
		elseif (currentSpecName =='Enhancement') then 		glyphArray = ib;
		elseif (currentSpecName == 'Restoration') then 		glyphArray = ic;
		else end
	elseif (playerClass == 'Warlock') then
		if (currentSpecName == 'Affliction') then 			glyphArray = ja;
		elseif (currentSpecName =='Demonology') then 		glyphArray = jb;
		elseif (currentSpecName == 'Destruction') then 		glyphArray = jc;
		else end
	elseif (playerClass == 'Warrior') then
		if (currentSpecName == 'Arms') then 				glyphArray = ka;
		elseif (currentSpecName =='Fury') then 				glyphArray = kb;
		elseif (currentSpecName == 'Protection') then 		glyphArray = kc;
		else end
	else end

	for i = 1, NUM_GLYPH_SLOTS do
		 local enabled, glyphType, glyphTooltipIndex, glyphSpellID, icon = GetGlyphSocketInfo(i);
		 if ( enabled ) then
		  local link = GetSpellInfo(glyphSpellID);
		  if ( link ~= "") then
		   
   			for j = 1, NUM_GLYPH_SLOTS do
   				if (link == glyphArray[j]) then
   					link = '|cFF00FF00' .. link .. '|r';
   				elseif (link == nil) then
   					link = blank;
   				else
   					link = link;
   				end
   			end
   			x = x .. link .. '\n';
   			
		else
			DEFAULT_CHAT_FRAME:AddMessage("Glyph Socket "..i.." is unlocked and empty!");
		end
		else
			DEFAULT_CHAT_FRAME:AddMessage("Glyph Socket "..i.." is locked!");
		end
	end

	for k = 1, table.getn(glyphArray) do
		y = y .. glyphArray[k] .. '\n';	
	end

	if not frame then
	frame = createFrame();
	    tinsert(UISpecialFrames, "autoglyphframe")
	else
		frame:Show()
	end
end

function createFrame()

	local frame = CreateFrame("Frame", "autoglyphframe", UIParent)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetScript("OnMouseDown", function(self, button)
	  if button == "LeftButton" and not self.isMoving then
	   self:StartMoving();
	   self.isMoving = true;
	  end
	end)
	frame:SetScript("OnMouseUp", function(self, button)
	  if button == "LeftButton" and self.isMoving then
	   self:StopMovingOrSizing();
	   self.isMoving = false;
	  end
	end)
	frame:SetScript("OnHide", function(self)
	  if ( self.isMoving ) then
	   self:StopMovingOrSizing();
	   self.isMoving = false;
	  end
	end)
	frame:SetBackdrop( { 
	   	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background",  
  		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border", tile = false, tileSize = 0, edgeSize = 32, 
	  	insets = { left = 0, right = 0, top = 0, bottom = 0 }
	});

	frame:SetPoint("CENTER"); frame:SetWidth(500); frame:SetHeight(250);
	local tex = frame:CreateTexture("ARTWORK");
	tex:SetAllPoints();
	tex:SetTexture(0, 0, 0); tex:SetAlpha(0.5);

	local leftText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	leftText:SetPoint("TOPLEFT",20,-20)
	leftText:SetText(x)

	local rightText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	rightText:SetPoint("TOPRIGHT",-20,-20)
	rightText:SetText(y)

	-- magic = CreateFrame("Button","magic",frame,"UIPanelButtonTemplate")
	-- magic:SetPoint("BOTTOM",0,20)
	-- magic:SetWidth(100)
	-- magic:SetHeight(30)
	-- magic:SetText("Automagic")
	-- magic:SetScript("OnClick", function(self, button, down)
	--   swapGlyphs();
	-- end)

	close = CreateFrame("Button","close",frame,"UIPanelCloseButton")
	close:SetPoint("TOPRIGHT",7,7)

	return frame
	
end

function swapGlyphs()
	-- DEFAULT_CHAT_FRAME:AddMessage('magic!!!');

	for i = 1, NUM_GLYPH_SLOTS do
		local enabled, glyphType, glyphTooltipIndex, glyphSpellID, icon = GetGlyphSocketInfo(i);
		DEFAULT_CHAT_FRAME:AddMessage(i .. ' ' .. GetSpellInfo(glyphSpellID));
		RemoveGlyphFromSocket(i);
	end
end
