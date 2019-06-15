local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local src = LocalPlayer:WaitForChild("PlayerScripts")
local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = lib:WaitForChild("RoactRodux")

local uiComponents = script:WaitForChild("uiComponents")
local App = require(uiComponents.App)

local GuiContainer = PizzaAlpaca.GameModule:extend("GuiContainer")

local function makeApp(store, clientApi)
    return Roact.createElement(App, {
        clientApi = clientApi
    })
end

function GuiContainer:preInit()
end

function GuiContainer:init()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    Roact.setGlobalConfig({elementTracing = true})
    self.appHandle = Roact.mount(makeApp(), playerGui)

    self.logger = self.core:getModule("Logger"):createLogger(self)
end

function GuiContainer:postInit()
    self.logger:log("UI Mounted")
end

return GuiContainer