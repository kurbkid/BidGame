function prompt_order(equals,modPlayer)
    
    N = length(equals)
    order = []
    while N>1
        choice = rand(1:N) #index of chosen player
        push!(order,equals[choice])
        deleteat!(equals,choice)
        N-=1
    end
    push!(order,equals[1]) #put the last remaining at the end

    return order
end
