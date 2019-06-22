return function(state, action)
    if action.type == "INTERACTABLE_SET" then
        return action.interactable
    end
end