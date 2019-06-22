-- Author: Lucien Greathouse
-- https://github.com/LPGhatguy/rdc-project/blob/master/src/server/ServerApi.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ApiSpec = require(ReplicatedStorage.common.ApiSpec)

local ServerApi = {}
ServerApi.prototype = {}
ServerApi.__index = ServerApi.prototype

ServerApi.AllPlayers = newproxy(true)

function ServerApi.create(handlers)
	assert(typeof(handlers) == "table")

	local self = {handlers = handlers}

	setmetatable(self, ServerApi)

	return self
end

function ServerApi.prototype:connect()
	local handlers = self.handlers
	local remotes = Instance.new("Folder")
	remotes.Name = "Events"

	for name, endpoint in pairs(ApiSpec.fromClient) do
		local remote = Instance.new("RemoteEvent")
		remote.Name = "fromClient-" .. name
		remote.Parent = remotes

		local handler = handlers[name]

		if handler == nil then
			error(("Need to implement server handler for %q"):format(name), 2)
		end

		remote.OnServerEvent:Connect(function(player, ...)
			assert(typeof(player) == "Instance" and player:IsA("Player"))

			endpoint.arguments(...)

			handler(player, ...)
		end)
	end

	for name, endpoint in pairs(ApiSpec.fromServer) do
		local remote = Instance.new("RemoteEvent")
		remote.Name = "fromServer-" .. name
		remote.Parent = remotes

		self[name] = function(_, player, ...)
			endpoint.arguments(...)

			if player == ServerApi.AllPlayers then
				remote:FireAllClients(...)
			else
				assert(typeof(player) == "Instance" and player:IsA("Player"))

				remote:FireClient(player, ...)
			end
		end
	end

	for name in pairs(handlers) do
		if ApiSpec.fromClient[name] == nil then
			error(("Invalid handler %q specified!"):format(name), 2)
		end
	end

	remotes.Parent = ReplicatedStorage
	self.remotes = remotes
end

function ServerApi.prototype:destroy()
	self.remotes:Destroy()
end

return ServerApi