-- Data settings
local userInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local char = player.Character
local mouse = player:GetMouse()
local tool = script.Parent
local cooldown = false

-- Ammo settings
local ammo = 10
local maxAmmo = 10
local reloading = false

-- Reload text animation
local function textReloadAnimation()
	player.PlayerGui.AmmoGui.Frame.TextLabel.Text = ". |" .. maxAmmo
	task.wait(1)
	player.PlayerGui.AmmoGui.Frame.TextLabel.Text = ".. |" .. maxAmmo
	task.wait(1)
	player.PlayerGui.AmmoGui.Frame.TextLabel.Text = "... |" .. maxAmmo
	task.wait(1)
end

-- Reload function    
local function reload()
	if not reloading and ammo < 10 then
		reloading = true
		tool.Sounds.reloadSound:Play()
		textReloadAnimation() -- Reload animation duration
		ammo = maxAmmo
		player.PlayerGui.AmmoGui.Frame.TextLabel.Text = ammo.. "|" .. maxAmmo
		reloading = false
	end
end

-- Shooting function
tool.Activated:Connect(function()
	if not cooldown and ammo > 0 and not reloading then
		cooldown = true
		ammo -= 1
		tool.Fired:FireServer(mouse.Hit.Position) -- Fires weapon
		tool.Sounds.firingSound:Play()
		player.PlayerGui.AmmoGui.Frame.TextLabel.Text = ammo.. "|" .. maxAmmo
		task.wait(0.5)
		cooldown = false
	elseif ammo <= 0 and not reloading then
		reload()
	end
end)

-- Handle reload on 'R' key press
userInputService.InputBegan:Connect(function(inputObject, isTyping)
	if isTyping then -- Does nothing if the player is typing
		return
	elseif inputObject.KeyCode == Enum.KeyCode.R then -- Executes further if the player is not typing
		print("Reloading...")
		reload()
	end
end)

-- Equip function
tool.Equipped:Connect(function()
	tool.Sounds.equippedSound:Play()
	player.PlayerGui.AmmoGui.Frame.TextLabel.Text = ammo.. "|" .. maxAmmo
	player.PlayerGui.AmmoGui.Enabled = true
end)

-- Unequip function
tool.Unequipped:Connect(function()
	tool.Sounds.unequippedSound:Play()
	player.PlayerGui.AmmoGui.Enabled = false
end)

player.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			print(player.Name .. " has died!")
		end)
	end)
end)
