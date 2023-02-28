using Random

function prompt_bets(player)
    global state
    global params

    numberOfFields = params["numberOfFields"]
    BOTBETS = floor(Int,params["initWorkers"]/2) ##MAGIC NUMBER. THINK OF FANCY THING LATER

    choice = zeros(Int,numberOfFields)

    #check for metal
    metalBool = zeros(Bool,numberOfFields)
    for i=1:numberOfFields
        metalBool[i] = ( "metal" in state["Fields"][i].objects )
    end

    workersLeft = BOTBETS
    if sum(metalBool)>0
        #spread first then randomly add if workers left
        for i in shuffle!(Vector(1:numberOfFields)) #random order
            if metalBool[i] && workersLeft>0
                choice[i]+=1
                workersLeft -=1
            end
        end        
        while workersLeft>0 # if workers left after spread
            i = rand(1:numberOfFields)
            if metalBool[i] && workersLeft>0
                choice[i]+=1
                workersLeft -=1
            end
        end
    else #no metal
        i = rand(1:numberOfFields)
        choice[i]+=1
        workersLeft -=1
    end
    

    println("metalbot bets: ", choice)

    return choice
end