--[[

nxzUI v2 by naz.

nxzUI is a user interface lua for aimware.net intended for use with legit and rage cheating.
I update this lua whenever I can be bothered to work on it, so don't expect super frequent updates over a long period of time.
aimware still hasn't updated the docs which makes it kinda hard to make new features/ideas.

https://raw.githubusercontent.com/n4zzu/nxzUI/main/nxzUI.lua

]]--


--[[UPDATER START]]--
local SCRIPT_FILE_NAME = GetScriptName()
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/n4zzu/nxzUI/main/nxzUI.lua"
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/n4zzu/nxzUI/main/version.txt"
local VERSION_NUMBER = "2.3"
local version_check_done = false
local update_downloaded = false
local update_available = false
local up_to_date = false
local updaterfont1 = draw.CreateFont("Bahnschrift", 18)
local updaterfont2 = draw.CreateFont("Bahnschrift", 14)
local updateframes = 0
local fadeout = 0
local spacing = 0
local fadein = 0

callbacks.Register( "Draw", "handleUpdates", function()
    if updateframes < 5.5 then
        if up_to_date or updateframes < 0.25 then
            updateframes = updateframes + globals.AbsoluteFrameTime()
            if updateframes > 5 then
                fadeout = ((updateframes - 5) * 510)
            end
            if updateframes > 0.1 and updateframes < 0.25 then
                fadein = (updateframes - 0.1) * 4500
            end
            if fadein < 0 then fadein = 0 end
            if fadein > 650 then fadein = 650 end
            if fadeout < 0 then fadeout = 0 end
            if fadeout > 255 then fadeout = 255 end
        end
        if updateframes >= 0.25 then fadein = 650 end
        for i = 0, 600 do
            local alpha = 200-i/3 - fadeout
            if alpha < 0 then alpha = 0 end
            draw.Color(15,15,15,alpha)
            draw.FilledRect(i - 650 + fadein, 0, i+1 - 650 + fadein, 30)
            draw.Color(239, 150, 255,alpha)
            draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31)
        end
        draw.SetFont(updaterfont1)
        draw.Color(239, 150, 255,255 - fadeout)
        draw.Text(7 - 650 + fadein, 7, "nxz")
        draw.Color(225,225,225,255 - fadeout)
        draw.Text(7 + draw.GetTextSize("nxz") - 650 + fadein, 7, "UI BETA ")
        draw.Color(239, 150, 255,255 - fadeout)
        draw.Text(7 + draw.GetTextSize("nxzUI BETA  ") - 650 + fadein, 7, "\\\\")
        spacing = draw.GetTextSize("nxzUI BETA \\    ")
        draw.SetFont(updaterfont2)
        draw.Color(225,225,225,255 - fadeout)
    end

    if (update_available and not update_downloaded) then
        draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest version.")
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false
        update_downloaded = true
    end
        
    if (update_downloaded) then
        draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.")
        return
    end
    
    if (not version_check_done) then
        version_check_done = true
        local version = http.Get(VERSION_FILE_ADDR)
        version = string.gsub(version, "\n", "")
        if (version ~= VERSION_NUMBER) then
            update_available = true
        else 
            up_to_date = true
        end
    end
        
    if up_to_date and updateframes < 5.5 then
        draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER)
    end
end)
--[[UPDATER END]]--

--[[SETUP START]]--
local font = draw.CreateFont('Verdana', 12)
local font2 = draw.CreateFont('Verdana', 16)
local settingsRef = gui.Reference("SETTINGS")
local infoTab = gui.Tab(settingsRef, "info.tab", "nxzUI v" .. VERSION_NUMBER)
local Window = gui.Window( "nxzUIWindow", "nxzUI v" .. VERSION_NUMBER, 150, 150, 328, 570)

local infoMainGroup = gui.Groupbox(infoTab, "Credits", 16,16,610,100)
local mainGroup = gui.Groupbox(Window, "Main Settings", 16,16,296,100)
local colorGroup = gui.Groupbox(Window, "Colours", 16,410,296,100)

