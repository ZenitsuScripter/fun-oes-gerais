-- geral.lua - Tudo em um único arquivo: pontos + features + farms + spin + anti afk + respawn + botão externo

local geral = {}

-- ========== PONTOS ==========
geral.pontosData = {
    rotacaoMadeira = CFrame.Angles(0, 0, 0),
    rotacaoBatatas = CFrame.Angles(0, math.rad(-90), 0),

    pontosMadeira = {
        Vector3.new(-106.11, 45.72, -525.81),
        Vector3.new(-91.83, 45.72, -526.34),
        Vector3.new(-91.75, 45.72, -535.48),
        Vector3.new(-106.22, 45.72, -534.57)
    },

    pontosBatatas = {
        Vector3.new(-229.38, 45.96, -323.15),
        Vector3.new(-218.70, 45.96, -323.23),
        Vector3.new(-208.59, 45.96, -323.68),
        Vector3.new(-198.06, 45.96, -323.61),
        Vector3.new(-187.51, 45.76, -322.96),
        Vector3.new(-177.34, 45.76, -322.99),
        Vector3.new(-167.40, 45.96, -323.48),
        Vector3.new(-158.11, 45.96, -323.46),
        Vector3.new(-147.73, 45.96, -323.77),
        Vector3.new(-139.03, 45.96, -323.18),
        Vector3.new(-128.56, 45.80, -323.07),
        Vector3.new(-117.30, 45.96, -323.17),
        Vector3.new(-107.91, 45.96, -323.10),
        Vector3.new(-98.35, 45.76, -322.73),
        Vector3.new(-88.25, 45.76, -322.65),
        Vector3.new(-76.85, 45.96, -323.18),
        Vector3.new(-68.08, 45.76, -323.04),
        Vector3.new(-58.79, 45.96, -323.46),
        Vector3.new(-48.73, 45.96, -323.22),
        Vector3.new(-39.20, 45.76, -322.92),
        Vector3.new(-228.89, 45.96, -333.25),
        Vector3.new(-218.86, 45.96, -333.16),
        Vector3.new(-209.12, 45.96, -333.59),
        Vector3.new(-198.36, 45.96, -333.13),
        Vector3.new(-188.77, 45.96, -333.23),
        Vector3.new(-178.48, 45.96, -333.20),
        Vector3.new(-168.32, 45.96, -332.91),
        Vector3.new(-158.52, 45.96, -333.04),
        Vector3.new(-148.39, 45.96, -333.30),
        Vector3.new(-137.81, 45.96, -333.07),
        Vector3.new(-128.78, 45.96, -332.82),
        Vector3.new(-118.77, 45.96, -333.09),
        Vector3.new(-108.59, 45.96, -333.29),
        Vector3.new(-97.96, 45.96, -333.17),
        Vector3.new(-88.99, 45.96, -333.10),
        Vector3.new(-78.18, 45.96, -333.23),
        Vector3.new(-68.81, 45.96, -333.17),
        Vector3.new(-58.65, 45.96, -333.52),
        Vector3.new(-48.67, 45.96, -333.55),
        Vector3.new(-38.30, 45.96, -333.22)
    },

    pontosDelivery = {
        Vector3.new(-23.28, 46.20, -203.02),
        Vector3.new(-7.11, 45.80, -202.10),
        Vector3.new(36.96, 45.80, -272.40),
        Vector3.new(87.13, 45.80, -273.33),
        Vector3.new(129.08, 46.30, -261.66),
        Vector3.new(152.81, 46.30, -268.79),
        Vector3.new(200.59, 45.80, -272.28),
        Vector3.new(247.52, 46.30, -266.15),
        Vector3.new(267.26, 45.90, -270.91),
        Vector3.new(278.85, 51.17, -268.52),
        Vector3.new(284.68, 46.30, -280.29),
        Vector3.new(288.87, 46.30, -294.78),
        Vector3.new(280.39, 45.80, -317.22),
        Vector3.new(282.45, 45.90, -362.67),
        Vector3.new(278.87, 45.80, -432.71),
        Vector3.new(283.78, 46.20, -474.51),
        Vector3.new(281.46, 45.80, -511.53),
        Vector3.new(280.33, 45.80, -536.47),
        Vector3.new(273.84, 45.80, -567.79),
        Vector3.new(257.48, 45.88, -568.66),
        Vector3.new(241.70, 45.80, -567.69),
        Vector3.new(240.84, 45.80, -548.84),
        Vector3.new(223.19, 45.80, -493.77),
        Vector3.new(165.05, 45.80, -495.07),
        Vector3.new(111.98, 45.80, -494.74),
        Vector3.new(79.10, 45.80, -495.55),
        Vector3.new(53.94, 45.80, -495.25),
        Vector3.new(24.02, 46.30, -498.18),
        Vector3.new(21.66, 45.80, -543.49),
        Vector3.new(20.29, 45.80, -570.60),
        Vector3.new(-20.74, 45.80, -636.81),
        Vector3.new(-19.99, 45.80, -612.97),
        Vector3.new(-31.32, 46.30, -584.47),
        Vector3.new(-23.73, 46.30, -559.85),
        Vector3.new(-23.23, 46.10, -531.05),
        Vector3.new(-31.38, 45.80, -494.51),
        Vector3.new(-213.67, 45.80, -273.74),
        Vector3.new(-242.58, 45.80, -272.71),
        Vector3.new(-281.25, 45.80, -272.97),
        Vector3.new(-281.45, 45.80, -297.21),
        Vector3.new(-280.07, 45.80, -326.63),
        Vector3.new(-280.67, 45.80, -346.04),
        Vector3.new(-281.92, 45.80, -383.86),
        Vector3.new(-279.71, 45.80, -409.69),
        Vector3.new(-283.40, 46.20, -434.05),
        Vector3.new(-280.44, 45.80, -455.08),
        Vector3.new(-288.35, 46.39, -466.67),
        Vector3.new(-281.70, 45.80, -478.54),
        Vector3.new(-282.19, 45.90, -518.32),
        Vector3.new(-284.49, 46.30, -536.44),
        Vector3.new(-269.25, 45.80, -545.39),
        Vector3.new(-245.65, 45.80, -544.43),
        Vector3.new(-241.79, 45.80, -511.14),
        Vector3.new(-192.54, 45.80, -495.72),
        Vector3.new(-153.21, 45.80, -546.58),
        Vector3.new(-155.47, 45.80, -578.71),
        Vector3.new(-151.10, 45.80, -595.24),
        Vector3.new(-135.74, 45.80, -595.27),
        Vector3.new(-114.30, 45.80, -580.33),
        Vector3.new(18.58, 45.80, -329.10),
        Vector3.new(69.43, 45.80, -312.84),
        Vector3.new(91.55, 45.80, -312.22),
        Vector3.new(126.92, 45.80, -314.25),
        Vector3.new(140.25, 46.30, -320.98),
        Vector3.new(169.22, 45.80, -312.34),
        Vector3.new(223.90, 45.80, -311.59),
        Vector3.new(228.61, 46.30, -389.11),
        Vector3.new(240.06, 45.80, -421.57),
        Vector3.new(203.91, 45.80, -455.06),
        Vector3.new(183.69, 45.80, -454.28),
        Vector3.new(143.15, 45.80, -452.17),
        Vector3.new(114.43, 45.80, -452.20),
        Vector3.new(85.94, 46.20, -450.54),
        Vector3.new(36.82, 45.80, -454.00)
    }
}

