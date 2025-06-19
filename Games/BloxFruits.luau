-- Zioles Task GUI for Blox Fruits | Full Redz Hub–Style Features by Brtskib return function(fetcher) local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local ReplicatedStorage = game:GetService("ReplicatedStorage") local Workspace = game:GetService("Workspace") local CoreGui = game:GetService("CoreGui") local VirtualInputManager = game:GetService("VirtualInputManager") local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerData = player:WaitForChild("Data")

-- Gui Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZiolesTaskGUI"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundTransparency = 1
toggleBtn.Image = "rbxassetid://74791331749289"
toggleBtn.Parent = screenGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 480)
mainFrame.Position = UDim2.new(0, 80, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Visible = false
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

toggleBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Tabs Setup
local tabNames = {"Farming", "Stats", "ESP", "Utility", "Raids"}
local tabs, toggles, currentTab = {}, {}, nil

for i, name in ipairs(tabNames) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 80, 0, 30)
	btn.Position = UDim2.new(0, (i - 1) * 90 + 10, 0, 10)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Parent = mainFrame

	local tabFrame = Instance.new("Frame")
	tabFrame.Size = UDim2.new(1, -20, 1, -50)
	tabFrame.Position = UDim2.new(0, 10, 0, 50)
	tabFrame.Visible = false
	tabFrame.BackgroundTransparency = 1
	tabFrame.Parent = mainFrame
	tabs[name] = tabFrame

	btn.MouseButton1Click:Connect(function()
		if currentTab then tabs[currentTab].Visible = false end
		tabs[name].Visible = true
		currentTab = name
	end)
end

-- Utility: Weapon Selector
local selectedWeapon = ""
local dropdown = Instance.new("TextButton")
dropdown.Size = UDim2.new(0, 200, 0, 30)
dropdown.Position = UDim2.new(0, 10, 0, 10)
dropdown.Text = "Select Weapon"
dropdown.Parent = tabs["Farming"]
dropdown.MouseButton1Click:Connect(function()
	for _, child in pairs(tabs["Farming"]:GetChildren()) do
		if child:IsA("TextButton") and child.Name == "Option" then child:Destroy() end
	end
	local y = 50
	for _, tool in ipairs(player.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			local opt = Instance.new("TextButton")
			opt.Size = UDim2.new(0, 200, 0, 30)
			opt.Position = UDim2.new(0, 10, 0, y)
			opt.Text = tool.Name
			opt.Name = "Option"
			opt.Parent = tabs["Farming"]
			y = y + 35
			opt.MouseButton1Click:Connect(function()
				selectedWeapon = tool.Name
				dropdown.Text = "Selected: " .. tool.Name
				for _, b in pairs(tabs["Farming"]:GetChildren()) do if b.Name == "Option" then b:Destroy() end end
			end)
		end
	end
end)

-- Feature Toggles
local function makeToggle(tab, labelText, default, callback)
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 200, 0, 30)
	toggle.Position = UDim2.new(0, 10, 0, #tab:GetChildren() * 35)
	toggle.Text = labelText .. ": " .. (default and "ON" or "OFF")
	toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	toggle.TextColor3 = Color3.new(1, 1, 1)
	toggle.Parent = tab

	local state = default
	toggle.MouseButton1Click:Connect(function()
		state = not state
		toggle.Text = labelText .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)
end

-- Auto Farm
local function startAutoFarm()
	local farming = true
	spawn(function()
		while farming do
			task.wait(0.3)
			if selectedWeapon == "" then continue end
			-- Dummy simplified logic here, add your full quest/farm logic
			-- Auto quest, mob detect, tween to mob, attack with VirtualInputManager
		end
	end)
end

makeToggle(tabs["Farming"], "Auto Farm", false, function(v)
	if v then startAutoFarm() end
end)

-- Fruit ESP
makeToggle(tabs["ESP"], "Fruit ESP", false, function(enabled)
	spawn(function()
		while enabled do
			for _, fruit in ipairs(Workspace:GetChildren()) do
				if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
					if not fruit:FindFirstChild("ESP") then
						local b = Instance.new("BillboardGui", fruit)
						b.Name = "ESP"
						b.Size = UDim2.new(0, 100, 0, 50)
						b.Adornee = fruit.Handle
						b.AlwaysOnTop = true
						local txt = Instance.new("TextLabel", b)
						txt.Size = UDim2.new(1, 0, 1, 0)
						txt.BackgroundTransparency = 1
						txt.Text = fruit.Name
						txt.TextColor3 = Color3.fromRGB(255, 255, 0)
						txt.TextScaled = true
					end
				end
			end
			task.wait(5)
		end
	end)
end)

-- Player ESP
makeToggle(tabs["ESP"], "Player ESP", false, function(enabled)
	spawn(function()
		while enabled do
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					if not plr.Character:FindFirstChild("ESP") then
						local b = Instance.new("BillboardGui", plr.Character.HumanoidRootPart)
						b.Name = "ESP"
						b.Size = UDim2.new(0, 100, 0, 40)
						b.AlwaysOnTop = true
						local txt = Instance.new("TextLabel", b)
						txt.Size = UDim2.new(1, 0, 1, 0)
						txt.BackgroundTransparency = 1
						txt.Text = plr.DisplayName
						txt.TextColor3 = Color3.new(1, 1, 1)
						txt.TextScaled = true
					end
				end
			end
			task.wait(3)
		end
	end)
end)

end