local watermark = gui.Checkbox(mainGroup, "watermark", "Watermark", false)
local keybindlist = gui.Checkbox(mainGroup, "keybindlist", "Show Keybinds", false)
local infolist = gui.Checkbox(mainGroup, "infolist", "pLocal Info", false)
local leftHandKnife = gui.Checkbox(mainGroup, "lefthandknife", "Left Hand Knife", false)
local customNameCheckBox = gui.Checkbox(mainGroup, "cNCheckBox", "Custom Watermark Cheat Name", false)
local customNameCheckBox2 = gui.Checkbox(mainGroup, "cNCheckBox2", "Custom Watermark Username", false)
local editbox = gui.Editbox(mainGroup, "textBox", "Custom watermark cheat name")
local editbox2 = gui.Editbox(mainGroup, "textBox2", "Custom watermark username")

local colorPickerBar = gui.ColorPicker(colorGroup, "mainCol", "Main Colour", 239, 150, 255,255)
local colorPickerText = gui.ColorPicker(colorGroup, "textCol", "Text Colour", 255,255,255,255)
Window:SetOpenKey( 45 )

if gui.Reference("Menu"):IsActive() then
    Window:SetActive(true);
else
    Window:SetActive(false);
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

gui.Text(infoMainGroup, "nxzUI v2")
gui.Text(infoMainGroup, "-------------------------------------------------------------------------------------------------------------------")
gui.Text(infoMainGroup, "Made by naz#6660 (UID: 71838)")
gui.Text(infoMainGroup, "nxzUI is a user interface lua for aimware.net intended for use with legit and rage cheating.")
gui.Text(infoMainGroup, "I update this lua whenever I can be bothered to work on it, so don't expect super frequent updates over a long     period of time.")
gui.Text(infoMainGroup, "aimware still hasn't updated the docs which makes it kinda hard to make new features/ideas.")
gui.Text(infoMainGroup, "-------------------------------------------------------------------------------------------------------------------")
--[[SETUP END]]--

--[[WATERMARK START]]--
callbacks.Register("Draw", function()
    if (watermark:GetValue() ~= true) then
        return
    end
    local lp = entities.GetLocalPlayer();
    local playerResources = entities.GetPlayerResources();
 
    -- do not edit above

    -- Check if main GUI is open. This is to stop GUI lockups if you set this lua to auto run.
    if gui.Reference("Menu"):IsActive() then
        Window:SetActive(true);
    else
        Window:SetActive(false);
    end
 
    local divider = ' | ';
    local cheatName = 'nxzUI';

    --function customName()
    if customNameCheckBox:GetValue() == true then
        cheatName = gui.GetValue("nxzUIWindow.textBox")
    else
        cheatName = 'nxzUI';
    end

    local indexlp = client.GetLocalPlayerIndex()
    local userName = client.GetConVar( "name" )

    if customNameCheckBox2:GetValue() == true then
        userName = gui.GetValue("nxzUIWindow.textBox2")
    else
        userName = client.GetConVar( "name" )
    end

    
    
    -- Do not edit below
    local delay;
    local tick;
  
    if (lp ~= nil) then
        delay = 'delay: ' .. playerResources:GetPropInt("m_iPing", lp:GetIndex()) .. 'ms';
        tick = math.floor(lp:GetProp("localdata", "m_nTickBase") + 0x20 * 2) .. 'tick';
    end
    local watermarkText = cheatName .. divider .. userName .. divider;
    if (delay ~= nil) then
        watermarkText = watermarkText .. delay .. divider;
    end
    if (tick ~= nil) then
        watermarkText = watermarkText .. tick;
    end 
    draw.SetFont(font);
    local w, h = draw.GetTextSize(watermarkText);
    local weightPadding, heightPadding = 20, 15;
    local watermarkWidth = weightPadding + w;
    local start_x, start_y = draw.GetScreenSize();
    start_x, start_y = start_x - watermarkWidth - 20, start_y * 0.0125;
    draw.Color(0, 0, 0, 150);
    draw.FilledRect(start_x + 10, start_y, start_x + watermarkWidth , start_y -5 + h + heightPadding);
 
    draw.Color(0, 0, 0, 255)
    draw.Text(start_x + weightPadding / 2+5, start_y + heightPadding / 2 - 2, watermarkText );
 
    draw.Color(gui.GetValue("nxzUIWindow.textCol"));
    draw.Text(start_x + weightPadding / 2+6, start_y + heightPadding / 2 - 3, watermarkText );
 
 
    draw.Color(gui.GetValue("nxzUIWindow.mainCol"));
    draw.FilledRect(start_x+10, start_y, start_x + watermarkWidth , start_y +1);
    draw.Color(gui.GetValue("nxzUIWindow.mainCol"));
    draw.FilledRect(start_x+10, start_y, start_x + watermarkWidth , start_y +2);
end)
--[[WATERMARK END]]--

