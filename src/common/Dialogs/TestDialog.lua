local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local dialogNode = require(common.dialogNode)
local dialogResponse = require(common.dialogResponse)

-- test for onSelect
local explosionResponse = dialogResponse({
    text = "please explode me!",
    onSelect = function(player, server)
        local character = player.Character
        if not character then return end
        local root = character.PrimaryPart
        if not root then return end

        local explosion = Instance.new("Explosion")
        explosion.Position = root.Position
        explosion.BlastRadius = 4
        explosion.Parent = character
    end,
})

local foobarResponse = dialogResponse({
    text = "foobar",
    nextNode = dialogNode({
        text = "baz!",
        responseOptions = {
            explosionResponse, -- nested option test
        }
    })
})

local dialogRoot = dialogNode({
    text = "Hello world!~",
    responseOptions = {
        foobarResponse, -- 1
        explosionResponse, -- 2
    }
})

return {
    id = "testDialog",
    root = dialogRoot,
}