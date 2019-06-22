local selectedInteractable = require(script:WaitForChild("selectedInteractable"))

return function(state,action)
    state = state or {}
    return {
        selectedInteractable = selectedInteractable(state.selectedInteractable, action),
    }
end