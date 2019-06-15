local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local uiComponents = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))

local CodeLabLogo = require(uiComponents.CodeLabLogo)

local App = Roact.Component:extend("App")

function App:init(initialProps)
end

function App:render()
    local children = {}

    children.codeLabLogo = Roact.createElement(CodeLabLogo,{
        Position = UDim2.new(0.5,0,0.5),
    })

    return Roact.createElement("ScreenGui", {
        Name = "gameGui",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, children)
end

return App