local targetInteractable = require(script:WaitForChild("targetInteractable"))

return function(state,action)
    state = state or {}
    return {
        targetInteractable = targetInteractable(state.targetInteractable, action),
    }
end