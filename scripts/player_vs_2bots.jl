using Revise
include("../BidGame.jl")
b = BidGame

params = b.get_params()
params["botPlayers"] = [2,3]
b.set_params(params)
b.new_game()

turns = 10

for i=1:turns
    println("turn ",i)
    b.Bot.random_resources(4)
    b.print_all()
    b.prompt_place_bets()
    b.resolve()
    b.shift_rings()

    println("end of turn\n")
end


# b.Bot.random_resources(3)
# b.Bot.random_bets(3)
# b.shift_rings()
# #b.Bot.random_bets(3)
# b.print_fields()


# b.prompt_place_bets()
# b.resolve()

# #test mod prompt
# s = b.get_state()
# s["Ring1"][1][1]=10 #lot of workers on modfield
# b.set_state(s)
# b.resolve()