--[[KEYBINDS START]]--
local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 25, 660, 0, 0, 300, 60;
local mouseX2, mouseY2, x2, y2, dx2, dy2, w2, h2 = 0, 0, 25, 660, 0, 0, 300, 60;
local shouldDrag = false;
local shouldDrag2 = false;
local font = draw.CreateFont("Verdana", 12, 12);
local topbarSize = 20;
local svgData = http.Get( "http://eaassets-a.akamaihd.net/battlelog/prod/emblem/325/83/320/2955057809976353965.png" );
local imgRGBA, imgWidth, imgHeight = common.DecodePNG( svgData );
local texture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );
local render = {};
 
render.outline = function( x, y, w, h, col )
    draw.Color(gui.GetValue("nxzUIWindow.colorPicker"));
    draw.OutlinedRect( x, y, x + w, y + h );
end
render.rect = function( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    --draw.FilledRect( x, y, x + w, y + h );
end
render.rect2 = function( x, y, w, h )
    draw.FilledRect( x, y, x + w, y + h );
end
render.gradient = function( x, y, w, h, col1, col2, is_vertical )
    render.rect( x, y, w, h, col1 );
 
    local r, g, b = col2[1], col2[2], col2[3];
 
    if is_vertical then
        for i = 1, h do
            local a = i / h * 255;
            render.rect( x, y + i, w, 1, { r, g, b, a } );
        end
    else
        for i = 1, w do
            local a = i / w * 255;
            render.rect( x + i, y, 1, h, { r, g, b, a } );
        end
    end
end
 
local function getKeybinds()
    local Keybinds = {};
    local i = 1;
 
    hLocalPlayer = entities.GetLocalPlayer();
    wid = hLocalPlayer:GetWeaponID()
---------------------------
if gui.GetValue("lbot.master") and gui.GetValue("lbot.trg.key") ~= 0 and input.IsButtonDown(gui.GetValue("lbot.trg.key")) then
    Keybinds[i] = 'Triggerbot';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.antiaim.type") == '"Minimum"' then
    Keybinds[i] = 'Min Legit AA';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.antiaim.type") == '"Maximum"' then
    Keybinds[i] = 'Max Legit AA';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.extra.knifetrigger") then
    Keybinds[i] = 'Knifebot';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("misc.fakelag.enable") then
    Keybinds[i] = 'Fakelag';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.movement.quickstop") then
    Keybinds[i] = 'Quick Stop';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.posadj.backtrack") then
    Keybinds[i] = 'Backtrack';
        i = i + 1;
    end
    if gui.GetValue("lbot.master") and gui.GetValue("lbot.posadj.resolver") then
        Keybinds[i] = 'Resolver';
            i = i + 1;
    end
    if gui.GetValue("lbot.master") and gui.GetValue("lbot.semirage.silentaimbot") then
        Keybinds[i] = 'Silent Aim';
            i = i + 1;
    end
---------------------------
if gui.GetValue("rbot.master") and (wid == 1 or wid == 64) and gui.GetValue("rbot.accuracy.weapon.hpistol.doublefire") then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63) and gui.GetValue("rbot.accuracy.weapon.pistol.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60) and gui.GetValue("rbot.accuracy.weapon.rifle.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 11 or wid == 38) and gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34) and gui.GetValue("rbot.accuracy.weapon.smg.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 14 or wid == 28) and gui.GetValue("rbot.accuracy.weapon.lmg.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 25 or wid == 27 or wid == 29 or wid == 35) and gui.GetValue("rbot.accuracy.weapon.shotgun.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
    end
    if gui.GetValue("rbot.master") and gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) then
    Keybinds[i] = 'Slowwalk';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and (gui.GetValue("rbot.antiaim.base.rotation") < 0) then
    Keybinds[i] = 'Real Left ' .. gui.GetValue("rbot.antiaim.base.rotation") .. "°";
        i = i + 1;
    end
    if gui.GetValue("rbot.master") and (gui.GetValue("rbot.antiaim.base.rotation") > 0) then
        Keybinds[i] = 'Real Right ' .. gui.GetValue("rbot.antiaim.base.rotation") .. "°";
            i = i + 1;
        end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.extra.fakecrouchkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
    Keybinds[i] = 'Fake Duck';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.condition.shiftonshot") then
    Keybinds[i] = 'Hide Shots';
        i = i + 1;
    end
