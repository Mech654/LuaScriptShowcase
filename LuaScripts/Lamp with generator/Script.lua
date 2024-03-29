-- Variables
local light = workspace.Lamp.Base.light.PointLight -- Path to the PointLight
local lamp = workspace.Lamp.Base.light -- Path to the part
local prompt = workspace.Lamp.generator.Attachment.ProximityPrompt -- Path to the prompt

-- Sounds
-- Light Sound
local lightSound = Instance.new("Sound") -- Creates a new Sound instance
lightSound.SoundId = workspace.Lamp.Base.light.Sound.SoundId -- Sets SoundId property
lightSound.Parent = workspace.Lamp.Base.light -- Sets the parent of the sound to the script
lightSound.RollOffMode = Enum.RollOffMode.InverseTapered -- Set the roll-off mode
lightSound.RollOffMaxDistance = 50 -- Set the maximum distance the sound can be heard

-- Generator Sound
local generatorSound = Instance.new("Sound") -- Creates a new Sound instance
generatorSound.SoundId = workspace.Lamp.generator.Sound.SoundId -- Sets SoundId property
generatorSound.Parent = workspace.Lamp.generator -- Sets the parent of the sound to the script
generatorSound.RollOffMode = Enum.RollOffMode.InverseTapered -- Set the roll-off mode
generatorSound.RollOffMaxDistance = 100 -- Set the maximum distance the sound can be heard
generatorSound.Volume = .05

-- Light Data
light.Brightness = 1.75
light.Color = Color3.fromRGB(255, 243, 196)
light.Range = 21


-- Event
prompt.Triggered:Connect(function()
	print("Prompt triggered") -- Debugging: Check if the prompt is triggered
	if not light.Enabled then
		-- Turn on light
		lamp.Transparency = 0
		lamp.Color = Color3.fromRGB(255, 145, 131)
		light.Enabled = true

		-- Play light sound
		lightSound:Play()
		lightSound.Looped = true

		-- Play generator sound
		generatorSound:Play()
		generatorSound.Looped = true

		-- Add light animation here if desired
	else
		-- Turn off light
		lamp.Transparency = 0.75
		lamp.Color = Color3.fromRGB(100, 100, 100)
		light.Enabled = false

		-- Stop light sound
		lightSound.Looped = false
		lightSound:Stop()

		-- Stop generator sound
		generatorSound.Looped = false
		generatorSound:Stop()
	end
end)
