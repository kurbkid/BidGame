module Bot

import ..BidGame: state,params #use state from parent module
import ..BidGame: add_resource, place_bets #game control functions

include("src/manipulate_game.jl")
include("src/prompt_a_bot.jl")

#available bots:
include("bots/randomBot/randomBot.jl")
include("bots/metalBot/metalBot.jl")

bots = Dict{Int,Module}()

function setup_bots(botList::Dict{Int,String})
    global bots   
    for i in keys(botList)
        bots[i] = eval(Meta.parse(botList[i]))
    end
    println(bots)
    bots
end



end #module
