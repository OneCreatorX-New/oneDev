local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Win = Lib:NewWindow("Survive The Killer v1.8")
local Sec = Win:NewSection("General")
local Ki = Win:NewSection("Killer")
local Su = Win:NewSection("Survivor")
local Sut = Win:NewSection("Survivor Teleports")
local Sec2 = Win:NewSection("Credits: OneCreatorX")

local Players = game:GetService("Players")
local Player = game.Players.LocalPlayer
local Humanoid = Player.Character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")

-- Functions
local function clickButton(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 2
    local centerY = pos.Y + size.Y / 2
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

local function copyToClipboard(text)
    if syn then
        syn.write_clipboard(text)
    else
        setclipboard(text)
    end
end

-- Utility Functions
local function findPlayerByNameTag(player)
    return player.Character:FindFirstChild("NameTag")
end

local function updateNameTag(player)
    local nameTag = findPlayerByNameTag(player)
    if nameTag then
        if player.Team == game.Teams.Killer then
            nameTag.TextLabel.Text = "K"
            nameTag.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        else
            nameTag.TextLabel.Text = "S"
            nameTag.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        end
    end
end

local function createNameTag(player)
    if player.Team ~= game.Teams.Lobby then
        local nameTag = findPlayerByNameTag(player)
        if not nameTag then
            local playerPart = player.Character:WaitForChild("HumanoidRootPart")
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Adornee = playerPart
            billboardGui.Size = UDim2.new(0, 200, 0, 40)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.AlwaysOnTop = true
            billboardGui.Name = "NameTag"

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextColor3 = Color3.new()
            nameLabel.FontSize = Enum.FontSize.Size10
            nameLabel.TextScaled = true
            nameLabel.Parent = billboardGui

            updateNameTag(player)

            billboardGui.Parent = playerPart.Parent
        else
            updateNameTag(player)
        end
    end
end

-- ESP 
local function esp()
    for _, player in ipairs(game.Players:GetPlayers()) do
        createNameTag(player)
    end
end

local function updateEsp()
    esp()
    task.wait(1)
end

-- Kill Aura
local killAuraEnabled = false
local function killAura()
    if killAuraEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Knife") then
        local rootPos = Player.Character.HumanoidRootPart.Position
        task.wait(0.5)
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local targetPos = player.Character.HumanoidRootPart.Position
                local distance = (rootPos - targetPos).magnitude
                if distance <= 22 then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(rootPos)
                end
            end
        end
    end
end

local function updateKillAura()
    killAura()
    task.wait(0.5)
end

-- Instant Kill
local instantKillEnabled = false
local function instantKill()
    if instantKillEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Knife") then
        local rootPos = Player.Character.HumanoidRootPart.Position
        task.wait(0.3)
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local targetPos = player.Character.HumanoidRootPart.Position
                local distance = (rootPos - targetPos).magnitude
                if distance <= 900 then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(rootPos)
                end
            end
        end
    end
end

local function updateInstantKill()
    instantKill()
    task.wait(0.3)
end

-- Heal Aura
local healAuraEnabled = false
local function healAura()
    if healAuraEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") then
        local rootPos = Player.Character.HumanoidRootPart.Position
        local targetPlayer = nil
        local minDistance = 900

        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("Knife") and player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth") and player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled then
                local targetPos = player.Character.HumanoidRootPart.Position
                local distance = (rootPos - targetPos).magnitude

                if distance > 7 and distance <= 19 and distance < minDistance then
                    targetPlayer = player
                    minDistance = distance
                end
            end
        end

        if targetPlayer then
            targetPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Player.Character.HumanoidRootPart.Position))
            clickButton(Player.PlayerGui.TouchGui.TouchControlFrame.CarryButton)
        end
    end
end

local function updateHealAura()
    healAura()
    task.wait()
end

-- Remove Traps
local removeTrapEnabled = false
local function removeTrap()
    if removeTrapEnabled then
        for _, item in pairs(workspace:GetChildren()) do
            if item:IsA("Model") and item.Name == "Trap" then
                item:Destroy()
            end
        end
    end
end

local function updateRemoveTrap()
    removeTrap()
    task.wait(1)
end

-- Escape 
local escapeEnabled = false
local isRunning = false
local exitFound = false

