local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
--local util = common:WaitForChild("util")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))
--local Selectors = require(common:WaitForChild("Selectors"))
--local Actions = require(common:WaitForChild("Actions"))

local RigRenderer = require(script:WaitForChild("RigRenderer"))

local RigRendererSystem = RECS.System:extend("RigRendererSystem")

function RigRendererSystem:newRigRenderer(instance,component)
    print(("New RigRenderer created for %s"):format(instance:GetFullName()))

    -- model may not be replicated fully when component tag is processed
    -- wait a sec and check again

    if not instance.PrimaryPart then
        wait(0.5)
        if not instance then return end
        if not instance.PrimaryPart then return end
    end

    for _, child in pairs(instance:GetChildren()) do
        if child:IsA("BasePart") then
            child.Transparency = 1
        end
    end

    local newRenderer = RigRenderer.new(instance, component.equipped or {"fedora"})

    self.renderers[instance] = newRenderer
    newRenderer:created()
end

function RigRendererSystem:removeRigRenderer(instance,component)
    self.renderers[instance]:removing()
    self.renderers[instance] = nil
end

function RigRendererSystem:init()
    self.store = self:getClientModule("StoreContainer"):getStore()
    self.renderers = {}

    self.core:getComponentAddedSignal(RecsComponents.RigRenderer):connect(function(instance,component)
        self:newRigRenderer(instance,component)
    end)

    self.core:getComponentRemovingSignal(RecsComponents.RigRenderer):connect(function(instance,component)
        self:removeRigRenderer(instance,component)
    end)

    for instance,component in self.core:components(RecsComponents.RigRenderer) do
        self:newRigRenderer(instance,component)
    end
end

function RigRendererSystem:step()
    for _, renderer in pairs(self.renderers) do
        renderer:update()
    end
end

return RigRendererSystem