local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")

local Dictionary = require(util.Dictionary)

local Roact = require(lib:WaitForChild("Roact"))

local Clock = Roact.Component:extend("Clock")

local SECS_IN_MIN = 60
local SECS_IN_HOUR = SECS_IN_MIN*60
local HOURS_ON_FACE = 12

local function hourMarks(numHours)
    local marks = {}
    for i = 1,numHours do
        local theta = (i/numHours)*math.pi*2
        local posX = math.sin(theta)*60
        local posY = math.cos(theta)*60
        marks["hour_"..i] = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,posX+1,0.5,posY+1),
            Size = UDim2.new(0,3,0,3),

            BackgroundColor3 = Color3.fromRGB(31,31,31),
            BorderSizePixel = 0,
        }, {
            Roact.createElement("Frame", {
                Position = UDim2.new(0,-1,0,-1),
                Size = UDim2.new(1,0,1,0),
                BackgroundColor3 = Color3.fromRGB(220,220,220),
                BorderSizePixel = 0,
            })
        })
    end
    return Roact.createElement("Frame", {
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
    }, marks)
end

local function clockHand(theta,length,thickness,color)
    return Roact.createElement("Frame", {
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,

        Rotation = math.deg(theta)
    }, {
        secHandVis = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5,1),
            Position = UDim2.new(0.5,0,0.5,0),
            Size = UDim2.new(0,thickness or 3,0,length),

            BackgroundColor3 = color or Color3.fromRGB(31,31,31),
            BorderSizePixel = 0,
        })
    })
end

local function hands(t)
    local secOfMin = (t%(60))/(SECS_IN_MIN)
    local minOfHour = (t%(60*60))/(SECS_IN_HOUR)
    local hourOfDay = (t%(60*60*12))/(SECS_IN_HOUR*HOURS_ON_FACE)

    local secHandTheta = secOfMin * math.pi * 2
    local minHandTheta = minOfHour * math.pi * 2
    local hourHandTheta = hourOfDay * math.pi * 2

    local secHand = clockHand(secHandTheta,60, 2,Color3.fromRGB(180,40,40))
    local minHand = clockHand(minHandTheta,60)
    local hourHand = clockHand(hourHandTheta,30)

    return Roact.createElement("Frame", {
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
    }, {
        secHand = secHand,
        minHand = minHand,
        hourHand = hourHand,
    })
end

function Clock:updateTime(newTime)
    self:setState({
        time = newTime
    })
end

function Clock:init(initialProps)
    self:updateTime(tick())
end

function Clock:render()

    local clockFrameProps = Dictionary.join(self.props, {
        Size = UDim2.new(0,128,0,128),

        BorderSizePixel = 0,
        BackgroundTransparency = 1
    })

    local clockFrameChildren = {
        hourMarks = hourMarks(HOURS_ON_FACE),
        hands = hands(self.state.time),
    }

    return Roact.createElement("Frame", clockFrameProps, clockFrameChildren)
end

function Clock:didMount()
    self.animationConnection = RunService.RenderStepped:connect(function()
        self:updateTime(tick())
    end)
end

function Clock:willUnmount()
    if self.animationConnection then self.animationConnection:disconnect() end
end

return Clock