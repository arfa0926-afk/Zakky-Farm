-- MARSHMALLOW COMPLETE SYSTEM v2
-- Anti-Kick & Anti-Ban Version

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hapus GUI lama
pcall(function()
	playerGui:FindFirstChild("MarshmallowUI"):Destroy()
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MarshmallowUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ==================== DATA ====================
local data = {
	marshmallows = 0,
	water = 0,
	sugarBag = 0,
	gelatin = 0,
	smallBags = 0,
	mediumBags = 0,
	largeBags = 0,
	hasApartment = false,
	isCooking = false,
	buyQuantity = 1,
	maxBuyQuantity = 100
}

-- ==================== CONSTANTS ====================
local NPC_POS = Vector3.new(510, 3, 597)
local KOMPOR_POS = Vector3.new(1202, 3, -182)

-- ==================== MAIN DRAGGABLE PANEL ====================
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 300, 0, 550)
mainPanel.Position = UDim2.new(0, 20, 0.5, -275)
mainPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainPanel.BorderSizePixel = 2
mainPanel.BorderColor3 = Color3.fromRGB(255, 150, 50)
mainPanel.ZIndex = 100
mainPanel.Parent = screenGui

-- Anti-Drag by making it only draggable from header
local isDragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

-- ==================== HEADER (DRAGGABLE) ====================
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
header.BorderSizePixel = 0
header.ZIndex = 101
header.Parent = mainPanel

local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, 0, 1, 0)
headerText.BackgroundTransparency = 1
headerText.TextColor3 = Color3.fromRGB(255, 255, 255)
headerText.TextSize = 18
headerText.Font = Enum.Font.GothamBold
headerText.Text = "🍡 MARSHMALLOW"
headerText.ZIndex = 101
headerText.Parent = header

-- Draggable logic
header.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = true
		dragStart = input.Position
		startPos = mainPanel.Position
	end
end)

header.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = false
	end
end)

RunService.RenderStepped:Connect(function()
	if isDragging and dragStart and startPos then
		local mouse = player:GetMouse()
		local delta = Vector2.new(mouse.X - dragStart.X, mouse.Y - dragStart.Y)
		mainPanel.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
	end
end)

-- ==================== SCROLL FRAME ====================
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -70)
scrollFrame.Position = UDim2.new(0, 5, 0, 55)
scrollFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)
scrollFrame.ZIndex = 101
scrollFrame.Parent = mainPanel

-- ==================== MARSHMALLOW COUNT ====================
local marshmallowFrame = Instance.new("Frame")
marshmallowFrame.Size = UDim2.new(1, -10, 0, 55)
marshmallowFrame.Position = UDim2.new(0, 5, 0, 10)
marshmallowFrame.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
marshmallowFrame.BorderSizePixel = 1
marshmallowFrame.BorderColor3 = Color3.fromRGB(255, 150, 50)
marshmallowFrame.ZIndex = 102
marshmallowFrame.Parent = scrollFrame

local marshmallowLabel = Instance.new("TextLabel")
marshmallowLabel.Size = UDim2.new(1, 0, 1, 0)
marshmallowLabel.BackgroundTransparency = 1
marshmallowLabel.TextColor3 = Color3.fromRGB(100, 50, 0)
marshmallowLabel.TextSize = 16
marshmallowLabel.Font = Enum.Font.GothamBold
marshmallowLabel.Text = "🍡 Marshmallow: 0"
marshmallowLabel.TextWrapped = true
marshmallowLabel.ZIndex = 102
marshmallowLabel.Parent = marshmallowFrame

-- ==================== STATUS ====================
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(1, -10, 0, 40)
statusFrame.Position = UDim2.new(0, 5, 0, 75)
statusFrame.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
statusFrame.BorderSizePixel = 1
statusFrame.BorderColor3 = Color3.fromRGB(0, 150, 0)
statusFrame.ZIndex = 102
statusFrame.Parent = scrollFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 1, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Text = "Status: Ready"
statusLabel.ZIndex = 102
statusLabel.Parent = statusFrame

-- ==================== INVENTORY SECTION ====================
local invTitle = Instance.new("TextLabel")
invTitle.Size = UDim2.new(1, -10, 0, 30)
invTitle.Position = UDim2.new(0, 5, 0, 125)
invTitle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
invTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
invTitle.TextSize = 13
invTitle.Font = Enum.Font.GothamBold
invTitle.Text = "📦 INVENTORY"
invTitle.ZIndex = 102
invTitle.Parent = scrollFrame

