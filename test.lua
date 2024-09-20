local LocalPlayer = game.Players.LocalPlayer
if not _G.part then
  _G.part = Instance.new("Part")
end
_G.part.Size = Vector3.new(50, 1, 50)
_G.part.Anchored = true
_G.part.Transparency = 0
_G.part.Parent = game.Workspace

local LocalPlayer = game.Players.LocalPlayer
local Object = {
  ["OakTree"] = 4,
  -- ["Rock"] = 3,
  -- ["PalmTree"]  = 3,
}
function getMesh(folder)
  for i,v in pairs(folder:GetDescendants()) do
    if v.ClassName == "MeshPart" then
      return v
    end
  end
end
for _, name in pairs(Object) do
  for v,cd in pairs(game:GetService("Workspace").Game.Harvest[name]:GetChildren()) do
    if v.Name == "HarvestModel" then
      pcall(function()
        local ModelParts = getMesh(v.ModelParts)
        local PrimaryPart = v.PrimaryPart
        if ModelParts.Transparency == 0 then
          _G.part.CFrame = PrimaryPart.CFrame + Vector3.new(0, -5, 0)
          LocalPlayer.Character.HumanoidRootPart.CFrame = PrimaryPart.CFrame + Vector3.new(0, 2, 0)
          repeat wait()
            fireproximityprompt(PrimaryPart.ProximityPrompt)
          until ModelParts.Transparency == 1
          wait(cd)
        end
      end)
    end
  end
end
LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
