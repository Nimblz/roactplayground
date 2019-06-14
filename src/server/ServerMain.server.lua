local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local src = script.Parent

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local module = common:WaitForChild("module")

local sidedmodule = src:WaitForChild("module")

local gameCore = PizzaAlpaca.GameCore.new()

gameCore:registerChildrenAsModules(module)
gameCore:registerChildrenAsModules(sidedmodule)

gameCore:load()