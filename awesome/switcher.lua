local switcher = require("switcher_init")

switcher.settings.preview_box                        = true                          -- display preview-box
switcher.settings.preview_box_bg                     = "#181926ff"                   -- background color
switcher.settings.preview_box_border                 = "#8bd5caff"                   -- border-color
switcher.settings.preview_box_fps                    = 60                            -- refresh framerate
switcher.settings.preview_box_delay                  = 200                           -- delay in ms
switcher.settings.preview_box_title_font             = { "sans", "italic", "normal" }-- the font for cairo
switcher.settings.preview_box_title_font_size_factor = 0.8                           -- the font sizing factor
switcher.settings.preview_box_title_color            = { 202, 211, 245, 1 }                -- the font color
switcher.settings.client_opacity                     = true                          -- opacity for unselected clients
switcher.settings.client_opacity_value               = 0.3                             -- alpha-value for any client
switcher.settings.client_opacity_value_in_focus      = 0.3                             -- alpha-value for the client currently in focus
switcher.settings.client_opacity_value_selected      = 1                             -- alpha-value for the selected client
switcher.settings.cycle_raise_client                 = true                          -- raise clients on cycle