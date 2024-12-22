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

require("MF_ISMoodle")

Character = nil
PreviousFoodSicknessLevel = -1
PreviousColdSicknessLevel = -1
SickHealing = false
MoodleOnValue = 1
MoodleOffValue = 0
MoodleId = "healing"

MF.createMoodle(MoodleId)

function UpdateMoodle()
    local value
    MoodleActive = SandboxVars.BetterSickness.Moodle
    if SickHealing then
        value= MoodleOnValue
    else
        value = MoodleOffValue
    end
    MF.getMoodle(MoodleId):setValue(value)
end

function HealSickness(player)
    --#region Variables
    local bodyDamage = player:getBodyDamage()
    local playerStats = player:getStats()
    local foodSicknessLevel = playerStats:getFoodSicknessLevel()
    local coldSicknessLevel = playerStats:getColdSicknessLevel()
    local hunger = playerStats:getHunger()
    local thirst = playerStats:getThirst()
    local endurance = playerStats:getEndurance()
    local recoveryRate = 1 * ((SandboxVars.BetterSickness.RecoveryRate) / 100)
    --#endregion
    -- Get initial value
    if PreviousFoodSicknessLevel < 0.0 then
        PreviousFoodSicknessLevel = bodyDamage:getFoodSicknessLevel()
    end
    if PreviousColdSicknessLevel < 0.0 then
        PreviousColdSicknessLevel = bodyDamage:getColdSicknessLevel()
    end
    -- Healing
    local currentSickness = bodyDamage:getFoodSicknessLevel() + bodyDamage:getColdSicknessLevel()
    if currentSickness > 0 then
        --If hunger, thirst, and endurance are high enough, heal sickness
        if hunger < 0.05 and thirst < 0.05 and endurance > 0.90 then
            local newFoodSicknessLevel = foodSicknessLevel - (foodSicknessLevel * recoveryRate)
            local newColdSicknessLevel = coldSicknessLevel - (coldSicknessLevel * recoveryRate)
            bodyDamage:setFoodSicknessLevel(newFoodSicknessLevel)
            bodyDamage:setColdSicknessLevel(newColdSicknessLevel)
            SickHealing = true
        else
            SickHealing = false
        end
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
--[[
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
]]
--[Events]--
Events.OnCreatePlayer.Add(OnCreatePlayer)
Events.OnPlayerUpdate.Add(OnPlayerUpdate)
--Events.OnKeyPressed.Add(OnKeyPressed)