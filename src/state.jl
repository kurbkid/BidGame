
BlankState = Dict{String,Any}(
    "Turn"      => 0,
    "Deck"      => Stack{Card}(),
    "Discard"   => Stack{Card}(),
    "OpenCards" => Vector{Card}(),
    "Fields"    => Vector{Field}(),
    "Ring1"     => Vector{Vector{Int}}(),
    "Ring2"     => Vector{Vector{Int}}(),
    "PlayerSupply" => Vector{Supply}(),
)
