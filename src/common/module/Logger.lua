local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local Logger = PizzaAlpaca.GameModule:extend("Logger")

local logtype = {
    OUTPUT = 1,
    WARNING = 2,
    SEVERE = 3,
}

local logtypeNames = {
    [logtype.OUTPUT] = "OUTPUT",
    [logtype.WARNING] = "WARNING",
    [logtype.SEVERE] = "SEVERE",
}

local printFuncs = {
    [logtype.OUTPUT] = print,
    [logtype.WARNING] = warn,
    [logtype.SEVERE] = function(msg)
        -- Todo: send this to a webserver so nim can review it
        error(msg,3) -- delicious red text.
    end
}

function Logger:create() -- constructor, fired on instantiation, core will be nil.
    self.logtype = logtype
end

function Logger:log(module, severity, msg)
    local logstring = "[%s][%s]: %s"
    printFuncs[severity or logtype.OUTPUT](logstring:format(tostring(module),tostring(logtypeNames[severity]),tostring(msg)))
end

return Logger