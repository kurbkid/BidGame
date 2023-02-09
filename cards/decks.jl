deckDict = Dict{String,Vector{Card}}(
    "testdeck" => vcat( [cardDict["3wood"] for i=1:5],
                        [cardDict["2metal"] for i=1:5],
                      ),
)