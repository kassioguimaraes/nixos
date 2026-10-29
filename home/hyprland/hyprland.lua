-- dwm-style Hyprland config (Hyprland >= 0.55, Lua).
-- Monitors and per-host bits live in the host's home-*.nix.

local hs = require("hyprsplit")

local mod = "SUPER"
local alt = "ALT"
local terminal = "kitty"
local noctalia = "noctalia msg "

-- Focus an existing app window (even if it is on another workspace), or start
-- the app when it is not running.  This uses Hyprland's Lua API directly so
-- the lookup happens when the key is pressed, rather than through a shell.
local function focus_or_spawn(class, command)
    return function()
        for _, window in ipairs(hl.get_windows()) do
            if string.lower(window.class) == class then
                hl.dispatch(hl.dsp.focus({ window = "address:" .. window.address }))
                return
            end
        end
        hl.dispatch(hl.dsp.exec_cmd(command))
    end
end

--------------------
---- AUTOSTART -----
--------------------

hl.on("hyprland.start", function()
    -- Apply the laptop's Xft.dpi resource before X11 applications start.
    hl.exec_cmd("xrdb -merge ~/.Xresources")
end)

hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "24")
-- XWayland apps (Discord) use the xcursor version of the same theme
hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_PATH", os.getenv("HOME") .. "/.icons:/etc/profiles/per-user/" .. os.getenv("USER")
    .. "/share/icons:/run/current-system/sw/share/icons")

----------------------
---- LOOK & FEEL -----
----------------------

hl.config({
    general = {
        layout = "master",
        gaps_in = 3,
        gaps_out = 6,
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    master = { mfact = 0.6 },

    xwayland = { force_zero_scaling = true },
    binds = { movefocus_cycles_fullscreen = true },

    input = {
        kb_layout = "br",
        kb_options = "caps:escape",
        touchpad = { natural_scroll = true },
    },
})

--------------------
---- WORKSPACES ----
--------------------

-- Independent workspaces per monitor: SUPER+N acts on the focused monitor
local num_workspaces = 5
hs.config({ num_workspaces = num_workspaces })

for i = 1, num_workspaces do
    hl.bind(mod .. " + " .. i, hs.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hs.dsp.window.move({ workspace = i, follow = false }))
end

-- hyprsplit gives each monitor a block of IDs (1-5, 6-10, ...); name them
-- 1-5 so the bar, which shows names, numbers every monitor from 1
for id = 1, num_workspaces * 4 do
    hl.workspace_rule({ workspace = tostring(id), default_name = tostring((id - 1) % num_workspaces + 1) })
end

hl.bind(mod .. " + G", hs.dsp.grab_rogue_windows())

-- dwm-style layout symbol in the noctalia bar ([]= tiled, [n] monocle).
-- noctalia merges every *.toml in its config dir, so write the symbol to its
-- own file and reload noctalia whenever it changes.
local layout_file = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config"))
    .. "/noctalia/layout-symbol.toml"
local last_symbol = nil

local function layout_symbol(ws)
    if ws.tiled_layout == "monocle" then
        return "[" .. ws.windows .. "]"
    end
    return "[]="
end

local function update_layout_symbol()
    local ws = hl.get_active_workspace()
    if ws == nil then
        return
    end
    local symbol = layout_symbol(ws)
    if symbol == last_symbol then
        return
    end
    last_symbol = symbol
    local f = io.open(layout_file, "w")
    if f == nil then
        return
    end
    f:write(string.format("[widget.layout]\ntext = %q\n", symbol))
    f:close()
    hl.exec_cmd("noctalia msg config-reload")
end

-- Window counts and layouts settle after the event fires, so check shortly after
local function schedule_layout_symbol()
    hl.timer(update_layout_symbol, { timeout = 50, type = "oneshot" })
end

for _, event in ipairs({
    "workspace.active",
    "monitor.focused",
    "window.open",
    "window.destroy",
    "window.move_to_workspace",
}) do
    hl.on(event, schedule_layout_symbol)
end
hl.on("hyprland.start", schedule_layout_symbol)

-- Toggle the current workspace between master/stack and monocle ("tabbed")
local function toggle_monocle()
    local ws = hl.get_active_workspace()
    if ws == nil then
        return
    end
    local layout = ws.tiled_layout == "monocle" and "master" or "monocle"
    hl.workspace_rule({ workspace = tostring(ws.id), layout = layout })
    schedule_layout_symbol()
end

------------------
---- KEYBINDS ----
------------------

-- noctalia
hl.bind(mod .. " + escape", hl.dsp.exec_cmd(noctalia .. "panel-toggle control-center"))
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd(noctalia .. "session lock"))
hl.bind(mod .. " + CTRL + L", hl.dsp.exec_cmd(noctalia .. "session lock-and-suspend"))
hl.bind(mod .. " + SHIFT + P", hl.dsp.exec_cmd(noctalia .. "panel-toggle session"))
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd(noctalia .. "panel-toggle control-center network"))
hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd(noctalia .. "panel-toggle control-center bluetooth"))
hl.bind(alt .. " + Q", hl.dsp.exec_cmd(noctalia .. "panel-toggle launcher"))
hl.bind(alt .. " + V", hl.dsp.exec_cmd(noctalia .. "panel-toggle clipboard"))
hl.bind(alt .. " + TAB", hl.dsp.exec_cmd(noctalia .. "window-switcher hold"))

