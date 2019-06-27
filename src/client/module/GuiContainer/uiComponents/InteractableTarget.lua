local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Selectors = require(common:WaitForChild("Selectors"))

local InteractableTarget = Roact.Component:extend("InteractableTarget")

function InteractableTarget:init(initialProps)
end

function InteractableTarget:render()
    if self.props.targetInteractable then

        local instanceRoot = self.props.targetInteractable
        if instanceRoot:IsA("Model") then
            instanceRoot = instanceRoot.PrimaryPart
            if not instanceRoot then return end
        end

        local interactableBillboard = Roact.createElement("BillboardGui", {
            Adornee = instanceRoot,
            AlwaysOnTop = true,
            ResetOnSpawn = false,
            Size = UDim2.new(0,64,0,64),
            MaxDistance = 64,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        }, {
            Roact.createElement("ImageLabel", {
                Image = "rbxassetid://924320031",
                Size = UDim2.new(1,0,1,0),
                BorderSizePixel = 0,
            })
        })

        return Roact.createElement(Roact.Portal, {
            target = PlayerGui
        }, {
            interactableBillboard = interactableBillboard
        })
    end
end

local function mapStateToProps(state, props)
    return {
        targetInteractable = Selectors.getTargetInteractable(state)
    }
end

InteractableTarget = RoactRodux.connect(mapStateToProps,nil)(InteractableTarget)

return InteractableTarget