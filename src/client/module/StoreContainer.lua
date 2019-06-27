local ReplicatedStorage = game:GetService("ReplicatedStorage")

local src = script.Parent.Parent
local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local Rodux = require(lib:WaitForChild("Rodux"))
local Signal = require(lib:WaitForChild("Signal"))

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local clientReducer = require(src:WaitForChild("clientReducer"))

local StoreContainer = PizzaAlpaca.GameModule:extend("StoreContainer")

function StoreContainer:create()
    self.storeInitialized = Signal.new()
end

function StoreContainer:getStore()
    return self.store
end

function StoreContainer:initializeStore(initialState)
    self.logger:log("Local store initialized.")
    self.store = Rodux.Store.new(clientReducer,initialState, {
        Rodux.thunkMiddleware,
    })
    self.storeInitialized:fire()
end

function StoreContainer:preInit()
end

function StoreContainer:init()
    self.logger = self.core:getModule("Logger"):createLogger(self)
end

function StoreContainer:postInit()
end

return StoreContainer