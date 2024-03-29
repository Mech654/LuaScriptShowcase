-- Variables
local TweenService = game:GetService("TweenService")
local lightRing = workspace["sci-fiGenerator"].Body.Ring
local lampLight = workspace["sci-fiGenerator"].Body.Ring.Attachment.Glow
local prompt = workspace["sci-fiGenerator"].Button.ProximityPrompt

-- Function to create sound
local function createSound(soundId, parent, rollOffMaxDistance)
	local sound = Instance.new("Sound")
	sound.SoundId = soundId
	sound.Parent = parent
	sound.RollOffMode = Enum.RollOffMode.InverseTapered
	sound.RollOffMaxDistance = rollOffMaxDistance
	return sound
end

-- Function to create tween
local function createTween(object, tweenInfo, properties)
	return TweenService:Create(object, tweenInfo, properties)
end

-- Create sounds
local sounds = {
	button = createSound(workspace["sci-fiGenerator"].Sounds.buttonSound.SoundId, lightRing, 100),
	alarm = createSound(workspace["sci-fiGenerator"].Sounds.alarmSound.SoundId, lightRing, 100),
	startup = createSound(workspace["sci-fiGenerator"].Sounds.startupSound.SoundId, lightRing, 100),
	poweringOn = createSound(workspace["sci-fiGenerator"].Sounds.powerUpSound.SoundId, lightRing, 100),
	primaryHum = createSound(workspace["sci-fiGenerator"].Sounds.whileOnSound1.SoundId, lightRing, 100),
	secondaryHum = createSound(workspace["sci-fiGenerator"].Sounds.whileOnSound2.SoundId, lightRing, 100),
	initialShutdown = createSound(workspace["sci-fiGenerator"].Sounds.initialShutdownSound.SoundId, lightRing, 100),
	additionalShutdown = createSound(workspace["sci-fiGenerator"].Sounds.additionalShutdownSound.SoundId, lightRing, 100)
}

-- Create tweens
local shutdownTweenInfo = TweenInfo.new(
	3, -- Time the tween takes
	Enum.EasingStyle.Exponential, -- EasingStyle
	Enum.EasingDirection.Out, -- EasingDirection
	0, -- Number of times you want it to repeat
	false, -- Do you want it to reverse
	0 -- Delay
)

local powerUpTweenInfo = TweenInfo.new(
	15, -- Time the tween takes
	Enum.EasingStyle.Bounce, -- EasingStyle
	Enum.EasingDirection.In, -- EasingDirection
	0, -- Number of times you want it to repeat
	false, -- Do you want it to reverse
	0 -- Delay
)

-- Create tweens
local shutdown = createTween(lightRing, shutdownTweenInfo, {Color = Color3.fromRGB(55, 55, 55)})
local powerUp = createTween(lightRing, powerUpTweenInfo, {Color = Color3.fromRGB(100, 100, 222)})

-- Function to toggle the generator state
local function toggleGenerator()
	if prompt.ActionText == "Turn on" then
		print("Generator turning on")
		prompt.Enabled = false
		wait(.5)
		prompt.ActionText = "Turn off"

		-- Sounds
		print("Button has been pressed.")
		sounds.button:Play()
		wait(2)
		print("Sounding off caution alarm.")
		sounds.alarm:Play()
		sounds.alarm.Looped = true
		wait(4)
		sounds.alarm.Looped = false
		print("Startup engaged.")
		sounds.startup:Play()
		print("Waiting...")
		wait(6)
		sounds.poweringOn:Play()
		print("Powering up...")

		-- Tween(s) & others
		powerUp:Play()

		wait(12.5)  -- Wait for the animation to complete
		sounds.primaryHum:Play()
		sounds.primaryHum.Looped = true
		sounds.secondaryHum:Play()
		sounds.secondaryHum.Looped = true
		prompt.Enabled = true
	else
		-- Stop looping sounds
		sounds.primaryHum:Stop()
		sounds.primaryHum.Looped = false
		sounds.secondaryHum:Stop()
		sounds.secondaryHum.Looped = false

		print("Generator turning off")
		sounds.initialShutdown:Play()
		sounds.additionalShutdown:Play()
		shutdown:Play()

		prompt.Enabled = false
		wait(.5)
		prompt.ActionText = "Turn on"
		wait(5)  -- Wait for the animation to complete
		prompt.Enabled = true
	end
end

-- Connects the toggle function to the prompt's Triggered event
prompt.Triggered:Connect(toggleGenerator)

print("Script finished executing")
