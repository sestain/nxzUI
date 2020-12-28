local font = draw.CreateFont('Verdana', 12);
 
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
    local cheatName = 'aimware';

    --function customName()
    --[[if customNameCheckBox:GetValue() == true then
        cheatName = gui.GetValue("mainWindow.textBox")
    else
        cheatName = 'aimware';
    end]]--

    local indexlp = client.GetLocalPlayerIndex()
    local userName = client.GetConVar( "name" )
    
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
 
    draw.Color(gui.GetValue("mainWindow.textCol"));
    draw.Text(start_x + weightPadding / 2+6, start_y + heightPadding / 2 - 3, watermarkText );
 
 
    draw.Color(gui.GetValue("mainWindow.mainCol"));
    draw.FilledRect(start_x+10, start_y, start_x + watermarkWidth , start_y +1);
    draw.Color(gui.GetValue("mainWindow.mainCol"));
    draw.FilledRect(start_x+10, start_y, start_x + watermarkWidth , start_y +2);
end)
 
------------------------------------------------------------
--DrawUI
------------------------------------------------------------



-- Keybind


local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 25, 660, 0, 0, 300, 60;
local shouldDrag = false;
local font = draw.CreateFont("Verdana", 12, 12);
local topbarSize = 20;
local svgData = http.Get( "http://eaassets-a.akamaihd.net/battlelog/prod/emblem/325/83/320/2955057809976353965.png" );
local imgRGBA, imgWidth, imgHeight = common.DecodePNG( svgData );
local texture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );
local render = {};
 
render.outline = function( x, y, w, h, col )
    draw.Color(gui.GetValue("mainWindow.colorPicker"));
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
if gui.GetValue("lbot.master") and input.IsButtonDown(gui.GetValue("lbot.trg.key")) then
    Keybinds[i] = 'Triggerbot';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.antiaim.type") ~= '"Off"' then
    Keybinds[i] = 'Legit AA';
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
    draw.Color(gui.GetValue("mainWindow.mainCol"));
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
 
    draw.Color(gui.GetValue("mainWindow.textCol"));
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
------------------------------------------------------------
--DrawUI
------------------------------------------------------------
 
function DrawUI()
    Window = gui.Window("mainWindow", "nxzUI", 150, 150, 328, 340)
    Window:SetOpenKey(45)

    mainGroup = gui.Groupbox(Window, "Main Settings", 16,16,296,100)
    colorGroup = gui.Groupbox(Window, "Colours", 16,185,296,100)

    keybindlist = gui.Checkbox(mainGroup,"keybindlist","Show Keybinds",0);
    keybindlist:SetDescription("Shows a list of active keybinds.");
    watermark = gui.Checkbox(mainGroup,"watermark","Show Watermark",0);
    watermark:SetDescription("Shows watermark.");
    colorPicker = gui.ColorPicker(colorGroup, "mainCol", "Main Colour", 239, 150, 255,255)
    colorPicker2 = gui.ColorPicker(colorGroup, "textCol", "Text Colour", 255,255,255,255)
    --customNameCheckBox = gui.Checkbox(mainGroup, "cNCheckBox", "Custom Watermark Name", 0)
    --editbox = gui.Editbox(mainGroup, "textBox", "Custom watermark name")

    local SCRIPT_FILE_NAME = GetScriptName()
    local SCRIPT_FILE_ADDR
    local VERSION_FILE_ADDR
    local VERSION_NUMBER = "1.0"
    local version_check_done = true
    local update_downloaded = true
    local update_available = false
    local up_to_date = true
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
            draw.Text(7 + draw.GetTextSize("nxz ") - 650 + fadein, 7, "UI")
            draw.Color(239, 150, 255,255 - fadeout)
            draw.Text(7 + draw.GetTextSize("nxzUI  ") - 650 + fadein, 7, "\\\\")
            spacing = draw.GetTextSize("nxzUI  \\  ")
            draw.SetFont(updaterfont2)
            draw.Color(225,225,225,255 - fadeout)
        end
        
        if up_to_date and updateframes < 5.5 then
            draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER)
        end
    end)

    end

--function customName()
    --if customNameCheckBox:GetValue() == true then
        --cheatName = gui.GetValue("mainWindow.textBox")
        --cheatName = "nxzUI";
    --else
        cheatName = 'aimware';
    --end
--end

DrawUI();