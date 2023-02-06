

function resolve(;verbose=true)
    global state
    numberOfFields = length(state["Fields"])
    numberOfPlayers = length(state["PlayerSupply"])

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
        order = determine_order(workersAtField,findMod()) #order of picks determined by bets
        field==1 && return_moderator() ## returns so it can be picked after last mod determined order for it.
        verbose && println("field ",field,": workers = ",workersAtField," order = ",order," resources = ", state["Fields"][field])
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

### FOR NOW THE MOD JUST RANDOMLY ASSIGNS ORDER
function prompt_order(equals,modPlayer)
    N = length(equals)
    order = []
    #if modPlayer == 0 #make random order
        while N>1
            choice = rand(1:N) #index of chosen player
            push!(order,equals[choice])
            deleteat!(equals,choice)
            N-=1
        end
        push!(order,equals[1]) #put the last remaining at the end
    #end
    order
end

function calc_resourcesLeft(f::Field)
    f.wood + f.metal + f.coal + length(f.objects)
end

### FOR NOW THE GAME JUST PICKS RANDOM RESOURCES FOR YOU
function prompt_resource_choice(field,player)

    #gather options
    options = []
    field.wood>0 && push!(options,1)
    field.metal>0 && push!(options,2)
    field.coal>0 && push!(options,3)
    if length(field.objects)>0
        options = vcat(options,field.objects)
    end

    #prompt choice
    ## RANDOM FOR NOW
    choice = rand(options)
    if typeof(choice)<:Set
        choice = rand(choice)
    end

    return choice
end