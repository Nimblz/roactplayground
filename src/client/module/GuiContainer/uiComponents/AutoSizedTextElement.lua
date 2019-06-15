-- heavily borrows concepts and design from
-- https://github.com/LPGhatguy/rojo/blob/master/plugin/src/Components/FitText.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")

local Dictionary = require(util.Dictionary)

local Roact = require(lib:WaitForChild("Roact"))

local AutoSizedTextElement = Roact.Component:extend("AutoSizedTextElement")

local INF_VEC2 = Vector2.new(math.huge, math.huge)

function AutoSizedTextElement:init(initialProps)
    self.textSize, self.updateTextSize = Roact.createBinding(UDim2.new(0,0,0,0))
end

function AutoSizedTextElement:render()
    local type = self.props.type or "TextLabel"

    self.props.Font = self.props.Font or Enum.Font.GothamBlack
    self.props.TextSize = self.props.TextSize or 16

    local joinedProps = Dictionary.join(self.props, {
        type = Dictionary.None,
        Size = self.textSize,

        [Roact.Event.Changed] = function(rbx, prop)
            if prop == "Text" then
                self:updateSizeBinding(rbx.Text or "   ")
            end
        end,
    })

    return Roact.createElement(type, joinedProps)
end

function AutoSizedTextElement:didMount()
    self:updateSizeBinding(self.props.Text)
end

function AutoSizedTextElement:didUpdate()
    self:updateSizeBinding(self.props.Text)
end

function AutoSizedTextElement:updateSizeBinding(text)
    text = text or ""

	local font = self.props.Font or Enum.Font.GothamBlack
	local textSize = self.props.TextSize or 16

	local textDimensions = TextService:GetTextSize(text, textSize, font, INF_VEC2)
	local totalSize = UDim2.new(
		0, textDimensions.X,
		0, textDimensions.Y)

	self.updateTextSize(totalSize)
end

return AutoSizedTextElement