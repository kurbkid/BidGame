function prompt_place_bets()
    global state
    global params
    BOTBETS = floor(Int,params["initWorkers"]/2) ##MAGIC NUMBER. THINK OF FANCY THING LATER
    
    #in the real game placing bets is hidden and simultaneous.
    #here we just prompt each player 1 by 1.
    #bots do random for now.

    botPlayers = params["botPlayers"]
    realPlayers = setdiff(1:params["numberOfPlayers"],botPlayers)
    botPlayersBool = [i in botPlayers for i=1:params["numberOfPlayers"]]

    #bots go first
    Bot.random_bets(BOTBETS.*botPlayersBool)

    playerBets = [zeros(Int,params["numberOfFields"]) for i=1:params["numberOfPlayers"]]
    choice = "blabla"
    for player in realPlayers
        println("Player ",player," may place their workers on the fields.")
        print_supply(player)
        println("type: \"k,l,m,n,...\" with integers and the correct number of fields (",params["numberOfFields"],").")
        choice = readline()
        playerBets[player] = parse_bets(choice)
    end
    println("test here: ",playerBets)
    place_bets(playerBets)
    
end

function prompt_order(equals,modPlayer)
    global params
    N = length(equals)
    order = []
    if modPlayer == 0 || modPlayer ∈ params["botPlayers"] #make random order
        while N>1
            choice = rand(1:N) #index of chosen player
            push!(order,equals[choice])
            deleteat!(equals,choice)
            N-=1
        end
        push!(order,equals[1]) #put the last remaining at the end
    else
        println("The Moderator: player ", modPlayer, " chooses who has priority")
        choice = "blabla"
        while N>1
            while choice ∉ equals
                println("type one of these options: ", equals)
                try 
                    choice = parse(Int,readline())
                catch
                    choice = "try again"
                end
            end
            push!(order,choice)
            deleteat!(equals,findfirst(equals.==choice))
            N-=1
        end
        push!(order,equals[1]) #put the last remaining at the end
    end
    order
end

function prompt_resource_choice(field,player)
    global params

    #gather options
    options = []
    field.wood>0 && push!(options,1)
    field.metal>0 && push!(options,2)
    field.coal>0 && push!(options,3)
    if length(field.objects)>0
        options = vcat(options,field.objects...)
    end

    
    if length(options)==1   #shortcut only one type of resource left
        choice = options[1]
    elseif player in params["botPlayers"] #botplayers choose randomly
        choice = rand(options)
    else #player gets message prompt
        println("player ",player," has to choose a resource from ",field)
        choice = "blabla"
        while choice ∉ options
            println("type one of these options: ", options)
            choice = readline()
            if choice ∈ ["1","2","3"]
                choice = parse(Int,choice)
            end
        end
    end
    return choice
end
