local tool = script.Parent

-- Function to clear player's inventory
local function clearInventory(player)
	local function destroyAllItems(container)
		if container then
			for _, item in ipairs(container:GetChildren()) do
				item:Destroy()
			end
		end
	end

	-- Clears player's backpack
	destroyAllItems(player:FindFirstChild("Backpack"))

	-- Clears player's toolbar
	local playerGui = player:FindFirstChildOfClass("PlayerGui")
	if playerGui then
		local toolbar = playerGui:FindFirstChild("Backpack") or playerGui:FindFirstChild("PlayerList")
		destroyAllItems(toolbar)
	end
end

-- Raycast function
script.Parent.Fired.OnServerEvent:Connect(function(player, target)
	-- Checks if the player's character exists (i.e., the player is alive)
	if player.Character then
		print("Firing event received.") -- Debug message: Checks if the firing event is triggered

		-- Sets up raycast parameters
		local raycastParameters = RaycastParams.new()
		raycastParameters.FilterDescendantsInstances = {player.Character}
		raycastParameters.FilterType = Enum.RaycastFilterType.Exclude

		-- Performs raycast
		local raycastResult = workspace:Raycast(tool.Pistol.Body.Position, (target - tool.Pistol.Body.Position) * 300, raycastParameters)

		if raycastResult then
			print("Raycast hit something.") -- Debug message: Checks if the raycast hits something

			local raycastInstance = raycastResult.Instance
			local model = raycastInstance:FindFirstAncestorOfClass("Model")

			if model then
				print("Hit model found.") -- Debug message: Checks if the hit model is found

				local humanoid = model:FindFirstChild("Humanoid")
				if humanoid then
					print("Humanoid found.") -- Debug message: Checks if the humanoid is found

					-- Inflict damage based on hit location
					local damage = raycastInstance.Name == "Head" and 20 or 10
					humanoid:TakeDamage(damage)

					print("Shots fired!") -- Debug message: Checks if shots are fired
				end

				print("End.") -- Debug message: End of model check
			end
		end
	else
		print("Player is dead. Raycast function cannot execute.") -- Debug message: Player is dead
		return
	end
end)

-- Clears inventory when player leaves the game
game.Players.PlayerRemoving:Connect(function(player)
	clearInventory(player)
end)