local function escape()
    if escapeEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") then
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("Exits") then
                exitFound = true
                isRunning = false
                while exitFound and escapeEnabled and model.Exits do
                    task.wait(1)
                    for _, part in ipairs(model.Exits:GetChildren()) do
                        task.wait(1)
                        if part:IsA("Model") then
                            for _, partt in ipairs(part.Trigger:GetChildren()) do
                                if partt.Name == "ExitIcon" then
                                    local triggerPos = partt.Parent.Position
                                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                                        local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                                        if distance < 7000 and game.Players.LocalPlayer.Team == game.Teams.Survivor then
                                            Humanoid.Sit = false
                                            task.wait(0.3)
                                            Player.Character:SetPrimaryPartCFrame(CFrame.new(partt.Parent.Parent.Doorway.Door1.Position))
                                            task.wait(0.3)
                                            Player.Character:SetPrimaryPartCFrame(CFrame.new(partt.Parent.Parent.Doorway.Door2.Position))
                                            task.wait(0.3)
                                            Player.Character:SetPrimaryPartCFrame(CFrame.new(triggerPos))
                                            exitFound = false
                                            isRunning = true
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function updateEscape()
    escape()
    task.wait(0.3)
end

-- Collect Items
local collectItemEnabled = false
local isRunningg = false
local exitFoundd = false

local function collectItems()
    if collectItemEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") then
        local backpackAmount = tonumber(string.split(Player.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text, "/")[1])
        local maxBackpackAmount = tonumber(string.split(Player.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text, "/")[2])
        local isBackpackFull = backpackAmount == maxBackpackAmount

        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("LootSpawns") then
                exitFoundd = true
                isRunningg = false

                while exitFoundd and collectItemEnabled and not isBackpackFull and model:FindFirstChild("LootSpawns") do
                    for _, part in ipairs(model.LootSpawns:GetChildren()) do
                        task.wait()
                        if part:IsA("BasePart") then
                            for _, partt in pairs(part:GetChildren()) do
                                if partt.Name == "Model" then
                                    for _, parttt in pairs(partt:GetChildren()) do
                                        if parttt:IsA("MeshPart") and parttt.Transparency == 0 then
                                            local triggerPos = part.Position
                                            local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                                            if distance < 100 and not isBackpackFull then
                                                fireproximityprompt(part.LootProxBlock.LootProximityPrompt)
                                                exitFoundd = false
                                                isRunningg = true
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function updateCollectItems()
    collectItems()
    task.wait(1)
end

-- Teleport Collect Items
local tpCollectItemEnabled = false
local function tpCollectItems()
    if tpCollectItemEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") then
        local backpackAmount = tonumber(string.split(Player.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text, "/")[1])
        local maxBackpackAmount = tonumber(string.split(Player.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text, "/")[2])
        local isBackpackFull = backpackAmount == maxBackpackAmount

        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("LootSpawns") then
                exitFoundd = true
                isRunningg = false

                while exitFoundd and tpCollectItemEnabled and not isBackpackFull and model:FindFirstChild("LootSpawns") do
                    for _, part in ipairs(model.LootSpawns:GetChildren()) do
                        task.wait(0.1)
                        if part:IsA("BasePart") then
                            for _, partt in pairs(part:GetChildren()) do
                                if partt.Name == "Model" then
                                    for _, parttt in pairs(partt:GetChildren()) do
                                        if parttt:IsA("MeshPart") and parttt.Transparency == 0 then
                                            local triggerPos = part.Position
                                            local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                                            if distance < 300 and not isBackpackFull then
                                                Player.Character:SetPrimaryPartCFrame(CFrame.new(triggerPos + Vector3.new(0, 3, 0)))
                                                task.wait(0.2)
                                                fireproximityprompt(part.LootProxBlock.LootProximityPrompt)
                                                exitFoundd = false
                                                isRunningg = true
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function updateTpCollectItems()
    tpCollectItems()
    task.wait(1)
end

