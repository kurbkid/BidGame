
function resolve()
    global state
    global params
    verbose = params["verbose"]

    numberOfFields = length(state["Fields"])
    numberOfPlayers = length(state["PlayerSupply"])
0
    # add the bets at each field
    betsPerFieldPerPlayer = zeros(Int,numberOfFields,numberOfPlayers)
    for player=1:numberOfPlayers
        for field=1:numberOfFields
            betsPerFieldPerPlayer[field,player] = state["Ring1"][field][player] + state["Ring2"][field][player]
        end
    end
    verbose && println("bets per field: ",betsPerFieldPerPlayer)

    #Resolve each field
    order = Int[]; resourcesLeft = 0;n=0;i=0;player=1
    workersAtField = zeros(Int,numberOfPlayers)
    for field=1:numberOfFields
        workersAtField = betsPerFieldPerPlayer[field,:] # bets is named workers now, because linked to amount of resources one may take
        verbose && println("field ",field,": workers = ",workersAtField," resources = ", format_objects_string( state["Fields"][field].objects) )
        order = determine_order(workersAtField,findMod()) #order of picks determined by bets
        verbose && println("         order = ",order)
        field==1 && return_moderator() ## returns so it can be picked after last mod determined order for it.
        
        resourcesLeft = calc_resourcesLeft(state["Fields"][field])
        n = length(order)
        i=0
        while resourcesLeft>0 && n>0
            i = mod1(i+1,n) #loop through order as long as resources left
            player=order[i]
            choice = prompt_resource_choice(state["Fields"][field],player)
            verbose && println("player ",player," chooses ", choice)
            move_resource_to_player(state["Fields"][field],state["PlayerSupply"][player],choice)
            resourcesLeft -= 1
            workersAtField[player]-=1
            if workersAtField[player]==0 #player may only take as many resources as he has workers.
                n-=1
                deleteat!(order,findfirst(order.==player))
                i-=1 # removed player causes shift left in order. this compensates. (otherwise a player is skipped)
            end

        end
    end

    state
end

function findMod()
    global state
    numberOfPlayers = length(state["PlayerSupply"])
    modPlayer=0
    if "moderator" ∉ state["Fields"][1].objects
        modPlayer = findfirst(["moderator" ∈ state["PlayerSupply"][i].objects for i=1:numberOfPlayers])
    end
    modPlayer
end

#for a given field, what is the picking order
function determine_order(betsPerPlayer,modPlayer)
    global state
    numberOfFields = length(state["Fields"])
    numberOfPlayers = length(state["PlayerSupply"])

    order = Int[]
    betAmount = maximum(betsPerPlayer)
    while betAmount>0 # those who bet 0 are not in the order to pick anything
        equals = findall( betsPerPlayer .== betAmount )
        if length(equals)>1 #multiple players made this bet. time to ask moderator
            equals = prompt_order(equals,modPlayer)
        end
        if !isempty(equals)
            order = vcat(order,equals)
        end
        betAmount-=1
    end
    order
end

function calc_resourcesLeft(f::Field)
    #f.wood + f.metal + f.coal + length(f.objects)
    length(f.objects)
end

