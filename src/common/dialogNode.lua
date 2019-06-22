local dialogNode_prototype = {
    text = "NODE TEXT UNIMPLEMENTED, NOTIFY NIMBLZ PLEASE",
    responseOptions = {},
}

local function dialogNode(props)
    return setmetatable(props,{__index = dialogNode_prototype})
end

return dialogNode