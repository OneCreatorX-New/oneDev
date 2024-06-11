local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()
    
    local gameName = ""
    if gameName == "" then
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end
    
    local function cleanGameName(name)
        name = name:gsub("%b[]", "")
        name = name:match("^[^:]*")
        return name:match("^%s*(.-)%s*$")
    end
    
    gameName = cleanGameName(gameName)
    
    local p = game.Players.LocalPlayer
    local sg = UL:CrSG("Default")
    local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)
   
    local speed = 60

    local a = false

    UL:AddTBtn(cfrm, "Auto Coins", a, function(b) 
 a = b
 end)

    UL:AddTBox(cfrm, "Speed Test: 50 :", function(text) 
 speed = text
 end)
    
    UL:AddText(crFrm, "By Script: OneCreatorX ")
    UL:AddText(crFrm, "Create Script: 29/05/24 ")
    UL:AddText(crFrm, "Update Script: --/--/--")
    UL:AddText(crFrm, "Script Version: 0.1")
    UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
    UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)
    
    game:GetService('Players').LocalPlayer.Idled:Connect(function()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):ClickButton2(Vector2.new())
    end)


local function getHorizontalDistance(p1, p2)
    return (Vector3.new(p1.X, 0, p1.Z) - Vector3.new(p2.X, 0, p2.Z)).magnitude
end

local function findNearestCoin()
    local nearest, minDist = nil, math.huge
    for _, coin in pairs(workspace.GAME.CoinCollection.CreatedCoins:GetChildren()) do
        if coin:IsA("BasePart") and coin.Transparency ~= 1 then
            local dist = getHorizontalDistance(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, coin.Position)
            if dist < minDist then
                minDist, nearest = dist, coin
            end
        end
    end
    return nearest
end

local function calculateVelocity(targetPos, speed)
    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    return (targetPos - playerPos).unit * speed
end

local function collectCoin(player, coin)
    local humanoid = player.Character:WaitForChild("Humanoid")
    local tolerance, maxDist = 8, 8
    
    if coin and coin.Parent and a then
        local playerPos, coinPos = humanoid.RootPart.Position, coin.Position
        local dist = getHorizontalDistance(playerPos, coinPos)
        
        if dist <= tolerance and dist <= maxDist then
            if dist > 5 then coin.Transparency = 1 end
a = false
wait(0.1)
            game:GetService("ReplicatedStorage"):WaitForChild("Packages")
                :WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.6.0")
                :WaitForChild("knit"):WaitForChild("Services")
                :WaitForChild("CoinCollectionService"):WaitForChild("RF")
                :WaitForChild("CollectCoin"):InvokeServer(coin.Name)
            coin:Destroy()
a = true
            
        else
            player.Character.HumanoidRootPart.Velocity = calculateVelocity(coinPos, speed)
        end
        wait()
    end
end

local player = game.Players.LocalPlayer

game:GetService("RunService").RenderStepped:Connect(function()
    
    local nearestCoin = findNearestCoin()
    if nearestCoin and a then
        collectCoin(player, nearestCoin)
    end
    wait()
end)