-- Teleport Collect Items (Lobby)
local tpLobbyCollectItemEnabled = false
local function tpLobbyCollectItems()
    if tpLobbyCollectItemEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") then
        local backpackAmount = tonumber(string.split(Player.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text, "/")[1])
        local maxBackpackAmount = tonumber(string.split(Player.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text, "/")[2])
        local isBackpackFull = backpackAmount == maxBackpackAmount

        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("LootSpawns") then
                exitFoundd = true
                isRunningg = false

                while exitFoundd and tpLobbyCollectItemEnabled and not isBackpackFull and model:FindFirstChild("LootSpawns") do
                    for _, part in ipairs(model.LootSpawns:GetChildren()) do
                        task.wait(0.1)
                        if part:IsA("BasePart") then
                            for _, partt in pairs(part:GetChildren()) do
                                if partt.Name == "Model" then
                                    for _, parttt in pairs(partt:GetChildren()) do
                                        if parttt:IsA("MeshPart") and parttt.Transparency == 0 then
                                            local triggerPos = part.Position
                                            local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                                            if distance < 4000 and not isBackpackFull then
                                                Player.Character:SetPrimaryPartCFrame(CFrame.new(triggerPos + Vector3.new(0, 3, 0)))
                                                task.wait(0.2)
                                                fireproximityprompt(part.LootProxBlock.LootProximityPrompt)
                                                exitFoundd = false
                                                isRunningg = true
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function updateTpLobbyCollectItems()
    tpLobbyCollectItems()
    task.wait(1)
end

local removeMapTrapEnabled = false
local removeMapTrapsEnabled = false

local function removeMapTrap()
    if removeMapTrapEnabled then
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") then
                for _, modell in pairs(model:GetChildren()) do
                    if modell.Name == "RatTraps" and removeMapTrapsEnabled then
                        modell:Destroy()
                        removeMapTrapsEnabled = false
                        task.wait(1)
                    elseif removeMapTrapEnabled then
                        removeMapTrapsEnabled = true
                    else
                        removeMapTrapsEnabled = false
                    end
                end
            end
        end
    end
end

local function updateRemoveMapTrap()
    removeMapTrap()
    task.wait(1)
end

local tpHealEnabled = false
local function tpHeal()
    if tpHealEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Team == game.Teams.Survivor and Player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth") and Player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled == false then
        local rootPos = Player.Character.HumanoidRootPart.Position
        local targetPlayer = nil
        local minDistance = 900
        local nearbyPlayer = nil

        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("Knife") and player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth") and player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled then
                local targetPos = player.Character.HumanoidRootPart.Position
                local distance = (rootPos - targetPos).magnitude

                if distance <= 13 then
                    nearbyPlayer = player
                elseif distance > 13 and distance <= 10000 and distance < minDistance then
                    local killerNearby = false
                    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
                        if otherPlayer.Team == game.Teams.Killer then
                            local killerPos = otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") and otherPlayer.Character.HumanoidRootPart.Position
                            if killerPos then
                                local killerDistance = (killerPos - targetPos).magnitude
                                if killerDistance <= 16 then
                                    killerNearby = true
                                    break
                                end
                            end
                        end
                    end
                    if not killerNearby then
                        targetPlayer = player
                        minDistance = distance
                    end
                end
            end
        end

        if nearbyPlayer then
            targetPlayer = nearbyPlayer
        end

        if targetPlayer then
            local ss = Player.Character.HumanoidRootPart.CFrame
            Player.Character:SetPrimaryPartCFrame(CFrame.new(targetPlayer.Character.HumanoidRootPart.Position))
            task.wait(0.1)
            clickButton(Player.PlayerGui.TouchGui.TouchControlFrame.CarryButton)
            task.wait(0.1)
            Player.Character:SetPrimaryPartCFrame(ss)
            task.wait(0.3)
            clickButton(game.Players.LocalPlayer.PlayerGui.GameHUD.DropPlayer.Button)
        end
    end
end

local function updateTpHeal()
    tpHeal()
    task.wait()
end

local fullBrightEnabled = false
local function fullBright()
    if fullBrightEnabled then
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.ScreenTint.Enabled = false
        Lighting.ColorCorrection.Enabled = false
    end
end

local function updateFullBright()
    fullBright()
    task.wait(0.3)
end
 
