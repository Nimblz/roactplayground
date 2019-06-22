local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local PlayerInitializer = PizzaAlpaca.GameModule:extend("PlayerInitializer")

function PlayerInitializer:preInit()
end

function PlayerInitializer:init()
    self.logger = self.core:getModule("Logger"):createLogger(self)
end

function PlayerInitializer:postInit()
    local api = self.core:getModule("ServerApi"):getApi()
    Players.PlayerAdded:connect(function(newPlayer)
        api:initialPlayerState(newPlayer,{})
        self.logger:log(("%s was initialized."):format(tostring(newPlayer)))
    end)
end


return PlayerInitializer