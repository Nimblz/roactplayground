-- break up a string into its words split by whitespace characters
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")
local uiComponents = script:FindFirstAncestor("uiComponents")

local Dictionary = require(util.Dictionary)
local RichText = require(lib.RichText)

local Roact = require(lib:WaitForChild("Roact"))

local RichTextMarkupFrame = Roact.Component:extend("RichTextMarkupFrame")

function RichTextMarkupFrame:init(initialProps)
    self.frameRef = Roact.createRef()
end

function RichTextMarkupFrame:render()

    local joinedProps = Dictionary.join(self.props, {
        text = Dictionary.None,
        Text = Dictionary.None,
        Font = Dictionary.None,
        TextSize = Dictionary.None,
        TextXAlignment = Dictionary.None,
        TextYAlignment = Dictionary.None,
        ClearTextOnFocus = Dictionary.None,
        [Roact.Children] = Dictionary.None,
    })

    return Roact.createElement("Frame", joinedProps, Dictionary.join(self.props[Roact.Children], {
        textContainer = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,0,self.props.TextSize or 24),
            [Roact.Ref] = self.frameRef,
        })
    }))
end

function RichTextMarkupFrame:didMount()
    local mountedFrame = self.frameRef:getValue()

    if not mountedFrame then return end

    self.state.textObject = RichText:New(
        mountedFrame,
        self.props.text or "",
        {
            Font = self.props.Font or Enum.Font.GothamBlack,
            TextSize = 16
        }
    )

    coroutine.wrap(function()
        wait(0.5)
        self.state.textObject:Animate()
    end)()
end

function RichTextMarkupFrame:willUnmount()
    local textObject = self.state.textObject
    if not textObject then return end

    textObject:Hide()
end


return RichTextMarkupFrame