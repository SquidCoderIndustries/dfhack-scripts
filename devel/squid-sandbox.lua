-- A basic example to start your own gui script from.
--@ module = true

local gui = require('gui')
local widgets = require('gui.widgets')
-- local Slider = reqscript(Slider)

local HIGHLIGHT_PEN = dfhack.pen.parse{
    ch=string.byte(' '),
    fg=COLOR_LIGHTGREEN,
    bg=COLOR_LIGHTGREEN,
}

HelloWorldWindow = defclass(HelloWorldWindow, widgets.Window)
HelloWorldWindow.ATTRS{
    frame={w=20, h=14},
    frame_title='Hello Squid',
    autoarrange_subviews=true,
    autoarrange_gap=1,
}

function HelloWorldWindow:init()
    self:addviews{
        widgets.Label{text={{text='Hello, Coder!', pen=COLOR_}}},
        widgets.HotkeyLabel{
            frame={l=0, t=0},
            label='Click me',
            key='CUSTOM_CTRL_A',
            on_activate=self:callback('toggleHighlight'),
        },
        widgets.Panel{
            view_id='highlight',
            frame={w=10, h=5},
            frame_style=gui.INTERIOR_FRAME,
        },
        -- Slider{
        --     frame={l=1, t=3},
        --     num_stops=3,
        --     get_idx_fn=function() return self.subviews.level:getOptionValue() end,
        --     on_change=function(idx) self.subviews.level:setOption(idx, true) end,
        -- },
        widgets.RangeSlider{
            frame={l=1, t=3},
            num_stops=3,
            get_left_idx_fn=function()
                return 1
            end,
            get_right_idx_fn=function()
                return 3
            end,
            on_left_change=function(idx) self.subviews.min_skill:setOption(idx, true) end,
            on_right_change=function(idx) self.subviews.max_skill:setOption(idx, true) end,
        },
    }
end

function HelloWorldWindow:toggleHighlight()
    local panel = self.subviews.highlight
    panel.frame_background = nil
end

HelloWorldScreen = defclass(HelloWorldScreen, gui.ZScreen)
HelloWorldScreen.ATTRS{
    focus_path='hello-world',
}

function HelloWorldScreen:init()
    self:addviews{HelloWorldWindow{}}
end

function HelloWorldScreen:onDismiss()
    view = nil
end

if dfhack_flags.module then
    return
end

view = view and view:raise() or HelloWorldScreen{}:show()
