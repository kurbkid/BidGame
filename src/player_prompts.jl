function prompt_place_bets()
    global state
    global params

    #in the real game placing bets is hidden and simultaneous.
    #here we just prompt each player 1 by 1.

    botPlayers = params["botPlayers"]
 
    playerBets = [zeros(Int,params["numberOfFields"]) for i=1:params["numberOfPlayers"]]
    choice = "blabla"

    for player in 1:params["numberOfPlayers"]
        if player in botPlayers
            playerBets[player] = Bot.prompt_bets(player)
        else #player in realPlayers
            println("Player ",player," may place their workers on the fields.")
            print_supply(player)
            println("type: \"k,l,m,n,...\" with integers and the correct number of fields (",params["numberOfFields"],").")
            choice = readline()
            playerBets[player] = parse_bets(choice)
        end
    end
    println("test here: ",playerBets)
    place_bets(playerBets)
    
end

function prompt_order(equals,modPlayer)
    global params
    N = length(equals)
    order = []
    if modPlayer == 0  #make random order
        while N>1
            choice = rand(1:N) #index of chosen player
            push!(order,equals[choice])
            deleteat!(equals,choice)
            N-=1
        end
        push!(order,equals[1]) #put the last remaining at the end
    elseif modPlayer ∈ params["botPlayers"]
        order = Bot.prompt_order(equals,modPlayer)
    else #modPlayer in realPlayers
        println("The Moderator, player ", modPlayer, ", chooses who has priority")
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

    options = field.objects
    
    if length(Set(options))==1   #shortcut only one type of resource left
        choice = options[1]
    elseif player in params["botPlayers"]
        choice = Bot.prompt_resource_choice(options,player)
    else #player gets message prompt
        println("player ",player," has to choose a resource from ",field)
        choice = "blabla"
        while choice ∉ options
            println("type one of these options: ", format_objects_string(options))
            choice = readline()
        end
    end
    return choice
end