if gui.GetValue("esp.master") and gui.GetValue("esp.local.thirdperson") then
    Keybinds[i] = 'Thirdperson';
        i = i + 1;
    end
---------------------------
if gui.GetValue("misc.fakelatency.key") == 0 then
if gui.GetValue("misc.master") and gui.GetValue("misc.fakelatency.enable") then
    Keybinds[i] = 'Fakelatency';
        i = i + 1;
    end
elseif gui.GetValue("misc.fakelatency.key") ~= 0 then
if gui.GetValue("misc.master") and gui.GetValue("misc.fakelatency.enable") and input.IsButtonDown(gui.GetValue("misc.fakelatency.key")) then
    Keybinds[i] = 'Fakelatency';
        i = i + 1;
    end
end
 
    return Keybinds;
end

local function drawkeybinds(Keybinds)
    local temp = false;
    for index in pairs(Keybinds) do
        
        if (temp) then
            render.gradient( x+9, (y + topbarSize + 5) + (index * 15), 198, 1, { 13, 14, 15, 255 }, {40, 30, 30, 255 }, false );
        end
        temp=true;
        draw.SetFont(font);
        draw.Color(0, 0, 0, 200);
        draw.Text(x + 10, (y + topbarSize + 5) + (index * 15), Keybinds[index])
        draw.Text(x + 85, (y + topbarSize + 5) + (index * 15), "[active]")
 
        draw.SetFont(font);
        draw.Color(255, 255, 255, 255);
        draw.Text(x + 84, (y + topbarSize + 4) + (index * 15), "[active]")
        draw.Text(x + 9, (y + topbarSize + 4) + (index * 15), Keybinds[index])
    end
end

local function dragFeature()
    if input.IsButtonDown(1) then
        mouseX, mouseY = input.GetMousePos();
        if shouldDrag then
            x = mouseX - dx;
            y = mouseY - dy;
        end
        if mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + 40 then
            shouldDrag = true;
            dx = mouseX - x;
            dy = mouseY - y;
        end
    else
        shouldDrag = false;
    end
end

local function drawkeybinds(Keybinds)
    local temp = false;
    for index in pairs(Keybinds) do
        
        if (temp) then
            render.gradient( x+9, (y + topbarSize + 5) + (index * 15), 198, 1, { 13, 14, 15, 255 }, {40, 30, 30, 255 }, false );
        end
        temp=true;
        draw.SetFont(font);
        draw.Color(0, 0, 0, 200);
        draw.Text(x + 10, (y + topbarSize + 5) + (index * 15), Keybinds[index])
        draw.Text(x + 85, (y + topbarSize + 5) + (index * 15), "[active]")
 
        draw.SetFont(font);
        draw.Color(255, 255, 255, 255);
        draw.Text(x + 84, (y + topbarSize + 4) + (index * 15), "[active]")
        draw.Text(x + 9, (y + topbarSize + 4) + (index * 15), Keybinds[index])
    end
end

local function drawRectFill(r, g, b, a, x, y, w, h, texture)
    if (texture ~= nil) then
        draw.SetTexture(texture);
    else
        draw.SetTexture(texture);
    end
    draw.Color(r, g, b, a);
    draw.FilledRect(x, y, x + w, y + h);
end

