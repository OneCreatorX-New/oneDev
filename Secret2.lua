local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local placeId = game.PlaceId
local jobId = game.JobId

local plr = Players.LocalPlayer

-- Recoger todos los Tickets
for _, obj in ipairs(workspace:GetChildren()) do
    if obj.Name:find("Ticket") then
        firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
        wait()
        firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
    end
end

wait(1)

-- Verificar si el jugador está solo en el servidor
if #Players:GetPlayers() <= 1 then
    plr:Kick("\nBy OneCreatorX")
    wait(1)
    TeleportService:Teleport(placeId, plr)
else
    TeleportService:TeleportToPlaceInstance(placeId, jobId, plr)
end
