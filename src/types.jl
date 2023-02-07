struct Card
    name
    #cost
    effect
end

mutable struct Field
    wood::Int
    metal::Int
    coal::Int
    objects::Set{String}

    Field() = new(0,0,0,Set())
end

mutable struct Supply
    wood::Int
    metal::Int
    coal::Int
    worker::Int
    objects::Set{String}

    Supply() = new(0,0,0,0,Set())
    Supply(initWorkers) = new(0,0,0,initWorkers,Set())
end
