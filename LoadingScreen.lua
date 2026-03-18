--made by mayhav
--aspect ratio is now fixed

local MarketplaceService = game:GetService("MarketplaceService") 
local RunService = game:GetService("RunService")
local Coregui = game:GetService("CoreGui")

local creatorname2
local pacename

local msSuccess, info = pcall(function()
  return MarketplaceService:GetProductInfo(game.PlaceId)
end)

if msSuccess and info and info.Creator then --i dont think that this works for 2013 - 2014
  creatorname2 = info.Creator.Name
  pacename = info.Name
else
  creatorname2 = "Undefined"
  pacename = "Baseplate"
  warn("Something is very wrong...")
end

local LoadingScreen = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local RobloxLogo = Instance.new("ImageLabel")
local GlowThing = Instance.new("ImageLabel")
local TextThing = Instance.new("TextLabel")
local CreatorName = Instance.new("TextLabel")
local PlaceTitle = Instance.new("TextLabel")

LoadingScreen.Parent = Coregui

MainFrame.Parent = LoadingScreen
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.Position = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)

RobloxLogo.Parent = MainFrame
RobloxLogo.Size = UDim2.new(0, 100, 0, 100)
RobloxLogo.Position = UDim2.new(1, -120, 1, -120)
RobloxLogo.BackgroundTransparency = 1
RobloxLogo.Image = "rbxasset://textures/Roblox-loading@2x.png"

GlowThing.Parent = MainFrame
GlowThing.Size = UDim2.new(0, 135, 0, 135)
GlowThing.Position = UDim2.new(1, -137, 1, -137)
GlowThing.BackgroundTransparency = 1
GlowThing.Image = "rbxasset://textures/Roblox-loading-glow.png"

--PlaceTitle.Parent = MainFrame
--PlaceTitle.Size = UDim2.new(0, 300, 0, 80)
--PlaceTitle.Position = UDim2.new(0, 35, 0, 640)
--PlaceTitle.Text = pacename
--PlaceTitle.BackgroundTransparency = 1
--PlaceTitle.TextColor3 = Color3.new(255, 255, 255)
--PlaceTitle.TextScaled = true
--PlaceTitle.Font = "SourceSans"

--CreatorName.Parent = MainFrame
--CreatorName.Size = UDim2.new(0, 200, 0, 50)
--CreatorName.Position = UDim2.new(0, 50, 0, 720)
--CreatorName.Text = "By " .. creatorname2
--CreatorName.BackgroundTransparency = 1
--CreatorName.TextColor3 = Color3.new(255, 255, 255)
--CreatorName.TextScaled = true
--CreatorName.Font = "SourceSans"

TextThing.Parent = MainFrame
TextThing.Size = UDim2.new(0, 300, 0, 30)
TextThing.Position = UDim2.new(0.5, -150, 0.75, 0)
TextThing.Text = "Requesting Server..."
TextThing.BackgroundTransparency = 1
TextThing.TextColor3 = Color3.new(255, 255, 255)
TextThing.TextScaled = true
TextThing.Font = "SourceSans"

local IsLoading = true
local transparency = 0
local direction = 1
local lastTick = tick()

RunService.RenderStepped:connect(function()
  if not IsLoading then return end

  local now = tick()
  local delta = now - lastTick
  lastTick = now

  RobloxLogo.Rotation = RobloxLogo.Rotation + 180 * delta

  transparency = transparency + direction * delta * 2
  if transparency >= 1 then
    transparency = 1
    direction = -1
  else
  if transparency <= 0 then
    transparency = 0
    direction = 1
  end

  GlowThing.ImageTransparency = transparency
end)

function setMessage(message)
  TextThing.Text = message
  --game:SetMessage(message)
end

function clearLoadingScreen()
  IsLoading = false
  game:ClearMessage()
  for i = 0, 10 do
    MainFrame.BackgroundTransparency = i / 10
    wait(0.05)
  end
  LoadingScreen:Destroy()
end
