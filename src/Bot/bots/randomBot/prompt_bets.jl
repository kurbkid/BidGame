function prompt_bets(player)
    global state
    global params

    BOTBETS = floor(Int,params["initWorkers"]/2) ##MAGIC NUMBER. THINK OF FANCY THING LATER
    numberOfFields = params["numberOfFields"]
    draw = rand(1:numberOfFields,BOTBETS) #BOTBETS times one random field
    choice = [sum(draw.==i) for i=1:numberOfFields] #choices of each field summed

    return choice
end