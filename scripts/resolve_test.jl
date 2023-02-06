using Revise
include("../BidGame.jl")
b = BidGame
b.new_game()
b.Bot.random_resources(3)
b.Bot.random_bets(3)
b.shift_rings()
b.Bot.random_bets(3)
b.print_fields()

#s = b.get_state()

b.resolve()

