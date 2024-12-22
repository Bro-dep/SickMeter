--[[
========================================================
Made by Luna 
Im no expert in lua but i wanted this so i made it.
========================================================
Version: 0.0.1
Date made: 12/21/2024
Date modified: 12/21/2024
========================================================
]] --

Character = nil
PreviousFoodSicknessLevel = -1
PreviousColdSicknessLevel = -1

function HealSickness(player)
    --#region Variables
    local bodyDamage = player:getBodyDamage()
    local playerStats = player:getStats()
    local foodSicknessLevel = playerStats:getFoodSicknessLevel()
    local coldSicknessLevel = playerStats:getColdSicknessLevel()
    local hunger = playerStats:getHunger()
    local thirst = playerStats:getThirst()
    local endurance = playerStats:getEndurance()
    local recoveryRate = SandboxVars.BetterSickness.RecoveryRate
    --#endregion
    if PreviousFoodSicknessLevel < 0.0 then
        PreviousFoodSicknessLevel = bodyDamage:getFoodSicknessLevel()
    end
    if PreviousColdSicknessLevel < 0.0 then
        PreviousColdSicknessLevel = bodyDamage:getColdSicknessLevel()
    end

    --#region Healing
    if foodSicknessLevel > 0 then
        bodyDamage:setFoodSicknessLevel(foodSicknessLevel - recoveryRate)
    end
    --#endregion
    end
    
    


end

local function OnCreatePlayer(playerIndex, player)
    if (playerIndex == 0) then
        Character = player
        print("Player created")
    end
end

local function OnPlayerUpdate(player)
    HealSickness(player)
end

local function OnKeyPressed(key)
    --print(key)
    --bodyStat = getPlayer.getStats()
    if key == KEY_F1 then
        player:Say("F1")
    end
    if key == 2 then
        print("I DID SOMETHING")
        --bodyStat:setThirst(bodyStat:getThirst() + 1)
    end
    if key == KEY_2 then
        print("I DID SOMETHING2")
    end
end

--[Events]--
Events.OnCreatePlayer.Add(OnCreatePlayer)
Events.OnPlayerUpdate.Add(OnPlayerUpdate)
Events.OnKeyPressed.Add(OnKeyPressed)