local LocalPlayer = game.Players.LocalPlayer
local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
local Combat = game:GetService("ReplicatedStorage").Events.Combat
local MobsSpots = game:GetService("Workspace").Game.Regions.Dion.Areas.AncientRuins.MobsSpots

local listMon = {
  {
    amount = 15,
    name = "FeralFiendSoldier",
    HP = "FeralFiend.Head.HealthAndMana.PlayerBars.Bars.HPFrame.CanvasGroup.TextFrame.AmountText",
    BodyHitbox = "FeralFiend.bodyHitbox",
    HRP = "FeralFiend.HumanoidRootPart",
  },
  {
    amount = 10,
    name = "FeralFiendGeneral",
    HP = "FeralFiend.Head.HealthAndMana.PlayerBars.Bars.HPFrame.CanvasGroup.TextFrame.AmountText",
    BodyHitbox = "FeralFiend.bodyHitbox",
    HRP = "FeralFiend.HumanoidRootPart",
  },
}

function FindByPath(root, path)
  local pathParts = string.split(path, ".")
  
  local current = root
  for _, part in ipairs(pathParts) do
      current = current:FindFirstChild(part)
      if not current then
          return nil
      end
  end
  
  return current
end

_G.AutoFarm = true
while (_G.AutoFarm) do
  wait()
  for _, MobData in pairs(listMon) do
    if not _G.AutoFarm then break end
    wait()
    local count = 0
    for _,mob in pairs(MobsSpots[MobData["name"]]:GetChildren()) do
      if not _G.AutoFarm then break end
      local HP = FindByPath(mob, MobData["HP"])
      local MobPart = FindByPath(mob, MobData["HRP"])
      local BodyHitbox = FindByPath(mob, MobData["BodyHitbox"])

      if (LocalPlayer.Character.RightHand:FindFirstChild("RightGrip")) then
        LocalPlayer.Character.RightHand.RightGrip.Part1 = nil
      else if (LocalPlayer.Character.Weapon.Handle:FindFirstChild("Handle")) then
        LocalPlayer.Character.Weapon.Handle.Handle.Part1 = nil
      end
      wait()

      BodyHitbox.Size = Vector3.new(60, 60, 60)
      LocalPlayer.Character.Weapon.Handle.Anchored = true
      LocalPlayer.Character.Weapon.Handle.FirePoint.Position = Vector3.new(0,0,0)

      if (tonumber(HP.Text) > 0) then
        count = count + 1
      end
      
      while tonumber(HP.Text) > 0 and _G.AutoFarm do
        task.wait()
        
        local cframe = CFrame.new(MobPart.Position)
        _G.part.CFrame = cframe + Vector3.new(0, -27, 0)
        HumanoidRootPart.CFrame = cframe + Vector3.new(0, -25, 0)
        LocalPlayer.Character.Weapon.Handle.Position = BodyHitbox.Position

        _G.Click()
      end
      if (count >= MobData["amount"]) then
        break
      end
    end
  end
end

print("Pass")
