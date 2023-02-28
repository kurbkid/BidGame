function get_standard_params()
    standard_params = Dict{String,Any}(
        "numberOfPlayers"   => 3,
        "numberOfFields"    => 4,
        "initWorkers"       => 6,
        "deck"              => "testdeck",
        "verbose"           => true,
        "maxTurns"          => 10,
        "botPlayers"        => [1,2,3],
        "botList"           => Dict(        #for each player, if they are a bot, which bot is it
            1 => "randomBot",
            2 => "randomBot",
            3 => "metalBot",
            4 => "randomBot",
        )
    )
end
