local gui = require('gui')
local widgets = require('gui.widgets')

--
-- RangerWindow
--

RangerWindow = defclass(RangerWindow, widgets.Window)
RangerWindow.ATTRS {
    frame_title='Hello, Slider!',
    frame={w=52, h=8},
    resizable=true,
    resize_min={w=40, h=8},
}

function RangerWindow:init()
    local LEVEL_OPTIONS = {
        {label='Low', value=1},
        {label='Medium', value=2},
        {label='High', value=3},
        {label='Pro', value=4},
        {label='Insane', value=5},
    }

    self:addviews{
        widgets.CycleHotkeyLabel{
            view_id='min_level',
            frame={l=1, t=0, w=16},
            label='Level:',
            label_below=true,
            key_back='CUSTOM_SHIFT_C',
            key='CUSTOM_SHIFT_V',
            options=LEVEL_OPTIONS,
            initial_option=LEVEL_OPTIONS[1].value,
            on_change=function(val)
                self.subviews.min_level:setOption(val)
                self.subviews.max_level:setOption(val)
            end,
        },
        widgets.CycleHotkeyLabel{
            view_id='max_level',
            frame={r=1, t=0, w=16},
            -- label='Max level:',
            -- label_below=true,
            -- key_back='CUSTOM_SHIFT_E',
            -- key='CUSTOM_SHIFT_R',
            options=LEVEL_OPTIONS,
            initial_option=LEVEL_OPTIONS[1].value,
            on_change=function(val)
                self.subviews.min_level:setOption(val)
                self.subviews.max_level:setOption(val)
            end,
        },
        widgets.RangeSlider{
            frame={l=1, t=3},
            num_stops=#LEVEL_OPTIONS,
            get_left_idx_fn=function()
                return self.subviews.min_level:getOptionValue()
            end,
            get_right_idx_fn=function()
                return self.subviews.max_level:getOptionValue()
            end,
            on_left_change=function(idx) self.subviews.min_level:setOption(idx, true) self.subviews.max_level:setOption(idx, true) end,
            on_right_change=function(idx) self.subviews.min_level:setOption(idx, true) self.subviews.max_level:setOption(idx) end,
        },
    }
end

--
-- RangerScreen
--

RangerScreen = defclass(RangerScreen, gui.ZScreen)
RangerScreen.ATTRS {
    focus_path='ranger',
}

function RangerScreen:init()
    self:addviews{RangerWindow{}}
end

function RangerScreen:onDismiss()
    view = nil
end

--
-- main logic
--

view = view and view:raise() or RangerScreen{}:show()