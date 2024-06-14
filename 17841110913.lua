local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local autoCollectEnabled = false

local function autoCollectCandies()
    while autoCollectEnabled do
        for _, obj in ipairs(workspace.Candies:GetChildren()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                local plr = game.Players.LocalPlayer
                firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
                wait()
                firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
                wait()
            end
        end
        wait(0.5)
    end
end

UL:AddTBtn(cfrm, "Auto Candy Collect", autoCollectEnabled, function(state)
    autoCollectEnabled = state
    if autoCollectEnabled then
        autoCollectCandies()
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 13/06/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")

UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