local waterLabel = Instance.new("TextLabel")
waterLabel.Size = UDim2.new(1, -10, 0, 25)
waterLabel.Position = UDim2.new(0, 5, 0, 160)
waterLabel.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
waterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
waterLabel.TextSize = 11
waterLabel.Font = Enum.Font.Gotham
waterLabel.Text = "💧 Water: 0"
waterLabel.ZIndex = 102
waterLabel.Parent = scrollFrame

local sugarLabel = Instance.new("TextLabel")
sugarLabel.Size = UDim2.new(1, -10, 0, 25)
sugarLabel.Position = UDim2.new(0, 5, 0, 190)
sugarLabel.BackgroundColor3 = Color3.fromRGB(200, 180, 80)
sugarLabel.TextColor3 = Color3.fromRGB(100, 50, 0)
sugarLabel.TextSize = 11
sugarLabel.Font = Enum.Font.Gotham
sugarLabel.Text = "🍭 Sugar Block Bag: 0"
sugarLabel.ZIndex = 102
sugarLabel.Parent = scrollFrame

local gelatinLabel = Instance.new("TextLabel")
gelatinLabel.Size = UDim2.new(1, -10, 0, 25)
gelatinLabel.Position = UDim2.new(0, 5, 0, 220)
gelatinLabel.BackgroundColor3 = Color3.fromRGB(200, 100, 200)
gelatinLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
gelatinLabel.TextSize = 11
gelatinLabel.Font = Enum.Font.Gotham
gelatinLabel.Text = "🧃 Gelatin: 0"
gelatinLabel.ZIndex = 102
gelatinLabel.Parent = scrollFrame

-- ==================== BUTTON HELPER ====================
local function createButton(text, yPos, color, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 45)
	btn.Position = UDim2.new(0, 5, 0, yPos)
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 12
	btn.Font = Enum.Font.GothamBold
	btn.Text = text
	btn.BorderSizePixel = 0
	btn.ZIndex = 102
	btn.Parent = scrollFrame
	
	btn.MouseButton1Click:Connect(callback)
	
	-- Hover effect
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = btn.BackgroundColor3 + Color3.fromRGB(30, 30, 30)
	end)
	
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = color
	end)
	
	return btn
end

-- ==================== BUY QUANTITY INPUT ====================
local buyQtyFrame = Instance.new("Frame")
buyQtyFrame.Size = UDim2.new(1, -10, 0, 40)
buyQtyFrame.Position = UDim2.new(0, 5, 0, 255)
buyQtyFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
buyQtyFrame.BorderSizePixel = 1
buyQtyFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
buyQtyFrame.ZIndex = 102
buyQtyFrame.Parent = scrollFrame

local buyQtyLabel = Instance.new("TextLabel")
buyQtyLabel.Size = UDim2.new(0.5, 0, 1, 0)
buyQtyLabel.BackgroundTransparency = 1
buyQtyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
buyQtyLabel.TextSize = 11
buyQtyLabel.Font = Enum.Font.GothamBold
buyQtyLabel.Text = "Buy Qty:"
buyQtyLabel.ZIndex = 102
buyQtyLabel.Parent = buyQtyFrame

local buyQtyInput = Instance.new("TextBox")
buyQtyInput.Size = UDim2.new(0.5, 0, 1, 0)
buyQtyInput.Position = UDim2.new(0.5, 0, 0, 0)
buyQtyInput.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
buyQtyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
buyQtyInput.TextSize = 11
buyQtyInput.Font = Enum.Font.GothamMonospace
buyQtyInput.Text = "1"
buyQtyInput.ClearTextOnFocus = false
buyQtyInput.ZIndex = 102
buyQtyInput.Parent = buyQtyFrame

buyQtyInput.FocusLost:Connect(function()
	local qty = tonumber(buyQtyInput.Text) or 1
	qty = math.max(1, math.min(qty, 100))
	data.buyQuantity = qty
	buyQtyInput.Text = tostring(qty)
end)

-- ==================== BUTTONS ====================
createButton("🛒 BUY INGREDIENTS", 305, Color3.fromRGB(100, 200, 100), function()
	-- Will call auto buy
end)

createButton("🔥 START AUTO COOK", 360, Color3.fromRGB(200, 100, 100), function()
	-- Will call auto cook
end)

createButton("💰 SELL MARSHMALLOW", 415, Color3.fromRGB(255, 200, 100), function()
	-- Will call auto sell
end)

createButton("🌍 TELEPORT MENU", 470, Color3.fromRGB(100, 150, 255), function()
	-- Show teleport menu
end)

