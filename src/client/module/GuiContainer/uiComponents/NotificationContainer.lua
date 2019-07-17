local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")
local components = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Selectors = require(common:WaitForChild("Selectors"))
local Dictionary = require(util:WaitForChild("Dictionary"))

local NotificationLabel = require(components:WaitForChild("NotificationLabel"))

local NotificationContainer = Roact.Component:extend("NotificationContainer")

function NotificationContainer:init(initialProps)
end

function NotificationContainer:render()
    local notifs = {}
    local children = {}

    -- loop thru each notification and create labels for each
    for idx, id in ipairs(self.props.notifications.all) do
        local notif = self.props.notifications.byId[id]
        notifs["notification_"..id] = Roact.createElement(NotificationLabel, {
            text = notif.text or "N/A",
            thumbnail = notif.thumbnail,
            statusColor = notif.status,
            layoutIndex = idx,
        })
    end

    children.listLayout = Roact.createElement("UIListLayout", {
        Padding = UDim.new(0,16),
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
    })
    children.padding = Roact.createElement("UIPadding", {
        PaddingBottom = UDim.new(0,16),
        PaddingLeft = UDim.new(0,16),
        PaddingRight = UDim.new(0,16),
        PaddingTop = UDim.new(0,16),
    })

    local combined = Dictionary.join(children,notifs)

    return Roact.createElement("Frame", {
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
    }, combined)
end

local function mapStateToProps(state,props)
    return {
        notifications = Selectors.getNotifications(state) or {byId = {}, all = {}}
    }
end

NotificationContainer = RoactRodux.connect(mapStateToProps,nil)(NotificationContainer)

return NotificationContainer