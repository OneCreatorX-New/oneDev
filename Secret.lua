local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)
local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local active = false
local damage = p:WaitForChild("Localstats"):WaitForChild("Damage")
local multiplier = p:WaitForChild("Values"):WaitForChild("Multiplier1")
local mt = getrawmetatable(game)
local old_index = mt.__index

setreadonly(mt, false)

mt.__index = function(instance, index)
    if active then
        if instance == damage and index == "Value" then
            return 100
        elseif instance == multiplier and index == "Value" then
            return 1000
        end
    end
    return old_index(instance, index)
end

setreadonly(mt, true)

UL:AddTBtn(cfrm, "Inject", false, function() 
    active = not active 
end)

local pet = false
UL:AddTBtn(cfrm, "Auto Egg Pet UGC", false, function() 
    pet = not pet
    while pet do
        local args = { workspace:WaitForChild("Eggs"):WaitForChild("Rich Egg") }
        game:GetService("ReplicatedStorage"):WaitForChild("EggHatchingRemotes"):WaitForChild("HatchServer"):InvokeServer(unpack(args))
        wait()
    end
end)

local eggg = false
UL:AddTBtn(cfrm, "Auto Egg Pet UGC", false, function() 
    eggg = not eggg
    while eggg do
        local area = workspace:WaitForChild("BreakablesByArea")
        for _, obj in ipairs(area:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                obj.MaxActivationDistance = 10000
                fireclickdetector(obj)
wait()
            end
        end
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 20/06/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
