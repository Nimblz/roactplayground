local targetInteractable = require(script:WaitForChild("targetInteractable"))
local notifications = require(script:WaitForChild("notifications"))

return function(state,action)
    state = state or {}
    return {
        targetInteractable = targetInteractable(state.targetInteractable, action),
        notifications = notifications(state.notifications, action),
    }
end