local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local cleanGameName = function(name)
    return name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")
end
gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)


OB, OF = UL:AddOBtn(cfrm, "MiniGames")

UL:AddTBtn(OF, "Auto Moños", a, function(b) 
    a = b
    while a do
        wait(0.1)
        for _, h in ipairs(workspace:GetChildren()) do
            if h.Name == "Bowtie" then
                fireproximityprompt(h["Meshes/bowV1.1_Cube"].ProximityPrompt)
            end
        end
    end
end)


UL:AddTBtn(cfrm, "Collect Flowers", a, function(b) 
    a = b
    while a do
        for _, h in ipairs(workspace.Activators:GetChildren()) do
            if h.Name == "Flower" and a then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = h.Part.CFrame
wait(0.5)
                fireproximityprompt(h.Part.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

UL:AddTBtn(cfrm, "Collect Magic Feathers", a, function(b) 
    a = b
    while a do
wait()
        for _, h in ipairs(workspace.Feathers:GetChildren()) do
            if h.Name == "Feather" and h:FindFirstChild("Root") and a then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = h.Root.CFrame
wait(0.5)
                fireproximityprompt(h.Root.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

UL:AddTBtn(cfrm, "Auto Claim Gift", a, function(b) 
    a = b
    while a do
        for i = 1, 9 do
            local args = {
                [1] = {
                    [1] = {
                        [1] = "\1",
                        [2] = "BERRIES_" .. i .. "00"
                    },
                    [2] = "-"
                }
            }

            game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            wait(1)
        end
    end
end)

UL:AddTBtn(cfrm, "Auto Tasks Pets", a, function(b) 
    a = b
while a do
local playerName = game.Players.LocalPlayer.Name 
local userDirectoryName = playerName .. ":Debris"
local workspace = game:GetService("Workspace")
local userDirectory = workspace:FindFirstChild(userDirectoryName)
    wait()
    if userDirectory then
        for _, child in ipairs(userDirectory:GetChildren()) do
            if a and child:IsA("Model") and not child.Name:find("_Accessories") then
                local actions = {"Fed", "Bathed", "Hugged"}
                for _, action in ipairs(actions) do
                    local args = {
                        [1] = {
                            [1] = "PetInteractAction",
                            [2] = "'",
                            [3] = {
                                [1] = "\1",
                                [2] = {
                                    [1] = child.Name,
                                    [2] = action
                                }
                            },
                            [4] = "\28"
                        }
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                    wait(0.3)
                end
                wait(0.5)
            end
        end
    else

    end
end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 29/05/24 ")
UL:AddText(crFrm, "Update Script: 29/06/24")
UL:AddText(crFrm, "Script Version: 0.2")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
