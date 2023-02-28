function setup_game()
    global params
    println("setting up game with params = ", params)
    numberOfFields = params["numberOfFields"]
    numberOfPlayers = params["numberOfPlayers"]
    initWorkers = params["initWorkers"]

    Bot.setup_bots(params["botList"])

    global state = deepcopy(BlankState)
    global deckDict

    cardList = deckDict[params["deck"]]
    state["Deck"] = Stack{Card}()
    for i in eachindex(cardList)
        push!(state["Deck"],cardList[i])
    end
    state["OpenCards"] = [cardDict["noCard"] for i=1:numberOfFields]
    state["Fields"] = [Field() for i=1:numberOfFields]
    state["Ring1"]  = [zeros(Int,numberOfPlayers) for i=1:numberOfFields]
    state["Ring2"]  = [zeros(Int,numberOfPlayers) for i=1:numberOfFields]
    state["PlayerSupply"] = [Supply(initWorkers) for i=1:numberOfPlayers]
    push!(state["Fields"][1].objects,"moderator")

    return state
end

function check_end_game_condition() 
    global state 
    global params 
    return false #placeholder
end

function shift_rings()
    global state
    numberOfFields = length(state["Fields"])
    numberOfPlayers = length(state["PlayerSupply"])

    #Ring 1 moves back to player supply
    for i=1:numberOfFields
        for j=1:numberOfPlayers
            state["PlayerSupply"][j].worker+=state["Ring1"][i][j]
        end
    end
    #move inward
    state["Ring1"]=state["Ring2"]
    state["Ring2"]=[zeros(Int,numberOfPlayers) for i=1:numberOfFields]
    state
end

function place_bets(playerChoices::Vector{Vector{Int}})
    global state
    numberOfFields = length(state["Fields"])
    numberOfPlayers = length(state["PlayerSupply"])

    for player=1:numberOfPlayers
        for field=1:numberOfFields
            k = playerChoices[player][field]
            while state["PlayerSupply"][player].worker>0 && k>0
                k-=1
                state["PlayerSupply"][player].worker -= 1
                state["Ring2"][field][player]+=1
            end
        end
    end
    state
end
function place_bets(player::Int,choices::Vector{Int})
    global params
    
    playerChoices = [zeros(Int,params["numberOfFields"]) for i=1:params["numberOfPlayers"]]
    playerChoices[player] += choices
    place_bets(playerChoices)
end


function return_moderator()
    global state
    player=1
    while "moderator" ∉ state["Fields"][1].objects && player<=length(state["PlayerSupply"])
        if "moderator" ∈ state["PlayerSupply"][player].objects
            deleteat!(state["PlayerSupply"][player].objects,findfirst(state["PlayerSupply"][player].objects.=="moderator"))
            push!(state["Fields"][1].objects,"moderator")
        end
        player+=1
    end
    if "moderator" ∉ state["Fields"][1].objects
        error("moderator is missing")
    end
    state
end

function move_resource_to_player(field::Field,supply::Supply,choice)
    if choice in field.objects
        deleteat!(field.objects,findfirst(field.objects.==choice))
        push!(supply.objects,choice)
    else
        error("typo in choice at move_resource_to_player!??")
    end
    global state
    state
end

function card_resources_to_field(card::Card,field::Field)
    for r in card.resources
        push!(field.objects,r)
    end
    field
end
function resolve_open_cards()
    for i=2:length(state["OpenCards"])
        card_resources_to_field(state["OpenCards"][i],state["Fields"][i])
    end
end

        