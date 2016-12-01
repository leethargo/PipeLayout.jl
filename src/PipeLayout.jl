__precompile__(false) # can't because of Combinatorics :-(

module PipeLayout

include("instances.jl")
# --> deserialization.jl
# --> random.jl
include("types.jl")

include("util.jl")
include("gasphysics.jl")
include("pwl.jl")

# graph methods and topologies
include("topology/util.jl")
include("topology/geosteiner.jl")
include("topology/grid.jl")
include("topology/mst.jl")
include("topology/isomorph.jl")

include("flow.jl") # needs topology

# optimization models and approaches
module PipeDimensioning
using ..PipeLayout
include("models/pipedimensioning.jl")
end

module JunctionLocation
using ..PipeLayout
include("models/junctionlocation/main.jl")
end

module GndStructDiscDiam
using ..PipeLayout
include("models/gndstruct_discdiam/main.jl")
end

# visualization via Plots recipes
include("plot_recipes.jl")

end
