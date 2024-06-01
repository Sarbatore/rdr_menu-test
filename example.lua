-------------------
--     Menus     --
-------------------
local firstMenu = Menu("First menu")
	:SetSubheader("This is the subheader") -- The menu must be opened to see the subheader
	:SetFooter("This menu is awesome!")
	:OnOpened(function()
		print("First menu opened")
	end)
	:OnClosed(function()
		print("First menu closed")
	end)

local secondMenu = Menu("Second menu")
	:SetFooter("This menu is awesome too!")
	:SetFooterColor(joaat("COLOR_PURPLE"))
	:OnOpened(function()
		print("Second menu opened")
	end)
	:OnClosed(function()
		print("Second menu closed")
	end)

------------------------
--   First menu Items --
------------------------
local item1, item2, goToSecondMenuItem

item1 = firstMenu:AddItem("Item 1")
	:SetTextColor(joaat("COLOR_BLUE"))
	:OnFocused(function()
		firstMenu:SetFooter("You can use")
	end)
	:OnUnfocused(function()
		firstMenu:SetHeader("item 1 is unfocused")
	end)

item2 = firstMenu:AddItem("Item 2")
	:OnFocused(function()
		firstMenu:SetFooter("on focus")
	end)

goToSecondMenuItem = firstMenu:AddItem("Second menu >>")
	:SetTextColor(joaat("COLOR_RED"))
	:OnFocused(function()
		firstMenu:SetFooter("event callbacks")
	end)
	:OnSelected(function()
		secondMenu:Open()
	end)

local smallImageItem = firstMenu:AddSmallImageItem("Small image item", joaat("HUD_TOASTS"), 1249997984)
	:SetImgColor(joaat("COLOR_YELLOW"))
	--:SetImgVisible(false)
	:OnFocused(function()
		firstMenu:SetFooter("The small image item is focused")
	end)
	:OnSelected(function()
		firstMenu:SetFooter("The small image item is selected")
	end)

local image = firstMenu:AddImage(joaat("HUD_TOASTS"), 1249997984)

-------------------------
--   Second menu Items --
-------------------------

local invisibleItem, setHeaderItem, firstMenuItem

for i=1, 3 do
	secondMenu:AddItem("Item Example " .. i):SetEnabled(false):OnFocused(function()
		secondMenu:SetHeader("Header for item " .. i)
	end)
end

setHeaderItem = secondMenu:AddImageItem("Toggle visibility", joaat("HUD_TOASTS"), 1249997984)
	:SetImgColor(joaat("COLOR_RED"))
	:SetSubtext("Oh its a subtext")
	:SetSubtextColor(joaat("COLOR_BLUE"))
	:OnFocused(function()
		secondMenu:SetHeader("This is the new header")
	end)
	:OnSelected(function()
		invisibleItem:SetVisible(true)
		setHeaderItem:SetVisible(false)
	end)

firstMenuItem = secondMenu:AddItem("First menu >>")
	:OnSelected(function()
		firstMenu:Open()
	end)
	
for i=4, 7 do
	secondMenu:AddItem("Item Example " .. i):SetEnabled(false)
end

invisibleItem = secondMenu:AddItem("Invisible item")
	:SetVisible(false)
	:OnSelected(function()
		invisibleItem:SetVisible(false)
		setHeaderItem:SetVisible(true)
	end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		-- Open the menu
		if (IsControlJustPressed(0, 0x760A9C6F)) then
			firstMenu:Open()
		end
	end
end)


AddEventHandler("onResourceStop", function(resource)
	if (GetCurrentResourceName() ~= resource) then return end

	CloseAllUiapps()
end)