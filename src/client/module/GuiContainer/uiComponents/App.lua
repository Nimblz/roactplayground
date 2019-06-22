local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local uiComponents = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))

local CodeLabLogo = require(uiComponents.CodeLabLogo)
local Clock = require(uiComponents.Clock)

local App = Roact.Component:extend("App")

function App:init(initialProps)
end

function App:render()
    local children = {}

    return Roact.createElement("ScreenGui", {
        Name = "gameGui",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, children)
end

return App