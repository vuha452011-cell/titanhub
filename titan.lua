-- TITAN GOD HUB WITH BOOK SELECT

local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local fishing = rs:WaitForChild("Fishing")

_G.AutoFish = false
_G.AutoSell = false
_G.AutoBook = false
_G.SelectedBook = "LuckBook"

-- Anti AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- UI
local gui = Instance.new("ScreenGui",player.PlayerGui)

local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0,260,0,330)
frame.Position = UDim2.new(0.1,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

-- rainbow border
task.spawn(function()
while true do
for i=0,1,0.01 do
frame.BorderColor3 = Color3.fromHSV(i,1,1)
task.wait()
end
end
end)

-- title
local title = Instance.new("TextLabel",frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "TITAN GOD HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(35,35,35)

-- BOOK SELECT
local bookLabel = Instance.new("TextLabel",frame)
bookLabel.Position = UDim2.new(0,10,0,40)
bookLabel.Size = UDim2.new(0,240,0,25)
bookLabel.Text = "Selected Book: LuckBook"
bookLabel.BackgroundTransparency = 1
bookLabel.TextColor3 = Color3.new(1,1,1)

local books = {"LuckBook","SpeedBook","PowerBook","GoldenBook"}

local dropdown = Instance.new("TextButton",frame)
dropdown.Position = UDim2.new(0,10,0,70)
dropdown.Size = UDim2.new(0,240,0,30)
dropdown.Text = "Change Book"

dropdown.MouseButton1Click:Connect(function()
local current = table.find(books,_G.SelectedBook) or 1
current = current + 1
if current > #books then current = 1 end
_G.SelectedBook = books[current]
bookLabel.Text = "Selected Book: ".._G.SelectedBook
end)

-- AUTO BUY BOOK
local bookBtn = Instance.new("TextButton",frame)
bookBtn.Position = UDim2.new(0,10,0,110)
bookBtn.Size = UDim2.new(0,240,0,30)
bookBtn.Text = "Auto Buy Book : OFF"

bookBtn.MouseButton1Click:Connect(function()
_G.AutoBook = not _G.AutoBook
bookBtn.Text = "Auto Buy Book : "..(_G.AutoBook and "ON" or "OFF")
end)

-- AUTO FISH
local fish = Instance.new("TextButton",frame)
fish.Position = UDim2.new(0,10,0,150)
fish.Size = UDim2.new(0,240,0,30)
fish.Text = "Auto Fish : OFF"

fish.MouseButton1Click:Connect(function()
_G.AutoFish = not _G.AutoFish
fish.Text = "Auto Fish : "..(_G.AutoFish and "ON" or "OFF")
end)

-- AUTO SELL
local sell = Instance.new("TextButton",frame)
sell.Position = UDim2.new(0,10,0,190)
sell.Size = UDim2.new(0,240,0,30)
sell.Text = "Auto Sell : OFF"

sell.MouseButton1Click:Connect(function()
_G.AutoSell = not _G.AutoSell
sell.Text = "Auto Sell : "..(_G.AutoSell and "ON" or "OFF")
end)

-- LOOPS
task.spawn(function()
while true do
if _G.AutoFish then
pcall(function()
fishing:FireServer("Cast")
wait(2)
fishing:FireServer("Reel")
end)
end
wait(1)
end
end)

task.spawn(function()
while true do
if _G.AutoSell then
pcall(function()
rs.SellFish:FireServer()
end)
end
wait(5)
end
end)

task.spawn(function()
while true do
if _G.AutoBook then
pcall(function()
rs.BuyBook:FireServer(_G.SelectedBook)
end)
end
wait(10)
end
end)