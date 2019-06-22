-- Author: Lucien Greathouse (LPGhatguy)
-- https://github.com/LPGhatguy/rdc-project/blob/master/src/client/ClientApi.lua

-- Modifications by Austin Reuschle (Nimblz)

--[[
	This object's job is to read the common ApiSpec, which defines the protocol
	for communicating with the server and the types that each method accepts.
	On connecting to the server via `connect`, we generate an object that has
	a method for each RemoteEvent that attached validation on both ends.
	I've found that this is a super nice way to think about network
	communication in Roblox, since it lines up with other strongly-typed RPC
	systems.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ApiSpec = require(ReplicatedStorage.common.ApiSpec)

local ClientApi = {}
ClientApi.prototype = {}
ClientApi.__index = ClientApi.prototype

function ClientApi.new(handlers)
	local self = {handlers = handlers}

	setmetatable(self, ClientApi)

	return self
end

function ClientApi.prototype:connect()
	local handlers = self.handlers
	local remotes = ReplicatedStorage:WaitForChild("Events")

	for name, endpoint in pairs(ApiSpec.fromClient) do
		local remote = remotes:WaitForChild("fromClient-" .. name)

		self[name] = function(_, ...)
			endpoint.arguments(...)

			remote:FireServer(...)
		end
	end

	for name, endpoint in pairs(ApiSpec.fromServer) do
		local remote = remotes:WaitForChild("fromServer-" .. name)

		local handler = handlers[name]

		if handler == nil then
			error(("Need to implement client handler for %q"):format(name), 2)
		end

		remote.OnClientEvent:Connect(function(...)
			endpoint.arguments(...)

			handler(...)
		end)
	end

	for name in pairs(handlers) do
		if ApiSpec.fromServer[name] == nil then
			error(("Invalid handler %q specified!"):format(name), 2)
		end
	end
end

return ClientApi