local function drawRectFillCol(r, g, b, a, x, y, w, h, texture)
    if (texture ~= nil) then
        draw.SetTexture(texture);
    else
        draw.SetTexture(texture);
    end
    draw.Color(gui.GetValue("nxzUIWindow.mainCol"));
    draw.FilledRect(x, y, x + w, y + h);
end
 
 
local function dragFeature()
    if input.IsButtonDown(1) then
        mouseX, mouseY = input.GetMousePos();
        if shouldDrag then
            x = mouseX - dx;
            y = mouseY - dy;
        end
        if mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + 40 then
            shouldDrag = true;
            dx = mouseX - x;
            dy = mouseY - y;
        end
    else
        shouldDrag = false;
    end
end
 
local function dragFeature2()
    if input.IsButtonDown(1) then
        mouseX2, mouseY2 = input.GetMousePos();
        if shouldDrag2 then
            x2 = mouseX2 - dx2;
            y2 = mouseY2 - dy2;
        end
        if mouseX2 >= x2 and mouseX2 <= x2 + w2 and mouseY2 >= y and mouseY2 <= y2 + 40 then
            shouldDrag2 = true;
            dx2 = mouseX2 - x2;
            dy2 = mouseY2 - y2;
        end
    else
        shouldDrag2 = false;
    end
end

local function drawOutline(r, g, b, a, x, y, w, h, howMany)
    for i = 1, howMany do
        draw.Color(r, g, b, a);
        draw.OutlinedRect(x - i, y - i, x + w + i, y + h + i);
    end
end
 
local function drawWindow(Keybinds)
    local tW, _ = draw.GetTextSize(keytext);
    local h2 = 5 + (Keybinds * 15);
    local h = h + (Keybinds * 15);
    
    drawRectFillCol(28, 76, 192, 200, x + 7, y + 21, 121, 1);
    drawRectFillCol(78, 126, 242, 190, x + 7, y + 20, 121, 1);
    drawRectFill(0, 0, 0, 150, x + 7, y + 22, 121, 14);
 
    draw.Color(0,0,0,255);
    draw.SetFont(font);
    local keytext = 'Keybinds';
    
    draw.Text(x + ((85 - tW) / 2), y + 25, keytext)
 
    draw.Color(gui.GetValue("nxzUIWindow.textCol"));
    draw.SetFont(font);
    
    draw.Text(x + ((84 - tW) / 2), y + 24, keytext)
    
    draw.Color(255, 255, 255);
    draw.SetTexture( texture );
 
    
end

