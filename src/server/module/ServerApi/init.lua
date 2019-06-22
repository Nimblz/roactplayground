-- wrapper for lpghatguy's common api implementation
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local ServerApi = require(script:WaitForChild("ServerApi"))

local ServerApiWrapper = PizzaAlpaca.GameModule:extend("ServerApi")

function ServerApiWrapper:getApi()
    return self.api
end

function ServerApiWrapper:preInit()
end

function ServerApiWrapper:init()
    self.api = ServerApi.create({

    })
end

function ServerApiWrapper:postInit()
    self.api:connect()
end


return ServerApiWrapper