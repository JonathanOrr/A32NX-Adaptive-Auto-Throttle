--[[A32NX Adaptive Auto Throttle
Copyright (C) 2020 Jonathan Orr

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.]]

size = {420,340}

local graph_timeline = 0
local past_graph_timeline = 0
local past_output = 0

--colors
local black = {0,0,0}
local white = {1,1,1}
local green = {0.004, 1, 0.004}
local blue = {0.004, 1.0, 1.0}
local orange = {0.843, 0.49, 0}
local red = {1, 0, 0}

local output_array = {}
local timeline_array = {}

local graph_timeline_sum = 0
local graph_x_offset_sum = 0

function update()
    graph_x_offset_sum = 0

    if #timeline_array > 550 then
        for i = 1, #timeline_array do
            timeline_array[i] = timeline_array[i+1]
            output_array[i] = output_array[i+1]
        end
    end

    output_array[#output_array+1] = get(A32nx_thrust_control_output)*300
    timeline_array[#timeline_array+1] = get(DELTA_TIME)*30

    for i = 1, #timeline_array do
        graph_x_offset_sum = graph_x_offset_sum + timeline_array[i]
    end

end

function draw()
    sasl.gl.drawRectangle(0,0,420,340,black)

    graph_timeline_sum = 0

    for i = 1 ,#timeline_array do
        graph_timeline_sum = graph_timeline_sum + timeline_array[i]

        if i > 1 then

            sasl.gl.drawLine(size[1]/2+graph_timeline_sum-timeline_array[i]-graph_x_offset_sum, output_array[i-1], size[1]/2+graph_timeline_sum-graph_x_offset_sum, output_array[i], white)

        end
    end
end