local soundRegions = Instance.new("Sound", script)
soundRegions.Looped = true
local player = script.Parent:WaitForChild("HumanoidRootPart")
local differentRegions = workspace:WaitForChild("Regions")
local currentRegion = nil

game:GetService("RunService").Heartbeat:Connect(function()
	local raycast = Ray.new(player.Position, player.CFrame.UpVector * -1000)
	local part = workspace:FindPartOnRayWithWhitelist(raycast, {differentRegions})
	if part and part.Parent == differentRegions then
		if part ~= currentRegion then
			currentRegion = part
			soundRegions.SoundId = currentRegion.Sound.SoundId
			soundRegions:Play()
		end
	else
		currentRegion = nil
		soundRegions:Stop()
	end
end)
