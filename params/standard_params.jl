function get_standard_params()
    standard_params = Dict{String,Any}(
        "numberOfPlayers"   => 3,
        "numberOfFields"    => 4,
        "initWorkers"       => 6,
        "botPlayers"        => [1,2,3],
        "deck"              => "testdeck",
        "verbose"           => true,
        "maxTurns"          => 10,
    )
end
