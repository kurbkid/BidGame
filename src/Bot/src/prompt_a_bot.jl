
##These functions redirect the choices to the bots. 

function prompt_bets(player)
    global bots
    choice = bots[player].prompt_bets(player)
end
function prompt_order(equals,modPlayer)
    global bots
    order = bots[modPlayer].prompt_order(equals,modPlayer)
end    
function prompt_resource_choice(options,player)
    global bots
    choice = bots[player].prompt_resource_choice(options,player)
end