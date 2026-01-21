-- Sui Hub - Versão Minimalista (Madeira + TP + Speed + Discord)
-- Por MG - 2026

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Sui Hub - Minimal",
    SubTitle = "Madeira + Extras",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 340),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Abas
local Tabs = {
    Main    = Window:AddTab({ Title = "Main", Icon = "axe" }),
    Player  = Window:AddTab({ Title = "Player", Icon = "user" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "locate" }),
    Discord = Window:AddTab({ Title = "Discord", Icon = "message-circle" })
}

-- Serviços
local Players        = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService     = game:GetService("RunService")
local LocalPlayer    = Players.LocalPlayer

-- =============================================
--              MADEIRA (apenas isso)
-- =============================================

local pontosMadeira = {
    Vector3.new(-106.11, 45.72, -525.81),
    Vector3.new(-91.83, 45.72, -526.34),
    Vector3.new(-91.75, 45.72, -535.48),
    Vector3.new(-106.22, 45.72, -534.57)
}

local rotacaoMadeira = CFrame.Angles(0, 0, 0)

local farmAtivo = false
local farmThread = nil
local equipThread = nil
local lockConn = nil
local currentPoint = nil

local function pegarQuestMadeira()
    pcall(function()
        ReplicatedStorage:WaitForChild("MainRemote"):FireServer("pcgamer", {
            Extra = "CutWoods",
            Type = "questpls",
            NpcName = "Father Orfi"
        })
    end)
end

local function removerQuest()
    pcall(function()
        ReplicatedStorage:WaitForChild("MainRemote"):FireServer("unquest")
    end)
end

local function equiparMachado()
    if equipThread then task.cancel(equipThread) end
    equipThread = task.spawn(function()
        while farmAtivo do
            local char = LocalPlayer.Character
            local bp = LocalPlayer.Backpack
            if char and bp then
                if not char:FindFirstChild("MAxe") then
                    local tool = bp:FindFirstChild("MAxe")
                    if tool then char.Humanoid:EquipTool(tool) end
                end
            end
            task.wait(0.12)
        end
    end)
end

local function teleportar(pos)
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    hrp.CFrame = CFrame.new(pos) * rotacaoMadeira
    currentPoint = pos
    hrp.Velocity = Vector3.zero
    hrp.AssemblyLinearVelocity = Vector3.zero
    return true
end

local function ativarMachado()
    local char = LocalPlayer.Character
    if char then
        local tool = char:FindFirstChild("MAxe")
        if tool then tool:Activate() end
    end
end

local function travar(state)
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end
    
    if state then
        hum.AutoRotate = false
        if lockConn then lockConn:Disconnect() end
        lockConn = RunService.Heartbeat:Connect(function()
            if not farmAtivo or not currentPoint then return end
            hrp.CFrame = CFrame.new(currentPoint) * rotacaoMadeira
            hrp.Velocity = Vector3.zero
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end)
    else
        hum.AutoRotate = true
        if lockConn then lockConn:Disconnect() lockConn = nil end
        currentPoint = nil
    end
end

local function pararFarm()
    farmAtivo = false
    if farmThread then task.cancel(farmThread) farmThread = nil end
    if equipThread then task.cancel(equipThread) equipThread = nil end
    travar(false)
    removerQuest()
end

local function iniciarFarmMadeira()
    pararFarm()
    farmAtivo = true
    
    farmThread = task.spawn(function()
        local contador = 0
        
        while farmAtivo do
            if contador == 0 then
                pegarQuestMadeira()
                task.wait(0.5)
                equiparMachado()
                task.wait(0.8)
                travar(true)
                task.wait(0.2)
            end
            
            for _, pos in ipairs(pontosMadeira) do
                if not farmAtivo then break end
                
                if teleportar(pos) then
                    task.wait(0.35)
                    ativarMachado()
                    task.wait(0.9)
                    
                    contador += 1
                    
                    if contador >= 5 then
                        pegarQuestMadeira()
                        task.wait(0.4)
                        equiparMachado()
                        contador = 0
                    end
                end
            end
            
            task.wait(0.25)
        end
    end)
end

-- Respawn
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1.5)
    if farmAtivo then
        travar(true)
        equiparMachado()
    end
end)

Tabs.Main:AddToggle("FarmMadeira", {
    Title = "Farm Madeira (CutWoods)",
    Default = false,
    Callback = function(v)
        if v then
            iniciarFarmMadeira()
        else
            pararFarm()
        end
    end
})

-- =============================================
--              WALK SPEED
-- =============================================

local speedEnabled = false
local speedMult = 1
local speedConn = nil

local function updateSpeed()
    if speedConn then speedConn:Disconnect() end
    if not speedEnabled then return end
    
    speedConn = RunService.RenderStepped:Connect(function()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChild("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if hum and root then
                local dir = hum.MoveDirection
                if dir.Magnitude > 0 then
                    root.CFrame += dir * (speedMult * 0.16)
                end
            end
        end)
    end)
end

Tabs.Player:AddToggle("SpeedToggle", {
    Title = "Ativar WalkSpeed",
    Default = false,
    Callback = function(v)
        speedEnabled = v
        updateSpeed()
    end
})

Tabs.Player:AddSlider("SpeedSlider", {
    Title = "Multiplicador de Velocidade",
    Min = 1,
    Max = 16,
    Default = 1,
    Rounding = 1,
    Callback = function(v)
        speedMult = v
        if speedEnabled then updateSpeed() end
    end
})

-- =============================================
--              TELEPORTE PARA PLAYERS
-- =============================================

local selectedPlr = nil

local dropdown = Tabs.Teleport:AddDropdown("TpPlayer", {
    Title = "Selecione Jogador",
    Values = {},
    Multi = false,
    Default = ""
})

local function atualizarListaPlayers()
    local lista = {}
    for _, p in Players:GetPlayers() do
        if p ~= LocalPlayer and p.Name then
            table.insert(lista, p.Name)
        end
    end
    dropdown:SetValues(lista)
end

atualizarListaPlayers()
Players.PlayerAdded:Connect(atualizarListaPlayers)
Players.PlayerRemoving:Connect(atualizarListaPlayers)

dropdown:OnChanged(function(v)
    selectedPlr = v
end)

Tabs.Teleport:AddButton({
    Title = "Teleportar para o Jogador",
    Callback = function()
        if not selectedPlr then return end
        local alvo = Players:FindFirstChild(selectedPlr)
        if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
            local meuChar = LocalPlayer.Character
            if meuChar and meuChar:FindFirstChild("HumanoidRootPart") then
                meuChar.HumanoidRootPart.CFrame = alvo.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
            end
        end
    end
})

-- =============================================
--              DISCORD
-- =============================================

Tabs.Discord:AddParagraph({
    Title = "Sui Hub Discord",
    Content = "Entre na comunidade para updates, suporte e scripts!"
})

Tabs.Discord:AddButton({
    Title = "Copiar Link do Discord",
    Callback = function()
        setclipboard("https://discord.gg/MG7EPpfWwu")
        Fluent:Notify({
            Title = "Link Copiado!",
            Content = "Link do Discord foi copiado para a área de transferência.",
            Duration = 4
        })
    end
})

Window:SelectTab(1)
