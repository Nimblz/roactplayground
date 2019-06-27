local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))
local Selectors = require(common:WaitForChild("Selectors"))
local Actions = require(common:WaitForChild("Actions"))

local InteractableSystem = RECS.System:extend("InteractableSystem")

function InteractableSystem:init()
    self.store = self:getClientModule("StoreContainer"):getStore()
end

function InteractableSystem:step()
    local targetInstance = nil
    local targetDist = math.huge

    local char = LocalPlayer.Character
    if not char then return end
    local root = char.PrimaryPart
    if not root then return end

    local charPos = root.Position

    for instance, component in self.core:components(RecsComponents.Interactable) do
        local instanceRoot = instance
        if instance:IsA("Model") then
            instanceRoot = instance.PrimaryPart
            if not instanceRoot then return end
        end

        local dist = (instanceRoot.Position - charPos).magnitude

        if dist < component.maxUseDistance and dist < targetDist then
            targetInstance = instance
            targetDist = dist
        end
    end

    -- check if closest valid interactable is diff to current target
    -- if it is dispatch an action to change target
    local state = self.store:getState()
    local targetInteractable = Selectors.getTargetInteractable(state)

    if targetInstance ~= targetInteractable then
        self.store:dispatch(Actions.TARGETINTERACTABLE_SET(targetInstance))
    end
end

return InteractableSystem