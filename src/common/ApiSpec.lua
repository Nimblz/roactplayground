-- Author: Lucien Greathouse
-- https://github.com/LPGhatguy/rdc-project/blob/master/src/common/ApiSpec.lua

--[[
	This file specifies the protocol for communication between the client and
	server.
	It uses 't' as a way to encode type signatures into the remotes, which
	are checked on both ends. This should be enough to verify that well-behaved
	clients are obeying the API contract, and acts as a first-pass guard against
	malicious clients.
	Both the client and server must implement the correct points of this API.
	Each remote is only one-way to prevent low-hanging fruit exploits related to
	causing a server to yield forever when using RemoteFunction objects.
	The server will automatically generate a RemoteEvent object for every object
	in this table.
	The client will automatically wait for every event to exist and connect to
	each of them.
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local t = require(lib:WaitForChild("t"))

return {
	fromClient = {
		-- methodName = {
        --     arguments = t.tuple(
        --         t.Instance
        --     )
		-- },
	},
	fromServer = {
		initialPlayerState = {
			arguments = t.tuple(
				t.any
			)
		},
		storeAction = {
			arguments = t.tuple(
				t.any
			)
		},
	},
}