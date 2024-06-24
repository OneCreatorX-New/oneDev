local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

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

local a = false
local ja = true

UL:AddTBtn(cfrm, "Auto Candies", false, function() 
    a = not a
    ja = true
end)

local function findNearestCoin()
    local nearest, minDist = nil, math.huge
    for _, coin in pairs(workspace:GetDescendants()) do
        if coin:IsA("BasePart") and coin:FindFirstChild("TouchInterest") and a then
            local dist = getHorizontalDistance(p.Character.HumanoidRootPart.Position, coin.Position)
            if dist < minDist then
                minDist, nearest = dist, coin
            end
        end
    end
    return nearest
end

local function calculateVelocity(targetPos, speed)
    local playerPos = p.Character.HumanoidRootPart.Position
    return (targetPos - playerPos).unit * speed
end

local function collectCoin(player, coin)
    local humanoid = player.Character:WaitForChild("Humanoid")
    local tolerance, maxDist = 2, 2
    
    if coin and coin.Parent and a then
        pcall(function()
            local playerPos, coinPos = humanoid.RootPart.Position, coin.Position
            local dist = getHorizontalDistance(playerPos, coinPos)
            
            if dist <= tolerance and dist <= maxDist then
                if dist > 2 then coin.Transparency = 1 end
                ja = false
                wait(0.1)

                spawn(function()
                    coin:Destroy()
                end)
                ja = true
            else
                humanoid.WalkToPoint = coinPos
                humanoid.WalkSpeed = 17  -- Ajusta la velocidad de caminar según sea necesario
            end
        end)
        wait()
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    local nearestCoin = findNearestCoin()
    if nearestCoin and a and ja then
            spawn(function()
    pcall(function()
        for _, par in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if par:IsA("BasePart") then
                par.CanCollide = false
            end
        end
    end)
end)
        collectCoin(p, nearestCoin)
    end
    wait()
end)
