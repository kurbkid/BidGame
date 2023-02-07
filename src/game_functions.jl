function new_game()
    global params
    println("stared new game with params = ", params)
    numberOfFields = params["numberOfFields"]
    numberOfPlayers = params["numberOfPlayers"]
    initWorkers = params["initWorkers"]

    global state = deepcopy(BlankState)
    global deckDict

    cardList = deckDict[params["deck"]]
    state["Deck"] = Stack{Card}()
    for i=1:length(cardList)
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

function return_moderator()
    global state
    player=1
    while "moderator" ∉ state["Fields"][1].objects && player<=length(state["PlayerSupply"])
        if "moderator" ∈ state["PlayerSupply"][player].objects
            delete!(state["PlayerSupply"][player].objects,"moderator")
        end
        player+=1
    end
    push!(state["Fields"][1].objects,"moderator")  #sets can't have multiple of the same element, so not dangerous.
    state
end

function move_resource_to_player(field::Field,supply::Supply,choice)
    if choice == 1
        if field.wood>0
            field.wood -=1
            supply.wood +=1
        else
            error("no wood to move")
        end
    elseif choice == 2
        if field.metal>0
            field.metal -=1
            supply.metal +=1
        else
            error("no metal to move")
        end
    elseif choice == 3
        if field.coal>0
            field.coal -=1
            supply.coal +=1
        else
            error("no coal to move")
        end
    elseif typeof(choice) == String
        if choice in field.objects
            delete!(field.objects,choice)
            push!(supply.objects,choice)
        else
            error("typo in choice at move_resource_to_player???")
        end
    end
    global state
    state
end

