struct Card
    name
    #effect
    resources
end

mutable struct Field
    objects::Vector{String}

    Field() = new(String[])
end

mutable struct Supply
    worker::Int
    objects::Vector{String}

    Supply() = new(String[])
    Supply(initWorkers) = new(initWorkers,String[])
end
