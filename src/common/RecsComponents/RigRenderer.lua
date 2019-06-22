-- increments score on touch, use in combination with spinner! :D entity composition!!
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "RigRenderer",
    generator = function()
        return {
            equipped = {
				"piratehat",
				"eyepatch",
				"beard",
			},
			scale = 1,
        }
    end,
})