-- wm
hl.bind(mod .. " + RETURN", focus_or_spawn("kitty", terminal))
hl.bind(mod .. " + BackSpace", focus_or_spawn("firefox", "firefox"))
hl.bind(mod .. " + equal", focus_or_spawn("discord", "discord"))
hl.bind(mod .. " + minus", focus_or_spawn("emacs", "emacs"))
hl.bind(mod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + M", toggle_monocle)

hl.bind(mod .. " + A", hl.dsp.focus({ monitor = "-1" }))
hl.bind(mod .. " + S", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mod .. " + SHIFT + A", hl.dsp.window.move({ monitor = "-1" }))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ monitor = "+1" }))

-- master/stack
hl.bind(mod .. " + I", hl.dsp.layout("swapwithmaster ignoremaster"))
hl.bind(mod .. " + J", hl.dsp.layout("cyclenext"))
hl.bind(mod .. " + K", hl.dsp.layout("cycleprev"))
hl.bind(mod .. " + SHIFT + J", hl.dsp.layout("swapnext"))
hl.bind(mod .. " + SHIFT + K", hl.dsp.layout("swapprev"))
hl.bind(mod .. " + O", hl.dsp.layout("addmaster"))
hl.bind(mod .. " + SHIFT + O", hl.dsp.layout("removemaster"))

-- resize submap
hl.bind(mod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
    hl.bind(mod .. " + R", hl.dsp.submap("reset"))
end)

-- mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output --raw | swappy -f -"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m window --raw | swappy -f -"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region --raw | swappy -f -"))

-- discord push-to-talk on Shift_R
hl.bind("Shift_R", hl.dsp.pass({ window = "class:^(discord|vesktop)$" }))

-- media
local media = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), media)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), media)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), media)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), media)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), media)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), media)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

----------------------
---- WINDOW RULES ----
----------------------

-- Apps (kitty, at least) ask to open maximized, which covers the other tiles
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })

local floating = {
    floatingmodal = { modal = true },
    dialogsandmore = { title = ".*(Dialog|dialog|About|Error|Warning).*" },
    savefile = { title = ".*(Save|Open|Select|Choose).*" },
    prefs = { title = ".*(Preferences|Settings|Options).*" },
    ["thunar file"] = { title = ".*File Operation Progress" },
}

for name, match in pairs(floating) do
    hl.window_rule({ name = name, match = match, float = true, center = true })
end

hl.window_rule({
    name = "firefox pip",
    match = { title = ".*Picture-in-Picture" },
    float = true,
    pin = true,
    move = "100%-w-10 40",
    size = "25% 15%",
    content = "video",
})