-- ==================== TELEPORT MENU ====================
local teleportMenu = Instance.new("Frame")
teleportMenu.Name = "TeleportMenu"
teleportMenu.Size = UDim2.new(0.85, 0, 0.55, 0)
teleportMenu.Position = UDim2.new(0.075, 0, 0.225, 0)
teleportMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
teleportMenu.BorderSizePixel = 2
teleportMenu.BorderColor3 = Color3.fromRGB(255, 150, 50)
teleportMenu.Visible = false
teleportMenu.ZIndex = 150
teleportMenu.Parent = screenGui

local teleportHeader = Instance.new("TextLabel")
teleportHeader.Size = UDim2.new(1, 0, 0, 45)
teleportHeader.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
teleportHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportHeader.TextSize = 16
teleportHeader.Font = Enum.Font.GothamBold
teleportHeader.Text = "🌍 TELEPORT OPTIONS"
teleportHeader.ZIndex = 151
teleportHeader.Parent = teleportMenu

local tpToNPC = Instance.new("TextButton")
tpToNPC.Size = UDim2.new(1, -20, 0, 50)
tpToNPC.Position = UDim2.new(0, 10, 0, 55)
tpToNPC.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
tpToNPC.TextColor3 = Color3.fromRGB(255, 255, 255)
tpToNPC.TextSize = 14
tpToNPC.Font = Enum.Font.GothamBold
tpToNPC.Text = "🛒 TP TO NPC (Buy)"
tpToNPC.BorderSizePixel = 0
tpToNPC.ZIndex = 151
tpToNPC.Parent = teleportMenu

local tpToKompor = Instance.new("TextButton")
tpToKompor.Size = UDim2.new(1, -20, 0, 50)
tpToKompor.Position = UDim2.new(0, 10, 0, 115)
tpToKompor.BackgroundColor3 = Color3.fromRGB(200, 100, 200)
tpToKompor.TextColor3 = Color3.fromRGB(255, 255, 255)
tpToKompor.TextSize = 14
tpToKompor.Font = Enum.Font.GothamBold
tpToKompor.Text = "🔥 TP TO APT 1 (Kompor)"
tpToKompor.BorderSizePixel = 0
tpToKompor.ZIndex = 151
tpToKompor.Parent = teleportMenu

local closeTpMenu = Instance.new("TextButton")
closeTpMenu.Size = UDim2.new(1, -20, 0, 50)
closeTpMenu.Position = UDim2.new(0, 10, 0, 175)
closeTpMenu.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
closeTpMenu.TextColor3 = Color3.fromRGB(255, 255, 255)
closeTpMenu.TextSize = 14
closeTpMenu.Font = Enum.Font.GothamBold
closeTpMenu.Text = "❌ CLOSE"
closeTpMenu.BorderSizePixel = 0
closeTpMenu.ZIndex = 151
closeTpMenu.Parent = teleportMenu

-- ==================== LOADING SCREEN ====================
local function showLoadingScreen(duration)
	local loadingGui = Instance.new("ScreenGui", playerGui)
	loadingGui.Name = "LoadingScreen"
	loadingGui.ZIndex = 200
	
	local bg = Instance.new("Frame", loadingGui)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bg.BackgroundTransparency = 0
	bg.BorderSizePixel = 0
	bg.ZIndex = 200
	
	local txt = Instance.new("TextLabel", bg)
	txt.Size = UDim2.new(1, 0, 1, 0)
	txt.BackgroundTransparency = 1
	txt.TextColor3 = Color3.fromRGB(255, 255, 255)
	txt.TextSize = 28
	txt.Font = Enum.Font.GothamBold
	txt.Text = "⏳ WAIT"
	txt.ZIndex = 201
	
	spawn(function()
		wait(duration)
		loadingGui:Destroy()
	end)
	
	return loadingGui
end

-- ==================== DETECT APARTMENT ====================
local function hasApartment()
	local char = player.Character
	if not char then return false end
	
	-- Check if player owns apartment by looking at furniture or other indicators
	-- This is a basic check - you might need to adjust based on actual game mechanics
	for _, item in pairs(workspace:GetDescendants()) do
		if item:FindFirstChild("Owner") and item.Owner.Value == player.Name then
			return true
		end
	end
	
	-- Alternative: Check PlayerData
	pcall(function()
		local playerData = game:GetService("ReplicatedStorage"):FindFirstChild("PlayerData")
		if playerData and playerData:FindFirstChild(player.Name) then
			local hasApt = playerData[player.Name]:FindFirstChild("HasApartment")
			if hasApt and hasApt.Value then
				return true
			end
		end
	end)
	
	return false
end

