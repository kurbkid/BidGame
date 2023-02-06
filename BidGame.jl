module BidGame

using DataStructures
include("params/standard_params.jl")
include("src/types.jl")
include("src/state.jl")
include("src/game_functions.jl")
include("src/player_prompts.jl")
include("src/parse_bets.jl")
include("src/resolve.jl")
include("src/field_functions.jl")
include("src/card_functions.jl")
include("src/Bot.jl")
include("src/show.jl")

using .Bot

state = deepcopy(BlankState)
params = get_standard_params()

function get_state()
    global state
    return state
end
function set_state(newState::Dict)
    global state = newState
    return state
end
function get_params()
    global params
    return params
end
function set_params(newParams::Dict)
    global params = newParams
    return params
end


end #module