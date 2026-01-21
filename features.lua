-- features.lua (Discord + Teleport Player + WalkSpeed)

return function(Fluent, Tabs, Players, LocalPlayer, RunService)
    -- ========== DISCORD TAB ==========
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
    
    -- ========== TELEPORT PLAYER ==========
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
                        LocalPlayer.Character.HumanoidRootPart.CFrame = 
                            target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                    end
                end
            end)
        end
    })
    
    -- ========== WALK SPEED ==========
    local speedMultiplier = 1
    local speedEnabled = false
    local speedConnection = nil
    local speedCharConnection = nil
    
    local function iniciarSpeedBoost()
        if speedConnection then 
            speedConnection:Disconnect() 
            speedConnection = nil 
        end
        
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
            if speedConnection then 
                speedConnection:Disconnect() 
                speedConnection = nil 
            end
            if speedCharConnection then 
                speedCharConnection:Disconnect() 
                speedCharConnection = nil 
            end
            
            if state then
                iniciarSpeedBoost()
                speedCharConnection = LocalPlayer.CharacterAdded:Connect(function()
                    task.wait(1)
                    if speedEnabled then 
                        iniciarSpeedBoost() 
                    end
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