callbacks.Register("Draw", function()
    if keybindlist:GetValue() == false then return end
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end
 
    draw.SetTexture( texture );
    local Keybinds = getKeybinds();
    drawWindow(#Keybinds);
 
    drawkeybinds(Keybinds);
    dragFeature();

end)
--[[KEYBINDS END]]--

--[[pLOCAL INFO START]]--
callbacks.Register("Draw", function()
    local localName = entities.GetLocalPlayer():GetName()
    local health = entities.GetLocalPlayer():GetHealth()
    local maxHealth = entities.GetLocalPlayer():GetMaxHealth()
    local whatTeam = entities.GetLocalPlayer():GetTeamNumber()
    local weaponInacc = entities.GetLocalPlayer():GetWeaponInaccuracy()

draw.Color(gui.GetValue("nxzUIWindow.textCol"));
draw.SetFont(font2);

if whatTeam == 3 then
    pLocalTeam = "CT"
    elseif whatTeam == 2 then
    pLocalTeam = "T"
end

if infolist:GetValue() == true then

    local weaponInacc = entities.GetLocalPlayer():GetWeaponInaccuracy()
        inaccuracy = round(weaponInacc, 3) * 100;
        inaccuracy2 = 100 - inaccuracy;

        local LocalPlayer = entities.GetLocalPlayer()
        local WeaponID = LocalPlayer:GetWeaponID()
        local WeaponType = LocalPlayer:GetWeaponType()

            if inaccuracy <= 5 then
                inaccuracyText = "Accurate"
            elseif inaccuracy <= 15 then
                inaccuracyText = "Somewhat Accurate"
            elseif inaccuracy <= 30 then
                inaccuracyText = "Inaccurate"
            elseif inaccuracy >= 31 then
                inaccuracyText = "Very Inaccurate"
            end
draw.TextShadow(5, 600, "Name: " .. localName)
draw.TextShadow(5, 620, "Health: " .. health .. "/" .. maxHealth)
draw.TextShadow(5, 640, "Team: " .. pLocalTeam)
if WeaponType == 0 and WeaponID ~= 31 then return
else draw.TextShadow(5, 660, inaccuracyText .. " (" .. inaccuracy2 .. "% Accurate)")
end
elseif infolist:GetValue() == false then return end
end)
--[[pLOCAL INFO END]]--

--[[LEFT HAND KNIFE START]]--
callbacks.Register('Draw', function()
    
    if not leftHandKnife:GetValue() then
        client.Command('cl_righthand 1', true)
		return
	end

	local LocalPlayer = entities.GetLocalPlayer()

	local WeaponID = LocalPlayer:GetWeaponID()
	local WeaponType = LocalPlayer:GetWeaponType()

	if WeaponType == 0 and WeaponID ~= 31 then
		client.Command('cl_righthand 0', true)
	else
		client.Command('cl_righthand 1', true)
	end
end)
--[[LEFT HAND KNIFE END]]--

--[[MENU RESIZE START]]--
local menu = gui.Reference("MENU");
local opt_pos = false;
local bounds = false;
local show_bounds = gui.Button( gui.Reference( "Settings", "Advanced", "Manage Advanced Settings" ), "Show Boundaries", function()
    bounds = true
end )

local hide_bounds = gui.Button( gui.Reference( "Settings", "Advanced", "Manage Advanced Settings" ), "Hide Boundaries", function()
    bounds = false
end )

local function handle_dpi(dpi)
    local value = dpi
    if value == 1 then
        return 1
    elseif value == 0 then
        return 0.75
    elseif value == 2 then
        return 1.25
    elseif value == 3 then
        return 1.5
    elseif value == 4 then
        return 1.75
    elseif value == 5 then
        return 2
    elseif value == 6 then
        return 2.25
    elseif value == 7 then
        return 2.5
    elseif value == 8 then
        return 2.75 
    elseif value == 9 then
        return 3
    end
end

local function gay()
    if menu:IsActive() then
        local x, y = menu:GetValue()
        local mx, my = input.GetMousePos()
        local x2 = x + 800 * handle_dpi(gui.GetValue("adv.dpi"))
        local y2 = y + 600 * handle_dpi(gui.GetValue("adv.dpi"))
        local a = (bounds == true) and 255 or 0
        draw.Color(25, 255, 255, a)
        draw.OutlinedRect(x, y, x2, y2)
        draw.OutlinedRect(x2 + 5, y2 + 5, x2 - 20, y2 - 20)
        if input.IsButtonDown("Mouse1") then    
            if mx > x2-20 and mx < x2+5 and my > y2-20 and my < y2+5 then
                opt_pos = true;
            end
            if opt_pos == true then 
                local ops = (gui.GetValue("adv.dpi") == 0) and 0 or 1
                draw.Line( x + 800 * handle_dpi(gui.GetValue("adv.dpi") - ops), y + 600 * handle_dpi(gui.GetValue("adv.dpi") - ops), x + 800 * handle_dpi(gui.GetValue("adv.dpi") + 1), y + 600 * handle_dpi(gui.GetValue("adv.dpi") + 1) )
                if mx > x + 800 * handle_dpi(gui.GetValue("adv.dpi") + 1) and my > y + 600 * handle_dpi(gui.GetValue("adv.dpi") + 1) then
                    gui.SetValue("adv.dpi", gui.GetValue("adv.dpi") + 1)
                end
                if mx < x + 800 * handle_dpi(gui.GetValue("adv.dpi") - ops) and my < y + 600 * handle_dpi(gui.GetValue("adv.dpi") - ops) and gui.GetValue("adv.dpi") ~= 0 then
                    gui.SetValue("adv.dpi", gui.GetValue("adv.dpi") - 1)
                end
            end 
        else
            opt_pos = false;
        end
    end
end

callbacks.Register("Draw", gay)
--[[MENU RESIZE END]]--