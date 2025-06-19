-- Blox Fruits Script (Zioled Task GUI by Brtskib with Complete Auto Farm from Level 1 to 2500) return function(fetcher) local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local ReplicatedStorage = game:GetService("ReplicatedStorage") local Workspace = game:GetService("Workspace") local player = Players.LocalPlayer local playerData = player:WaitForChild("Data")

local function getLevel()
	return tonumber(playerData.Level.Value)
end

local function getQuestInfo(level)
	local questList = {
		-- First Sea
		{min = 1, max = 9, mob = "Bandit", quest = "BanditQuest1", pos = Vector3.new(1060, 17, 1547)},
		{min = 10, max = 14, mob = "Monkey", quest = "JungleQuest", pos = Vector3.new(-1599, 36, 153)},
		{min = 15, max = 29, mob = "Gorilla", quest = "JungleQuest", pos = Vector3.new(-1599, 36, 153)},
		{min = 30, max = 59, mob = "Pirate", quest = "BuggyQuest1", pos = Vector3.new(-1143, 4, 3820)},
		{min = 60, max = 99, mob = "Brute", quest = "BuggyQuest1", pos = Vector3.new(-1143, 4, 3820)},
		{min = 100, max = 119, mob = "Desert Bandit", quest = "DesertQuest", pos = Vector3.new(896, 7, 4392)},
		{min = 120, max = 149, mob = "Desert Officer", quest = "DesertQuest", pos = Vector3.new(896, 7, 4392)},
		{min = 150, max = 174, mob = "Snow Bandit", quest = "SnowQuest", pos = Vector3.new(1389, 87, -1297)},
		{min = 175, max = 189, mob = "Snowman", quest = "SnowQuest", pos = Vector3.new(1389, 87, -1297)},
		{min = 190, max = 209, mob = "Chief Petty Officer", quest = "MarineQuest3", pos = Vector3.new(-2446, 73, -3214)},
		{min = 210, max = 249, mob = "Sky Bandit", quest = "SkyQuest", pos = Vector3.new(-4842, 717, -2626)},
		{min = 250, max = 274, mob = "Dark Master", quest = "SkyQuest", pos = Vector3.new(-4842, 717, -2626)},
		{min = 275, max = 299, mob = "Prisoner", quest = "PrisonerQuest", pos = Vector3.new(5411, 96, 691)},
		{min = 300, max = 324, mob = "Dangerous Prisoner", quest = "PrisonerQuest", pos = Vector3.new(5411, 96, 691)},
		{min = 325, max = 374, mob = "Toga Warrior", quest = "ColosseumQuest", pos = Vector3.new(-1576, 7, -2981)},
		{min = 375, max = 399, mob = "Gladiator", quest = "ColosseumQuest", pos = Vector3.new(-1576, 7, -2981)},
		{min = 400, max = 449, mob = "Military Soldier", quest = "MagmaQuest", pos = Vector3.new(-5316, 12, 8513)},
		{min = 450, max = 474, mob = "Military Spy", quest = "MagmaQuest", pos = Vector3.new(-5316, 12, 8513)},
		{min = 475, max = 524, mob = "Fishman Warrior", quest = "FishmanQuest", pos = Vector3.new(61123, 18, 1569)},
		{min = 525, max = 549, mob = "Fishman Commando", quest = "FishmanQuest", pos = Vector3.new(61123, 18, 1569)},
		{min = 550, max = 624, mob = "God's Guard", quest = "SkyExp1Quest", pos = Vector3.new(-7867, 5636, -504)},
		{min = 625, max = 649, mob = "Shanda", quest = "SkyExp1Quest", pos = Vector3.new(-7867, 5636, -504)},
		{min = 650, max = 699, mob = "Royal Squad", quest = "SkyExp2Quest", pos = Vector3.new(-7900, 5636, -1058)},
		{min = 700, max = 724, mob = "Royal Soldier", quest = "SkyExp2Quest", pos = Vector3.new(-7900, 5636, -1058)},
		{min = 725, max = 774, mob = "Galley Pirate", quest = "FountainQuest", pos = Vector3.new(5243, 38, 4037)},
		{min = 775, max = 799, mob = "Galley Captain", quest = "FountainQuest", pos = Vector3.new(5243, 38, 4037)},

		-- Second Sea
		{min = 800, max = 874, mob = "Raider", quest = "Area1Quest", pos = Vector3.new(-460, 73, 1896)},
		{min = 875, max = 899, mob = "Mercenary", quest = "Area1Quest", pos = Vector3.new(-460, 73, 1896)},
		{min = 900, max = 949, mob = "Swan Pirate", quest = "Area2Quest", pos = Vector3.new(878, 122, 1236)},
		{min = 950, max = 974, mob = "Factory Staff", quest = "Area2Quest", pos = Vector3.new(878, 122, 1236)},
		{min = 975, max = 999, mob = "Marine Lieutenant", quest = "MarineQuest2", pos = Vector3.new(2394, 122, -1960)},
		{min = 1000, max = 1049, mob = "Marine Captain", quest = "MarineQuest2", pos = Vector3.new(2394, 122, -1960)},
		{min = 1050, max = 1099, mob = "Zombie", quest = "ZombieQuest", pos = Vector3.new(-5627, 491, -781)},
		{min = 1100, max = 1124, mob = "Vampire", quest = "ZombieQuest", pos = Vector3.new(-5627, 491, -781)},
		{min = 1125, max = 1174, mob = "Snow Trooper", quest = "SnowMountainQuest", pos = Vector3.new(1354, 470, -1325)},
		{min = 1175, max = 1199, mob = "Winter Warrior", quest = "SnowMountainQuest", pos = Vector3.new(1354, 470, -1325)},
		{min = 1200, max = 1249, mob = "Lab Subordinate", quest = "IceQuest", pos = Vector3.new(-6060, 15, -4900)},
		{min = 1250, max = 1299, mob = "Horned Warrior", quest = "IceQuest", pos = Vector3.new(-6060, 15, -4900)},
		{min = 1300, max = 1324, mob = "Magma Ninja", quest = "FlamingoQuest", pos = Vector3.new(-5478, 15, -5246)},
		{min = 1325, max = 1349, mob = "Lava Pirate", quest = "FlamingoQuest", pos = Vector3.new(-5478, 15, -5246)},

		-- Third Sea (partial)
		{min = 1500, max = 1524, mob = "Pirate Millionaire", quest = "PiratePortQuest", pos = Vector3.new(-288, 44, 5587)},
		{min = 1525, max = 1574, mob = "Pistol Billionaire", quest = "PiratePortQuest", pos = Vector3.new(-288, 44, 5587)},
		{min = 1575, max = 1599, mob = "Dragon Crew Warrior", quest = "AmazonQuest", pos = Vector3.new(5444, 602, 752)},
		{min = 1600, max = 1624, mob = "Dragon Crew Archer", quest = "AmazonQuest", pos = Vector3.new(5444, 602, 752)},
		-- Final Level
		{min = 2000, max = 2500, mob = "Elite Pirate", quest = "EliteQuest", pos = Vector3.new(5132, 5, -3210)}
	}

	for _, q in ipairs(questList) do
		if level >= q.min and level <= q.max then
			return q
		end
	end
	return nil
end

end

