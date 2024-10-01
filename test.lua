local success, errorMessage = pcall(function()
  local LocalPlayer = game.Players.LocalPlayer
  local camera = workspace.CurrentCamera
  local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
  local Combat = game:GetService("ReplicatedStorage").Events.Combat

  if not _G.part then
    _G.part = Instance.new("Part")
  end
  _G.part.Size = Vector3.new(50, 1, 50)
  _G.part.Anchored = true
  _G.part.Transparency = 0
  _G.part.Parent = game.Workspace

  local list = {
    [15] = "FeralFiendSoldier",
    [10] = "FeralFiendGeneral"
  }

  _G.AutoFarm = true
  while (_G.AutoFarm) do
    wait()
    for num, mobPath in pairs(list) do
      if not _G.AutoFarm then break end
      wait()
      count = 0
      
      wait(1)
      game:GetService("ReplicatedStorage").Events.Quest.GrantQuest:FireServer("MarshFiendPurge")
      for _,mob in pairs(game:GetService("Workspace").Game.Regions.Dion.Areas.AncientRuins.MobsSpots[mobPath]:GetChildren()) do
        if not _G.AutoFarm then break end
        task.wait()
        local HP = mob.UndeadBear.Head.HealthAndMana.PlayerBars.Bars.HPFrame.CanvasGroup.TextFrame.AmountText
        local BodyHitbox = mob.UndeadBear.BodyHitbox
        local MobPart = mob.UndeadBear.HumanoidRootPart
        
        local cframe = CFrame.new(MobPart.Position)
        _G.part.CFrame = cframe + Vector3.new(0, -27, 0)
        HumanoidRootPart.CFrame = cframe + Vector3.new(0, -25, 0)
        
        BodyHitbox.Size = Vector3.new(20, 20, 20)
        if (LocalPlayer.Character.RightHand:FindFirstChild("RightGrip")) then
          LocalPlayer.Character.RightHand.RightGrip.Part1 = nil
        else if (LocalPlayer.Character.Weapon.Handle:FindFirstChild("Handle")) then
          LocalPlayer.Character.Weapon.Handle.Handle.Part1 = nil
        end
        wait()
        LocalPlayer.Character.Weapon.Handle.Anchored = true
        LocalPlayer.Character.Weapon.Handle.FirePoint.Position = Vector3.new(0,0,0)

        if _G.AutoFarm then
          if (tonumber(HP.Text) > 0) then
            count = count + 1
          end
          while tonumber(HP.Text) > 0 and _G.AutoFarm do
            task.wait()
            HumanoidRootPart.CFrame = cframe + Vector3.new(0, -25, 0)
            LocalPlayer.Character.Weapon.Handle.Position = BodyHitbox.Position

            local cameraPosition = camera.CFrame.Position
            camera.CFrame = CFrame.new(cameraPosition, BodyHitbox.Position)

            _G.Click()
            -- BodyHitbox.CFrame = HumanoidRootPart.CFrame
          end
        end
        if (count >= num) then
          break
        end
      end
    end
  end
end)

if not success then
  local errorString = tostring(errorMessage)
  print(errorString)
else 
  print("Pass")
end
