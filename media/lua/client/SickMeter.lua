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

local function MeterUpdate(character)
    --[Variables]--
    --[Damage taken]--
    local bodyDamage = character:getBodyDamage()
    --[Stats such as food,thirst etc]--
    local playerStats = character:getStats()



end

local function CheckMood(character)
    
end

local function Testing(character)
    local bodyDamage = character:getBodyDamage()
    local playerStats = character:getStats()
    print(bodyDamage)
    print(playerStats)
end

local function OnCreatePlayer(playerIndex, player)
    if (playerIndex == 0) then
        Testing(player)
    end
end

local function OnPlayerUpdate(player)
    Testing(player)
    
end

local function OnKeyPressed(key)
    if key == KEY_F1 then
        print("F1 Pressed")
    end
end

--[Events]--
--Events.OnCreatePlayer.Add(OnCreatePlayer)
--Events.OnPlayerUpdate.Add(OnPlayerUpdate)
Events.OnKeyPressed.Add(OnKeyPressed)