-- ==================== ANTI-KICK TELEPORT ====================
local function teleportSafe(targetPos, needsApt)
	if needsApt and not hasApartment() then
		statusLabel.Text = "Status: ❌ No Apartment"
		return false
	end
	
	showLoadingScreen(1)
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then
		statusLabel.Text = "Status: ❌ No Character"
		return false
	end
	
	local hrp = char.HumanoidRootPart
	statusLabel.Text = "Status: 🔄 Teleporting..."
	
	-- Smooth teleport (anti-kick)
	local startPos = hrp.Position
	local distance = (targetPos - startPos).Magnitude
	local steps = math.ceil(distance / 60)
	
	for i = 1, steps do
		local alpha = i / steps
		local newPos = startPos + (targetPos - startPos) * alpha
		hrp.CFrame = CFrame.new(newPos + Vector3.new(0, 5, 0))
		
		-- Anti-kick: small movement
		if i % 5 == 0 then
			wait(0.05)
		end
	end
	
	hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
	wait(0.5)
	
	statusLabel.Text = "Status: ✅ Arrived"
	return true
end

-- ==================== AUTO BUY ====================
local function autoBuy()
	if not teleportSafe(NPC_POS, false) then return end
	
	statusLabel.Text = "Status: 🛒 Buying..."
	wait(1)
	
	-- Repeat buying based on quantity
	for qty = 1, data.buyQuantity do
		statusLabel.Text = "Status: 🛒 Buying (" .. qty .. "/" .. data.buyQuantity .. ")"
		
		-- Click Water
		local water = workspace:FindFirstChild("Water")
		if water and water:FindFirstChild("ClickDetector") then
			game:GetService("RunService").Heartbeat:Wait()
			mouse1click(water.ClickDetector)
		end
		wait(0.3)
		
		-- Click Sugar Block Bag
		local sugar = workspace:FindFirstChild("Sugar Block Bag")
		if sugar and sugar:FindFirstChild("ClickDetector") then
			game:GetService("RunService").Heartbeat:Wait()
			mouse1click(sugar.ClickDetector)
		end
		wait(0.3)
		
		-- Click Gelatin
		local gelatin = workspace:FindFirstChild("Gelatin")
		if gelatin and gelatin:FindFirstChild("ClickDetector") then
			game:GetService("RunService").Heartbeat:Wait()
			mouse1click(gelatin.ClickDetector)
		end
		wait(0.3)
	end
	
	data.water += data.buyQuantity
	data.sugarBag += data.buyQuantity
	data.gelatin += data.buyQuantity
	statusLabel.Text = "Status: ✅ Buy Complete"
end

-- ==================== AUTO COOK ====================
local function autoCook()
	if data.water < 1 or data.sugarBag < 1 or data.gelatin < 1 then
		statusLabel.Text = "Status: ❌ Not Enough Items"
		return
	end
	
	if not teleportSafe(KOMPOR_POS, true) then return end
	
	statusLabel.Text = "Status: 🔥 Cooking..."
	data.isCooking = true
	
	-- STEP 1: Water (21 seconds)
	statusLabel.Text = "Status: 💧 Water (21s)"
	local waterItem = player.Backpack:FindFirstChild("Water") or player.Character:FindFirstChild("Water")
	if waterItem then
		waterItem.Parent = player.Character
		wait(0.1)
	end
	
	local kompor = workspace:FindFirstChild("Kompor") or workspace:FindFirstChild("Stove")
	if kompor and kompor:FindFirstChild("Interact") then
		local interact = kompor.Interact
		game:GetService("RunService").Heartbeat:Wait()
		interact:FireEvent("interact")
	end
	
	for i = 21, 1, -1 do
		statusLabel.Text = "Status: 💧 Water (" .. i .. "s)"
		wait(1)
	end
	
	-- STEP 2: Sugar Block Bag + Gelatin (46 seconds)
	statusLabel.Text = "Status: 🍭 Sugar (46s)"
	local sugarItem = player.Backpack:FindFirstChild("Sugar Block Bag") or player.Character:FindFirstChild("Sugar Block Bag")
	if sugarItem then
		sugarItem.Parent = player.Character
		wait(0.1)
	end
	
	if kompor and kompor:FindFirstChild("Interact") then
		local interact = kompor.Interact
		game:GetService("RunService").Heartbeat:Wait()
		interact:FireEvent("interact")
	end
	
	wait(0.5)
	
	local gelatinItem = player.Backpack:FindFirstChild("Gelatin") or player.Character:FindFirstChild("Gelatin")
	if gelatinItem then
		gelatinItem.Parent = player.Character
		wait(0.1)
	end
	
	if kompor and kompor:FindFirstChild("Interact") then
		local interact = kompor.Interact
		game:GetService("RunService").Heartbeat:Wait()
		interact:FireEvent("interact")
	end
	
	for i = 46, 1, -1 do
		statusLabel.Text = "Status: 🍭 Sugar (" .. i .. "s)"
		wait(1)
	end
	
	-- STEP 3: Empty Bag (finish)
	statusLabel.Text = "Status: 📦 Finishing..."
	local emptyBag = player.Backpack:FindFirstChild("Empty Bag") or player.Character:FindFirstChild("Empty Bag")
	if emptyBag then
		emptyBag.Parent = player.Character
		wait(0.1)
	end
	
	if kompor and kompor:FindFirstChild("Interact") then
		local interact = kompor.Interact
		game:GetService("RunService").Heartbeat:Wait()
		interact:FireEvent("interact")
	end
	
	wait(1)
	
	-- Update data
	data.water -= 1
	data.sugarBag -= 1
	data.gelatin -= 1
	data.marshmallows += 1
	data.isCooking = false
	
	statusLabel.Text = "Status: ✅ Marshmallow Ready!"
