-- Change this value to adjust the distance between the players before teleporting
local TeleportDistance = 100000

-- Define a function to find and return the nearest player to the player's character
local function findNearestPlayer()
    local players = game.Players:GetPlayers()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(players) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

while true do
    if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
            -- If the player's character dies, find another target player to teleport to
            targetPlayer = findNearestPlayer()
        else
            if targetPlayer then
                -- Calculate the distance between the player and the target player
                local distance = (targetPlayer.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                
                -- Only teleport if the players are far enough apart
                if distance > TeleportDistance then
                    -- Add some randomness to the teleportation direction
                    local randomOffset = Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
                    local destination = targetPlayer.Character.HumanoidRootPart.Position + randomOffset
                    
                    -- Teleport the player's character to the target player's location with some randomness
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(destination)
                end
                
            else
                -- If there is no target player, find the nearest player to teleport to
                targetPlayer = findNearestPlayer()
            end
        end
    end
    wait()
end
