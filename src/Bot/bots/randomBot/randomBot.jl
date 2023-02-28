module randomBot

import ...BidGame: state,params #use state from parent module

include("prompt_bets.jl")
include("prompt_order.jl")
include("prompt_resource_choice.jl")

end #module