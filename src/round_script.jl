

function play_a_round()
    global state 
    global params 
    verbose = params["verbose"]

    verbose && println("turn ",state["Turn"])
    deal_field_cards()
    verbose && print_all()
    prompt_place_bets()
    resolve()
    shift_rings()
    resolve_open_cards()
    discard_field_cards()

    state["Turn"] += 1
    verbose && println("end of turn\n")

end

function start_game()
    global state 
    global params 
    verbose = params["verbose"]

    verbose && println("resolving inital round of cards")
    deal_field_cards()
    resolve_open_cards()
    discard_field_cards()

    verbose && println("game starts")
    
    state["Turn"]=0
    endGameConditionMet = false
    while state["Turn"]<=params["maxTurns"] && endGameConditionMet==false
        state["Turn"]+=1
        play_a_round()
        check_end_game_condition()
    end

    println("game over\n")
    state
end
