-- botao.lua - Volta ao método antigo (procura por ScreenGui genérico), mas com espera curta e confiável

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Espera até encontrar o GUI do hub (usa o método antigo que funcionava pra você)
local HubGUI
repeat
    task.wait(0.2)
    for _, gui in pairs(CoreGui:GetChildren()) do
        if gui:IsA("ScreenGui") and (gui.Name == "ScreenGui" or gui.Name == "Fluent" or gui:FindFirstChild("Acrylic") or gui:FindFirstChild("Main")) then
            HubGUI = gui
            break
        end
    end
until HubGUI

if not HubGUI then
    return  -- se mesmo assim não encontrar, não cria o botão (evita erro)
end

-- Cria o botão externo
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "HubToggleButton"
ToggleGui.ResetOnSpawn = false
ToggleGui.Parent = CoreGui

local Button = Instance.new("ImageButton")
Button.Name = "ToggleButton"
Button.Size = UDim2.new(0, 60, 0, 60)
Button.Position = UDim2.new(0, 20, 0, 200)
Button.BackgroundTransparency = 1
Button.Image = "rbxassetid://12232793816"
Button.ScaleType = Enum.ScaleType.Fit
Button.BorderSizePixel = 0
Button.Parent = ToggleGui

-- Draggable (mesmo do antigo)
local dragging = false
local dragInput, dragStart, startPos

Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Button.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Minimizar / restaurar
local minimized = false
Button.MouseButton1Click:Connect(function()
    minimized = not minimized
    HubGUI.Enabled = not minimized
end)
