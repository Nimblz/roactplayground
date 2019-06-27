local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local uiComponents = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))

local InteractableTarget = require(uiComponents.InteractableTarget)
local Clock = require(uiComponents.Clock)

local App = Roact.Component:extend("App")

function App:init(initialProps)
end

function App:render()
    local children = {}

    children.clock = Roact.createElement(Clock, {
        Position = UDim2.new(1,-32,1,-32),
        AnchorPoint = Vector2.new(1,1),
        Size = UDim2.new(0,64,0,64),
    })

    children.interactableTarget = Roact.createElement(InteractableTarget)

    return Roact.createElement("ScreenGui", {
        Name = "gameGui",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, children)
end

return App