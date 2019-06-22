-- wrapper for lpghatguy's common api implementation
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local ClientApi = require(script:WaitForChild("ClientApi"))

local ClientApiWrapper = PizzaAlpaca.GameModule:extend("ClientApi")

function ClientApiWrapper:getApi()
    return self.api
end

function ClientApiWrapper:preInit()
end

function ClientApiWrapper:init()
    local StoreContainer = self.core:getModule("StoreContainer")
    self.api = ClientApi.new({
        initialPlayerState = function(gameState)
            StoreContainer:initializeStore(gameState)
        end,

        storeAction = function(action)
            local store = StoreContainer:getStore()
            if not store then return end

            store:dispatch(action)
        end,
    })
end

function ClientApiWrapper:postInit()
    self.api:connect()
end


return ClientApiWrapper