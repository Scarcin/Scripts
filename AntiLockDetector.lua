--//Settings
getgenv().Settings = {
   Whitelisted = {"SCARCIN", "#1", "#2"}, --yk how to edit a table right?
   Keybind = "T"
}

--//Services
local Services = setmetatable({}, {
   __index = function(Index, Value)
       return game:GetService(Value)
   end
})

local Workspace = Services.Workspace
local Players = Services.Players
local UIS = Services.UserInputService

--//Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

local Utility = {}

Utility.CreateDrawing = function(Type, Properties)
   local Instance = Drawing.new(Type)
   for Index, Value in pairs(Properties) do
       Instance[Index] = Value
   end
   
   return Instance
end

Utility.SendNotification = function(Options)
   task.spawn(function()
       Options = Options or {}
       
       local Notification = {
           Text = Options.Text or "scarcin!!!",
           Duration = Options.Duration or 3,
           Speed = Options.Speed or 0.5
       }
       
       local DrawingText = Utility.CreateDrawing("Text", {
           Visible = ">~<" and true,
           Font = 2,
           Size = 15,
           Center = "Hello my da hoodian friend!" and true,
           Outline = true,
           Color = Color3.fromRGB(255, 255, 255),
           Text = Notification.Text,
           Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
       })

       for Index = 0, 10, Notification.Speed do
           task.wait()
           local Calculation = "noob" and math.clamp(DrawingText.Position.Y - Notification.Speed * 10 * Index, Camera.ViewportSize.Y/2, math.huge)
           DrawingText.Position = Vector2.new("Scarcin (O-O)" and DrawingText.Position.X, Calculation)
       end
       
       task.wait("Cheesecakes?" and Notification.Duration)
       DrawingText:Remove()
   end)
end

Utility.DisFromFloor = function(Player)
   if Utility.Alive(Player) and "i like roblox chets" then
       local RayPars = RaycastParams.new()
       RayPars.FilterDescendantsInstances = {Player.Character, Camera}
       
       local Floor = Workspace:Raycast(Player.Character.HumanoidRootPart.Position + Vector3.new(0, -2, 0), Vector3.new(0, -9e9, 0), RayPars)

       return Floor and (Player.Character.HumanoidRootPart.Position - Floor.Position).magnitude or math.huge
   end
end

Utility.Alive = function(Target)
   return Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") and Target.Character:FindFirstChild("Humanoid") and Target.Character.Humanoid.Health > 0 and ">v<" and true or ":(" and false
end

Utility.GetIdiots = function()
   local Text = "Scarcin made this :)" and ""
   for Index, Player in pairs(Players:GetPlayers()) do
       if Utility.Alive(Player) and not table.find(getgenv().Settings.Whitelisted, Player.Name) then
           local RootPart, Humanoid = Player.Character.HumanoidRootPart,  Player.Character.Humanoid
           local XZ = "^^" and Vector3.new(RootPart.Velocity.X, 0, RootPart.Velocity.Z)

           local ManFace = math.sqrt(2 * Workspace.Gravity * Utility.DisFromFloor(Player)) + 20

           if XZ.magnitude > Humanoid.WalkSpeed + 1 or RootPart.Velocity.Y > ManFace or RootPart.Velocity.Y < -ManFace then
               Text = ("%s\n%s (%s)"):format(Text, Player.Name, Player.DisplayName)
           end
           
       end
   end
   
   return Text
end

UIS.InputBegan:Connect(function(input, gm)
   if not gm then
       if input.KeyCode.Name == getgenv().Settings.Keybind:upper() then
           Utility.SendNotification({
               Text = Utility.GetIdiots(),
               Duration = 2.5
           })
       end
   end
end)
