local LocalPlayer = game.Players.LocalPlayer
local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
local Combat = game:GetService("ReplicatedStorage").Events.Combat
local MobsSpots = game:GetService("Workspace").Game.Regions.Dion.Areas.AncientRuins.MobsSpots

print("pass1")
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

print("pass2")
_G.AutoFarm = true
local skill1 = tick()
while (_G.AutoFarm) do
  wait()
  local npcCF = CFrame.new(5704.8330078125, 86.257568359375, -1452.57958984375)
  HumanoidRootPart.CFrame = npcCF
  _G.part.CFrame = npcCF + Vector3.new(0, -10, 0)
  wait(2)
  game:GetService("ReplicatedStorage").Events.Quest.GrantQuest:FireServer("MarshFiendPurge")

  for _, MobData in pairs(listMon) do
    if not _G.AutoFarm then break end
    wait()
    local count = 0
    print("pass3")
    for _,mob in pairs(MobsSpots[MobData["name"]]:GetChildren()) do
      -- pcall(function()
        if not _G.AutoFarm then break end
        local HP = FindByPath(mob, MobData["HP"])
        local MobPart = FindByPath(mob, MobData["HRP"])
        local BodyHitbox = FindByPath(mob, MobData["BodyHitbox"])
        local CharacterId = MobPart:GetAttribute("CharacterId")

        if (LocalPlayer.Character.RightHand:FindFirstChild("RightGrip")) then
          LocalPlayer.Character.RightHand.RightGrip.Part1 = nil
        elseif (LocalPlayer.Character.Weapon.Handle:FindFirstChild("Handle")) then
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
          HumanoidRootPart.CFrame = cframe + Vector3.new(0, -20, 0)
          LocalPlayer.Character.Weapon.Handle.Position = BodyHitbox.Position

          if tick() - skill1 > 6 then
            wait(1.5)
            skill1 = tick()
            -- game:GetService("ReplicatedStorage").Events.Combat.ActivateSkill:FireServer({
            --   "FireMeteor",
            --   HumanoidRootPart.CFrame,
            --   MobPart.Position
            -- })
            VirtualInputManager:SendKeyEvent(true, 49, false, x)
            wait()
            VirtualInputManager:SendKeyEvent(false, 49, false, x)
            wait(1.5)
          else
            _G.Click()
          end
        end

        local monDeadCF = CFrame.new(MobPart.Position)
        HumanoidRootPart.CFrame = monDeadCF
        _G.part.CFrame = monDeadCF + Vector3.new(0, -10, 0)
        wait(1)
        -- game:GetService("ReplicatedStorage").Events.Drop.CollectDrop:FireServer({
        --   "All",
        --   {
        --     [CharacterId] = "0"
        --   }
        -- })
        VirtualInputManager:SendKeyEvent(true, 103, false, x)
        wait()
        VirtualInputManager:SendKeyEvent(false, 103, false, x)
        wait()
        VirtualInputManager:SendKeyEvent(true, 103, false, x)
        wait()
        VirtualInputManager:SendKeyEvent(false, 103, false, x)
        wait(1)

        if (count >= MobData["amount"]) then
          break
        end
      -- end)
    end
  end
  
  local npcCF = CFrame.new(5704.8330078125, 86.257568359375, -1452.57958984375)
  HumanoidRootPart.CFrame = npcCF
  _G.part.CFrame = npcCF + Vector3.new(0, -10, 0)
  wait(2)
  game:GetService("ReplicatedStorage").Events.Quest.CompleteQuest:FireServer("MarshFiendPurge")
end

print("Pass")
