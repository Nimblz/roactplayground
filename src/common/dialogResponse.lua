local dialogResponse_prototype = {
    text = "RESPONSE UNIMPLEMENTED, NOTIFY NIMBLZ",
    onSelect = function(player, server) end,
    nextNode = nil, -- if nil this is the end of conversation.
}

local function dialogResponse(props)
    return setmetatable(props,{__index = dialogResponse_prototype})
end

return dialogResponse