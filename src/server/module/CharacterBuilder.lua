-- creates the abstract replicated versions of character rigs, adds RigRenderer tags for recs on the client side

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local CharacterBuilder = PizzaAlpaca.GameModule:extend("CharacterBuilder")

local function bindRigBuilder(player)
    player.CharacterAdded:connect(function(newChar)
        local humanoid = newChar:WaitForChild("Humanoid")
        newChar:WaitForChild("HumanoidRootPart")
        newChar:WaitForChild("LowerTorso")
        newChar:WaitForChild("Head")
        humanoid:BuildRigFromAttachments()

        CollectionService:AddTag(newChar, "RigRenderer")
    end)
end

function CharacterBuilder:preInit()
end

function CharacterBuilder:init()
    Players.PlayerAdded:connect(bindRigBuilder)

    for _,player in pairs(Players:GetPlayers()) do
        bindRigBuilder(player)
    end
end

function CharacterBuilder:postInit()
end


return CharacterBuilder