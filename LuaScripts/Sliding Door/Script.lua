-- Data Settings
print("Creating sound...")
local doorSound = Instance.new("Sound", script) -- Create a new Sound instance and set the parent to the script
doorSound.SoundId = script.Sound.SoundId -- Set SoundId property

-- Obtain TweenService
print("Obtaining TweenService...")
local tweenService = game:GetService("TweenService")

-- Named Models
print("Naming models...")
local model = script.Parent
local leftDoor = model.leftDoor
local rightDoor = model.rightDoor
local prompt = model.top.Attachment.ProximityPrompt

-- TweenInfo
print("Setting TweenInfo...")
local tweenInfo = TweenInfo.new(1) -- Animation duration in seconds

-- Animation values
print("Defining values...")
local leftOpen = {CFrame = leftDoor.CFrame * CFrame.new(-leftDoor.Size.X, 0, 0)} -- Table for opening animation values
local leftClose = {CFrame = leftDoor.CFrame} -- Table for closing animation values
local rightOpen = {CFrame = rightDoor.CFrame * CFrame.new(rightDoor.Size.X, 0, 0)} -- Table for opening animation values
local rightClose = {CFrame = rightDoor.CFrame} -- Table for closing animation values

-- Tweens
print("Setting up tweens...")
local leftTweenOpen = tweenService:Create(leftDoor, tweenInfo, leftOpen)
local leftTweenClose = tweenService:Create(leftDoor, tweenInfo, leftClose)
local rightTweenOpen = tweenService:Create(rightDoor, tweenInfo, rightOpen)
local rightTweenClose = tweenService:Create(rightDoor, tweenInfo, rightClose)

-- Event
print("Setting up event...")
prompt.Triggered:Connect(function()
	print("Phase 1: Opening doors...")

	-- Phase 1: Opening doors
	leftTweenOpen:Play()
	rightTweenOpen:Play()
	doorSound:Play()
	prompt.Enabled = false -- Disable prompt to prevent spam

	wait(3) -- Wait for a moment before closing the doors

	print("Phase 2: Closing doors...")

	-- Phase 2: Closing doors
	leftTweenClose:Play()
	rightTweenClose:Play()
	doorSound:Play()
	prompt.Enabled = true -- Re-enable prompt
end)

print("Script setup finished.")
