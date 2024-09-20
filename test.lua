local Combat = game:GetService("ReplicatedStorage").Events.Combat
local LocalPlayer = game.Players.LocalPlayer
local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart


function getPlayerHp()
  for i,v in pairs(LocalPlayer.PlayerGui.Actions.PartyMemberUI.Frame:GetChildren()) then
    if v.ClassName == "Frame" then
      local target = v.Frame.PlayerStats.PlayerName.Text
      local healthText = v.Frame.PlayerStats.HPFrame.TextFrame.AmountText.Text
      local num1, num2 = healthText:match("(%d+)/(%d+)")
      num1, num2 = tonumber(num1), tonumber(num2)

      return {target , (num2/num1)*100}
    end
  end
end

function follow()
  local func = {}

  function func:createPath()
    if not _G.part then
      _G.part = Instance.new("Part")
    end
    _G.part.Size = Vector3.new(50, 1, 50)
    _G.part.Anchored = true
    _G.part.Transparency = 0
    _G.part.Parent = game.Workspace
  end

  function func:Tp()
    spawn(function()
      while _G.follow do
        task.wait()
        local target = game.Players[_G.target].Character.HumanoidRootPart
        _G.part.CFrame = target.CFrame + Vector3.new(0, -27, 0)
        HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, -25, 0)
      end
    end)
  end

  return func
end

local MainTarget = "Phruetsakol"
_G.follow = true
_G.AutoSkill = true
_G.target = MainTarget

local MyFollow = follow()
MyFollow:createPath()
MyFollow:Tp()

while _G.AutoSkill do
  task.wait()
  local target, hp = getPlayerHp()
  _G.target = target

  if (hp < 80) then
    local args = {
      [1] = "HealShot",
      [2] = HumanoidRootPart.CFrame,
      [3] = game.Players[target].Character.HumanoidRootPart.Position
    }
    wait(.5)
    Combat.ActivateSkill:FireServer(unpack(args))
  end

  if (hp < 80) then
    local args = {
      [1] = "GroupHeal",
      [2] = HumanoidRootPart.CFrame,
      [3] = game.Players[target].Character.HumanoidRootPart.Position
    }
    wait(.5)
    Combat.ActivateSkill:FireServer(unpack(args))
  end

  wait(3)
  _G.target = MainTarget
end
