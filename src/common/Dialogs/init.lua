local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("common")

local by = require(common.util:WaitForChild("by"))
local compileSubmodulesToArray = require(common.util:WaitForChild("compileSubmodulesToArray"))
local all = compileSubmodulesToArray(script, true)

return {
    all = all,
    byId = by("id", all),
}