if vim.g.neovide then
    -- Variables
    local defaultFontSize = 11
    local currentFontSize = defaultFontSize
    local fontSizeScaleFactor = 1
    local defaultFontName = "JetBrainsMono Nerd Font"
    local default_scale_factor = 1.0
    -- Functions
    local setFont = function(fontName, fontSize)
        vim.o.guifont = string.format("%s:h%d", fontName, fontSize)
    end
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    local change_font_size = function(currentFontName, delta)
        currentFontSize = currentFontSize + delta
        setFont(currentFontName, currentFontSize)
    end

    -- Keymaps

    -- Scaling
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)
    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = default_scale_factor
    end)

    -- Font and size
    vim.keymap.set("n", "<f11>", function()
        change_font_size(defaultFontName, fontSizeScaleFactor)
    end)
    vim.keymap.set("n", "<f10>", function()
        change_font_size(defaultFontName, -fontSizeScaleFactor)
    end)
    vim.keymap.set("n", "<f9>", function()
        setFont(defaultFontName, defaultFontSize)
    end)

    -- Fullscreen
    vim.keymap.set("n", "<f12>", function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen -- NOTE: Windowed fullscreen
    end)

    -- Configurations
    setFont(defaultFontName, defaultFontSize)
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_theme = 'auto'
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_refresh_rate = 144 -- NOTE: Use --no-vsync when using this option
    vim.g.neovide_scale_factor = default_scale_factor

    -- vim.g.NeovideRegisterRightClick()
    -- vim.g.neovide_:transparency = 0.8
    -- vim.g.neovide_refresh_rate_idle = 5 -- NOTE: Use --no-vsync when using this option
    -- vim.g.neovide_no_idle = true
    -- vim.g.neovide_confirm_quit = true -- NOTE: will not ask to save unsaved files
    -- vim.g.neovide_remember_window_size = true
    -- vim.g.neovide_profiler = true -- NOTE: enable fps profiler
end