-- ========== FEATURES (Discord + Teleport Player + WalkSpeed) ==========
geral.loadFeatures = function(Fluent, Tabs, Players, LocalPlayer, RunService)
    -- Discord Tab
    Tabs.Discord:AddParagraph({
        Title = "Official Sui Hub Server",
        Content = "Join our community to receive updates and support!"
    })

    Tabs.Discord:AddButton({
        Title = "Copy Discord Link",
        Description = "Copy the invite link to the clipboard",
        Callback = function()
            setclipboard("https://discord.gg/MG7EPpfWwu")
            Fluent:Notify({
                Title = "Link Copied!",
                Content = "The Discord invite has been copied to the clipboard",
                Duration = 5
            })
        end
    })

    -- Teleport Player
    local selectedPlayer = nil

    local PlayersDropdown = Tabs.Teleport:AddDropdown("PlayersDropdown", {
        Title = "Teleport Player",
        Description = "Select a Player",
        Values = {},
        Multi = false,
        Default = "Select"
    })

    PlayersDropdown:OnChanged(function(v)
        selectedPlayer = v
    end)

    local function updatePlayerList()
        local names = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name ~= LocalPlayer.Name then
                table.insert(names, p.Name)
            end
        end
        PlayersDropdown:SetValues(names)
    end

    Players.PlayerAdded:Connect(updatePlayerList)
    Players.PlayerRemoving:Connect(updatePlayerList)
    updatePlayerList()

    Tabs.Teleport:AddButton({
        Title = "Teleporte to Player",
        Description = "Teleport to Selected Player",
        Callback = function()
            pcall(function()
                if not selectedPlayer then return end
                local target = Players:FindFirstChild(selectedPlayer)
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                    end
                end
            end)
        end
    })

    -- Walk Speed
    local speedMultiplier = 1
    local speedEnabled = false
    local speedConnection = nil
    local speedCharConnection = nil

    local function iniciarSpeedBoost()
        if speedConnection then speedConnection:Disconnect() speedConnection = nil end

        speedConnection = RunService.RenderStepped:Connect(function()
            if not speedEnabled then return end
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hum = char:FindFirstChild("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hum and hrp then
                    local dir = hum.MoveDirection
                    if dir.Magnitude > 0.1 then
                        local mult = math.max(speedMultiplier, 1)
                        hrp.CFrame = hrp.CFrame + (dir * (mult * 0.15))
                    end
                end
            end)
        end)
    end

    Tabs.Player:AddToggle("WalkSpeedToggle", {
        Title = "Enable Walk Speed",
        Description = "Enable/Disable Walk Speed",
        Default = false,
        Callback = function(state)
            speedEnabled = state
            if speedConnection then speedConnection:Disconnect() speedConnection = nil end
            if speedCharConnection then speedCharConnection:Disconnect() speedCharConnection = nil end

            if state then
                iniciarSpeedBoost()
                speedCharConnection = LocalPlayer.CharacterAdded:Connect(function()
                    task.wait(1)
                    if speedEnabled then iniciarSpeedBoost() end
                end)
            end
        end
    })

    Tabs.Player:AddSlider("WalkSpeedSlider", {
        Title = "Walk Speed",
        Description = "Multiply your movement speed",
        Default = 1,
        Min = 1,
        Max = 15,
        Rounding = 1,
        Callback = function(v)
            speedMultiplier = v
        end
    })
