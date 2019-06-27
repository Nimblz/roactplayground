local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local getDiffs = require(util:WaitForChild("getDiffs"))

local rigRenderer = {}

function rigRenderer:created()
    print("hoo")
end

function rigRenderer:removing()

end

function rigRenderer:refresh(newEquipped)
    local oldEquipped = self.equipped

    -- get diffs and create individual renderers for them, like in old system.
    local added, removed = getDiffs(oldEquipped,newEquipped)

    self.equipped = newEquipped
end

function rigRenderer:update() -- called every frame

end

return {
    new = function(rig, equipped)
        local self = setmetatable({
            rig = rig,
            equipped = {},
            assetRenderers = {},
        }, {__index = rigRenderer})

        self:refresh(equipped)

        return self
    end
}