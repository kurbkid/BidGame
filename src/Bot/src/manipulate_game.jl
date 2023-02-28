function random_resources(numberOfResourcesPerField::Vector{Int})
    global state
    numberOfFields = length(state["Fields"])
    resourceOptions = ["wood","metal","coal"] #this is temporary
    for i = 2:numberOfFields
        choice = rand(resourceOptions,numberOfResourcesPerField[i])
        add_resource(state["Fields"][i],choice)
    end
    state
end
function random_resources(numberOfResourcesPerField::Int)
    global state
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
    global params

    numberOfBetsPerPlayer = numberOfBets*ones(Int, params["numberOfPlayers"])
    random_bets(numberOfBetsPerPlayer)
end