local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local FooProducer = PizzaAlpaca.GameModule:extend("FooProducer")


function FooProducer:preInit()
    self.logger = self.core:getModule("Logger")
end

function FooProducer:init()
    self.logger:log(self, self.logger.logtype.SEVERE, "Foo") -- log(module, severity, str) produces an output like "[{module}]: {str}"
end


return FooProducer