local hideSeatEnabled = false
local bench = game.workspace._Lobby.Bench.Seat
local function hideSeat()
    if hideSeatEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Team == game.Teams.Survivor then
        task.wait()
        local killer = game.Teams.Killer and game.Teams.Killer:GetPlayers()[1]

        if Player.Character and Humanoid and killer then
            local playerPos = Player.Character:FindFirstChild("HumanoidRootPart").Position
            local killerPos = killer.Character and killer.Character:FindFirstChild("HumanoidRootPart") and killer.Character.HumanoidRootPart.Position

            if playerPos and killerPos then
                local playerPosNoY = Vector3.new(playerPos.X, 0, playerPos.Z)
                local killerPosNoY = Vector3.new(killerPos.X, 0, killerPos.Z)
                local distance = (killerPosNoY - playerPosNoY).magnitude
                local heightDifference = math.abs(killerPos.Y - playerPos.Y)

                if distance < 29 and heightDifference <= 7 and not Humanoid.Sit then
                    local h = bench.Position
                    wait()
                    bench.Position = Player.Character.LeftFoot.Position
                    wait(0.4)
                    bench.Position = h
                elseif distance > 30 and distance < 45 and Humanoid.Sit then
                    Humanoid.Sit = false
                end
            end
        end
    end
end

local tpwalking = false
local speed = 15

local function tpwalk()
    if Player.Character and Humanoid and Humanoid.Parent then
        local hb = RunService.Heartbeat
        while Player.Character and Humanoid and Humanoid.Parent do
            local delta = hb:Wait()
            Humanoid.WalkSpeed = speed
        end
    end
end

-- UI Setup
Sec:CreateToggle("Esp Players", function(value)
    if value then
        updateEsp()
    else
        for _, player in ipairs(game.Players:GetPlayers()) do
            local nameTag = findPlayerByNameTag(player)
            if nameTag then
                nameTag:Destroy()
            end
        end
    end
end)
Sec:CreateToggle("Full Bright", function(value)
    fullBrightEnabled = value
    if value then
        updateFullBright()
    end
end)
Sec:CreateButton("Esconderse", function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("LeftFoot") then
        local h = bench.Position
        wait()
        bench.Size = Vector3.new(4, 1, 4)
        bench.Position = Player.Character.LeftFoot.Position
        wait(0.4)
        bench.Position = h
    end
end)
Sec:CreateButton("Fixed Screen Loading", function()
    game.Players.LocalPlayer.PlayerGui.ScreenFX.Enabled = false
end)
Ki:CreateToggle("Kill Aura", function(value)
    killAuraEnabled = value
    if value then
        updateKillAura()
    end
end)
Ki:CreateToggle("Instant Kill", function(value)
    instantKillEnabled = value
    if value then
        updateInstantKill()
    end
end)
Su:CreateToggle("Aura Help Plrs(B 1)", function(value)
    healAuraEnabled = value
    if value then
        updateHealAura()
    end
end)
Su:CreateToggle("No Trap Killer", function(value)
    removeTrapEnabled = value
    if value then
        updateRemoveTrap()
    end
end)
Sut:CreateToggle("Auto Escape", function(value)
    escapeEnabled = value
    if value then
        updateEscape()
    end
end)
Su:CreateToggle("Auto Esconderse(B 9)", function(value)
    hideSeatEnabled = value
    if value then
        hideSeat()
    end
end)
Su:CreateToggle("Aura Collect Items", function(value)
    collectItemEnabled = value
    if value then
        updateCollectItems()
    end
end)
Sut:CreateToggle("Collect Items", function(value)
    tpCollectItemEnabled = value
    if value then
        updateTpCollectItems()
    end
end)
Sut:CreateToggle("Collect Items(T.Lobby)", function(value)
    tpLobbyCollectItemEnabled = value
    if value then
        updateTpLobbyCollectItems()
    end
end)
Su:CreateToggle("No Trap Map", function(value)
    removeMapTrapEnabled = value
    if value then
        updateRemoveMapTrap()
    end
end)
Sut:CreateToggle("Tp Player Help", function(value)
    tpHealEnabled = value
    if value then
        updateTpHeal()
    end
end)
Sec2:CreateButton("Copy Link YouTube", function()
    copyToClipboard("https://youtube.com/@OneCreatorX")
end)
Sec2:CreateButton("Copy Link Discord", function()
    copyToClipboard("https://discord.com/invite/23kFrRBSfD")
end)
Sec:CreateTextbox("Speed", function(value)
    speed = tonumber(value)
    tpwalking = speed > 15
end)

RunService.RenderStepped:Connect(hideSeat)
tpwalk()
