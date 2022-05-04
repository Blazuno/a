



--Anything below here dont touch shit
local inputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local Username = Players.LocalPlayer.Name


local positions = {CFrame.new(-2502, 608, -319),
    CFrame.new(-2654, 608, 98),
    CFrame.new(-2666, 607, 97),
    CFrame.new(-2672, 607, 112),
    CFrame.new(-2653, 608, 120),
    CFrame.new(-2690, 608, 106),
    CFrame.new(-2672, 607, 112),
    CFrame.new(-2666, 607, 97),
    CFrame.new(-2654, 608, 98),
    CFrame.new(-2502, 608, -319)
}

getgenv().isAutoPickup = true
function detectTrinkets(trinket)
    local part
    local returned
    if trinket.Name == "Part" and trinket:FindFirstChild("ID") then
        returned = true
    else
        returned = false
    end
    return returned, trinket
end

function autoPickup(connectTrinket)
    spawn(function()
        local player = game.Players.LocalPlayer
        while isAutoPickup do
            for i,v in pairs(game.Workspace:GetChildren()) do
                local _, trinket = detectTrinkets(v)
                if _ then
                    if v.Size == Vector3.new(0.208974, 0.554892, 0.457498) and pickupScrolls or v.Size ~= Vector3.new(0.208974, 0.554892, 0.457498)  then
                            local part = trinket:WaitForChild("Part")
                            local clickdetector = part:WaitForChild("ClickDetector")
                            local maxDistance = clickdetector.MaxActivationDistance - 0.1
                            while not player.Character:FindFirstChild("Head") do 
                                wait(0.1)
                            end
                            if player:DistanceFromCharacter(part.Position) < maxDistance and player.Character.Head then
                                fireclickdetector(clickdetector)
                            end
                            if connectTrinket then
                                local part = connectTrinket:FindFirstChild("Part")
                                local clickdetector2 = part:FindFirstChild("ClickDetector")
                                if player:DistanceFromCharacter(part.Position) < maxDistance and player.Character.Head then
                                    fireclickdetector(clickdetector2)
                                end
                            end
                            
                    end
                end
            end
            wait()
        end
    end)
end

function ServerHop(msg)
    local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/4556484/servers/Public?sortOrder=Asc&limit=100"))
    game.Players.LocalPlayer:Kick(msg)
    for i,v in pairs(Servers.data) do
        if v.playing ~= v.maxPlayers then
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
        end
        wait()
    end
end

function detectIllu()
    local players = game.Players:GetChildren()
    for i,v in pairs(players) do
        local backpack = v:FindFirstChild("Backpack")
        for i2, v2 in pairs(backpack) do
            if v.Name == "Observe" then 
                ServerHop("Illu detected")
            end
        end
        wait()
    end
end

function detectMod()
    local players = game.Players:GetChildren()
    for i,v in pairs(players) do
        if v:IsInGroup(4556484) then
            ServerHop("Stinky mod")
        end
        wait()
    end
end

function checkDeaths()
    spawn(function()
        local character = game.Players.LocalPlayer.Character
        while checkDeath do 
            if character.Humanoid.Health == 0 then
                autoSewers = false
                game.Players.LocalPlayer:Kick("you somehow died")
            end
            wait()
        end
    end)
end

function checkNearby()
    local localPlayer = game.Players.LocalPlayer
    local players = game.Players:GetChildren()
    for i,v in pairs(players) do
        if v:DistanceFromCharacter(localPlayer.Character.HumanoidRootPart.Position) < tonumber(playerLogDistance) then
            ServerHop("plr nearby")
        end
        wait()
    end
end

function sewersBot(...)
    while autoSewers do
        repeat
            wait()
        until game.Players.LocalPlayer.PlayerGUI.StartMenu
        detectMod()
        detectIllu()
        checkDeaths()
        autoPickup()
        
        local artiList = {
            "Night Stone",
            "Lannis's Amulet",
            "Amulet of the White King",
            "Rift Gem",
            "Mysterious Artifact",
            "Howler Friend",
            "Phoenix Down",
            "Ice Essence",
            "Scroll of Fimbulvetr",
            "Scroll of Manus Dei"
        }
        local attemptBreak
        local tempT = {}
        local positionTable = ...
        local chr = game.Players.LocalPlayer.Character
        local movement = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
        local slowMovement = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
        for i,v in pairs(positionTable) do
            tempT.CFrame = v
            local lootingTween = tweenService:Create(chr.HumanoidRootPart, slowMovement, tempT)
            local movementTween = tweenService:Create(chr.HumanoidRootPart, movement, tempT)
            if i >= 3 and i <= 9 then
                lootingTween:Play()
                wait(slowMovement.Time)
            else
                movementTween:Play()
                wait(movement.Time)
            end
        end
        local backpack = game.Players.LocalPlayer.Backpack:GetChildren()
        local q = 1 
        for i,v in pairs(backpack) do
            for i2, v2 in pairs(artiList) do 
                if v.Name == v2 then
                    autoSewers = false
                    attemptBreak = true
                    if webhookEnabled and string.sub(Webhook, 1, 4) == "http"  then 
                        local OSTime = os.time();
                        local Time = os.date('!*t', OSTime);
                        local Avatar = 'https://cdn.discordapp.com/embed/avatars/4.png';
                        local Content = '<@'..discordID..">";
                        local Embed = {
                            title = 'found an arti ez';
                            color = '99999';
                            footer = { text = game.JobId };
                            author = {
                                name = 'ROBLOX';
                                url = 'https://www.roblox.com/';
                            };
                            fields = {
                                {
                                    name = 'arti found:';
                                    value = v.Name;
                                }
                            };
                            timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
                        };
                        (syn and syn.request or http_request) {
                            Url = Webhook;
                            Method = 'POST';
                            Headers = {
                                ['Content-Type'] = 'application/json';
                            };
                            Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
                        };
                        game.Players.LocalPlayer:Kick("found an arti blaze bot winnin")
                    end
                end
            end
        end   
    end
    ServerHop("Serverhopping")
end

sewersBot(positions)

