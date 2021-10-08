module MeshCatViz

import MeshCat
import GeometryBasics: Point, Mesh, GLTriangleFace
import Colors

"""
Initialize visualizer in the browser.
"""
function setup_visualizer()
    global visualizer
    visualizer = MeshCat.Visualizer()
    set_background_color(Colors.colorant"white")
    open(visualizer)
end

"""
Set background color of visualized environment.
"""
function set_background_color(color::Colors.Color)
    MeshCat.setprop!(visualizer["/Background"], "top_color", color)
    MeshCat.setprop!(visualizer["/Background"], "bottom_color", color)
end

"""
Clear all entities from the environment.
"""
function reset_visualizer()
    delete!(visualizer)
end

"""
Visualize a point cloud, optionally specifying the color and the channel name.
"""
function viz(c::Matrix{<:Real}; color::Union{Colors.Color, Nothing}=nothing, channel_name::Union{Symbol, Nothing}=nothing)
    @assert size(c)[1] == 3
    if isnothing(color)
        color = Colors.colorant"black"
    end
    if isnothing(channel_name)
        channel_name = :cloud1
    end


    cloud =  map(Point{3,Float32}, eachcol(c))
    colors = [color for _ in 1:size(c)[2]]
    MeshCat.setobject!(visualizer[channel_name], MeshCat.PointCloud(cloud, colors))
end

function viz_colored(c::Matrix, colors::Vector{<:Colors.Color}; channel_name::Union{Symbol, Nothing}=nothing)
    @assert size(c)[1] == 3
    if isnothing(channel_name)
        channel_name = :cloud1
    end

    cloud =  map(Point{3,Float32}, eachcol(c))
    MeshCat.setobject!(visualizer[channel_name], MeshCat.PointCloud(cloud, colors))
end

end # module
