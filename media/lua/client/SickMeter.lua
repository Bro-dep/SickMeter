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
MoodleOnValue = .6
MoodleOffValue = .5
MoodleId = "healing"

MF.createMoodle(MoodleId)

function UpdateMoodle(SickHealing)
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
    local foodSicknessLevel = bodyDamage:getFoodSicknessLevel()
    local coldSicknessLevel = bodyDamage:getColdStrength()
    local hunger = playerStats:getHunger()
    local thirst = playerStats:getThirst()
    local endurance = playerStats:getEndurance()
    local recoveryRate = .0005 * ((SandboxVars.BetterSickness.RecoveryRate) / 100)
    --#endregion
    -- Get initial value
    if PreviousFoodSicknessLevel < 0.0 then
        PreviousFoodSicknessLevel = bodyDamage:getFoodSicknessLevel()
    end
    if PreviousColdSicknessLevel < 0.0 then
        PreviousColdSicknessLevel = bodyDamage:getColdStrength()
    end
    -- Healing
    local currentSickness = bodyDamage:getFoodSicknessLevel() + bodyDamage:getColdStrength()
    if currentSickness > 0 then
        if currentSickness > 25 then
            --print("Current Sickness: " .. tostring(currentSickness))
            --If hunger, thirst, and endurance are high enough, heal sickness
            if hunger < 0.05 and thirst < 0.05 and endurance > 0.90 then
                --print("coldSicknessLevel: " .. tostring(coldSicknessLevel))
                local newFoodSicknessLevel = foodSicknessLevel - (foodSicknessLevel * recoveryRate)
                local newColdSicknessLevel = coldSicknessLevel - ((coldSicknessLevel * recoveryRate) * 3)
                --print("NewColdSicknessLevel: " .. tostring(newColdSicknessLevel))
                bodyDamage:setFoodSicknessLevel(newFoodSicknessLevel)
                bodyDamage:setColdStrength(newColdSicknessLevel)
                --Drain stats
                playerStats:setHunger(playerStats:getHunger() + 0.00005)
                playerStats:setThirst(playerStats:getThirst() + 0.00005)
                UpdateMoodle(true)
                --print("Healing")
            else
                UpdateMoodle(false)
            end
        elseif currentSickness < 25 then
            if hunger < 0.05 and thirst < 0.05 and endurance > 0.90 then
                local newFoodSicknessLevel = foodSicknessLevel - (foodSicknessLevel * recoveryRate)
                local newColdSicknessLevel = coldSicknessLevel - ((coldSicknessLevel * recoveryRate) * 3)
                bodyDamage:setFoodSicknessLevel(newFoodSicknessLevel)
                bodyDamage:setColdStrength(newColdSicknessLevel)
                UpdateMoodle(false)
            else
                UpdateMoodle(false)
            end
        end
    end
end

local function OnCreatePlayer(playerIndex, player)
    if (playerIndex == 0) then
        Character = player
        --print("Player created")
    end
end

local function OnPlayerUpdate(player)
    HealSickness(player)
end

--[Events]--
Events.OnCreatePlayer.Add(OnCreatePlayer)
Events.OnPlayerUpdate.Add(OnPlayerUpdate)