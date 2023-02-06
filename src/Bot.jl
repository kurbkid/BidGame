module Bot

import ..BidGame: state #use state from parent module
import ..BidGame: add_resource, place_bets #game control functions

function random_resources(numberOfResourcesPerField::Vector{Int})
    global state
    numberOfFields = length(state["Fields"])
    for i = 2:numberOfFields
        choice = rand(1:3,numberOfResourcesPerField[i]) #choose 1, 2 or 3 number times
        a = [sum(choice.==i) for i=1:3] #sum how often each was chosen.
        add_resource(state["Fields"][i],a)
    end
    state
end
function random_resources(numberOfResourcesPerField::Int)
    global state
    println(state)
    vecm = numberOfResourcesPerField*ones(Int,sizeof(state["Fields"]))
    random_resources(vecm)
end


function random_bets(numberOfBetsPerPlayer::Vector{Int})
    global state
    numberOfFields = length(state["Fields"])
    numberOfPlayers = length(state["PlayerSupply"])

    playerChoices = [zeros(Int,numberOfFields) for i=1:numberOfPlayers]
    for player=1:numberOfPlayers
        choice = rand(1:numberOfFields,numberOfBetsPerPlayer[player]) #m times one random field
        playerChoices[player] = [sum(choice.==i) for i=1:numberOfFields] #choices of each field summed
    end
    place_bets(playerChoices)

end
function random_bets(numberOfBets::Int)
    global state
    numberOfBetsPerPlayer = numberOfBets*ones(Int, length(state["PlayerSupply"]))
    random_bets(numberOfBetsPerPlayer)
end


end #module