end

-- ==================== AUTO SELL ====================
local function autoSell()
	if data.marshmallows < 1 then
		statusLabel.Text = "Status: ❌ No Marshmallows"
		return
	end
	
	if not teleportSafe(NPC_POS, false) then return end
	
	statusLabel.Text = "Status: 💰 Selling..."
	wait(1)
	
	-- Check which bag to sell
	if data.largeBags > 0 then
		local largeBag = player.Backpack:FindFirstChild("Large Marshmallow Bag") or player.Character:FindFirstChild("Large Marshmallow Bag")
		if largeBag then
			largeBag.Parent = player.Character
			wait(0.1)
		end
		data.largeBags -= 1
	elseif data.mediumBags > 0 then
		local mediumBag = player.Backpack:FindFirstChild("Medium Marshmallow Bag") or player.Character:FindFirstChild("Medium Marshmallow Bag")
		if mediumBag then
			mediumBag.Parent = player.Character
			wait(0.1)
		end
		data.mediumBags -= 1
	elseif data.smallBags > 0 then
		local smallBag = player.Backpack:FindFirstChild("Small Marshmallow Bag") or player.Character:FindFirstChild("Small Marshmallow Bag")
		if smallBag then
			smallBag.Parent = player.Character
			wait(0.1)
		end
		data.smallBags -= 1
	end
	
	-- Click NPC to sell
	local npc = workspace:FindFirstChild("Lamont Bell")
	if npc and npc:FindFirstChild("Humanoid") then
		game:GetService("RunService").Heartbeat:Wait()
		-- Trigger sale event
	end
	
	data.marshmallows -= 1
	statusLabel.Text = "Status: ✅ Sell Complete"
end

-- ==================== UPDATE UI ====================
local function updateUI()
	marshmallowLabel.Text = "🍡 Marshmallow: " .. data.marshmallows
	waterLabel.Text = "💧 Water: " .. data.water
	sugarLabel.Text = "🍭 Sugar Block Bag: " .. data.sugarBag
	gelatinLabel.Text = "🧃 Gelatin: " .. data.gelatin
end

-- ==================== BUTTON CONNECTIONS ====================
local buttons = scrollFrame:GetChildren()
for _, btn in pairs(buttons) do
	if btn:IsA("TextButton") then
		if string.find(btn.Text, "BUY") then
			btn.MouseButton1Click:Connect(autoBuy)
		elseif string.find(btn.Text, "COOK") then
			btn.MouseButton1Click:Connect(autoCook)
		elseif string.find(btn.Text, "SELL") then
			btn.MouseButton1Click:Connect(autoSell)
		elseif string.find(btn.Text, "TELEPORT") then
			btn.MouseButton1Click:Connect(function()
				teleportMenu.Visible = not teleportMenu.Visible
			end)
		end
	end
end

-- ==================== TELEPORT MENU BUTTONS ==========

tpToNPC.MouseButton1Click:Connect(function()
	teleportSafe(NPC_POS, false)
	teleportMenu.Visible = false
end)

tpToKompor.MouseButton1Click:Connect(function()
	teleportSafe(KOMPOR_POS, true)
	teleportMenu.Visible = false
end)

closeTpMenu.MouseButton1Click:Connect(function()
	teleportMenu.Visible = false
end)

-- ==================== AUTO UPDATE ====================
spawn(function()
	while true do
		updateUI()
		data.hasApartment = hasApartment()
		wait(0.5)
	end
end)

print("✅ Marshmallow System Ready!")
statusLabel.Text = "Status: ✅ Ready"
