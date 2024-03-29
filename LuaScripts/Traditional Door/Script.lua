-- Established sound assets
--Opening sound
local openSound = Instance.new("Sound", workspace.TraditionalDoor.Door) -- Creates a new Sound instance and sets parent by path
openSound.SoundId = workspace.TraditionalDoor.Door.openSound.SoundId -- Sets SoundId property
openSound.RollOffMode = Enum.RollOffMode.InverseTapered -- Set the roll-off mode
openSound.RollOffMaxDistance = 30 -- Set the maximum distance the sound can be heard

--Closing sound
local closeSound = Instance.new("Sound", workspace.TraditionalDoor.Door) -- Creates a new Sound instance and sets parent by path
closeSound.SoundId = workspace.TraditionalDoor.Door.closeSound.SoundId -- Sets SoundId property
closeSound.RollOffMode = Enum.RollOffMode.InverseTapered -- Set the roll-off mode
closeSound.RollOffMaxDistance = 30 -- Set the maximum distance the sound can be heard

-- Initializes services
local tweenService = game:GetService("TweenService")

-- Initializes door components
local door = script.Parent.Door
local hinge = script.Parent.Hinge
local prompt = door.ProximityPrompt

-- Defines door states
local openCFrame = hinge.CFrame * CFrame.Angles(0, math.rad(90), 0)
local closeCFrame = hinge.CFrame * CFrame.Angles(0, 0, 0)

-- Defines tween parameters
local tweenDuration = 1
local tweenInfo = TweenInfo.new(tweenDuration)

-- Creates tweens for opening and closing
local tweenOpen = tweenService:Create(hinge, tweenInfo, { CFrame = openCFrame })
local tweenClose = tweenService:Create(hinge, tweenInfo, { CFrame = closeCFrame })

-- Function to toggle the door state
local function toggleDoor()
	if prompt.ActionText == "Close" then
		tweenClose:Play()
		closeSound:Play()
		
		-- Prevents actionText changing after key is pressed
		-- Disables prompt temporarily to prevent spamming
		prompt.Enabled = false
		prompt.ActionText = "Open"
		wait(tweenDuration)  -- Wait for the animation to complete
		prompt.Enabled = true
	else
		tweenOpen:Play()
		openSound:Play()
		
		-- Prevents actionText changing after key is pressed
		-- Disables prompt temporarily to prevent spamming
		prompt.Enabled = false
		prompt.ActionText = "Close"
		wait(tweenDuration)  -- Wait for the animation to complete
		prompt.Enabled = true
	end
end

-- Connects the toggle function to the prompt's Triggered event
prompt.Triggered:Connect(toggleDoor)