end

-- ========== ANTI AFK ==========
geral.setupAntiAFK = function(LocalPlayer)
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- ========== RESPAWN HANDLER ==========
geral.setupRespawnHandler = function(LocalPlayer, currentFarmType, rotacaoMadeira, rotacaoBatatas, equiparFerramenta, equiparTrain)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(2)

        if getgenv().AutoFarmInteligente and currentFarmType then
            if currentFarmType == "madeira" or currentFarmType == "batatas" then
                local rot = currentFarmType == "madeira" and rotacaoMadeira or rotacaoBatatas
                travarPosicao(true, rot)
                equiparFerramenta(currentFarmType)
            end
        end

        if getgenv().AutoTrainBody then
            task.wait(1)
            equiparTrain()
        end

        if getgenv().AutoFarmMoney then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                posicaoInicialMoney = hrp.Position
            end
        end
    end)
end

-- ========== SELECIONA ABA INICIAL ==========
geral.selectInitialTab = function(Window, initialTab)
    Window:SelectTab(initialTab)
end

-- ========== TODAS AS FARMS + AUTO SPIN + TRAIN BODY ==========
geral.setupFarms = function(Fluent, Tabs, LocalPlayer, ReplicatedStorage, RunService, pontosMadeira, pontosBatatas, pontosDelivery, rotacaoMadeira, rotacaoBatatas)
    -- Variáveis globais necessárias
    getgenv().AutoFarmInteligente = getgenv().AutoFarmInteligente or false
    getgenv().AutoFarmMoney = getgenv().AutoFarmMoney or false
    getgenv().AutoTrainBody = getgenv().AutoTrainBody or false
    getgenv().AutoSpinGrimoire = getgenv().AutoSpinGrimoire or false

    local NIVEL_MIN_MADEIRA = 1
    local NIVEL_MAX_MADEIRA = 20
    local NIVEL_MIN_BATATAS = 20
    local NIVEL_MAX_BATATAS = 60
    local NIVEL_MIN_DELIVERY = 60
    local NIVEL_MAX_DELIVERY = 125
    local NIVEL_MAX_FARM = 125
    local NIVEL_MAX_TOTAL = 10000

    local farmCoroutine = nil
    local equipCoroutine = nil
    local lockConnection = nil
    local currentPoint = nil
    local currentFarmType = nil

    local moneyCoroutines = {}
    local posicaoInicialMoney = nil
    local velocidadeFarmMoney = 0.15

    local trainCoroutine = nil
    local trainEquipCoroutine = nil
    local contadorTreinos = 0

    local grimoriosSelecionados = {}
    local folhasSelecionadas = {}
    local spinCoroutine = nil
    local tentativasSpin = 0

    -- Função getCurrentLevel
    local function getCurrentLevel()
        local success, level = pcall(function()
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 5)
            if not PlayerGui then return nil end
            local StartGui = PlayerGui:FindFirstChild("StartGui")
            if not StartGui then return nil end
            local Exp = StartGui:FindFirstChild("Exp")
            if not Exp then return nil end
            local LevelText = Exp:FindFirstChild("LevelText")
            if not LevelText or not LevelText:IsA("TextLabel") then return nil end
            local num = LevelText.Text:match("%d+")
            return num and tonumber(num) or nil
        end)
        return success and level or nil
    end

    -- Toggles finais
    local toggleAutoFarmInteligente = Tabs.AutoFarm:AddToggle("AutoFarmInteligenteToggle", { /* ... */ })
    local toggleAutoFarmMoney = Tabs.AutoFarm:AddToggle("AutoFarmMoneyToggle", { /* ... */ })
end

-- ========== BOTÃO EXTERNO ==========
geral.loadBotaoExterno = function()
    local CoreGui = game:GetService("CoreGui")
    local UserInputService = game:GetService("UserInputService")

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

    if not HubGUI then return end

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

    local minimized = false
    Button.MouseButton1Click:Connect(function()
        minimized = not minimized
        HubGUI.Enabled = not minimized
    end)
end

return geral
