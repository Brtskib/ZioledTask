-- Blox Fruits Script (Zioled Task GUI by Brtskib with Tabs, Auto Stats, Fruit Tween, and Weapon Selector) return function(fetcher) local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local ReplicatedStorage = game:GetService("ReplicatedStorage") local Workspace = game:GetService("Workspace") local CoreGui = game:GetService("CoreGui") local player = Players.LocalPlayer local playerData = player:WaitForChild("Data")

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZioledTaskGUI"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundTransparency = 1
toggleBtn.Image = "rbxassetid://74791331749289"
toggleBtn.Parent = screenGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0, 80, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.Visible = false
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

toggleBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Tab Buttons
local tabNames = {"Farming", "Stats", "Utility"}
local currentTab
local tabs = {}

for i, name in ipairs(tabNames) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 100, 0, 30)
	btn.Position = UDim2.new(0, (i - 1) * 110 + 10, 0, 10)
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

-- Auto Stats
spawn(function()
	while task.wait(5) do
		pcall(function()
			ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
			ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
			ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
		end)
	end
end)

-- Weapon Selector
local weaponDropdown = Instance.new("TextBox")
weaponDropdown.PlaceholderText = "Enter Weapon Name"
weaponDropdown.Size = UDim2.new(1, -20, 0, 30)
weaponDropdown.Position = UDim2.new(0, 10, 0, 10)
weaponDropdown.Text = ""
weaponDropdown.Parent = tabs["Farming"]

-- Tween to Fruit (Fruit Notifier + Tween)
spawn(function()
	while task.wait(10) do
		for _, fruit in ipairs(Workspace:GetChildren()) do
			if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
				local char = player.Character
				if char and char:FindFirstChild("HumanoidRootPart") then
					local root = char.HumanoidRootPart
					local tween = TweenService:Create(root, TweenInfo.new(2), {CFrame = fruit.Handle.CFrame + Vector3.new(0, 3, 0)})
					tween:Play()
					print("Tweening to fruit: " .. fruit.Name)
				end
			end
		end
	end
end)

-- Raid Mode
spawn(function()
	while task.wait(15) do
		pcall(function()
			ReplicatedStorage.Remotes.CommF_:InvokeServer("Raid", "Join")
		end)
	end
end)

-- Attach further farming code and logic inside tabs["Farming"]

end

